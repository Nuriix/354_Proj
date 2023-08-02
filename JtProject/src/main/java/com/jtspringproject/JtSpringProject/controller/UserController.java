package com.jtspringproject.JtSpringProject.controller;

import com.jtspringproject.JtSpringProject.models.Cart;
import com.jtspringproject.JtSpringProject.models.Product;
import com.jtspringproject.JtSpringProject.models.User;

import java.io.Console;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;

import com.jtspringproject.JtSpringProject.services.cartService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import com.jtspringproject.JtSpringProject.services.userService;
import com.jtspringproject.JtSpringProject.services.productService;
import com.jtspringproject.JtSpringProject.services.cartService;



@Controller
public class UserController{
	
	@Autowired
	private userService userService;

	@Autowired
	private productService productService;

	@GetMapping("/register")
	public String registerUser()
	{
		return "register";
	}

	@GetMapping("/buy")
	public String buy()
	{
		return "buy";
	}

	@GetMapping("/home/{id}")
	public ModelAndView customerHome(@PathVariable("id") int id){
		ModelAndView mView  = new ModelAndView("index");
		User u = this.userService.getUser(id);
		List<Product> products = this.productService.getProducts();

		mView.addObject("products", products);
		mView.addObject("user", u);

		return mView;
	}

	@GetMapping("/")
	public String userlogin(Model model) { return "userLogin"; }
	@RequestMapping(value = "userloginvalidate", method = RequestMethod.POST)
	public ModelAndView userlogin( @RequestParam("username") String username, @RequestParam("password") String pass,Model model,HttpServletResponse res) {

		User u = this.userService.checkLogin(username, pass);
		if(u.getUsername().equals(username)) {	
			
			res.addCookie(new Cookie("username", u.getUsername()));
			ModelAndView mView  = new ModelAndView("index");	
			mView.addObject("user", u);
			List<Product> products = this.productService.getProducts();

			if (products.isEmpty()) {
				mView.addObject("msg", "No products are available");
			} else {
				mView.addObject("products", products);
			}
			return mView;

		}else {
			ModelAndView mView = new ModelAndView("userLogin");
			mView.addObject("msg", "Please enter correct email and password");
			return mView;
		}
	}

	@GetMapping("user/profileDisplay/{id}")
	public ModelAndView getUserProfile(@PathVariable("id") int id){
		ModelAndView mView = new ModelAndView("customerProfile");
		User customer = this.userService.getUser(id);
		mView.addObject("user", customer);
		return mView;
	}

	@GetMapping("user/profileDisplay/update/")
	public ModelAndView updateUserProfile(@RequestParam("id") int id){
		ModelAndView mView = new ModelAndView("customerProfileUpdate");
		User customer = this.userService.getUser(id);
		mView.addObject("user", customer);
		return mView;
	}

	@RequestMapping(value = "user/profileDisplay/update/", method=RequestMethod.POST)
	public ModelAndView updateUserProfileInfo(@RequestParam("id") int id, @RequestParam("email") String email, @RequestParam("address") String address){
		User customer = this.userService.getUser(id);

		customer.setEmail(email);
		customer.setAddress(address);
		this.userService.updateUser(id, customer);

		return getUserProfile(id);
	}

	@GetMapping("/user/products")
	public ModelAndView getproduct() {

		ModelAndView mView = new ModelAndView("uproduct");
		List<Product> products = this.productService.getProducts();
		if(products.isEmpty()) {
			mView.addObject("msg","No products are available");
		}else {
			mView.addObject("products",products);
		}

		return mView;
	}

	@RequestMapping(value = "newuserregister", method = RequestMethod.POST)
	public String newUseRegister(@ModelAttribute User user)
	{
		System.out.println(user.getEmail());
		user.setRole("ROLE_NORMAL");
		this.userService.addUser(user);
		
		return "redirect:/";
	}
}
