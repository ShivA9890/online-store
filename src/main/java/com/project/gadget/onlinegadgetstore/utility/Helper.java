package com.project.gadget.onlinegadgetstore.utility;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;

import com.project.gadget.onlinegadgetstore.dao.ProductDao;
import com.project.gadget.onlinegadgetstore.model.Cart;
import com.project.gadget.onlinegadgetstore.model.Product;

public class Helper {
	
	@Autowired
	private ProductDao productdao;
	
	public static String get10Words(String productDescription)
    {
    	String[] str=productDescription.split(" ");
    	if(str.length>10)
    	{
    		String res="";
    		for(int i=0;i<10;i++)
    		{
    			res=res+str[i]+" ";
    		}
    		
    		return res+"...";
    	}
    	
    	else
    	{
    		return productDescription+"...";
    	}
    }
	
	 public static double getProductSellingPrice(double productPrice,double productDiscountPercent)
	    {
	    	
	    	Double tenPercentValue=productDiscountPercent*0.01;
	    	Double tenPercentOfPrice=tenPercentValue*productPrice;
	    	Double finalPrice=productPrice-tenPercentOfPrice;
	    	
	    	return finalPrice;
	    }
	 
	 public static String getAlphaNumericOrderId(int n)
	    {
	        String AlphaNumericString = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789abcdefghijklmnopqrstuvxyz";
	        StringBuilder sb = new StringBuilder(n);
	        for (int i = 0; i < n; i++) {
	            int index = (int)(AlphaNumericString.length()* Math.random());
	            sb.append(AlphaNumericString.charAt(index));
	        }
	        return sb.toString();
	    }
	 
	 public double getProductsTotalSellingPrice(List<Cart> carts) {
	    	double totalPrice = 0;
	    	for(Cart c : carts) {
	    		Optional<Product> optinal = productdao.findById(c.getProductId());
	    		Product f = null;
	    		f = optinal.get();
	    	    double productPrice = getProductSellingPrice(f.getPrice(),f.getDiscount());
	    	    totalPrice = totalPrice + (productPrice*c.getQuantity());
	    	}
	    	
	    	return totalPrice;
	    	
	    }
}
