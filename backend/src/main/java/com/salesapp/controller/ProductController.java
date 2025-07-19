package com.salesapp.controller;

import com.salesapp.entity.Product;
import com.salesapp.entity.ProductImage;
import com.salesapp.repository.CategoryRepository;
import com.salesapp.repository.ProductImageRepository;
import com.salesapp.service.ProductService;
import com.salesapp.dto.ProductDTO;
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

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;
import java.util.Map;

@RestController
@RequestMapping("/api/products")
@Tag(name = "Products", description = "Product management APIs")
@CrossOrigin(origins = "*")
public class ProductController {

    @Autowired
    private CategoryRepository categoryRepository;
    
    @Autowired
    private ProductService productService;
    
    @Autowired
    private ProductImageRepository productImageRepository;
    
    @GetMapping
    @Operation(summary = "Get all products", description = "Retrieve all active products with pagination")
    public ResponseEntity<Page<ProductDTO>> getAllProducts(
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "10") int size,
            @RequestParam(defaultValue = "name") String sortBy,
            @RequestParam(defaultValue = "asc") String sortDir,
            @RequestParam(required = false) String search) {
        
        Sort sort = sortDir.equalsIgnoreCase("desc") ? 
            Sort.by(sortBy).descending() : 
            Sort.by(sortBy).ascending();
        
        Pageable pageable = PageRequest.of(page, size, sort);
        Page<Product> products;
        
        if (search != null && !search.trim().isEmpty()) {
            products = productService.searchProducts(search, pageable);
        } else {
            products = productService.getAllProductsWithPagination(pageable);
        }
        
        Page<ProductDTO> productDTOs = products.map(productService::toProductDTO);
        return ResponseEntity.ok(productDTOs);
    }
    
    @GetMapping("/all")
    @Operation(summary = "Get all products without pagination", description = "Retrieve all active products as a list")
    public ResponseEntity<List<ProductDTO>> getAllProductsList() {
        List<ProductDTO> products = productService.getAllProducts().stream()
            .map(productService::toProductDTO)
            .collect(Collectors.toList());
        return ResponseEntity.ok(products);
    }
    
    @GetMapping("/{id}")
    @Operation(summary = "Get product by ID", description = "Retrieve a specific product by its ID")
    public ResponseEntity<?> getProductById(@PathVariable Long id) {
        Optional<Product> productOpt = productService.getProductById(id);
        if (productOpt.isPresent()) {
            ProductDTO dto = productService.toProductDTO(productOpt.get());
            return ResponseEntity.ok(dto);
        } else {
            return ResponseEntity.status(404).body(new com.salesapp.exception.GlobalExceptionHandler.ErrorResponse("Product not found"));
        }
    }
    
    @GetMapping("/code/{productCode}")
    @Operation(summary = "Get product by code", description = "Retrieve a specific product by its product code")
    public ResponseEntity<Product> getProductByCode(@PathVariable String productCode) {
        Optional<Product> product = productService.getProductByCode(productCode);
        return product.map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }
    
    @GetMapping("/category/{categoryId}")
    @Operation(summary = "Get products by category", description = "Retrieve all products in a specific category")
    public ResponseEntity<List<ProductDTO>> getProductsByCategory(@PathVariable Long categoryId) {
        List<ProductDTO> products = productService.getProductsByCategory(categoryId).stream()
            .map(productService::toProductDTO)
            .collect(Collectors.toList());
        return ResponseEntity.ok(products);
    }
    
    @PostMapping
    @PreAuthorize("hasAuthority('product:write')")
    @Operation(summary = "Create product", description = "Create a new product (requires product:write permission)")
    public ResponseEntity<ProductDTO> createProduct(@Valid @RequestBody ProductDTO productDTO) {
        Product product = new Product();
        product.setProductCode(productDTO.getProductCode());
        product.setName(productDTO.getName());
        product.setSlug(productDTO.getSlug());
        product.setDescription(productDTO.getDescription());
        product.setShortDescription(productDTO.getShortDescription());
        product.setPrice(productDTO.getPrice());
        product.setCost(productDTO.getCost());
        product.setSalePrice(productDTO.getSalePrice());
        product.setStockQuantity(productDTO.getStockQuantity());
        product.setMinStockLevel(productDTO.getMinStockLevel());
        product.setMaxStockLevel(productDTO.getMaxStockLevel());
        if (productDTO.getCategoryId() != null) {
            categoryRepository.findById(productDTO.getCategoryId()).ifPresent(product::setCategory);
        }
        product.setBrand(productDTO.getBrand());
        product.setColor(productDTO.getColor());
        product.setSize(productDTO.getSize());
        product.setMaterial(productDTO.getMaterial());
        product.setTags(productDTO.getTags());
        // Always set isActive to true for new products
        product.setActive(true);
        Product savedProduct = productService.saveProduct(product);
        return ResponseEntity.ok(productService.toProductDTO(savedProduct));
    }
    
    @PutMapping(value = "/{id}", consumes = MediaType.APPLICATION_JSON_VALUE, produces = MediaType.APPLICATION_JSON_VALUE)
    @PreAuthorize("hasAuthority('product:write')")
    @Operation(summary = "Update product", description = "Update an existing product (requires product:write permission)")
    public ResponseEntity<ProductDTO> updateProduct(@PathVariable Long id, @Valid @RequestBody ProductDTO productDTO) {
        productDTO.setId(id);
        Product updatedProduct = productService.updateProductFromDTO(productDTO);
        return ResponseEntity.ok(productService.toProductDTO(updatedProduct));
    }
    
    @DeleteMapping("/{id}")
    @PreAuthorize("hasAuthority('product:delete')")
    @Operation(summary = "Delete product", description = "Delete a product (requires product:delete permission)")
    public ResponseEntity<Void> deleteProduct(@PathVariable Long id) {
        productService.deleteProduct(id);
        return ResponseEntity.ok().build();
    }
    
    @PostMapping("/{id}/images")
    @PreAuthorize("hasAuthority('product:write')")
    public ResponseEntity<?> uploadProductImage(@PathVariable Long id, @RequestParam("file") MultipartFile file) {
        try {
            Product product = productService.getProductById(id).orElse(null);
            if (product == null) {
                return ResponseEntity.status(HttpStatus.NOT_FOUND).body(Map.of("error", "Product not found"));
            }
            String filename = System.currentTimeMillis() + "_" + file.getOriginalFilename();
            productService.addProductImage(id, filename, file.getContentType(), file.getBytes());
            return ResponseEntity.ok().body(Map.of("message", "Image uploaded successfully"));
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(500).body(Map.of("error", "Failed to upload image: " + e.getMessage()));
        }
    }

    @GetMapping("/{productId}/images/{filename:.+}")
    @Operation(summary = "Serve product image from DB", description = "Serve a product image by filename from the database")
    public ResponseEntity<?> serveProductImage(@PathVariable Long productId, @PathVariable String filename) {
        ProductImage image = productImageRepository.findImagesByProductId(productId).stream()
                .filter(img -> filename.equals(img.getImageUrl()))
                .findFirst().orElse(null);
        if (image == null || image.getData() == null) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Image not found");
        }
        ByteArrayResource resource = new ByteArrayResource(image.getData());
        return ResponseEntity.ok()
                .header(HttpHeaders.CONTENT_DISPOSITION, "inline; filename=\"" + image.getImageUrl() + "\"")
                .contentType(MediaType.parseMediaType(image.getContentType()))
                .body(resource);
    }
    
    @GetMapping("/featured")
    @Operation(summary = "Get featured products", description = "Retrieve featured products (deprecated - returns empty list)")
    public ResponseEntity<List<ProductDTO>> getFeaturedProducts() {
        // Return empty list since featured products are no longer supported
        return ResponseEntity.ok(List.of());
    }
}