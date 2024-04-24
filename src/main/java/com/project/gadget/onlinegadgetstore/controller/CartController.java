package com.project.gadget.onlinegadgetstore.controller;

import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.project.gadget.onlinegadgetstore.dao.CartDao;
import com.project.gadget.onlinegadgetstore.model.Cart;

@Controller
public class CartController {
	
	@Autowired
	private CartDao cartdao;
	
	@GetMapping("/addtocart")
	public ModelAndView addToCart(@ModelAttribute Cart cart) {
		ModelAndView mv = new ModelAndView();
		cartdao.save(cart);
		mv.addObject("status","Product added to Cart");
		mv.setViewName("login");
		return mv;
	}
	
	@GetMapping("/deletecart")
	public ModelAndView deleteCart(@RequestParam("cartId") int cartId) {
		ModelAndView mv = new ModelAndView();
		Cart cart = new Cart();
		Optional<Cart> cartlist = cartdao.findById(cartId);
		if(cartlist.isPresent()) {
			cart = cartlist.get();
		}
		cartdao.delete(cart);
		mv.addObject("status","Product deleted from cart.");
		mv.setViewName("login");
		return mv;
	}
	

}
