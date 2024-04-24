package com.project.gadget.onlinegadgetstore.dao;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.project.gadget.onlinegadgetstore.model.Users;

@Repository
public interface UsersDao extends JpaRepository<Users, Integer> {
	

	Users findByEmailidAndPassword(String emailId, String password);
	Users findByEmailid(String emailId);
	Users findByEmailidAndMobileno(String emailId, String mobileNo);
}
