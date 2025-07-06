package com.salesapp.repository;

import com.salesapp.entity.ProductImage;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface ProductImageRepository extends JpaRepository<ProductImage, Long> {
    
    List<ProductImage> findByProductIdOrderBySortOrderAsc(Long productId);
    
    Optional<ProductImage> findByProductIdAndIsPrimaryTrue(Long productId);
    
    @Query("SELECT pi FROM ProductImage pi WHERE pi.product.id = :productId ORDER BY pi.sortOrder ASC")
    List<ProductImage> findImagesByProductId(@Param("productId") Long productId);
    
    void deleteByProductId(Long productId);
} 