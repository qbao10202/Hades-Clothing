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
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/api/user")
@Tag(name = "User Profile", description = "User profile and order management APIs")
@CrossOrigin(origins = "*")
public class UserController {
    
    @Autowired
    private UserRepository userRepository;
    
    @Autowired
    private OrderService orderService;
    
    // Get current user profile
    @GetMapping("/profile")
    @Operation(summary = "Get user profile", description = "Get current authenticated user's profile")
    public ResponseEntity<User> getUserProfile(Authentication authentication) {
        String username = authentication.getName();
        Optional<User> user = userRepository.findByUsername(username);
        return user.map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }
    
    // Update user profile
    @PutMapping("/profile")
    @Operation(summary = "Update user profile", description = "Update current authenticated user's profile")
    public ResponseEntity<User> updateUserProfile(
            @RequestBody UpdateProfileRequest request,
            Authentication authentication) {
        
        String username = authentication.getName();
        Optional<User> userOpt = userRepository.findByUsername(username);
        
        if (userOpt.isPresent()) {
            User user = userOpt.get();
            
            if (request.firstName != null) {
                user.setFirstName(request.firstName);
            }
            if (request.lastName != null) {
                user.setLastName(request.lastName);
            }
            if (request.phone != null) {
                user.setPhone(request.phone);
            }
            if (request.email != null && !request.email.equals(user.getEmail())) {
                // Check if new email already exists
                if (userRepository.existsByEmail(request.email)) {
                    return ResponseEntity.badRequest().build();
                }
                user.setEmail(request.email);
            }
            
            User updatedUser = userRepository.save(user);
            return ResponseEntity.ok(updatedUser);
        }
        
        return ResponseEntity.notFound().build();
    }
    
    // Get user's orders
    @GetMapping("/orders")
    @Operation(summary = "Get user orders", description = "Get orders for the current authenticated user")
    public ResponseEntity<Page<Order>> getUserOrders(
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "10") int size,
            @RequestParam(defaultValue = "createdAt") String sortBy,
            @RequestParam(defaultValue = "desc") String sortDir,
            Authentication authentication) {
        
        String username = authentication.getName();
        Optional<User> userOpt = userRepository.findByUsername(username);
        
        if (userOpt.isPresent()) {
            User user = userOpt.get();
            Sort sort = sortDir.equalsIgnoreCase("desc") ? 
                Sort.by(sortBy).descending() : 
                Sort.by(sortBy).ascending();
            
            Pageable pageable = PageRequest.of(page, size, sort);
            Page<Order> orders = orderService.getOrdersByUserId(user.getId(), pageable);
            
            return ResponseEntity.ok(orders);
        }
        
        return ResponseEntity.notFound().build();
    }
    
    // Get specific order by ID (only if it belongs to the user)
    @GetMapping("/orders/{id}")
    @Operation(summary = "Get user order by ID", description = "Get a specific order by ID if it belongs to the authenticated user")
    public ResponseEntity<Order> getUserOrderById(
            @PathVariable Long id,
            Authentication authentication) {
        
        String username = authentication.getName();
        Optional<User> userOpt = userRepository.findByUsername(username);
        
        if (userOpt.isPresent()) {
            User user = userOpt.get();
            Optional<Order> order = orderService.getOrderById(id);
            
            if (order.isPresent() && order.get().getUser().getId().equals(user.getId())) {
                return ResponseEntity.ok(order.get());
            }
        }
        
        return ResponseEntity.notFound().build();
    }
    
    // Cancel order (only if it's still pending)
    @PutMapping("/orders/{id}/cancel")
    @Operation(summary = "Cancel order", description = "Cancel an order if it's still pending")
    public ResponseEntity<Order> cancelOrder(
            @PathVariable Long id,
            Authentication authentication) {
        
        String username = authentication.getName();
        Optional<User> userOpt = userRepository.findByUsername(username);
        
        if (userOpt.isPresent()) {
            User user = userOpt.get();
            Optional<Order> orderOpt = orderService.getOrderById(id);
            
            if (orderOpt.isPresent() && orderOpt.get().getUser().getId().equals(user.getId())) {
                Order order = orderOpt.get();
                
                if (order.getStatus() == Order.OrderStatus.PENDING) {
                    order.setStatus(Order.OrderStatus.CANCELLED);
                    Order updatedOrder = orderService.updateOrderStatus(id, Order.OrderStatus.CANCELLED);
                    return ResponseEntity.ok(updatedOrder);
                } else {
                    return ResponseEntity.badRequest().build();
                }
            }
        }
        
        return ResponseEntity.notFound().build();
    }
    
    // Inner class for update profile request
    public static class UpdateProfileRequest {
        public String firstName;
        public String lastName;
        public String phone;
        public String email;
    }
}
