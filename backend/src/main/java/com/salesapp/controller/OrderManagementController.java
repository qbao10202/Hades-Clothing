package com.salesapp.controller;

import com.salesapp.entity.Order;
import com.salesapp.entity.User;
import com.salesapp.repository.UserRepository;
import com.salesapp.service.OrderService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;

import java.time.Instant;
import java.util.List;
import java.util.Map;
import java.util.Optional;

@RestController
@RequestMapping("/api/admin/orders-management")
@Tag(name = "Order Management", description = "Admin and Seller Order management APIs")
@CrossOrigin(origins = "*")
public class OrderManagementController {
    
    @Autowired
    private OrderService orderService;
    
    @Autowired
    private UserRepository userRepository;
    
    // Get all orders with pagination and filtering
    @GetMapping
    @PreAuthorize("hasRole('ADMIN') or hasRole('SELLER')")
    @Operation(summary = "Get all orders", description = "Retrieve all orders with pagination and filtering")
    public ResponseEntity<Page<Order>> getAllOrders(
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "10") int size,
            @RequestParam(defaultValue = "createdAt") String sortBy,
            @RequestParam(defaultValue = "desc") String sortDir,
            @RequestParam(required = false) Order.OrderStatus status,
            @RequestParam(required = false) Order.PaymentStatus paymentStatus,
            @RequestParam(required = false) Order.ShippingStatus shippingStatus,
            @RequestParam(required = false) Instant startDate,
            @RequestParam(required = false) Instant endDate,
            Authentication authentication) {
        
        Sort sort = sortDir.equalsIgnoreCase("desc") ? 
            Sort.by(sortBy).descending() : 
            Sort.by(sortBy).ascending();
        
        Pageable pageable = PageRequest.of(page, size, sort);
        
        Page<Order> orders = orderService.getAllOrdersWithFilters(
            pageable, status, paymentStatus, shippingStatus, startDate, endDate
        );
        
        return ResponseEntity.ok(orders);
    }
    
    // Get order by ID
    @GetMapping("/{id}")
    @PreAuthorize("hasRole('ADMIN') or hasRole('SELLER')")
    @Operation(summary = "Get order by ID", description = "Retrieve a specific order by its ID")
    public ResponseEntity<Order> getOrderById(@PathVariable Long id) {
        Optional<Order> order = orderService.getOrderById(id);
        return order.map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }
    
    // Update order status
    @PutMapping("/{id}/status")
    @PreAuthorize("hasRole('ADMIN') or hasRole('SELLER')")
    @Operation(summary = "Update order status", description = "Update the status of an order")
    public ResponseEntity<Order> updateOrderStatus(
            @PathVariable Long id, 
            @RequestParam Order.OrderStatus status,
            Authentication authentication) {
        
        try {
            Order updatedOrder = orderService.updateOrderStatus(id, status);
            return ResponseEntity.ok(updatedOrder);
        } catch (Exception e) {
            return ResponseEntity.badRequest().build();
        }
    }
    
    // Update payment status
    @PutMapping("/{id}/payment-status")
    @PreAuthorize("hasRole('ADMIN') or hasRole('SELLER')")
    @Operation(summary = "Update payment status", description = "Update the payment status of an order")
    public ResponseEntity<Order> updatePaymentStatus(
            @PathVariable Long id, 
            @RequestParam Order.PaymentStatus paymentStatus,
            Authentication authentication) {
        
        try {
            Order updatedOrder = orderService.updatePaymentStatus(id, paymentStatus);
            return ResponseEntity.ok(updatedOrder);
        } catch (Exception e) {
            return ResponseEntity.badRequest().build();
        }
    }
    
    // Update shipping status
    @PutMapping("/{id}/shipping-status")
    @PreAuthorize("hasRole('ADMIN') or hasRole('SELLER')")
    @Operation(summary = "Update shipping status", description = "Update the shipping status of an order")
    public ResponseEntity<Order> updateShippingStatus(
            @PathVariable Long id, 
            @RequestParam Order.ShippingStatus shippingStatus,
            @RequestParam(required = false) String trackingNumber,
            Authentication authentication) {
        
        try {
            Order updatedOrder = orderService.updateShippingStatus(id, shippingStatus, trackingNumber);
            return ResponseEntity.ok(updatedOrder);
        } catch (Exception e) {
            return ResponseEntity.badRequest().build();
        }
    }
    
    // Get order statistics
    @GetMapping("/statistics")
    @PreAuthorize("hasRole('ADMIN') or hasRole('SELLER')")
    @Operation(summary = "Get order statistics", description = "Get order statistics for dashboard")
    public ResponseEntity<Map<String, Object>> getOrderStatistics(
            @RequestParam(required = false) Instant startDate,
            @RequestParam(required = false) Instant endDate) {
        
        Map<String, Object> stats = orderService.getOrderStatistics(startDate, endDate);
        return ResponseEntity.ok(stats);
    }
    
    // Get recent orders
    @GetMapping("/recent")
    @PreAuthorize("hasRole('ADMIN') or hasRole('SELLER')")
    @Operation(summary = "Get recent orders", description = "Get most recent orders")
    public ResponseEntity<List<Order>> getRecentOrders(@RequestParam(defaultValue = "10") int limit) {
        List<Order> orders = orderService.getRecentOrders(limit);
        return ResponseEntity.ok(orders);
    }
    
    // Search orders
    @GetMapping("/search")
    @PreAuthorize("hasRole('ADMIN') or hasRole('SELLER')")
    @Operation(summary = "Search orders", description = "Search orders by order number, customer name, or email")
    public ResponseEntity<Page<Order>> searchOrders(
            @RequestParam String query,
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "10") int size,
            @RequestParam(defaultValue = "createdAt") String sortBy,
            @RequestParam(defaultValue = "desc") String sortDir) {
        
        Sort sort = sortDir.equalsIgnoreCase("desc") ? 
            Sort.by(sortBy).descending() : 
            Sort.by(sortBy).ascending();
        
        Pageable pageable = PageRequest.of(page, size, sort);
        
        Page<Order> orders = orderService.searchOrders(query, pageable);
        return ResponseEntity.ok(orders);
    }
    
    // Add order notes
    @PutMapping("/{id}/notes")
    @PreAuthorize("hasRole('ADMIN') or hasRole('SELLER')")
    @Operation(summary = "Add order notes", description = "Add notes to an order")
    public ResponseEntity<Order> addOrderNotes(
            @PathVariable Long id, 
            @RequestBody Map<String, String> request,
            Authentication authentication) {
        
        try {
            String notes = request.get("notes");
            Order updatedOrder = orderService.addOrderNotes(id, notes);
            return ResponseEntity.ok(updatedOrder);
        } catch (Exception e) {
            return ResponseEntity.badRequest().build();
        }
    }
}
