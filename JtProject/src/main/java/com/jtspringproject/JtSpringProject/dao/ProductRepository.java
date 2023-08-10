package com.jtspringproject.JtSpringProject.dao;

import com.jtspringproject.JtSpringProject.models.Product;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ProductRepository extends JpaRepository<Product, Integer> {
    //Custom query for seach bar
    @Query(value = "select * from PRODUCT p where p.name like %:keyword%", nativeQuery = true)
    List<Product> findByKeyword(@Param("keyword") String keyword);

    @Query(value = "SELECT p1.product_id AS \"product1_id\", p2.product_id AS \"product2_id\", COUNT(*) AS \"count\"" +
            "FROM CART_PRODUCT p1 " +
            "JOIN CART_PRODUCT p2 " +
            "ON p1.cart_id = p2.cart_id AND p1.product_id < p2.product_id " +
            "GROUP BY p1.product_id, p2.product_id " +
            "ORDER BY COUNT(*) DESC", nativeQuery = true)
    List<Object []> getProductPairs();
}

