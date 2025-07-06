package com.salesapp.entity;

import jakarta.persistence.*;
import jakarta.validation.constraints.DecimalMin;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import lombok.Getter;
import lombok.Setter;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.annotation.LastModifiedDate;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "orders")
@EntityListeners(AuditingEntityListener.class)
@Getter
@Setter
public class Order {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    @NotBlank
    @Size(max = 20)
    @Column(unique = true)
    private String orderNumber;
    
    @NotNull
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "customer_id")
    private Customer customer;
    
    @NotNull
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id")
    private User user;
    
    private LocalDateTime orderDate;
    
    @Enumerated(EnumType.STRING)
    private OrderStatus status = OrderStatus.PENDING;
    
    @Enumerated(EnumType.STRING)
    @Column(name = "payment_status")
    private PaymentStatus paymentStatus = PaymentStatus.PENDING;
    
    @Enumerated(EnumType.STRING)
    @Column(name = "shipping_status")
    private ShippingStatus shippingStatus = ShippingStatus.PENDING;
    
    @DecimalMin(value = "0.0")
    private BigDecimal subtotal;
    
    @DecimalMin(value = "0.0")
    private BigDecimal taxAmount = BigDecimal.ZERO;
    
    @DecimalMin(value = "0.0")
    @Column(name = "shipping_amount")
    private BigDecimal shippingAmount = BigDecimal.ZERO;
    
    @DecimalMin(value = "0.0")
    @Column(name = "discount_amount")
    private BigDecimal discountAmount = BigDecimal.ZERO;
    
    @DecimalMin(value = "0.0")
    @Column(name = "total_amount")
    private BigDecimal totalAmount;
    
    @Size(max = 3)
    private String currency = "VND";
    
    @Column(name = "shipping_address", columnDefinition = "TEXT")
    private String shippingAddress;
    
    @Column(name = "billing_address", columnDefinition = "TEXT")
    private String billingAddress;
    
    @Size(max = 100)
    @Column(name = "shipping_method")
    private String shippingMethod;
    
    @Size(max = 100)
    @Column(name = "tracking_number")
    private String trackingNumber;
    
    @Column(columnDefinition = "TEXT")
    private String notes;
    
    @OneToMany(mappedBy = "order", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<OrderItem> orderItems = new ArrayList<>();
    
    @CreatedDate
    @Column(name = "created_at")
    private LocalDateTime createdAt;
    
    @LastModifiedDate
    @Column(name = "updated_at")
    private LocalDateTime updatedAt;
    
    public enum OrderStatus {
        CART, PENDING, CONFIRMED, PROCESSING, SHIPPED, DELIVERED, CANCELLED, REFUNDED
    }
    
    public enum PaymentStatus {
        PENDING, PAID, FAILED, REFUNDED, PARTIALLY_REFUNDED
    }
    
    public enum ShippingStatus {
        PENDING, SHIPPED, DELIVERED, RETURNED
    }
    
    // Constructors
    public Order() {}
    
    public Order(String orderNumber, Customer customer, User user) {
        this.orderNumber = orderNumber;
        this.customer = customer;
        this.user = user;
        this.orderDate = LocalDateTime.now();
    }
    
    // Helper methods
    public void addOrderItem(OrderItem orderItem) {
        orderItems.add(orderItem);
        orderItem.setOrder(this);
    }
    
    public void removeOrderItem(OrderItem orderItem) {
        orderItems.remove(orderItem);
        orderItem.setOrder(null);
    }
    
    public void calculateTotals() {
        this.subtotal = orderItems.stream()
                .map(item -> item.getTotalPrice() != null ? item.getTotalPrice() : BigDecimal.ZERO)
                .reduce(BigDecimal.ZERO, BigDecimal::add);
        
        BigDecimal safeShippingAmount = shippingAmount != null ? shippingAmount : BigDecimal.ZERO;
        BigDecimal safeTaxAmount = taxAmount != null ? taxAmount : BigDecimal.ZERO;
        BigDecimal safeDiscountAmount = discountAmount != null ? discountAmount : BigDecimal.ZERO;
        
        this.totalAmount = subtotal.add(safeShippingAmount).add(safeTaxAmount).subtract(safeDiscountAmount);
    }
    
    // Getters and Setters
    public Long getId() {
        return id;
    }
    
    public void setId(Long id) {
        this.id = id;
    }
    
    public String getOrderNumber() {
        return orderNumber;
    }
    
    public void setOrderNumber(String orderNumber) {
        this.orderNumber = orderNumber;
    }
    
    public Customer getCustomer() {
        return customer;
    }
    
    public void setCustomer(Customer customer) {
        this.customer = customer;
    }
    
    public User getUser() {
        return user;
    }
    
    public void setUser(User user) {
        this.user = user;
    }
    
    public LocalDateTime getOrderDate() {
        return orderDate;
    }
    
    public void setOrderDate(LocalDateTime orderDate) {
        this.orderDate = orderDate;
    }
    
    public OrderStatus getStatus() {
        return status;
    }
    
    public void setStatus(OrderStatus status) {
        this.status = status;
    }
    
    public PaymentStatus getPaymentStatus() {
        return paymentStatus;
    }
    
    public void setPaymentStatus(PaymentStatus paymentStatus) {
        this.paymentStatus = paymentStatus;
    }
    
    public ShippingStatus getShippingStatus() {
        return shippingStatus;
    }
    
    public void setShippingStatus(ShippingStatus shippingStatus) {
        this.shippingStatus = shippingStatus;
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
    
    public String getCurrency() {
        return currency;
    }
    
    public void setCurrency(String currency) {
        this.currency = currency;
    }
    
    public String getShippingAddress() {
        return shippingAddress;
    }
    
    public void setShippingAddress(String shippingAddress) {
        this.shippingAddress = shippingAddress;
    }
    
    public String getBillingAddress() {
        return billingAddress;
    }
    
    public void setBillingAddress(String billingAddress) {
        this.billingAddress = billingAddress;
    }
    
    public String getShippingMethod() {
        return shippingMethod;
    }
    
    public void setShippingMethod(String shippingMethod) {
        this.shippingMethod = shippingMethod;
    }
    
    public String getTrackingNumber() {
        return trackingNumber;
    }
    
    public void setTrackingNumber(String trackingNumber) {
        this.trackingNumber = trackingNumber;
    }
    
    public String getNotes() {
        return notes;
    }
    
    public void setNotes(String notes) {
        this.notes = notes;
    }
    
    public List<OrderItem> getOrderItems() {
        return orderItems;
    }
    
    public void setOrderItems(List<OrderItem> orderItems) {
        this.orderItems = orderItems;
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
} 