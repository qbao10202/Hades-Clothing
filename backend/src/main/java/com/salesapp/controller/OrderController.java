package com.salesapp.controller;

import com.salesapp.entity.Order;
import com.salesapp.service.OrderService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/api/orders")
@Tag(name = "Orders", description = "Order management APIs")
@CrossOrigin(origins = "*")
public class OrderController {
    
    @Autowired
    private OrderService orderService;
    
    @GetMapping
    @Operation(summary = "Get all orders", description = "Retrieve all orders")
    public ResponseEntity<List<Order>> getAllOrders() {
        List<Order> orders = orderService.getAllOrders();
        return ResponseEntity.ok(orders);
    }
    
    @GetMapping("/{id}")
    @Operation(summary = "Get order by ID", description = "Retrieve a specific order by its ID")
    public ResponseEntity<Order> getOrderById(@PathVariable Long id) {
        Optional<Order> order = orderService.getOrderById(id);
        return order.map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }
    
    @GetMapping("/number/{orderNumber}")
    @Operation(summary = "Get order by number", description = "Retrieve a specific order by its order number")
    public ResponseEntity<Order> getOrderByNumber(@PathVariable String orderNumber) {
        Optional<Order> order = orderService.getOrderByNumber(orderNumber);
        return order.map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }
    
    @GetMapping("/customer/{customerId}")
    @Operation(summary = "Get orders by customer", description = "Retrieve all orders for a specific customer")
    public ResponseEntity<List<Order>> getOrdersByCustomer(@PathVariable Long customerId) {
        List<Order> orders = orderService.getOrdersByCustomer(customerId);
        return ResponseEntity.ok(orders);
    }
    
    @GetMapping("/user/{userId}")
    @Operation(summary = "Get orders by user", description = "Retrieve all orders created by a specific user")
    public ResponseEntity<List<Order>> getOrdersByUser(@PathVariable Long userId) {
        List<Order> orders = orderService.getOrdersByUser(userId);
        return ResponseEntity.ok(orders);
    }
    
    @GetMapping("/status/{status}")
    @Operation(summary = "Get orders by status", description = "Retrieve all orders with a specific status")
    public ResponseEntity<List<Order>> getOrdersByStatus(@PathVariable Order.OrderStatus status) {
        List<Order> orders = orderService.getOrdersByStatus(status);
        return ResponseEntity.ok(orders);
    }
    
    @GetMapping("/date-range")
    @Operation(summary = "Get orders by date range", description = "Retrieve orders within a specific date range")
    public ResponseEntity<List<Order>> getOrdersByDateRange(
            @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME) LocalDateTime startDate,
            @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME) LocalDateTime endDate) {
        List<Order> orders = orderService.getOrdersByDateRange(startDate, endDate);
        return ResponseEntity.ok(orders);
    }
    
    @PostMapping
    @PreAuthorize("hasAuthority('order:write')")
    @Operation(summary = "Create order", description = "Create a new order (requires order:write permission)")
    public ResponseEntity<Order> createOrder(@Valid @RequestBody Order order) {
        Order createdOrder = orderService.createOrder(order);
        return ResponseEntity.ok(createdOrder);
    }
    
    @PutMapping("/{id}/status")
    @PreAuthorize("hasAuthority('order:process')")
    @Operation(summary = "Update order status", description = "Update the status of an order (requires order:process permission)")
    public ResponseEntity<Order> updateOrderStatus(@PathVariable Long id, @RequestParam Order.OrderStatus status) {
        Order updatedOrder = orderService.updateOrderStatus(id, status);
        return ResponseEntity.ok(updatedOrder);
    }
    
    @GetMapping("/sales-total")
    @Operation(summary = "Calculate total sales", description = "Calculate total sales for a date range")
    public ResponseEntity<BigDecimal> calculateTotalSales(
            @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME) LocalDateTime startDate,
            @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME) LocalDateTime endDate) {
        BigDecimal totalSales = orderService.calculateTotalSales(startDate, endDate);
        return ResponseEntity.ok(totalSales);
    }
    
    @PutMapping("/{id}/approve")
    @PreAuthorize("hasRole('ADMIN') or hasRole('SELLER')")
    public ResponseEntity<Order> approveOrder(@PathVariable Long id) {
        Order approvedOrder = orderService.approveOrder(id);
        return ResponseEntity.ok(approvedOrder);
    }
} 