package com.salesapp.service;

import com.salesapp.entity.Product;
import com.salesapp.repository.ProductRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.cache.annotation.Cacheable;
import com.salesapp.dto.ProductDTO;
import com.salesapp.dto.ProductImageDTO;
import java.util.stream.Collectors;

import java.util.List;
import java.util.Optional;
import com.salesapp.entity.ProductImage;
import com.salesapp.repository.ProductImageRepository;
import com.salesapp.repository.CategoryRepository;

@Service
public class ProductService {
    
    @Autowired
    private ProductRepository productRepository;
    
    @Autowired
    private ProductImageRepository productImageRepository;
    
    @Autowired
    private CategoryRepository categoryRepository;
    
    public List<Product> getAllProducts() {
        List<Product> products = productRepository.findAllWithImages();
        List<Product> filtered = products.stream()
            .filter(p -> p.isActive() && (p.getStockQuantity() == null || p.getStockQuantity() > 0))
            .collect(Collectors.toList());
        filtered.forEach(product -> {
            if (product.getImages() != null) product.getImages().size();
            if (product.getCategory() != null) product.getCategory().getId();
        });
        return filtered;
    }
    
    public Page<Product> getAllProductsWithPagination(Pageable pageable) {
        Page<Product> products = productRepository.findAllWithImagesPaged(pageable);
        return products.map(product -> {
            if (product.getImages() != null) product.getImages().size();
            if (product.getCategory() != null) product.getCategory().getId();
            return product;
        });
    }
    
    public Page<Product> searchProducts(String query, Pageable pageable) {
        Page<Product> products = productRepository.searchProducts(query, pageable);
        return products.map(product -> {
            if (product.getImages() != null) product.getImages().size();
            if (product.getCategory() != null) product.getCategory().getId();
            return product;
        });
    }
    
    public List<Product> getProductsByCategory(Long categoryId) {
        List<Product> products = productRepository.findByCategoryIdWithImages(categoryId);
        List<Product> filtered = products.stream()
            .filter(p -> p.isActive() && (p.getStockQuantity() == null || p.getStockQuantity() > 0))
            .collect(Collectors.toList());
        filtered.forEach(product -> {
            if (product.getImages() != null) product.getImages().size();
            if (product.getCategory() != null) product.getCategory().getId();
        });
        return filtered;
    }
    
    @Cacheable(value = "products", key = "#id")
    public Optional<Product> getProductById(Long id) {
        return productRepository.findById(id);
    }
    
    public Optional<Product> getProductByCode(String productCode) {
        return productRepository.findByProductCode(productCode);
    }
    
    public Product saveProduct(Product product) {
        return productRepository.save(product);
    }
    
    public void deleteProduct(Long id) {
        productRepository.deleteById(id);
    }
    
    public boolean updateStock(Long productId, Integer quantity) {
        Optional<Product> productOpt = productRepository.findById(productId);
        if (productOpt.isPresent()) {
            Product product = productOpt.get();
            int newStock = product.getStockQuantity() - quantity;
            if (newStock >= 0) {
                product.setStockQuantity(newStock);
                productRepository.save(product);
                return true;
            }
        }
        return false;
    }
    
    public boolean checkStockAvailability(Long productId, Integer quantity) {
        Optional<Product> productOpt = productRepository.findById(productId);
        return productOpt.map(product -> product.getStockQuantity() >= quantity).orElse(false);
    }
    
    public ProductDTO toProductDTO(Product product) {
        ProductDTO dto = new ProductDTO();
        dto.setId(product.getId());
        dto.setProductCode(product.getProductCode());
        dto.setName(product.getName());
        dto.setSlug(product.getSlug());
        dto.setDescription(product.getDescription());
        dto.setShortDescription(product.getShortDescription());
        dto.setPrice(product.getPrice());
        dto.setCost(product.getCost());
        dto.setSalePrice(product.getSalePrice());
        dto.setStockQuantity(product.getStockQuantity());
        dto.setMinStockLevel(product.getMinStockLevel());
        dto.setMaxStockLevel(product.getMaxStockLevel());
        dto.setCategoryId(product.getCategory() != null ? product.getCategory().getId() : null);
        dto.setBrand(product.getBrand());
        dto.setColor(product.getColor());
        dto.setSize(product.getSize());
        dto.setMaterial(product.getMaterial());
        dto.setTags(product.getTags());
        dto.setIsActive(product.isActive());
        dto.setCreatedAt(product.getCreatedAt());
        dto.setUpdatedAt(product.getUpdatedAt());
        if (product.getImages() != null) {
            dto.setImages(product.getImages().stream().map(img -> {
                ProductImageDTO imgDto = new ProductImageDTO();
                imgDto.setId(img.getId());
                imgDto.setImageUrl(img.getImageUrl());
                imgDto.setIsPrimary(img.isPrimary());
                return imgDto;
            }).collect(Collectors.toList()));
        }
        return dto;
    }
    
    public void addProductImage(Long productId, String filename, String contentType, byte[] data) {
        Product product = productRepository.findById(productId).orElse(null);
        if (product != null) {
            // Remove all old images
            product.getImages().clear();
            ProductImage image = new ProductImage();
            image.setProduct(product);
            image.setImageUrl(filename); // store filename
            image.setContentType(contentType);
            image.setData(data);
            image.setPrimary(true);
            image.setSortOrder(1);
            product.getImages().add(image);
            productRepository.save(product);
        }
    }
    
    public Product updateProductFromDTO(ProductDTO dto) {
        Product product = productRepository.findById(dto.getId()).orElse(new Product());
        product.setProductCode(dto.getProductCode());
        product.setName(dto.getName());
        product.setSlug(dto.getSlug());
        product.setDescription(dto.getDescription());
        product.setShortDescription(dto.getShortDescription());
        product.setPrice(dto.getPrice());
        product.setCost(dto.getCost());
        product.setSalePrice(dto.getSalePrice());
        product.setStockQuantity(dto.getStockQuantity());
        product.setMinStockLevel(dto.getMinStockLevel());
        product.setMaxStockLevel(dto.getMaxStockLevel());
        if (dto.getCategoryId() != null) {
            categoryRepository.findById(dto.getCategoryId()).ifPresent(product::setCategory);
        } else {
            product.setCategory(null);
        }
        product.setBrand(dto.getBrand());
        product.setColor(dto.getColor());
        product.setSize(dto.getSize());
        product.setMaterial(dto.getMaterial());
        product.setTags(dto.getTags());
        // Always set isActive to true for new products
        product.setActive(true);
        // Do not update images here
        return productRepository.save(product);
    }
} 