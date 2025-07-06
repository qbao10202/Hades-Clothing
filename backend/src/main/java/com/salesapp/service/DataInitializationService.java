package com.salesapp.service;

import com.salesapp.entity.Permission;
import com.salesapp.entity.Role;
import com.salesapp.entity.User;
import com.salesapp.repository.PermissionRepository;
import com.salesapp.repository.RoleRepository;
import com.salesapp.repository.UserRepository;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.Arrays;
import java.util.HashSet;
import java.util.Set;

@Service
public class DataInitializationService implements CommandLineRunner {
    
    private static final Logger logger = LoggerFactory.getLogger(DataInitializationService.class);
    
    @Autowired
    private RoleRepository roleRepository;
    
    @Autowired
    private PermissionRepository permissionRepository;
    
    @Autowired
    private UserRepository userRepository;
    
    @Autowired
    private PasswordEncoder passwordEncoder;
    
    @Override
    public void run(String... args) throws Exception {
        try {
            logger.info("Starting data initialization...");
            initializePermissions();
            initializeRoles();
            initializeAdminUser();
            logger.info("Data initialization completed successfully.");
        } catch (Exception e) {
            logger.error("Error during data initialization: {}", e.getMessage(), e);
            // Don't throw the exception to allow the application to start
        }
    }
    
    private void initializePermissions() {
        logger.info("Initializing permissions...");
        
        // Product permissions
        createPermissionIfNotExists("product:read", "View products", "product", "read");
        createPermissionIfNotExists("product:write", "Create/Update products", "product", "write");
        createPermissionIfNotExists("product:delete", "Delete products", "product", "delete");
        
        // Order permissions
        createPermissionIfNotExists("order:read", "View orders", "order", "read");
        createPermissionIfNotExists("order:write", "Create/Update orders", "order", "write");
        createPermissionIfNotExists("order:delete", "Delete orders", "order", "delete");
        createPermissionIfNotExists("order:process", "Process orders", "order", "process");
        
        // Customer permissions
        createPermissionIfNotExists("customer:read", "View customers", "customer", "read");
        createPermissionIfNotExists("customer:write", "Create/Update customers", "customer", "write");
        createPermissionIfNotExists("customer:delete", "Delete customers", "customer", "delete");
        
        // User permissions
        createPermissionIfNotExists("user:read", "View users", "user", "read");
        createPermissionIfNotExists("user:write", "Create/Update users", "user", "write");
        createPermissionIfNotExists("user:delete", "Delete users", "user", "delete");
        
        // Category permissions
        createPermissionIfNotExists("category:read", "View categories", "category", "read");
        createPermissionIfNotExists("category:write", "Create/Update categories", "category", "write");
        createPermissionIfNotExists("category:delete", "Delete categories", "category", "delete");
        
        // Report permissions
        createPermissionIfNotExists("report:read", "View reports", "report", "read");
        createPermissionIfNotExists("report:write", "Generate reports", "report", "write");
        
        // System permissions
        createPermissionIfNotExists("system:admin", "System administration", "system", "admin");
        
        logger.info("Permissions initialization completed.");
    }
    
    private void initializeRoles() {
        logger.info("Initializing roles...");
        
        // Create basic roles first
        Role customerRole = createRoleIfNotExists("CUSTOMER", "Regular customer with basic access");
        Role salesRole = createRoleIfNotExists("SALES", "Sales staff with order management access");
        Role managerRole = createRoleIfNotExists("MANAGER", "Store manager with administrative access");
        Role adminRole = createRoleIfNotExists("ADMIN", "System administrator with full access");
        
        // Assign permissions to roles
        assignPermissionsToRole(customerRole, Arrays.asList("product:read", "order:read", "order:write"));
        assignPermissionsToRole(salesRole, Arrays.asList("product:read", "order:read", "order:write", "order:process", "customer:read", "customer:write", "category:read"));
        assignPermissionsToRole(managerRole, Arrays.asList("product:read", "product:write", "order:read", "order:write", "order:process", "customer:read", "customer:write", "category:read", "category:write", "report:read", "report:write"));
        
        // Admin gets all permissions
        Set<Permission> allPermissions = new HashSet<>(permissionRepository.findAll());
        adminRole.setPermissions(allPermissions);
        roleRepository.save(adminRole);
        
        logger.info("Roles initialization completed.");
    }
    
    private Permission createPermissionIfNotExists(String name, String description, String resource, String action) {
        if (!permissionRepository.existsByName(name)) {
            Permission permission = new Permission(name, description, resource, action);
            Permission saved = permissionRepository.save(permission);
            logger.debug("Created permission: {}", name);
            return saved;
        }
        return permissionRepository.findByName(name).orElse(null);
    }
    
    private Role createRoleIfNotExists(String name, String description) {
        if (!roleRepository.existsByName(name)) {
            Role role = new Role(name, description);
            Role saved = roleRepository.save(role);
            logger.debug("Created role: {}", name);
            return saved;
        }
        return roleRepository.findByName(name).orElse(null);
    }
    
    private void assignPermissionsToRole(Role role, java.util.List<String> permissionNames) {
        Set<Permission> permissions = new HashSet<>();
        for (String permissionName : permissionNames) {
            Permission permission = permissionRepository.findByName(permissionName).orElse(null);
            if (permission != null) {
                permissions.add(permission);
            } else {
                logger.warn("Permission not found: {}", permissionName);
            }
        }
        role.setPermissions(permissions);
        roleRepository.save(role);
        logger.debug("Assigned {} permissions to role: {}", permissions.size(), role.getName());
    }
    
    private void initializeAdminUser() {
        logger.info("Checking for default admin user...");
        String adminUsername = "admin";
        String adminEmail = "admin@gmail.com";
        String adminPassword = "123456";
        User admin = userRepository.findByUsername(adminUsername).orElse(null);
        if (admin == null) {
            admin = new User();
            admin.setUsername(adminUsername);
            admin.setFirstName("Admin");
            admin.setLastName("User");
        }
        admin.setEmail(adminEmail);
        admin.setPassword(passwordEncoder.encode(adminPassword));
        admin.setActive(true);
        admin.setEmailVerified(true);
        admin.setPhoneVerified(false);
        // Assign ADMIN role
        Role adminRole = roleRepository.findByName("ADMIN").orElse(null);
        if (adminRole != null) {
            admin.getRoles().clear();
            admin.getRoles().add(adminRole);
        }
        userRepository.save(admin);
        logger.info("Default admin user ensured: {} / {}", adminUsername, adminPassword);
    }
} 