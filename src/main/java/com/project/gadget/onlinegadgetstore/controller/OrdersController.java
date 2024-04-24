package com.project.gadget.onlinegadgetstore.controller;

import java.time.LocalDate;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.project.gadget.onlinegadgetstore.dao.CartDao;
import com.project.gadget.onlinegadgetstore.dao.OrdersDao;
import com.project.gadget.onlinegadgetstore.model.Cart;
import com.project.gadget.onlinegadgetstore.model.Orders;
import com.project.gadget.onlinegadgetstore.model.Users;
import com.project.gadget.onlinegadgetstore.utility.Constant;
import com.project.gadget.onlinegadgetstore.utility.Helper;

import jakarta.servlet.http.HttpSession;

@Controller
public class OrdersController {
	
	@Autowired
	private OrdersDao ordersdao;
	@Autowired
	private CartDao cartdao;
	
	@PostMapping("/order")
	public ModelAndView orderProduct(HttpSession session) {
		ModelAndView mv = new ModelAndView();
		Users user = (Users) session.getAttribute("active-user");
		String orderId = Helper.getAlphaNumericOrderId(10);
		LocalDate orderDate = LocalDate.now();
		List<Cart> carts =cartdao.findByUserId(user.getId());
		
		for(Cart cart : carts) {
			Orders order = new Orders();

			order.setOrderDate(orderDate);
			order.setOrderId(orderId);
			order.setUserId(user.getId());
			order.setQuantity(cart.getQuantity());
			order.setProductId(cart.getProductId());
			order.setDeliveryStatus(Constant.DeliveryStatus.PENDING.value());
			order.setDeliveryDate(LocalDate.now().plusDays(10));
			
			ordersdao.save(order);
			cartdao.delete(cart);
		}
		
		mv.addObject("status", "Successfully Placed Order with Order Id: "+orderId);
		mv.setViewName("login");
		return mv;
	}
	
	@GetMapping("/myorder")
	public ModelAndView goToMyOrder(HttpSession session) {
		
		Users user = (Users)session.getAttribute("active-user");
		ModelAndView mv = new ModelAndView();
		List<Orders> orders = ordersdao.findByUserId(user.getId());
		mv.addObject("orders", orders);
		mv.setViewName("myorder");
		return mv;
	
	}
	
	@GetMapping("/searchorderbyid")
	public ModelAndView searchByOrderId(@RequestParam("orderid") String orderId) {
		ModelAndView mv = new ModelAndView();
		List<Orders> orders = ordersdao.findByOrderId(orderId);
		mv.addObject("orders", orders);
		mv.setViewName("myorder");
		return mv;
	}

	@GetMapping("/searchorderbydate")
	public ModelAndView searchByOrderDate(@RequestParam("orderdate") LocalDate date, HttpSession session) {
		ModelAndView mv = new ModelAndView();
		Users ur = (Users)session.getAttribute("active-user");
		List<Orders> lorder = ordersdao.findByOrderDateAndUserId(date, ur.getId());
		mv.addObject("orders", lorder);
		mv.setViewName("myorder");
		
		return mv;
	}
	
	@PostMapping("/checkout")
	public ModelAndView searchByOrderDate(@RequestParam("amount") String amount) {
		
		ModelAndView mv = new ModelAndView();
	
		mv.addObject("amount", amount);
		mv.setViewName("checkout");
		return mv;
	}
	
	@GetMapping("/updatedeliverydate")
	public ModelAndView addDeliveryDetails(@RequestParam("orderId") String orderid , @RequestParam("deliverystatus") String deliverystatus ,@RequestParam("deliveryDate") LocalDate date) {
		ModelAndView mv = new ModelAndView();
		List<Orders> orders = ordersdao.findByOrderId(orderid);
		for(Orders order: orders) {
			order.setDeliveryStatus(deliverystatus);
			order.setDeliveryDate(date);
			ordersdao.save(order);
		}
		mv.addObject("status", "Order Delivery Status Updated Successfully.");
		mv.setViewName("login");
		return mv;
	}

}
