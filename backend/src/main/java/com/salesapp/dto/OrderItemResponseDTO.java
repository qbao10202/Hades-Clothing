package com.salesapp.dto;

import com.salesapp.entity.OrderItem;
import lombok.Data;

import java.math.BigDecimal;
import java.time.Instant;

@Data
public class OrderItemResponseDTO {
    private Long id;
    private Long productId;
    private String productName;
    private String productSku;
    private Integer quantity;
    private BigDecimal unitPrice;
    private BigDecimal totalPrice;
    private ProductDTO product;
    private Instant createdAt;
    private Instant updatedAt;

    public static OrderItemResponseDTO fromEntity(OrderItem item) {
        OrderItemResponseDTO dto = new OrderItemResponseDTO();
        dto.setId(item.getId());
        dto.setProductId(item.getProduct() != null ? item.getProduct().getId() : null);
        dto.setProductName(item.getProductName());
        dto.setProductSku(item.getProductSku());
        dto.setQuantity(item.getQuantity());
        dto.setUnitPrice(item.getUnitPrice());
        dto.setTotalPrice(item.getTotalPrice());
        dto.setCreatedAt(item.getCreatedAt());
        dto.setUpdatedAt(item.getUpdatedAt());
        
        if (item.getProduct() != null) {
            ProductDTO productDTO = new ProductDTO();
            productDTO.setId(item.getProduct().getId());
            productDTO.setName(item.getProduct().getName());
            productDTO.setDescription(item.getProduct().getDescription());
            productDTO.setPrice(item.getProduct().getPrice());
            productDTO.setStockQuantity(item.getProduct().getStockQuantity());
            productDTO.setIsActive(item.getProduct().getIsActive());
            productDTO.setSku(item.getProduct().getProductCode());
            
            if (item.getProduct().getCategory() != null) {
                CategoryDTO categoryDTO = new CategoryDTO();
                categoryDTO.setId(item.getProduct().getCategory().getId());
                categoryDTO.setName(item.getProduct().getCategory().getName());
                categoryDTO.setDescription(item.getProduct().getCategory().getDescription());
                categoryDTO.setImageUrl(item.getProduct().getCategory().getImageUrl());
                categoryDTO.setIsActive(item.getProduct().getCategory().isActive());
                productDTO.setCategory(categoryDTO);
            }
            
            if (item.getProduct().getImages() != null && !item.getProduct().getImages().isEmpty()) {
                productDTO.setImages(item.getProduct().getImages().stream()
                    .map(img -> {
                        ProductImageDTO imageDTO = new ProductImageDTO();
                        imageDTO.setId(img.getId());
                        imageDTO.setImageUrl(img.getImageUrl());
                        imageDTO.setIsPrimary(img.isPrimary());
                        return imageDTO;
                    })
                    .collect(java.util.stream.Collectors.toList()));
            }
            
            dto.setProduct(productDTO);
        }
        
        return dto;
    }
} 