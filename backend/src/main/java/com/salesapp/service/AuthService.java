package com.salesapp.service;

import com.salesapp.dto.LoginRequest;
import com.salesapp.dto.LoginResponse;
import com.salesapp.dto.RegisterRequest;
import com.salesapp.dto.RegisterResponse;
import com.salesapp.entity.Role;
import com.salesapp.entity.User;
import com.salesapp.repository.RoleRepository;
import com.salesapp.repository.UserRepository;
import com.salesapp.security.JwtUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.time.Instant;
import java.util.Optional;

@Service
public class AuthService {
    
    @Autowired
    private AuthenticationManager authenticationManager;
    
    @Autowired
    private JwtUtil jwtUtil;
    
    @Autowired
    private UserRepository userRepository;
    
    @Autowired
    private RoleRepository roleRepository;
    
    @Autowired
    private PasswordEncoder passwordEncoder;
    
    public LoginResponse login(LoginRequest loginRequest) {
        Authentication authentication = authenticationManager.authenticate(
                new UsernamePasswordAuthenticationToken(loginRequest.getUsername(), loginRequest.getPassword())
        );
        
        UserDetails userDetails = (UserDetails) authentication.getPrincipal();
        String token = jwtUtil.generateToken(userDetails);
        
        User user = userRepository.findByUsername(loginRequest.getUsername()).orElse(null);
        
        // Update last login
        if (user != null) {
            user.setLastLogin(Instant.now());
            userRepository.save(user);
        }
        
        return new LoginResponse(token, user);
    }
    
    public RegisterResponse register(RegisterRequest registerRequest) {
        // Check if username already exists
        if (userRepository.existsByUsername(registerRequest.getUsername())) {
            throw new RuntimeException("Username already exists");
        }
        
        // Check if email already exists
        if (userRepository.existsByEmail(registerRequest.getEmail())) {
            throw new RuntimeException("Email already exists");
        }
        
        // Create new user
        User user = new User();
        user.setUsername(registerRequest.getUsername());
        user.setEmail(registerRequest.getEmail());
        user.setPassword(passwordEncoder.encode(registerRequest.getPassword()));
        user.setFirstName(registerRequest.getFirstName());
        user.setLastName(registerRequest.getLastName());
        user.setPhone(registerRequest.getPhone());
        user.setActive(true);
        user.setEmailVerified(false);
        user.setPhoneVerified(false);
        
        // Assign default USER role
        Optional<Role> userRole = roleRepository.findByName("USER");
        if (userRole.isPresent()) {
            user.addRole(userRole.get());
        } else {
            // If USER role doesn't exist, create it
            Role newUserRole = new Role();
            newUserRole.setName("USER");
            newUserRole.setDescription("Default user role");
            Role savedRole = roleRepository.save(newUserRole);
            user.addRole(savedRole);
        }
        // Assign CUSTOMER role for cart access
        Optional<Role> customerRole = roleRepository.findByName("CUSTOMER");
        customerRole.ifPresent(user::addRole);
        
        // Save user
        User savedUser = userRepository.save(user);
        
        // Generate token for auto-login
        String token = jwtUtil.generateToken(savedUser.getUsername());
        
        return new RegisterResponse("User registered successfully", savedUser, token);
    }
    
    public void logout(String username) {
        // Update last login or other logout logic if needed
        // For JWT, we mainly rely on frontend token removal
        // but we can add blacklist functionality here if needed
    }
}