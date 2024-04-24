package com.project.gadget.onlinegadgetstore.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.project.gadget.onlinegadgetstore.config.exception.CustomException;
import com.project.gadget.onlinegadgetstore.dao.CategoryDao;
import com.project.gadget.onlinegadgetstore.dao.ProductDao;
import com.project.gadget.onlinegadgetstore.model.Category;
import com.project.gadget.onlinegadgetstore.model.Product;

@Controller
public class CategoryController {

	@Autowired
	private ProductDao productdao;
	@Autowired
	private CategoryDao categorydao;
	
	@PostMapping("/addcategory")
	public ModelAndView addCategory(@ModelAttribute Category category){
		ModelAndView mv = new ModelAndView();
		if(this.categorydao.save(category)!=null) {
		
		mv.addObject("status", "Category Added Successfully");
		mv.setViewName("login");
		}
		else {
			mv.addObject("status", "Failed to Add Category");
			mv.setViewName("addcategory");
		}
		return mv;
	}
	
	@GetMapping("/category")
	public ModelAndView viewCategory(@RequestParam("categoryId") int categoryId) throws CustomException {
		ModelAndView mv = new ModelAndView();
		int cid = categoryId;
		List<Product> list = new ArrayList<>();
		if(cid == 0) {
			list = productdao.findAll();
			mv.addObject("products", list);
			mv.addObject("othersource", "yes");
			mv.setViewName("login");
		}else {
			
			list = productdao.findByCategoryId(categoryId);
			if(list.isEmpty()) {
				throw new CustomException("Product For This Category is Not Available !");
				}
			mv.addObject("products", list);
			mv.addObject("othersource", "yes");
			mv.setViewName("login");
		}
		
		
		return mv;
	}
	
	@GetMapping("/deletecategory")
	public ModelAndView deleteCategory(@RequestParam("categoryId") int categoryId) {
		ModelAndView mv = new ModelAndView();
		Optional<Category> category = categorydao.findById(categoryId);
		Category c = null;
		if(category.isPresent()) {
			c= category.get();
		}
		categorydao.delete(c);
		List<Product> list = productdao.findByCategoryId(categoryId);
		for(Product pro:list) {
			productdao.delete(pro);
		}
		mv.addObject("status", "Category Deleted Successfully!");
		mv.setViewName("login");
		
		return mv;
	}
}
