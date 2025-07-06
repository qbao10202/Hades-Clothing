package com.salesapp.dto;

import com.salesapp.entity.Order;
import com.salesapp.entity.Product;
import java.math.BigDecimal;
import java.util.List;

public class DashboardStatsResponse {
    private BigDecimal totalSales;
    private long totalOrders;
    private long totalProducts;
    private long totalCustomers;
    private List<Order> recentOrders;
    private List<TopSellingProduct> topSellingProducts;

    // Getters and setters
    public BigDecimal getTotalSales() { return totalSales; }
    public void setTotalSales(BigDecimal totalSales) { this.totalSales = totalSales; }
    public long getTotalOrders() { return totalOrders; }
    public void setTotalOrders(long totalOrders) { this.totalOrders = totalOrders; }
    public long getTotalProducts() { return totalProducts; }
    public void setTotalProducts(long totalProducts) { this.totalProducts = totalProducts; }
    public long getTotalCustomers() { return totalCustomers; }
    public void setTotalCustomers(long totalCustomers) { this.totalCustomers = totalCustomers; }
    public List<Order> getRecentOrders() { return recentOrders; }
    public void setRecentOrders(List<Order> recentOrders) { this.recentOrders = recentOrders; }
    public List<TopSellingProduct> getTopSellingProducts() { return topSellingProducts; }
    public void setTopSellingProducts(List<TopSellingProduct> topSellingProducts) { this.topSellingProducts = topSellingProducts; }

    // Add an inner static class for TopSellingProduct with soldQuantity
    public static class TopSellingProduct {
        private Product product;
        private int soldQuantity;
        public Product getProduct() { return product; }
        public void setProduct(Product product) { this.product = product; }
        public int getSoldQuantity() { return soldQuantity; }
        public void setSoldQuantity(int soldQuantity) { this.soldQuantity = soldQuantity; }
    }
} 