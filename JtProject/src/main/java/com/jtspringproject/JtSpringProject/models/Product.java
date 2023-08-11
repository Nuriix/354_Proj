package com.jtspringproject.JtSpringProject.models;

import com.fasterxml.jackson.annotation.JsonAnyGetter;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.persistence.*;

@Getter
@Setter
@Entity(name="PRODUCT")
@NoArgsConstructor
@AllArgsConstructor
public class Product {
	@Id
	@Column(name = "product_id")
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private int id;

	private String name;
	private String image;
	
	@OneToOne(cascade = CascadeType.PERSIST)
	@JoinColumn(name = "category_id",referencedColumnName = "category_id")
	private Category category;
	
	private int quantity;
	
	private double price;
	
	private int weight;
	
	private String description;

	@OneToOne(optional = true)
	@JoinColumn(name="suggested_product_id", referencedColumnName = "product_id")
	private Product productSuggestion;

	@ManyToOne
	@JoinColumn(name = "customer_id")
	private User customer;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getImage() {
		return image;
	}

	public void setImage(String image) {
		this.image = image;
	}

	public Category getCategory() {
		return category;
	}

	public void setCategory(Category category) {
		this.category = category;
	}

	public int getQuantity() {
		return quantity;
	}

	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}

	public double getPrice() {
		return price;
	}

	public void setPrice(double price) {
		this.price = price;
	}

	public int getWeight() {
		return weight;
	}

	public void setWeight(int weight) {
		this.weight = weight;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public void setProductSuggestion(Product product){ this.productSuggestion = product; }

	public Product getProductSuggestion(Product product){ return productSuggestion; }

}
