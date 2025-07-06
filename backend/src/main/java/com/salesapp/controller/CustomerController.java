package com.salesapp.controller;

import com.salesapp.entity.Customer;
import com.salesapp.repository.CustomerRepository;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/api/customers")
@Tag(name = "Customers", description = "Customer management APIs")
@CrossOrigin(origins = "*")
public class CustomerController {
    
    @Autowired
    private CustomerRepository customerRepository;
    
    @GetMapping
    @Operation(summary = "Get all customers", description = "Retrieve all customers")
    public ResponseEntity<List<Customer>> getAllCustomers() {
        List<Customer> customers = customerRepository.findAll();
        return ResponseEntity.ok(customers);
    }
    
    @GetMapping("/{id}")
    @Operation(summary = "Get customer by ID", description = "Retrieve a specific customer by its ID")
    public ResponseEntity<Customer> getCustomerById(@PathVariable Long id) {
        Optional<Customer> customer = customerRepository.findById(id);
        return customer.map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }
    
    @GetMapping("/code/{customerCode}")
    @Operation(summary = "Get customer by code", description = "Retrieve a specific customer by its customer code")
    public ResponseEntity<Customer> getCustomerByCode(@PathVariable String customerCode) {
        Optional<Customer> customer = customerRepository.findByCustomerCode(customerCode);
        return customer.map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }
    
    @PostMapping
    @PreAuthorize("hasAuthority('customer:write')")
    @Operation(summary = "Create customer", description = "Create a new customer (requires customer:write permission)")
    public ResponseEntity<Customer> createCustomer(@Valid @RequestBody Customer customer) {
        Customer savedCustomer = customerRepository.save(customer);
        return ResponseEntity.ok(savedCustomer);
    }
    
    @PutMapping("/{id}")
    @PreAuthorize("hasAuthority('customer:write')")
    @Operation(summary = "Update customer", description = "Update an existing customer (requires customer:write permission)")
    public ResponseEntity<Customer> updateCustomer(@PathVariable Long id, @Valid @RequestBody Customer customer) {
        Optional<Customer> existingCustomer = customerRepository.findById(id);
        if (existingCustomer.isPresent()) {
            customer.setId(id);
            Customer updatedCustomer = customerRepository.save(customer);
            return ResponseEntity.ok(updatedCustomer);
        }
        return ResponseEntity.notFound().build();
    }
    
    @DeleteMapping("/{id}")
    @PreAuthorize("hasAuthority('customer:delete')")
    @Operation(summary = "Delete customer", description = "Delete a customer (requires customer:delete permission)")
    public ResponseEntity<Void> deleteCustomer(@PathVariable Long id) {
        if (customerRepository.existsById(id)) {
            customerRepository.deleteById(id);
            return ResponseEntity.ok().build();
        }
        return ResponseEntity.notFound().build();
    }
} 