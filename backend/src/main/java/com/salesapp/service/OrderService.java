package com.salesapp.service;

import com.salesapp.entity.*;
import com.salesapp.repository.OrderRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.*;

@Service
public class OrderService {
    
    @Autowired
    private OrderRepository orderRepository;
    
    @Autowired
    private ProductService productService;
    
    public List<Order> getAllOrders() {
        return orderRepository.findAll();
    }
    
    public Page<Order> getAllOrdersWithFilters(
            Pageable pageable,
            Order.OrderStatus status,
            Order.PaymentStatus paymentStatus,
            Order.ShippingStatus shippingStatus,
            LocalDateTime startDate,
            LocalDateTime endDate) {
        
        Specification<Order> spec = Specification.where(null);
        
        if (status != null) {
            spec = spec.and((root, query, builder) -> builder.equal(root.get("status"), status));
        }
        
        if (paymentStatus != null) {
            spec = spec.and((root, query, builder) -> builder.equal(root.get("paymentStatus"), paymentStatus));
        }
        
        if (shippingStatus != null) {
            spec = spec.and((root, query, builder) -> builder.equal(root.get("shippingStatus"), shippingStatus));
        }
        
        if (startDate != null) {
            spec = spec.and((root, query, builder) -> builder.greaterThanOrEqualTo(root.get("orderDate"), startDate));
        }
        
        if (endDate != null) {
            spec = spec.and((root, query, builder) -> builder.lessThanOrEqualTo(root.get("orderDate"), endDate));
        }
        
        return orderRepository.findAll(spec, pageable);
    }
    
    public Page<Order> searchOrders(String query, Pageable pageable) {
        return orderRepository.searchOrders(query, pageable);
    }
    
    public List<Order> getRecentOrders(int limit) {
        return orderRepository.findTopByOrderByCreatedAtDesc(limit);
    }
    
    public Map<String, Object> getOrderStatistics(LocalDateTime startDate, LocalDateTime endDate) {
        Map<String, Object> stats = new HashMap<>();
        
        // Set date range if not provided
        if (startDate == null) {
            startDate = LocalDateTime.now().minusDays(30);
        }
        if (endDate == null) {
            endDate = LocalDateTime.now();
        }
        
        List<Order> orders = getOrdersByDateRange(startDate, endDate);
        
        // Total orders
        stats.put("totalOrders", orders.size());
        
        // Total sales
        BigDecimal totalSales = orders.stream()
                .map(Order::getTotalAmount)
                .reduce(BigDecimal.ZERO, BigDecimal::add);
        stats.put("totalSales", totalSales);
        
        // Average order value
        BigDecimal avgOrderValue = orders.isEmpty() ? BigDecimal.ZERO : 
                totalSales.divide(BigDecimal.valueOf(orders.size()), 2, BigDecimal.ROUND_HALF_UP);
        stats.put("averageOrderValue", avgOrderValue);
        
        // Order status counts
        Map<Order.OrderStatus, Long> statusCounts = new HashMap<>();
        for (Order.OrderStatus status : Order.OrderStatus.values()) {
            long count = orders.stream()
                    .filter(order -> order.getStatus() == status)
                    .count();
            statusCounts.put(status, count);
        }
        stats.put("statusCounts", statusCounts);
        
        // Payment status counts
        Map<Order.PaymentStatus, Long> paymentCounts = new HashMap<>();
        for (Order.PaymentStatus status : Order.PaymentStatus.values()) {
            long count = orders.stream()
                    .filter(order -> order.getPaymentStatus() == status)
                    .count();
            paymentCounts.put(status, count);
        }
        stats.put("paymentCounts", paymentCounts);
        
        return stats;
    }
    
    public Order updatePaymentStatus(Long orderId, Order.PaymentStatus paymentStatus) {
        Optional<Order> orderOpt = orderRepository.findById(orderId);
        if (orderOpt.isPresent()) {
            Order order = orderOpt.get();
            order.setPaymentStatus(paymentStatus);
            return orderRepository.save(order);
        }
        throw new RuntimeException("Order not found with id: " + orderId);
    }
    
