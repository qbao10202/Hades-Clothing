package com.salesapp.controller;

import com.salesapp.dto.CartResponseDTO;
import com.salesapp.dto.CartItemResponseDTO;
import com.salesapp.entity.Order;
import com.salesapp.entity.OrderItem;
import com.salesapp.entity.Product;
import com.salesapp.entity.User;
import com.salesapp.entity.Customer;
import com.salesapp.repository.OrderRepository;
import com.salesapp.repository.ProductRepository;
import com.salesapp.repository.UserRepository;
import com.salesapp.repository.CustomerRepository;
import com.salesapp.service.OrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;

import java.math.BigDecimal;
import java.util.List;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/api/cart")
@CrossOrigin(origins = "*")
public class CartController {

    @Autowired
    private OrderService orderService;
    @Autowired
    private ProductRepository productRepository;
    @Autowired
    private OrderRepository orderRepository;
    @Autowired
    private UserRepository userRepository;
    @Autowired
    private CustomerRepository customerRepository;

    // DTO for incoming cart items
    public static class CartItemDTO {
        public Long productId;
        public Integer quantity;
        public Double price;
    }

    @PostMapping("/migrate")
    public ResponseEntity<?> migrateGuestCartToUser(@RequestBody List<CartItemDTO> items, Authentication authentication) {
        // Here, you would get the user from authentication
        // For demo, assume userId is available as principal name (should be replaced with real user lookup)
        String username = authentication.getName();
        User user = userRepository.findByUsername(username).orElseThrow();
        // Create a new order with these items, status DRAFT or CART
        Order order = new Order();
        order.setUser(user);
        order.setStatus(Order.OrderStatus.PENDING);
        List<OrderItem> orderItems = items.stream().map(dto -> {
            OrderItem item = new OrderItem();
            Product product = productRepository.findById(dto.productId).orElseThrow();
            item.setProduct(product);
            item.setProductName(product.getName());
            item.setQuantity(dto.quantity);
            item.setUnitPrice(BigDecimal.valueOf(dto.price));
            item.setTotalPrice(BigDecimal.valueOf(dto.price * dto.quantity));
            return item;
        }).collect(Collectors.toList());
        order.setOrderItems(orderItems);
        Order savedOrder = orderService.createOrder(order);
        return ResponseEntity.ok(savedOrder);
    }

    // Helper: get or create cart for user
    private Order getOrCreateCart(User user) {
        Customer customer = customerRepository.findByUserId(user.getId())
            .orElseGet(() -> {
                Customer newCustomer = new Customer();
                newCustomer.setUserId(user.getId());
                newCustomer.setEmail(user.getEmail());
                newCustomer.setCustomerCode("CUST-" + user.getId());
                newCustomer.setCountry("VN"); // default country
                newCustomer.setCustomerType(Customer.CustomerType.INDIVIDUAL); // default type
                newCustomer.setActive(true);
                // Set other required fields with defaults if needed
                return customerRepository.save(newCustomer);
            });

        return orderRepository.findByUserIdAndStatus(user.getId(), Order.OrderStatus.CART)
            .orElseGet(() -> {
                Order cart = new Order();
                cart.setUser(user);
                cart.setCustomer(customer);
                cart.setStatus(Order.OrderStatus.CART);
                cart.setOrderItems(new java.util.ArrayList<>());
                cart.setOrderNumber("CART-" + user.getId());
                cart.setSubtotal(BigDecimal.ZERO);
                cart.setTotalAmount(BigDecimal.ZERO);
                cart.setTaxAmount(BigDecimal.ZERO);
                cart.setShippingAmount(BigDecimal.ZERO);
                cart.setDiscountAmount(BigDecimal.ZERO);
                // Set other required fields with defaults if needed
                return orderRepository.save(cart);
            });
    }

    // GET /api/cart
    @GetMapping
    public ResponseEntity<CartResponseDTO> getCart(Authentication authentication) {
        String username = authentication.getName();
        User user = userRepository.findByUsername(username).orElseThrow();
        Order cart = getOrCreateCart(user);
        CartResponseDTO response = convertToCartResponse(cart);
        return ResponseEntity.ok(response);
    }

