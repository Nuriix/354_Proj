package com.jtspringproject.JtSpringProject.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jtspringproject.JtSpringProject.dao.paymentDao;
import com.jtspringproject.JtSpringProject.models.Payment;

@Service
public class paymentService {
	@Autowired
	private paymentDao paymentDao;
	
	public Payment addPaymentMethod(Payment payment){
        return paymentDao.addPaymentMethod(payment);
    }
	
	public Payment getPaymentMethod(int id){
        return paymentDao.getPaymentMethod(id);
    }
	
	public void deletePaymentMethod(int id){
        paymentDao.deletePaymentMethod(id);
    }

}
