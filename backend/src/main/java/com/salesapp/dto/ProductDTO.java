package com.salesapp.dto;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;

public class ProductDTO {
    private Long id;
    private String productCode;
    private String name;
    private String slug;
    private String description;
    private String shortDescription;
    private BigDecimal price;
    private BigDecimal cost;
    private BigDecimal salePrice;
    private Integer stockQuantity;
    private Integer minStockLevel;
    private Integer maxStockLevel;
    private Long categoryId;
    private String brand;
    private String color;
    private String size;
    private String material;
    private String tags;
    private boolean isActive;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;
    private List<ProductImageDTO> images;

    // Getters and setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public String getProductCode() { return productCode; }
    public void setProductCode(String productCode) { this.productCode = productCode; }
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    public String getSlug() { return slug; }
    public void setSlug(String slug) { this.slug = slug; }
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
    public String getShortDescription() { return shortDescription; }
    public void setShortDescription(String shortDescription) { this.shortDescription = shortDescription; }
    public BigDecimal getPrice() { return price; }
    public void setPrice(BigDecimal price) { this.price = price; }
    public BigDecimal getCost() { return cost; }
    public void setCost(BigDecimal cost) { this.cost = cost; }
    public BigDecimal getSalePrice() { return salePrice; }
    public void setSalePrice(BigDecimal salePrice) { this.salePrice = salePrice; }
    public Integer getStockQuantity() { return stockQuantity; }
    public void setStockQuantity(Integer stockQuantity) { this.stockQuantity = stockQuantity; }
    public Integer getMinStockLevel() { return minStockLevel; }
    public void setMinStockLevel(Integer minStockLevel) { this.minStockLevel = minStockLevel; }
    public Integer getMaxStockLevel() { return maxStockLevel; }
    public void setMaxStockLevel(Integer maxStockLevel) { this.maxStockLevel = maxStockLevel; }
    public Long getCategoryId() { return categoryId; }
    public void setCategoryId(Long categoryId) { this.categoryId = categoryId; }
    public String getBrand() { return brand; }
    public void setBrand(String brand) { this.brand = brand; }
    public String getColor() { return color; }
    public void setColor(String color) { this.color = color; }
    public String getSize() { return size; }
    public void setSize(String size) { this.size = size; }
    public String getMaterial() { return material; }
    public void setMaterial(String material) { this.material = material; }
    public String getTags() { return tags; }
    public void setTags(String tags) { this.tags = tags; }
    public boolean isActive() { return isActive; }
    public void setActive(boolean active) { isActive = active; }
    public LocalDateTime getCreatedAt() { return createdAt; }
    public void setCreatedAt(LocalDateTime createdAt) { this.createdAt = createdAt; }
    public LocalDateTime getUpdatedAt() { return updatedAt; }
    public void setUpdatedAt(LocalDateTime updatedAt) { this.updatedAt = updatedAt; }
    public List<ProductImageDTO> getImages() { return images; }
    public void setImages(List<ProductImageDTO> images) { this.images = images; }

    public static class ProductImageDTO {
        private Long id;
        private String imageUrl;
        private String altText;
        private int sortOrder;
        private boolean isPrimary;
        // Getters and setters
        public Long getId() { return id; }
        public void setId(Long id) { this.id = id; }
        public String getImageUrl() { return imageUrl; }
        public void setImageUrl(String imageUrl) { this.imageUrl = imageUrl; }
        public String getAltText() { return altText; }
        public void setAltText(String altText) { this.altText = altText; }
        public int getSortOrder() { return sortOrder; }
        public void setSortOrder(int sortOrder) { this.sortOrder = sortOrder; }
        public boolean isPrimary() { return isPrimary; }
        public void setPrimary(boolean primary) { isPrimary = primary; }
    }
} 