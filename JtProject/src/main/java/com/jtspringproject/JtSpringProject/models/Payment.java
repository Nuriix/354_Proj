package com.jtspringproject.JtSpringProject.models;

import java.util.List;

import javax.persistence.Entity;
import javax.persistence.Id;


@Entity(name="PAYMENT")
public class Payment {

	@Id
	private int id;
	
	private String nameOnCard;
	
	private String cardNumber;
	
	private String cvs;
	
	private String expiryDate;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getNameOnCard() {
		return nameOnCard;
	}

	public void setNameOnCard(String nameOnCard) {
		this.nameOnCard = nameOnCard;
	}

	public String getCardNumber() {
		return cardNumber;
	}

	public void setCardNumber(String cardNumber) {
		this.cardNumber = cardNumber;
	}

	public String getCvs() {
		return cvs;
	}

	public void setCvs(String cvs) {
		this.cvs = cvs;
	}

	public String getExpiryDate() {
		return expiryDate;
	}

	public void setExpiryDate(String expiryDate) {
		this.expiryDate = expiryDate;
	}
	
}
