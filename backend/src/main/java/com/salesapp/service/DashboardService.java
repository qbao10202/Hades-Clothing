package com.salesapp.service;

import com.salesapp.dto.DashboardStatsResponse;
import com.salesapp.entity.Order;
import com.salesapp.entity.Product;
import com.salesapp.repository.OrderRepository;
import com.salesapp.repository.ProductRepository;
import com.salesapp.repository.CustomerRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.math.BigDecimal;
import java.util.Comparator;
import java.util.List;
import java.util.stream.Collectors;

@Service
public class DashboardService {
    @Autowired
    private OrderRepository orderRepository;
    @Autowired
    private ProductRepository productRepository;
    @Autowired
    private CustomerRepository customerRepository;

    public DashboardStatsResponse getDashboardStats() {
        DashboardStatsResponse stats = new DashboardStatsResponse();
        stats.setTotalOrders(orderRepository.count());
        stats.setTotalProducts(productRepository.count());
        stats.setTotalCustomers(customerRepository.count());
        // Total sales
        List<Order> allOrders = orderRepository.findAll();
        BigDecimal totalSales = allOrders.stream()
            .map(Order::getTotalAmount)
            .reduce(BigDecimal.ZERO, BigDecimal::add);
        stats.setTotalSales(totalSales);
        // Recent orders (last 5 by order date desc)
        List<Order> recentOrders = allOrders.stream()
            .sorted(Comparator.comparing(Order::getOrderDate).reversed())
            .limit(5)
            .collect(Collectors.toList());
        stats.setRecentOrders(recentOrders);
        // Top-selling products (by quantity sold, top 5)
        List<Product> allProducts = productRepository.findAll();
        List<DashboardStatsResponse.TopSellingProduct> topSellingProducts = allProducts.stream()
            .map(product -> {
                Integer soldQuantity = orderRepository.getTotalSoldQuantityByProductId(product.getId());
                DashboardStatsResponse.TopSellingProduct tsp = new DashboardStatsResponse.TopSellingProduct();
                tsp.setProduct(product);
                tsp.setSoldQuantity(soldQuantity != null ? soldQuantity : 0);
                return tsp;
            })
            .sorted((p1, p2) -> Integer.compare(p2.getSoldQuantity(), p1.getSoldQuantity()))
            .limit(5)
            .collect(Collectors.toList());
        stats.setTopSellingProducts(topSellingProducts);
        return stats;
    }
} 