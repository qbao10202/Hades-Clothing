package com.salesapp.repository;

import com.salesapp.entity.Order;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.time.Instant;
import java.util.List;
import java.util.Optional;

@Repository
public interface OrderRepository extends JpaRepository<Order, Long>, JpaSpecificationExecutor<Order> {
    Optional<Order> findByOrderNumber(String orderNumber);
    List<Order> findByCustomerId(Long customerId);
    List<Order> findByUserId(Long userId);
    List<Order> findByOrderDateBetween(Instant startDate, Instant endDate);
    List<Order> findByStatus(Order.OrderStatus status);
    boolean existsByOrderNumber(String orderNumber);

    @Query("SELECT SUM(oi.quantity) FROM OrderItem oi WHERE oi.product.id = :productId")
    Integer getTotalSoldQuantityByProductId(@Param("productId") Long productId);

    Optional<Order> findByUserIdAndStatus(Long userId, Order.OrderStatus status);
    
    // New methods for order management
    @Query(value = "SELECT o FROM Order o ORDER BY o.createdAt DESC", 
           nativeQuery = false)
    List<Order> findTopByOrderByCreatedAtDesc(Pageable pageable);
    
    default List<Order> findTopByOrderByCreatedAtDesc(int limit) {
        return findTopByOrderByCreatedAtDesc(PageRequest.of(0, limit));
    }
    
    @Query("SELECT o FROM Order o WHERE " +
           "LOWER(o.orderNumber) LIKE LOWER(CONCAT('%', :query, '%')) OR " +
           "LOWER(o.customer.contactPerson) LIKE LOWER(CONCAT('%', :query, '%')) OR " +
           "LOWER(o.customer.email) LIKE LOWER(CONCAT('%', :query, '%'))")
    Page<Order> searchOrders(@Param("query") String query, Pageable pageable);
    
    @Query("SELECT COUNT(o) FROM Order o WHERE o.status = :status")
    long countByStatus(@Param("status") Order.OrderStatus status);
    
    @Query("SELECT COUNT(o) FROM Order o WHERE o.paymentStatus = :paymentStatus")
    long countByPaymentStatus(@Param("paymentStatus") Order.PaymentStatus paymentStatus);
    
    @Query("SELECT COUNT(o) FROM Order o WHERE o.shippingStatus = :shippingStatus")
    long countByShippingStatus(@Param("shippingStatus") Order.ShippingStatus shippingStatus);

    Page<Order> findByUserIdOrderByCreatedAtDesc(Long userId, Pageable pageable);
}