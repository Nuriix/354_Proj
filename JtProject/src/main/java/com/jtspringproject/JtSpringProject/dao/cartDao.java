package com.jtspringproject.JtSpringProject.dao;
import java.util.List;

import com.jtspringproject.JtSpringProject.models.Cart;
import com.jtspringproject.JtSpringProject.models.Product;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.jpa.repository.Modifying;
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
    public Query<Cart> getIsSelected(int id){
        return this.sessionFactory.getCurrentSession().createQuery("SELECT isSelected FROM CART WHERE id = :id", Cart.class).setParameter("id",id);
    }

    @Transactional
    public Query<Cart> updateIsSelected(int id, boolean isSelected){
        return this.sessionFactory.getCurrentSession().createQuery("UPDATE CART(isSelected) SET isSelected = :isSelected WHERE id = :id", Cart.class)
                .setParameter("id", id)
                .setParameter("isSelected", isSelected);
    }

    @Transactional
    public List<Cart> getCartsByUserId(int customer_id) {
        return this.sessionFactory.getCurrentSession()
                .createQuery("from CART where customer_id = :customer_id", Cart.class)
                .setParameter("customer_id", customer_id).list();
    }

    @Modifying
    @Transactional
    public int addProductToCart(int cartId, Product product){
        return this.sessionFactory.getCurrentSession()
                .createSQLQuery("INSERT INTO CART_PRODUCT(cart_id,product_id) VALUES (:cart_id,:product_id)")
                .setParameter("cart_id",cartId)
                .setParameter("product_id",product.getId())
                .executeUpdate();
    }

    @Transactional
    public void updateCart(Cart cart) {
        this.sessionFactory.getCurrentSession().update(cart);
    }

    @Modifying
    @Transactional
    public void deleteCartProduct(int cart_id, int product_id) {

        Session session = this.sessionFactory.getCurrentSession();
        session.createSQLQuery("DELETE FROM CART_PRODUCT " +
                        "WHERE cart_id = :cart_id AND product_id = :product_id")
                .setParameter("cart_id",cart_id)
                .setParameter("product_id",product_id)
                .executeUpdate();
    }

    @Transactional
    public Boolean deleteCart(int id) {
    	
    	Session session = this.sessionFactory.getCurrentSession();
		Object persistanceInstance = session.load(Cart.class, id);

		if (persistanceInstance != null) {
			session.delete(persistanceInstance);
			return true;
		}
		return false;
    }
}
