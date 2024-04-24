package com.project.gadget.onlinegadgetstore.controller;


import org.springframework.boot.web.servlet.error.ErrorController;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import jakarta.servlet.http.HttpServletResponse;

@Controller
public class CustomExceptionController implements ErrorController{
	

	@RequestMapping("/error")
	public ModelAndView errorhandling(HttpServletResponse response) {
		Integer statuscode = response.getStatus();
		ModelAndView mv = new ModelAndView();
		mv.addObject("error", statuscode);
		mv.setViewName("error");
		return mv;
	}
}