    public Order updateShippingStatus(Long orderId, Order.ShippingStatus shippingStatus, String trackingNumber) {
        Optional<Order> orderOpt = orderRepository.findById(orderId);
        if (orderOpt.isPresent()) {
            Order order = orderOpt.get();
            order.setShippingStatus(shippingStatus);
            if (trackingNumber != null && !trackingNumber.isEmpty()) {
                order.setTrackingNumber(trackingNumber);
            }
            return orderRepository.save(order);
        }
        throw new RuntimeException("Order not found with id: " + orderId);
    }
    
    public Order addOrderNotes(Long orderId, String notes) {
        Optional<Order> orderOpt = orderRepository.findById(orderId);
        if (orderOpt.isPresent()) {
            Order order = orderOpt.get();
            order.setNotes(notes);
            return orderRepository.save(order);
        }
        throw new RuntimeException("Order not found with id: " + orderId);
    }
    
    public List<Order> getOrdersByCustomer(Long customerId) {
        return orderRepository.findByCustomerId(customerId);
    }
    
    public List<Order> getOrdersByUser(Long userId) {
        return orderRepository.findByUserId(userId);
    }
    
    public Page<Order> getOrdersByUserId(Long userId, Pageable pageable) {
        return orderRepository.findByUserIdOrderByCreatedAtDesc(userId, pageable);
    }
    
    public Optional<Order> getOrderById(Long id) {
        return orderRepository.findById(id);
    }
    
    public Optional<Order> getOrderByNumber(String orderNumber) {
        return orderRepository.findByOrderNumber(orderNumber);
    }
    
    @Transactional
    public Order createOrder(Order order) {
        // Generate order number
        order.setOrderNumber("ORD-" + UUID.randomUUID().toString().substring(0, 8).toUpperCase());
        order.setOrderDate(LocalDateTime.now());
        
        // Validate stock and update quantities
        for (OrderItem item : order.getOrderItems()) {
            if (!productService.checkStockAvailability(item.getProduct().getId(), item.getQuantity())) {
                throw new RuntimeException("Insufficient stock for product: " + item.getProduct().getName());
            }
        }
        
        // Calculate totals
        order.calculateTotals();
        
        // Save order
        Order savedOrder = orderRepository.save(order);
        
        // Update stock quantities
        for (OrderItem item : savedOrder.getOrderItems()) {
            productService.updateStock(item.getProduct().getId(), item.getQuantity());
        }
        
        return savedOrder;
    }
    
    public Order updateOrderStatus(Long orderId, Order.OrderStatus status) {
        Optional<Order> orderOpt = orderRepository.findById(orderId);
        if (orderOpt.isPresent()) {
            Order order = orderOpt.get();
            order.setStatus(status);
            return orderRepository.save(order);
        }
        throw new RuntimeException("Order not found with id: " + orderId);
    }
    
    public List<Order> getOrdersByDateRange(LocalDateTime startDate, LocalDateTime endDate) {
        return orderRepository.findByOrderDateBetween(startDate, endDate);
    }
    
    public List<Order> getOrdersByStatus(Order.OrderStatus status) {
        return orderRepository.findByStatus(status);
    }
    
    public BigDecimal calculateTotalSales(LocalDateTime startDate, LocalDateTime endDate) {
        List<Order> orders = getOrdersByDateRange(startDate, endDate);
        return orders.stream()
                .map(Order::getTotalAmount)
                .reduce(BigDecimal.ZERO, BigDecimal::add);
    }
    
    public Order approveOrder(Long orderId) {
        Optional<Order> orderOpt = orderRepository.findById(orderId);
        if (orderOpt.isPresent()) {
            Order order = orderOpt.get();
            if (order.getStatus() == Order.OrderStatus.CONFIRMED) {
                return order; // Already approved
            }
            if (order.getStatus() != Order.OrderStatus.PENDING) {
                throw new RuntimeException("Order cannot be approved in its current status");
            }
            // Decrease stock for each item
            for (OrderItem item : order.getOrderItems()) {
                productService.updateStock(item.getProduct().getId(), item.getQuantity());
            }
            order.setStatus(Order.OrderStatus.CONFIRMED);
            return orderRepository.save(order);
        }
        throw new RuntimeException("Order not found with id: " + orderId);
    }
}