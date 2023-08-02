package com.jtspringproject.JtSpringProject.services;

import com.jtspringproject.JtSpringProject.dao.cartDao;
import com.jtspringproject.JtSpringProject.models.Cart;
import com.jtspringproject.JtSpringProject.models.Category;
import com.jtspringproject.JtSpringProject.models.Product;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class cartService {
    @Autowired
    private cartDao cartDao;

    public Cart addCart(Cart cart)
    {
        return cartDao.addCart(cart);
    }
    
    public Cart getCart(int id){
        return cartDao.getCart(id);
    }
    
	public List<Cart> getCarts(){
	    return this.cartDao.getCarts();
	}
	
	public List<Cart> getCartsByUserId(int customer_id){
	    return this.cartDao.getCartsByUserId(customer_id);
	}

    public void updateCart(Cart cart){
        cartDao.updateCart(cart);
    }
    public void deleteCart(int id)
    {
        cartDao.deleteCart(id);
    }



}
