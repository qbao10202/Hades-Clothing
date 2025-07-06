package com.salesapp.controller;

import com.salesapp.dto.LoginRequest;
import com.salesapp.dto.LoginResponse;
import com.salesapp.dto.RegisterRequest;
import com.salesapp.dto.RegisterResponse;
import com.salesapp.service.AuthService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/auth")
@Tag(name = "Authentication", description = "Authentication management APIs")
@CrossOrigin(origins = "*")
public class AuthController {
    
    @Autowired
    private AuthService authService;
    
    @PostMapping("/login")
    @Operation(summary = "User login", description = "Authenticate user and return JWT token")
    public ResponseEntity<LoginResponse> login(@Valid @RequestBody LoginRequest loginRequest) {
        try {
            LoginResponse response = authService.login(loginRequest);
            return ResponseEntity.ok(response);
        } catch (Exception e) {
            return ResponseEntity.badRequest().build();
        }
    }
    
    @PostMapping("/register")
    @Operation(summary = "User registration", description = "Register a new user account")
    public ResponseEntity<RegisterResponse> register(@Valid @RequestBody RegisterRequest registerRequest) {
        try {
            RegisterResponse response = authService.register(registerRequest);
            return ResponseEntity.ok(response);
        } catch (Exception e) {
            return ResponseEntity.badRequest().build();
        }
    }
    
    @PostMapping("/logout")
    @Operation(summary = "User logout", description = "Logout the authenticated user")
    public ResponseEntity<String> logout(Authentication authentication) {
        if (authentication != null && authentication.isAuthenticated()) {
            authService.logout(authentication.getName());
            return ResponseEntity.ok("Logged out successfully");
        }
        return ResponseEntity.badRequest().body("Not authenticated");
    }
    
    @GetMapping("/health")
    @Operation(summary = "Health check", description = "Check if authentication service is running")
    public ResponseEntity<String> health() {
        return ResponseEntity.ok("Auth service is running");
    }
}