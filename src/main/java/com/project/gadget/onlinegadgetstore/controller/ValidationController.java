package com.project.gadget.onlinegadgetstore.controller;

import java.util.regex.Pattern;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.gadget.onlinegadgetstore.utility.Validation;

@Controller
public class ValidationController {

	@Autowired
	private Validation validate;
	
	
	@PostMapping("/validateadminemail")
	@ResponseBody
	public String validateAdminEmail(@RequestBody String email) {
		boolean result = validate.validateAdminEmail(email);
		if(result) {
			return "notexists";
		}
		return "Exists";
	}
	
	@PostMapping("/validateuseremail")
	@ResponseBody
	public String validateUserEmail(@RequestBody String email) {
		
		boolean result = validate.validateUserEmail(email);
		if(result) {
			return "notexists";
		}
		return "Exists";
	}
	
	@PostMapping("/validatepassword")
	@ResponseBody
	public String validatePassword(@RequestBody String password) {
		//String pattern = "^[A-Za-z0-9@#]+$";
		String pattern = "^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[@#]).+$";
		int sizeOfPassword = password.length();
		if(sizeOfPassword >= 8) {
			if(Pattern.matches(pattern, password)) return "strong";	
		}
		return "weak";
	}
	
	@PostMapping("/validateemail")
	@ResponseBody
	public String validateEmail(@RequestBody String email) {
		String patternEmail = "^(?=.{1,64}@)[A-Za-z0-9_-]+(\\.[A-Za-z0-9_-]+)*@[^-][A-Za-z0-9-]+(\\.[A-Za-z0-9-]+)*(\\.[A-Za-z]{2,})$";
		if(Pattern.matches(patternEmail, email)) {
			return "correct";	
		}
		return "notcorrect";
	}

	@PostMapping("/validatemobile")
	@ResponseBody
	public String validateNumber(@RequestBody String mobile) {
		String numberpattern = "^[0-9]{10}+$";
		if(Pattern.matches(numberpattern, mobile)) {
			return "valid";
		}
		return "notvalid";
	}
	
	
}
