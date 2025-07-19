package com.salesapp.controller;

import com.salesapp.entity.Category;
import com.salesapp.repository.CategoryRepository;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.core.io.ByteArrayResource;
import com.fasterxml.jackson.databind.ObjectMapper;

import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/api/categories")
@Tag(name = "Categories", description = "Category management APIs")
@CrossOrigin(origins = "*")
public class CategoryController {
    
    @Autowired
    private CategoryRepository categoryRepository;
    
    @Autowired
    private ObjectMapper objectMapper;
    
    @GetMapping
    @Operation(summary = "Get all categories", description = "Retrieve all product categories with pagination")
    public ResponseEntity<Page<Category>> getAllCategories(
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "10") int size,
            @RequestParam(defaultValue = "name") String sortBy,
            @RequestParam(defaultValue = "asc") String sortDir,
            @RequestParam(required = false) String search) {
        
        Sort sort = sortDir.equalsIgnoreCase("desc") ? 
            Sort.by(sortBy).descending() : 
            Sort.by(sortBy).ascending();
        
        Pageable pageable = PageRequest.of(page, size, sort);
        Page<Category> categories;
        
        if (search != null && !search.trim().isEmpty()) {
            categories = categoryRepository.findByNameContainingIgnoreCase(search, pageable);
        } else {
            categories = categoryRepository.findAll(pageable);
        }
        
        return ResponseEntity.ok(categories);
    }
    
    @GetMapping("/all")
    @Operation(summary = "Get all categories without pagination", description = "Retrieve all product categories as a list")
    public ResponseEntity<List<Category>> getAllCategoriesList() {
        List<Category> categories = categoryRepository.findAll();
        return ResponseEntity.ok(categories);
    }
    
    @GetMapping("/{id}")
    @Operation(summary = "Get category by ID", description = "Retrieve a specific category by its ID")
    public ResponseEntity<Category> getCategoryById(@PathVariable Long id) {
        Optional<Category> category = categoryRepository.findById(id);
        return category.map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }
    
    @PostMapping
    @PreAuthorize("hasRole('ADMIN')")
    @Operation(summary = "Create category", description = "Create a new category (Admin only)")
    public ResponseEntity<Category> createCategory(@Valid @RequestBody Category category) {
        Category savedCategory = categoryRepository.save(category);
        return ResponseEntity.ok(savedCategory);
    }
    
    @PutMapping("/{id}")
    @PreAuthorize("hasRole('ADMIN')")
    @Operation(summary = "Update category", description = "Update an existing category (Admin only)")
    public ResponseEntity<Category> updateCategory(@PathVariable Long id, @Valid @RequestBody Category category) {
        Optional<Category> existingCategory = categoryRepository.findById(id);
        if (existingCategory.isPresent()) {
            category.setId(id);
            Category updatedCategory = categoryRepository.save(category);
            return ResponseEntity.ok(updatedCategory);
        }
        return ResponseEntity.notFound().build();
    }
    
    @DeleteMapping("/{id}")
    @PreAuthorize("hasRole('ADMIN')")
    @Operation(summary = "Delete category", description = "Delete a category (Admin only)")
    public ResponseEntity<Void> deleteCategory(@PathVariable Long id) {
        if (categoryRepository.existsById(id)) {
            categoryRepository.deleteById(id);
            return ResponseEntity.ok().build();
        }
        return ResponseEntity.notFound().build();
    }

    @PostMapping(value = "/{id}/image", produces = MediaType.APPLICATION_JSON_VALUE)
    @PreAuthorize("hasRole('ADMIN')")
    public ResponseEntity<?> uploadCategoryImage(@PathVariable Long id, @RequestParam("file") MultipartFile file) {
        try {
            Optional<Category> categoryOpt = categoryRepository.findById(id);
            if (categoryOpt.isPresent()) {
                Category category = categoryOpt.get();
                category.setImageContentType(file.getContentType());
                category.setImageData(file.getBytes());
                category.setImageUrl(file.getOriginalFilename()); // store filename for reference
                categoryRepository.save(category);
                return ResponseEntity.ok().body(java.util.Collections.singletonMap("message", "Image uploaded and category updated successfully"));
            } else {
                return ResponseEntity.status(404).body(java.util.Collections.singletonMap("error", "Category not found"));
            }
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(500).body(java.util.Collections.singletonMap("error", "Failed to upload image: " + e.getMessage()));
        }
    }

    @GetMapping("/{id}/image")
    @Operation(summary = "Serve category image from DB", description = "Serve a category image as binary data from the database")
    public ResponseEntity<?> serveCategoryImage(@PathVariable Long id) {
        Optional<Category> categoryOpt = categoryRepository.findById(id);
        if (categoryOpt.isPresent() && categoryOpt.get().getImageData() != null) {
            Category category = categoryOpt.get();
            ByteArrayResource resource = new ByteArrayResource(category.getImageData());
            return ResponseEntity.ok()
                    .header(HttpHeaders.CONTENT_DISPOSITION, "inline; filename=\"" + category.getImageUrl() + "\"")
                    .contentType(MediaType.parseMediaType(category.getImageContentType()))
                    .body(resource);
        } else {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Image not found");
        }
    }

    @PostMapping(value = "/multipart", consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
    @PreAuthorize("hasRole('ADMIN')")
    public ResponseEntity<?> createCategoryMultipart(@RequestPart("category") String categoryJson,
                                                    @RequestPart(value = "file", required = false) MultipartFile file) {
        try {
            Category category = objectMapper.readValue(categoryJson, Category.class);
            if (file != null && !file.isEmpty()) {
                category.setImageContentType(file.getContentType());
                category.setImageData(file.getBytes());
                category.setImageUrl(file.getOriginalFilename());
            } else {
                // No image provided, leave image fields null
                category.setImageContentType(null);
                category.setImageData(null);
                category.setImageUrl(null);
            }
            Category savedCategory = categoryRepository.save(category);
            return ResponseEntity.ok(savedCategory);
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(500).body("Failed to create category: " + e.getMessage());
        }
    }

    @PutMapping(value = "/{id}/multipart", consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
    @PreAuthorize("hasRole('ADMIN')")
    public ResponseEntity<?> updateCategoryMultipart(@PathVariable Long id,
                                                    @RequestPart("category") String categoryJson,
                                                    @RequestPart(value = "file", required = false) MultipartFile file) {
        try {
            Optional<Category> existingCategoryOpt = categoryRepository.findById(id);
            if (existingCategoryOpt.isEmpty()) {
                return ResponseEntity.status(404).body("Category not found");
            }
            Category existing = existingCategoryOpt.get();
            Category category = objectMapper.readValue(categoryJson, Category.class);
            category.setId(id);
            // Preserve createdAt
            category.setCreatedAt(existing.getCreatedAt());
            if (file != null && !file.isEmpty()) {
                category.setImageContentType(file.getContentType());
                category.setImageData(file.getBytes());
                category.setImageUrl(file.getOriginalFilename());
            } else {
                // Preserve existing image if not updated
                category.setImageContentType(existing.getImageContentType());
                category.setImageData(existing.getImageData());
                category.setImageUrl(existing.getImageUrl());
            }
            Category updatedCategory = categoryRepository.save(category);
            return ResponseEntity.ok(updatedCategory);
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(500).body("Failed to update category: " + e.getMessage());
        }
    }
} 