package com.project.gadget.onlinegadgetstore.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.ModelAndView;

import com.project.gadget.onlinegadgetstore.dao.UsersDao;
import com.project.gadget.onlinegadgetstore.model.Users;

import jakarta.servlet.http.HttpSession;

@Controller
public class loginController {

	@Autowired
	private UsersDao userDao;
	
	@GetMapping("/login")
	public String login(){
		return "login";
	}
	
	@GetMapping("/logout")
	public ModelAndView logout(HttpSession session) {
		ModelAndView mv = new ModelAndView();
		
		session.removeAttribute("active-user");
		session.removeAttribute("user-login");
		mv.addObject("status","Logged out Successfully");
		mv.setViewName("login");
		
		return mv;
	}
	
	@PostMapping("/forgetpassword")
	public ModelAndView forgetpassword(@ModelAttribute Users forgetPassDetail,HttpSession session) {
		ModelAndView mv = new ModelAndView();
		
		Users user = userDao.findByEmailidAndMobileno(forgetPassDetail.getEmailid(), forgetPassDetail.getMobileno());
		
		if(user != null) {
			user.setPassword(forgetPassDetail.getPassword());
			userDao.save(user);
			

			mv.addObject("status", "Password Changed");
			mv.setViewName("userlogin");
			session.removeAttribute("active-user");
			session.removeAttribute("user-login");
			
		}
		
		else {
			mv.addObject("status", "No User found!");
			mv.setViewName("userregister");
		}
		
		return mv;
	}
}
