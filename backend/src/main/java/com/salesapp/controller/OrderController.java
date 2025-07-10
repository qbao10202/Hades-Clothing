package com.salesapp.controller;

import com.salesapp.dto.OrderResponseDTO;
import com.salesapp.entity.Order;
import com.salesapp.service.OrderService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/api")
@Tag(name = "Orders", description = "Order management APIs")
@CrossOrigin(origins = "*")
public class OrderController {
    
    @Autowired
    private OrderService orderService;
    
    @GetMapping("/admin/orders")
    @PreAuthorize("hasRole('ADMIN')")
    @Operation(summary = "Get all orders for admin", description = "Retrieve all orders with full details for admin")
    public ResponseEntity<Page<OrderResponseDTO>> getAllOrdersForAdmin(
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "10") int size,
            @RequestParam(defaultValue = "createdAt") String sortBy,
            @RequestParam(defaultValue = "desc") String sortDir) {
        
        Sort sort = sortDir.equalsIgnoreCase("desc") ? 
            Sort.by(sortBy).descending() : 
            Sort.by(sortBy).ascending();
        
        Pageable pageable = PageRequest.of(page, size, sort);
        Page<Order> orders = orderService.getAllOrdersWithDetails(pageable);
        
        return ResponseEntity.ok(orders.map(OrderResponseDTO::fromEntity));
    }
    
    @GetMapping("/orders")
    @Operation(summary = "Get all orders", description = "Retrieve all orders")
    public ResponseEntity<List<OrderResponseDTO>> getAllOrders() {
        List<Order> orders = orderService.getAllOrders();
        List<OrderResponseDTO> orderDTOs = orders.stream()
            .map(OrderResponseDTO::fromEntity)
            .collect(Collectors.toList());
        return ResponseEntity.ok(orderDTOs);
    }
    
    @GetMapping("/{id}")
    @Operation(summary = "Get order by ID", description = "Retrieve a specific order by its ID")
    public ResponseEntity<OrderResponseDTO> getOrderById(@PathVariable Long id) {
        Optional<Order> order = orderService.getOrderById(id);
        return order.map(o -> ResponseEntity.ok(OrderResponseDTO.fromEntity(o)))
                .orElse(ResponseEntity.notFound().build());
    }
    
    @GetMapping("/number/{orderNumber}")
    @Operation(summary = "Get order by number", description = "Retrieve a specific order by its order number")
    public ResponseEntity<OrderResponseDTO> getOrderByNumber(@PathVariable String orderNumber) {
        Optional<Order> order = orderService.getOrderByNumber(orderNumber);
        return order.map(o -> ResponseEntity.ok(OrderResponseDTO.fromEntity(o)))
                .orElse(ResponseEntity.notFound().build());
    }
    
    @GetMapping("/customer/{customerId}")
    @Operation(summary = "Get orders by customer", description = "Retrieve all orders for a specific customer")
    public ResponseEntity<List<OrderResponseDTO>> getOrdersByCustomer(@PathVariable Long customerId) {
        List<Order> orders = orderService.getOrdersByCustomer(customerId);
        List<OrderResponseDTO> orderDTOs = orders.stream()
            .map(OrderResponseDTO::fromEntity)
            .collect(Collectors.toList());
        return ResponseEntity.ok(orderDTOs);
    }
    
    @GetMapping("/user/{userId}")
    @Operation(summary = "Get orders by user", description = "Retrieve all orders created by a specific user")
    public ResponseEntity<List<OrderResponseDTO>> getOrdersByUser(@PathVariable Long userId) {
        List<Order> orders = orderService.getOrdersByUser(userId);
        List<OrderResponseDTO> orderDTOs = orders.stream()
            .map(OrderResponseDTO::fromEntity)
            .collect(Collectors.toList());
        return ResponseEntity.ok(orderDTOs);
    }
    
    @GetMapping("/status/{status}")
    @Operation(summary = "Get orders by status", description = "Retrieve all orders with a specific status")
    public ResponseEntity<List<OrderResponseDTO>> getOrdersByStatus(@PathVariable Order.OrderStatus status) {
        List<Order> orders = orderService.getOrdersByStatus(status);
        List<OrderResponseDTO> orderDTOs = orders.stream()
            .map(OrderResponseDTO::fromEntity)
            .collect(Collectors.toList());
        return ResponseEntity.ok(orderDTOs);
    }
    
    @GetMapping("/date-range")
    @Operation(summary = "Get orders by date range", description = "Retrieve orders within a specific date range")
    public ResponseEntity<List<OrderResponseDTO>> getOrdersByDateRange(
            @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME) LocalDateTime startDate,
            @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME) LocalDateTime endDate) {
        List<Order> orders = orderService.getOrdersByDateRange(startDate, endDate);
        List<OrderResponseDTO> orderDTOs = orders.stream()
            .map(OrderResponseDTO::fromEntity)
            .collect(Collectors.toList());
        return ResponseEntity.ok(orderDTOs);
    }
    
    @PostMapping
    @PreAuthorize("hasAuthority('order:write')")
    @Operation(summary = "Create order", description = "Create a new order (requires order:write permission)")
    public ResponseEntity<OrderResponseDTO> createOrder(@Valid @RequestBody Order order) {
        Order createdOrder = orderService.createOrder(order);
        return ResponseEntity.ok(OrderResponseDTO.fromEntity(createdOrder));
    }
    
    @PutMapping("/{id}/status")
    @PreAuthorize("hasRole('ADMIN') or hasRole('SELLER') or hasAuthority('order:process')")
    @Operation(summary = "Update order status", description = "Update the status of an order (requires ADMIN/SELLER role or order:process permission)")
    public ResponseEntity<?> updateOrderStatus(@PathVariable Long id, @RequestParam String status) {
        try {
            // Log the incoming request
            System.out.println("Updating order status - ID: " + id + ", Status: " + status);
            
            // Convert string to enum
            Order.OrderStatus orderStatus;
            try {
                orderStatus = Order.OrderStatus.valueOf(status.toUpperCase());
            } catch (IllegalArgumentException e) {
                System.out.println("Invalid status value: " + status);
                Map<String, String> error = new HashMap<>();
                error.put("error", "Invalid status value: " + status + ". Valid values are: " + Arrays.toString(Order.OrderStatus.values()));
                return ResponseEntity.badRequest().body(error);
            }
            
            // Update the order
            Order updatedOrder = orderService.updateOrderStatus(id, orderStatus);
            
            // Create a simplified response without lazy-loaded associations
            Map<String, Object> response = new HashMap<>();
            response.put("id", updatedOrder.getId());
            response.put("orderNumber", updatedOrder.getOrderNumber());
            response.put("status", updatedOrder.getStatus());
            response.put("updatedAt", updatedOrder.getUpdatedAt());
            
            System.out.println("Order updated successfully - ID: " + id + ", New Status: " + updatedOrder.getStatus());
            return ResponseEntity.ok(response);
            
        } catch (RuntimeException e) {
            System.out.println("Error updating order status - ID: " + id + ", Error: " + e.getMessage());
            e.printStackTrace(); // Add stack trace for debugging
            Map<String, String> error = new HashMap<>();
            error.put("error", "Failed to update order status: " + e.getMessage());
            return ResponseEntity.badRequest().body(error);
        } catch (Exception e) {
            System.out.println("Unexpected error updating order status - ID: " + id + ", Error: " + e.getMessage());
            e.printStackTrace(); // Add stack trace for debugging
            Map<String, String> error = new HashMap<>();
            error.put("error", "An unexpected error occurred while updating order status. Please try again later.");
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(error);
        }
    }
    
    @GetMapping("/sales-total")
    @Operation(summary = "Calculate total sales", description = "Calculate total sales for a date range")
    public ResponseEntity<BigDecimal> calculateTotalSales(
            @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME) LocalDateTime startDate,
            @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME) LocalDateTime endDate) {
        BigDecimal totalSales = orderService.calculateTotalSales(startDate, endDate);
        return ResponseEntity.ok(totalSales);
    }
    
    @GetMapping("/admin/orders/statistics")
    @PreAuthorize("hasRole('ADMIN')")
    @Operation(summary = "Get order statistics", description = "Get order statistics for admin dashboard")
    public ResponseEntity<Map<String, Object>> getOrderStatistics(
            @RequestParam(required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDateTime startDate,
            @RequestParam(required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDateTime endDate) {
        Map<String, Object> stats = orderService.getOrderStatistics(startDate, endDate);
        return ResponseEntity.ok(stats);
    }
    
    @PutMapping("/{id}/approve")
    @PreAuthorize("hasRole('ADMIN') or hasRole('SELLER')")
    public ResponseEntity<OrderResponseDTO> approveOrder(@PathVariable Long id) {
        Order approvedOrder = orderService.approveOrder(id);
        return ResponseEntity.ok(OrderResponseDTO.fromEntity(approvedOrder));
    }
    
    @PutMapping("/admin/orders/{id}/status")
    @PreAuthorize("hasRole('ADMIN') or hasRole('SELLER')")
    @Operation(summary = "Update order status (Admin)", description = "Update the status of an order via admin endpoint")
    public ResponseEntity<?> updateOrderStatusAdmin(@PathVariable Long id, @RequestParam String status) {
        try {
            // Log the incoming request
            System.out.println("Admin updating order status - ID: " + id + ", Status: " + status);
            
            // Convert string to enum
            Order.OrderStatus orderStatus;
            try {
                orderStatus = Order.OrderStatus.valueOf(status.toUpperCase());
            } catch (IllegalArgumentException e) {
                System.out.println("Invalid status value: " + status);
                Map<String, String> error = new HashMap<>();
                error.put("error", "Invalid status value: " + status + ". Valid values are: " + Arrays.toString(Order.OrderStatus.values()));
                return ResponseEntity.badRequest().body(error);
            }
            
            // Update the order
            Order updatedOrder = orderService.updateOrderStatus(id, orderStatus);
            
            System.out.println("Successfully updated order " + id + " to status " + status);
            return ResponseEntity.ok(OrderResponseDTO.fromEntity(updatedOrder));
            
        } catch (Exception e) {
            System.out.println("Error updating order status: " + e.getMessage());
            Map<String, String> error = new HashMap<>();
            error.put("error", "Failed to update order status: " + e.getMessage());
            return ResponseEntity.status(500).body(error);
        }
    }
}