package com.salesapp.dto;

import java.math.BigDecimal;
import java.time.LocalDateTime;

public class CartItemResponseDTO {
    private Long id;
    private Long userId;
    private Long productId;
    private Integer quantity;
    private BigDecimal price;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;
    private String productName;
    private String productSku;

    // Constructors
    public CartItemResponseDTO() {}

    public CartItemResponseDTO(Long id, Long userId, Long productId, Integer quantity, 
                              BigDecimal price, LocalDateTime createdAt, LocalDateTime updatedAt, 
                              String productName, String productSku) {
        this.id = id;
        this.userId = userId;
        this.productId = productId;
        this.quantity = quantity;
        this.price = price;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
        this.productName = productName;
        this.productSku = productSku;
    }

    // Getters and Setters
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getUserId() {
        return userId;
    }

    public void setUserId(Long userId) {
        this.userId = userId;
    }

    public Long getProductId() {
        return productId;
    }

    public void setProductId(Long productId) {
        this.productId = productId;
    }

    public Integer getQuantity() {
        return quantity;
    }

    public void setQuantity(Integer quantity) {
        this.quantity = quantity;
    }

    public BigDecimal getPrice() {
        return price;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }

    public LocalDateTime getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(LocalDateTime updatedAt) {
        this.updatedAt = updatedAt;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public String getProductSku() {
        return productSku;
    }

    public void setProductSku(String productSku) {
        this.productSku = productSku;
    }
}
