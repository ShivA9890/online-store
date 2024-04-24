package com.project.gadget.onlinegadgetstore.dao;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.project.gadget.onlinegadgetstore.model.Product;

@Repository
public interface ProductDao extends JpaRepository<Product, Integer> {

	List<Product> findByNameContainingIgnoreCase(String name);
	List<Product> findByCategoryId(int categpryId);
	
	@Query(value="delete from Product p where p.categoryId = :categoryId")
	void deleteProductByCategoryId(@Param("categoryId") int categoryId);
}
