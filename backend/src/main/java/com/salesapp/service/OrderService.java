package com.salesapp.service;

import com.salesapp.entity.*;
import com.salesapp.repository.OrderRepository;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.time.Instant;
import java.time.Instant;
import java.util.*;

@Service
@Transactional
public class OrderService {
    
    @Autowired
    private OrderRepository orderRepository;
    
    @Autowired
    private ProductService productService;
    
    @PersistenceContext
    private EntityManager entityManager;
    
    public Page<Order> getAllOrdersWithDetails(Pageable pageable) {
        // First, get the total count
        Long total = entityManager.createQuery(
            "SELECT COUNT(o) FROM Order o", Long.class)
            .getSingleResult();
        
        // Then get the paginated data with all necessary joins
        List<Order> orders = entityManager.createQuery(
            "SELECT DISTINCT o FROM Order o " +
            "LEFT JOIN FETCH o.customer " +
            "LEFT JOIN FETCH o.orderItems oi " +
            "LEFT JOIN FETCH oi.product p " +
            "LEFT JOIN FETCH p.category " +
            "LEFT JOIN FETCH p.images " +
            "ORDER BY o.createdAt DESC", Order.class)
            .setFirstResult((int) pageable.getOffset())
            .setMaxResults(pageable.getPageSize())
            .getResultList();
        
        return new PageImpl<>(orders, pageable, total);
    }
    
    public List<Order> getAllOrders() {
        return orderRepository.findAll();
    }
    
    public Page<Order> getAllOrdersWithFilters(
            Pageable pageable,
            Order.OrderStatus status,
            Order.PaymentStatus paymentStatus,
            Order.ShippingStatus shippingStatus,
            Instant startDate,
            Instant endDate) {
        
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
            spec = spec.and((root, query, builder) -> builder.greaterThanOrEqualTo(root.get("createdAt"), startDate));
        }
        
        if (endDate != null) {
            spec = spec.and((root, query, builder) -> builder.lessThanOrEqualTo(root.get("createdAt"), endDate));
        }
        
        return orderRepository.findAll(spec, pageable);
    }
    
    public Page<Order> searchOrders(String query, Pageable pageable) {
        return orderRepository.searchOrders(query, pageable);
    }
    
    public List<Order> getRecentOrders(int limit) {
        return orderRepository.findTopByOrderByCreatedAtDesc(limit);
    }
    
    public Map<String, Object> getOrderStatistics(Instant startDate, Instant endDate) {
        Map<String, Object> stats = new HashMap<>();
        
        // Set date range if not provided
        if (startDate == null) {
            startDate = Instant.now().minusSeconds(2592000);
        }
        if (endDate == null) {
            endDate = Instant.now();
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
        order.setOrderDate(Instant.now());
        
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
    
    @Transactional
    public Order updateOrderStatus(Long orderId, Order.OrderStatus status) {
        if (orderId == null) {
            throw new IllegalArgumentException("Order ID cannot be null");
        }
        if (status == null) {
            throw new IllegalArgumentException("Order status cannot be null");
        }

        System.out.println("Updating order " + orderId + " to status " + status);
        
        // Use findById with a direct database query to avoid lazy loading issues
        // Load order with all associations for DTO
        Order order = entityManager.createQuery(
            "SELECT o FROM Order o " +
            "LEFT JOIN FETCH o.customer " +
            "LEFT JOIN FETCH o.orderItems oi " +
            "LEFT JOIN FETCH oi.product p " +
            "LEFT JOIN FETCH p.category " +
            "LEFT JOIN FETCH p.images " +
            "WHERE o.id = :id", Order.class)
            .setParameter("id", orderId)
            .getSingleResult();

        System.out.println("Current order status: " + order.getStatus());
        
        // Validate status transition
        if (!isValidStatusTransition(order.getStatus(), status)) {
            throw new IllegalStateException(
                "Invalid status transition from " + order.getStatus() + " to " + status
            );
        }

        try {
            order.setStatus(status);
            order.setUpdatedAt(Instant.now());
            Order savedOrder = orderRepository.save(order);
            System.out.println("Order status updated successfully to: " + savedOrder.getStatus());
            // Return the fully loaded order for DTO
            return order;
        } catch (Exception e) {
            System.out.println("Error saving order: " + e.getMessage());
            e.printStackTrace();
            throw new RuntimeException("Failed to update order status: " + e.getMessage());
        }
    }

    private boolean isValidStatusTransition(Order.OrderStatus currentStatus, Order.OrderStatus newStatus) {
        if (currentStatus == newStatus) {
            return true; // Allow setting the same status
        }

        switch (currentStatus) {
            case CART:
                return newStatus == Order.OrderStatus.PENDING;
            case PENDING:
                return newStatus == Order.OrderStatus.CONFIRMED || 
                       newStatus == Order.OrderStatus.CANCELLED;
            case CONFIRMED:
                return newStatus == Order.OrderStatus.PROCESSING || 
                       newStatus == Order.OrderStatus.CANCELLED;
            case PROCESSING:
                return newStatus == Order.OrderStatus.SHIPPED || 
                       newStatus == Order.OrderStatus.CANCELLED;
            case SHIPPED:
                return newStatus == Order.OrderStatus.DELIVERED || 
                       newStatus == Order.OrderStatus.CANCELLED;
            case DELIVERED:
                return newStatus == Order.OrderStatus.REFUNDED;
            case CANCELLED:
                return false; // Cannot transition from CANCELLED
            case REFUNDED:
                return false; // Cannot transition from REFUNDED
            default:
                return false;
        }
    }
    
    public List<Order> getOrdersByDateRange(Instant startDate, Instant endDate) {
        return orderRepository.findByOrderDateBetween(startDate, endDate);
    }
    
    public List<Order> getOrdersByStatus(Order.OrderStatus status) {
        return orderRepository.findByStatus(status);
    }
    
    public BigDecimal calculateTotalSales(Instant startDate, Instant endDate) {
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