package com.jtspringproject.JtSpringProject.dao;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.jtspringproject.JtSpringProject.models.Payment;

@Repository
public class paymentDao {
	@Autowired
    private SessionFactory sessionFactory;

    public void setSessionFactory(SessionFactory sf){ this.sessionFactory =sf;}
    
    @Transactional
    public Payment addPaymentMethod(Payment payment) {
        this.sessionFactory.getCurrentSession().save(payment);
        return payment;
    }
    
    @Transactional
    public Payment getPaymentMethod(int id) {
        return this.sessionFactory.getCurrentSession().get(Payment.class, id);
    }
    
    @Transactional
    public Boolean deletePaymentMethod(int id) {
    	
    	Session session = this.sessionFactory.getCurrentSession();
		Object persistanceInstance = session.load(Payment.class, id);

		if (persistanceInstance != null) {
			session.delete(persistanceInstance);
			return true;
		}
		return false;
    }

}
