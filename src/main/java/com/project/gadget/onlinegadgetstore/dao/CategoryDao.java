package com.project.gadget.onlinegadgetstore.dao;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.project.gadget.onlinegadgetstore.model.Category;

@Repository
public interface CategoryDao extends JpaRepository<Category, Integer> {

}
