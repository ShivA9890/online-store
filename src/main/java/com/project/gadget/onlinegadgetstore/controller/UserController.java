package com.project.gadget.onlinegadgetstore.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.project.gadget.onlinegadgetstore.dao.UsersDao;
import com.project.gadget.onlinegadgetstore.model.Users;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class UserController {

	@Autowired
	private UsersDao userdao;
	
	@GetMapping("userlogin")
	public String goToUserLoginPage(){
		return "userlogin";
	}
	
	
	@GetMapping("userregister")
	public String goToUserRegisterPage() {
		return "userregister";
	}
	
	
	
	
	@PostMapping("userregister")
	public ModelAndView addNewUser(@ModelAttribute Users user) {
		ModelAndView mv = new ModelAndView();
		if(this.userdao.save(user)!=null) {
			mv.addObject("status",user.getFirstname()+" Successfully Registered!");
			mv.setViewName("userlogin");
		}
		else {
			mv.addObject("status",user.getFirstname()+" Failed to Register!");
			mv.setViewName("userregister");
		}
		return mv;
	}
	
	@PostMapping("/userlogin")
	public ModelAndView validateUserDetails(HttpServletRequest request,@RequestParam("emailid") String email,@RequestParam("password") String password) {
		ModelAndView mv = new ModelAndView();
		Users user = userdao.findByEmailidAndPassword(email, password);
		if(user != null) {
			HttpSession session = request.getSession();
			session.setAttribute("active-user",user);
			session.setAttribute("user-login", "user");
			mv.addObject("status", user.getFirstname()+" Login Successfully !!!");
			mv.setViewName("login");
		}
		else {
			mv.addObject("status", " Failed to Login !!");
			mv.setViewName("userlogin");
		}
		
		return mv;
	}
}
