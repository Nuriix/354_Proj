package com.jtspringproject.JtSpringProject.models;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.*;

@Entity(name="CATEGORY")
@Table(name="CATEGORY")
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Category {
	@Id
	@Column(name = "category_id")
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private int id;
	
	private String name;
	
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
	
}
