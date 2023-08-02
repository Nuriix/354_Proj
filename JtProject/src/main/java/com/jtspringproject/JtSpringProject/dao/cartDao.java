package com.jtspringproject.JtSpringProject.dao;
import java.util.List;

import com.jtspringproject.JtSpringProject.models.Cart;
import com.jtspringproject.JtSpringProject.models.Category;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

@Repository
public class cartDao {
    @Autowired
    private SessionFactory sessionFactory;

    public void setSessionFactory(SessionFactory sf){ this.sessionFactory =sf;}

    @Transactional
    public Cart addCart(Cart cart) {
        this.sessionFactory.getCurrentSession().save(cart);
        return cart;
    }

    @Transactional
    public Cart getCart(int id) {
        return this.sessionFactory.getCurrentSession().get(Cart.class, id);
    }
    
    @Transactional
    public List<Cart> getCarts() {
        return this.sessionFactory.getCurrentSession().createQuery("from CART").list();
    }
    
    @Transactional
    public List<Cart> getCartsByUserId(int customer_id) {
        return this.sessionFactory.getCurrentSession().createQuery("from CART where customer_id =:customer_id", Cart.class).setParameter("customer_id", customer_id).list();
    }

    @Transactional
    public void updateCart(Cart cart) {
        this.sessionFactory.getCurrentSession().update(cart);
    }

    @Transactional
    public void deleteCart(Cart cart) {
        this.sessionFactory.getCurrentSession().delete(cart);
    }
}
