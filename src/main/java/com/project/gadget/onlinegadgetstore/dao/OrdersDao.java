package com.project.gadget.onlinegadgetstore.dao;

import java.time.LocalDate;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.project.gadget.onlinegadgetstore.model.Orders;

@Repository
public interface OrdersDao extends JpaRepository<Orders, Integer> {

	List<Orders> findByOrderId(String orderId);
	List<Orders> findByUserId(int userId);
	List<Orders> findByOrderDate(LocalDate orderDate);
	List<Orders> findByOrderDateAndUserId(LocalDate orderDate, int userId);
	
	@Query(value="select count(*) from Orders where delivery_status <> :deliverystatus" , nativeQuery=true)
	int countNotExists(@Param("deliverystatus") String deliverystatus);

}
