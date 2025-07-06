package com.salesapp.repository;

import com.salesapp.entity.Product;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.EntityGraph;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface ProductRepository extends JpaRepository<Product, Long> {
    Optional<Product> findByProductCode(String productCode);
    @EntityGraph(attributePaths = {"images"})
    List<Product> findByIsActiveTrue();
    @EntityGraph(attributePaths = {"images"})
    List<Product> findByCategoryIdAndIsActiveTrue(Long categoryId);
    boolean existsByProductCode(String productCode);
    @Query("SELECT DISTINCT p FROM Product p WHERE p.isActive = true")
    @EntityGraph(attributePaths = {"images"})
    List<Product> findByIsActiveTrueWithImages();
    @Query("SELECT DISTINCT p FROM Product p")
    @EntityGraph(attributePaths = {"images"})
    List<Product> findAllWithImages();
    @Query("SELECT DISTINCT p FROM Product p WHERE p.category.id = :categoryId")
    @EntityGraph(attributePaths = {"images"})
    List<Product> findByCategoryIdWithImages(Long categoryId);
} 