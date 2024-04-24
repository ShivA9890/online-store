package com.project.gadget.onlinegadgetstore.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.project.gadget.onlinegadgetstore.dao.AdminDao;
import com.project.gadget.onlinegadgetstore.model.Admin;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class AdminController {

	@Autowired
	private AdminDao adminDao;
	
	@GetMapping("/home")
	public String goToHome() {
		return "login";
	}
	
	@GetMapping("/adminlogin")
	public String goToAdminLoginPage() {
		return "adminlogin";
	}
	
	@GetMapping("/adminregister")
	public String goToAdminRegistrationPage() {
		return "adminregister";
	}
	
	@PostMapping("/adminlogin")
	public ModelAndView loginAdmin(HttpServletRequest request, @RequestParam("emailid") String emailId, @RequestParam("password") String password ) {
		ModelAndView mv = new ModelAndView();
		
		Admin admin = adminDao.findByEmailidAndPassword(emailId, password);
		
		if(admin != null) {
			HttpSession session = request.getSession();
			session.setAttribute("active-user", admin);
			session.setAttribute("user-login","admin");
			mv.addObject("status", admin.getFirstname()+" Successfully Logged in as ADMIN!");
			mv.setViewName("login");
		}
		
		else {
			mv.addObject("status","Failed to login as Admin!");
			mv.setViewName("login");
		}
		
		return mv;
	}
	
	@PostMapping("/adminregister")
	public ModelAndView registerAdmin(@ModelAttribute Admin admin) {
		ModelAndView mv = new ModelAndView();
		if(this.adminDao.save(admin)!= null) {
			mv.addObject("status", admin.getFirstname()+" Successfully Registered as ADMIN");
			mv.setViewName("adminlogin");
		}
		
		else {
			mv.addObject("status", admin.getFirstname()+" Failed to Registered as ADMIN");
			mv.setViewName("adminregister");
	
		}
		
		return mv;
	}
	
	@GetMapping("/admindashboard")
	public String viewAdminRights(HttpServletRequest request) {
		HttpSession session = (HttpSession) request.getAttribute("user-login");
		System.out.println(session);
		return "admin";
	}
}
