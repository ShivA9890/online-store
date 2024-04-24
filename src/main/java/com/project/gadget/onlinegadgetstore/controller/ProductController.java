package com.project.gadget.onlinegadgetstore.controller;

import java.io.IOException;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.project.gadget.onlinegadgetstore.config.exception.CustomException;
import com.project.gadget.onlinegadgetstore.dao.ProductDao;
import com.project.gadget.onlinegadgetstore.model.Product;
import com.project.gadget.onlinegadgetstore.utility.AddPhoto;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.Part;

@Controller
public class ProductController {
	
	@Autowired
	private AddPhoto ap;

	@Autowired
	private ProductDao productdao;
	
	@PostMapping("/addproduct")
	public ModelAndView addProduct(HttpServletRequest request) throws IOException, ServletException {
        ModelAndView mv = new ModelAndView();
		
		String name=request.getParameter("name");
		String brand=request.getParameter("brand");
		String description=request.getParameter("description");
		Double price=Double.parseDouble(request.getParameter("price"));
		Double discount=Double.parseDouble(request.getParameter("discount"));
		int categoryId=Integer.parseInt(request.getParameter("categoryId"));
		Part part=request.getPart("image");	
		
	
		String fileName = ap.addPhotoToFolder(part);
		
		Product product = new Product();
		product.setCategoryId(categoryId);
		product.setImagePath(fileName);
		product.setName(name);
		product.setBrand(brand);
		product.setPrice(price);
		product.setDiscount(discount);
		product.setDescription(description);
	    
		product = productdao.save(product);
		
		if(product != null )  mv.addObject("status", "Product Added Successfully.");  
	    else mv.addObject("status", "Failed to add Product.");
	    
		mv.setViewName("login");
		return mv;
	}
	
	@PostMapping("/updateproduct")
	public ModelAndView updateProduct(HttpServletRequest request) throws IOException, ServletException {
	    ModelAndView mv = new ModelAndView();
	    Product product = null;

	    int productId = Integer.parseInt(request.getParameter("id"));
	    Optional<Product> p = productdao.findById(productId);

	    if(p.isPresent()) {
	        product = p.get();

	        String name = request.getParameter("name");
	        if(name != null && !name.isEmpty()) {
	            product.setName(name);
	        }

	        String brand = request.getParameter("brand");
	        if(brand != null && !brand.isEmpty()) {
	            product.setBrand(brand);
	        }

	        String description = request.getParameter("description");
	        if(description != null && !description.isEmpty()) {
	            product.setDescription(description);
	        }

	        String price = request.getParameter("price");
	        if(price != null && !price.isEmpty()) {
	            product.setPrice(Double.parseDouble(price));
	        }

	        String discount = request.getParameter("discount");
	        if(discount != null && !discount.isEmpty()) {
	            product.setDiscount(Double.parseDouble(discount));
	        }

	        String categoryId = request.getParameter("categoryId");
	        if(categoryId != null && !categoryId.isEmpty()) {
	            product.setCategoryId(Integer.parseInt(categoryId));
	        }

	        Part part = request.getPart("image");
	        if(part != null) {
	            String fileName = ap.addPhotoToFolder(part);
	            product.setImagePath(fileName);
	        }

	        product = productdao.save(product);
	        mv.addObject("status", "Product Updated Successfully.");
	    } else {
	        mv.addObject("status", "Failed to update Product.");
	    }

	    mv.setViewName("login");
	    return mv;
	}

	
//	@PostMapping("/updateproduct")
//	public ModelAndView updateProduct(HttpServletRequest request) throws IOException, ServletException {
//        ModelAndView mv = new ModelAndView();
//        Product product = null;
//		int productid = Integer.parseInt(request.getParameter("id"));
//    	Optional<Product> p = productdao.findById(productid);
//		if(p.isPresent()) product= p.get();
//		String name=request.getParameter("name");
//		String brand=request.getParameter("brand");
//		String description=request.getParameter("description");
//		Double price=Double.parseDouble(request.getParameter("price"));
//		Double discount=Double.parseDouble(request.getParameter("discount"));
//		int categoryId=Integer.parseInt(request.getParameter("categoryId"));
//		
//		Part part=request.getPart("image");		
//		int id = product.getId();
//		if(part!=null) {
//			String fileName = ap.addPhotoToFolder(part);
//			product.setImagePath(fileName);
//		}
//		if(productid == id) {
//		product.setCategoryId(categoryId);
//		product.setName(name);
//		product.setBrand(brand);
//		product.setPrice(price);
//		product.setDiscount(discount);
//		product.setDescription(description);
//		product = productdao.save(product);
//		}
//		if(product != null )  mv.addObject("status", "Product Updated Successfully.");  
//	    else mv.addObject("status", "Failed to update Product.");
//	    
//		mv.setViewName("login");
//		return mv;
//	}
//	
	@GetMapping("/searchproduct")
	public ModelAndView searchProduct(@RequestParam("productname") String productName) throws CustomException{
		ModelAndView mv = new ModelAndView();
		List<Product> li = productdao.findByNameContainingIgnoreCase(productName);
		if(li.isEmpty()) {
			throw new CustomException("Product with "+productName+" is currently Not Available");
		}
		mv.addObject("products", li);
		mv.addObject("othersource", "yes");
		mv.setViewName("login");
		return mv;
	}
	
	@GetMapping("/product")
	public ModelAndView getFood(@RequestParam("productId") int productId){
		ModelAndView mv = new ModelAndView();
		Product products = null;
		Optional<Product> p = productdao.findById(productId);
		
		if(p.isPresent()) products = p.get();
		   
		mv.addObject("product", products);
		mv.setViewName("product");
		return mv;
	}
	
	@GetMapping("/deleteproduct")
	public ModelAndView deleteFood(@RequestParam("productId") int productId){
		ModelAndView mv = new ModelAndView();
		Product products = null;
		Optional<Product> p = productdao.findById(productId);
		
		if(p.isPresent()) products = p.get();
		productdao.delete(products);
		mv.addObject("status", "Product deleted Successfully ");
		mv.setViewName("login");
		return mv;
	}
	
	@GetMapping("/updateproduct")
	public ModelAndView updateFood(@RequestParam("productId") int productId){
		ModelAndView mv = new ModelAndView();
		Product products = null;
		Optional<Product> p = productdao.findById(productId);
		
		if(p.isPresent()) products = p.get();
		   
		mv.addObject("product", products);
		mv.setViewName("updateproduct");
		return mv;
	}
	
	
}
