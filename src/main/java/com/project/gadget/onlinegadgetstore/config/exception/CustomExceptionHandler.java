package com.project.gadget.onlinegadgetstore.config.exception;

import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.servlet.ModelAndView;

@ControllerAdvice
public class CustomExceptionHandler {
	
	@ExceptionHandler(value= {CustomException.class})
	public ModelAndView throwCustomException(CustomException customException) {
		
		ModelAndView mv = new ModelAndView();
		mv.addObject("errorMessage", customException.getMessage());
		mv.setViewName("error");
		return mv;
	}

}