    // POST /api/cart/items
    @PostMapping("/items")
    public ResponseEntity<CartResponseDTO> addItemToCart(@RequestBody CartItemDTO itemDto, Authentication authentication) {
        try {
            String username = authentication.getName();
            User user = userRepository.findByUsername(username).orElseThrow();
            Order cart = getOrCreateCart(user);
            
            // Check if item exists
            OrderItem existing = cart.getOrderItems().stream()
                    .filter(i -> i.getProduct().getId().equals(itemDto.productId))
                    .findFirst().orElse(null);
                    
            if (existing != null) {
                existing.setQuantity(existing.getQuantity() + itemDto.quantity);
                // Defensive: set unitPrice if null or zero
                if (existing.getUnitPrice() == null || BigDecimal.ZERO.equals(existing.getUnitPrice())) {
                    if (itemDto.price != null && itemDto.price > 0) {
                        existing.setUnitPrice(BigDecimal.valueOf(itemDto.price));
                    } else {
                        // fallback: get price from product
                        BigDecimal productPrice = productRepository.findById(itemDto.productId)
                            .map(p -> p.getPrice())
                            .orElse(BigDecimal.ZERO);
                        existing.setUnitPrice(productPrice);
                    }
                }
                if (existing.getUnitPrice() == null) {
                    throw new IllegalStateException("unitPrice is null for OrderItem with productId " + itemDto.productId);
                }
                existing.setTotalPrice(existing.getUnitPrice().multiply(BigDecimal.valueOf(existing.getQuantity())));
            } else {
                OrderItem item = new OrderItem();
                item.setProduct(productRepository.findById(itemDto.productId).orElseThrow());
                item.setProductName(item.getProduct().getName());
                // Defensive: ensure quantity is always a positive integer
                int quantity = (itemDto.quantity != null && itemDto.quantity > 0) ? itemDto.quantity : 1;
                // Defensive: ensure price is always a valid BigDecimal
                BigDecimal price;
                if (itemDto.price != null && itemDto.price > 0) {
                    price = BigDecimal.valueOf(itemDto.price);
                } else {
                    BigDecimal productPrice = item.getProduct().getPrice();
                    price = (productPrice != null && productPrice.compareTo(BigDecimal.ZERO) > 0) ? productPrice : BigDecimal.ZERO;
                }
                item.setQuantity(quantity);
                item.setUnitPrice(price);
                item.setTotalPrice(price.multiply(BigDecimal.valueOf(quantity)));
                item.setOrder(cart);
                cart.getOrderItems().add(item);
            }
            cart.calculateTotals();
            orderRepository.save(cart);
            
            CartResponseDTO response = convertToCartResponse(cart);
            return ResponseEntity.ok(response);
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.badRequest().build();
        }
    }

    // PUT /api/cart/items/{itemId}
    @PutMapping("/items/{itemId}")
    public ResponseEntity<Order> updateCartItem(@PathVariable Long itemId, @RequestBody CartItemDTO itemDto, Authentication authentication) {
        String username = authentication.getName();
        User user = userRepository.findByUsername(username).orElseThrow();
        Order cart = getOrCreateCart(user);
        OrderItem item = cart.getOrderItems().stream().filter(i -> i.getId().equals(itemId)).findFirst().orElseThrow();
        
        // Ensure unitPrice is not null before updating
        if (item.getUnitPrice() == null) {
            // Try to get price from DTO first, then from product
            if (itemDto.price != null && itemDto.price > 0) {
                item.setUnitPrice(BigDecimal.valueOf(itemDto.price));
            } else {
                BigDecimal productPrice = item.getProduct().getPrice();
                item.setUnitPrice(productPrice != null ? productPrice : BigDecimal.ZERO);
            }
        }
        
        item.setQuantity(itemDto.quantity);
        item.setTotalPrice(item.getUnitPrice().multiply(BigDecimal.valueOf(itemDto.quantity)));
        cart.calculateTotals();
        orderRepository.save(cart);
        return ResponseEntity.ok(cart);
    }

