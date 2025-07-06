package com.salesapp.dto;

import com.salesapp.entity.OrderItem;
import java.math.BigDecimal;
import java.util.List;

public class CartResponseDTO {
    private List<CartItemResponseDTO> items;
    private Integer totalItems;
    private BigDecimal subtotal;
    private BigDecimal taxAmount;
    private BigDecimal shippingAmount;
    private BigDecimal discountAmount;
    private BigDecimal totalAmount;

    // Constructors
    public CartResponseDTO() {}

    public CartResponseDTO(List<CartItemResponseDTO> items, Integer totalItems, 
                          BigDecimal subtotal, BigDecimal taxAmount, BigDecimal shippingAmount, 
                          BigDecimal discountAmount, BigDecimal totalAmount) {
        this.items = items;
        this.totalItems = totalItems;
        this.subtotal = subtotal;
        this.taxAmount = taxAmount;
        this.shippingAmount = shippingAmount;
        this.discountAmount = discountAmount;
        this.totalAmount = totalAmount;
    }

    // Getters and Setters
    public List<CartItemResponseDTO> getItems() {
        return items;
    }

    public void setItems(List<CartItemResponseDTO> items) {
        this.items = items;
    }

    public Integer getTotalItems() {
        return totalItems;
    }

    public void setTotalItems(Integer totalItems) {
        this.totalItems = totalItems;
    }

    public BigDecimal getSubtotal() {
        return subtotal;
    }

    public void setSubtotal(BigDecimal subtotal) {
        this.subtotal = subtotal;
    }

    public BigDecimal getTaxAmount() {
        return taxAmount;
    }

    public void setTaxAmount(BigDecimal taxAmount) {
        this.taxAmount = taxAmount;
    }

    public BigDecimal getShippingAmount() {
        return shippingAmount;
    }

    public void setShippingAmount(BigDecimal shippingAmount) {
        this.shippingAmount = shippingAmount;
    }

    public BigDecimal getDiscountAmount() {
        return discountAmount;
    }

    public void setDiscountAmount(BigDecimal discountAmount) {
        this.discountAmount = discountAmount;
    }

    public BigDecimal getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(BigDecimal totalAmount) {
        this.totalAmount = totalAmount;
    }
}
