package com.project.gadget.onlinegadgetstore.utility;

import java.util.regex.Pattern;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.project.gadget.onlinegadgetstore.dao.AdminDao;
import com.project.gadget.onlinegadgetstore.dao.UsersDao;
import com.project.gadget.onlinegadgetstore.model.Admin;
import com.project.gadget.onlinegadgetstore.model.Users;

@Component
public class Validation{

	@Autowired
	private AdminDao admindao;
	@Autowired
	private UsersDao userdao; 
	
	public boolean validateAdminEmail(String email) {
		Admin result = admindao.findByEmailid(email);
		if(result != null) {
			return false;
		}
		return true;
	}

	public boolean validateUserEmail(String email) {
		Users result = userdao.findByEmailid(email);
		if(result != null) {
			return false;
		}
		return true;
	}
	
	public boolean validateEmail(String email) {
		String patternEmail = "^(?=.{1,64}@)[A-Za-z0-9_-]+(\\.[A-Za-z0-9_-]+)*@[^-][A-Za-z0-9-]+(\\.[A-Za-z0-9-]+)*(\\.[A-Za-z]{2,})$";
		if(Pattern.matches(patternEmail, email)) {
			return true;	
		}
		return false;
	}
}