    // DELETE /api/cart/items/{itemId}
    @DeleteMapping("/items/{itemId}")
    public ResponseEntity<Order> removeCartItem(@PathVariable Long itemId, Authentication authentication) {
        String username = authentication.getName();
        User user = userRepository.findByUsername(username).orElseThrow();
        Order cart = getOrCreateCart(user);
        cart.getOrderItems().removeIf(i -> i.getId().equals(itemId));
        cart.calculateTotals();
        orderRepository.save(cart);
        return ResponseEntity.ok(cart);
    }

    // DELETE /api/cart
    @DeleteMapping
    public ResponseEntity<Order> clearCart(Authentication authentication) {
        String username = authentication.getName();
        User user = userRepository.findByUsername(username).orElseThrow();
        Order cart = getOrCreateCart(user);
        cart.getOrderItems().clear();
        cart.calculateTotals();
        orderRepository.save(cart);
        return ResponseEntity.ok(cart);
    }

    // POST /api/cart/checkout
    @PostMapping("/checkout")
    public ResponseEntity<Order> checkout(@RequestBody CheckoutDTO checkoutDto, Authentication authentication) {
        String username = authentication.getName();
        User user = userRepository.findByUsername(username).orElseThrow();
        Order cart = getOrCreateCart(user);
        
        if (cart.getOrderItems().isEmpty()) {
            throw new RuntimeException("Cart is empty");
        }
        
        // Find or create customer
        Customer customer = customerRepository.findByUserId(user.getId()).orElseGet(() -> {
            Customer newCustomer = new Customer();
            newCustomer.setUserId(user.getId());
            newCustomer.setCustomerCode("CUST-" + user.getId());
            newCustomer.setEmail(user.getEmail());
            newCustomer.setContactPerson(user.getFirstName() + " " + user.getLastName());
            newCustomer.setCustomerType(Customer.CustomerType.INDIVIDUAL);
            newCustomer.setCreditLimit(BigDecimal.ZERO);
            newCustomer.setPaymentTerms(0);
            newCustomer.setCountry("Vietnam");
            newCustomer.setActive(true);
            return customerRepository.save(newCustomer);
        });
        
        // Convert cart to order
        cart.setStatus(Order.OrderStatus.PENDING);
        cart.setOrderNumber("ORDER-" + System.currentTimeMillis());
        cart.setCustomer(customer);
        cart.setOrderDate(java.time.LocalDateTime.now());
        cart.setShippingAddress(checkoutDto.shippingAddress);
        cart.setBillingAddress(checkoutDto.billingAddress);
        cart.setShippingMethod(checkoutDto.shippingMethod);
        cart.setNotes(checkoutDto.notes);
        
        // Calculate final totals
        cart.calculateTotals();
        
        Order savedOrder = orderRepository.save(cart);
        
        return ResponseEntity.ok(savedOrder);
    }

    // DTO for checkout
    public static class CheckoutDTO {
        public String shippingAddress;
        public String billingAddress;
        public String shippingMethod;
        public String notes;
    }

    // Helper method to convert Order to CartResponseDTO
    private CartResponseDTO convertToCartResponse(Order cart) {
        List<CartItemResponseDTO> items = cart.getOrderItems().stream()
            .map(this::convertToCartItemResponse)
            .collect(Collectors.toList());
        return new CartResponseDTO(
            items,
            items.size(),
            cart.getSubtotal(),
            cart.getTaxAmount(),
            cart.getShippingAmount(),
            cart.getDiscountAmount(),
            cart.getTotalAmount()
        );
    }
    
    // Helper method to convert OrderItem to CartItemResponseDTO
    private CartItemResponseDTO convertToCartItemResponse(OrderItem item) {
        CartItemResponseDTO dto = new CartItemResponseDTO();
        dto.setId(item.getId());
        dto.setProductId(item.getProduct().getId());
        dto.setProductName(item.getProductName());
        dto.setProductSku(item.getProductSku());
        dto.setQuantity(item.getQuantity());
        dto.setPrice(item.getUnitPrice());
        dto.setCreatedAt(item.getCreatedAt());
        dto.setUpdatedAt(item.getUpdatedAt());
        return dto;
    }
}