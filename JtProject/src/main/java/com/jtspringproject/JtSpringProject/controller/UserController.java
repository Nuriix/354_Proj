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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
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
	
	private int customerId;
	
	@Autowired
	private userService userService;

	@Autowired
	private productService productService;
	
	@Autowired
	private cartService cartService;

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
	

	@GetMapping("/")
	public String userlogin(Model model) {
		
		return "userLogin";
	}
	@RequestMapping(value = "userloginvalidate", method = RequestMethod.POST)
	public ModelAndView userlogin( @RequestParam("username") String username, @RequestParam("password") String pass,Model model,HttpServletResponse res) {
		
		System.out.println(pass);
		User u = this.userService.checkLogin(username, pass);
		System.out.println(u.getUsername());
		if(u.getUsername().equals(username)) {	
			
			res.addCookie(new Cookie("username", u.getUsername()));
			ModelAndView mView  = new ModelAndView("index");	
			mView.addObject("user", u);
			customerId = u.getId();
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
	
	
	
	   //for Learning purpose of model
		@GetMapping("/test")
		public String Test(Model model)
		{
			System.out.println("test page");
			model.addAttribute("author","jay gajera");
			model.addAttribute("id",40);
			
			List<String> friends = new ArrayList<String>();
			model.addAttribute("f",friends);
			friends.add("xyz");
			friends.add("abc");
			
			return "test";
		}
		
		// for learning purpose of model and view ( how data is pass to view)
		
		@GetMapping("/test2")
		public ModelAndView Test2()
		{
			System.out.println("test page");
			//create modelandview object
			ModelAndView mv=new ModelAndView();
			mv.addObject("name","jay gajera 17");
			mv.addObject("id",40);
			mv.setViewName("test2");
			
			List<Integer> list=new ArrayList<Integer>();
			list.add(10);
			list.add(25);
			mv.addObject("marks",list);
			return mv;
			
			
		}
			
		// Need to iterate all items a customer has by looping through all product id under the same customer id
		@GetMapping("carts")
		public ModelAndView  getCartDetail()
		{
			ModelAndView mView= new ModelAndView();
			List<Cart> carts = this.cartService.getCartsByUserId(customerId);
			List<Product> products = new ArrayList<>();
			
			for(int i = 0; i < carts.size(); i++) {
				int productId = carts.get(i).getId();
				Product product = this.productService.getProduct(productId);
				products.add(product);
			}
			
			if (products.isEmpty()) {
				mView.addObject("msg", "No products in cart");
			}
			else {
				mView.addObject("products", products);
			}
			return mView;
		}
		
		@RequestMapping(value = "carts/add", method = RequestMethod.POST)
		public String addToCart(@RequestParam("productId") int id) {
			
			User user = new User();
			user.setId(customerId);
			
			Cart cart = new Cart();
			cart.setId(id);
			cart.setCustomer(user);
			
			try {
				this.cartService.addCart(cart);
			} catch (Exception e) {
				return "redirect:/carts";
			}
			
			return "redirect:/carts";
		}
		
		@GetMapping("carts/delete")
		public String removeCartDb(@RequestParam("id") int id)
		{	
			this.cartService.deleteCart(id);
			return "redirect:/carts";
		}
		
		@GetMapping("carts/empty")
		public String removeEntireCart()
		{	
			List<Cart> carts = this.cartService.getCartsByUserId(customerId);
			for(int i = 0; i < carts.size(); i++) {
				int productId = carts.get(i).getId();
				this.cartService.deleteCart(productId);
			}
			return "redirect:/carts";
		}
	  
}
