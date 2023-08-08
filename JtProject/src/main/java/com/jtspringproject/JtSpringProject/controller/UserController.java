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
import org.springframework.boot.Banner;
import org.springframework.transaction.annotation.Transactional;
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
			customerId = u.getId();
			List<Product> products = this.productService.getProducts();

			if (products.isEmpty()) {
				mView.addObject("msg", "No products are available");
			} else {
				mView.addObject("products", products);
			}
			return mView;
		} else {
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

	@GetMapping("/user/products/{id}")
	public ModelAndView getproductlist(@PathVariable("id") int id) {
		ModelAndView mView = new ModelAndView("uproduct");

		List<Product> products = this.productService.getProducts();
		User u = this.userService.getUser(id);
		mView.addObject("user", u);

		if(products.isEmpty()) {
			mView.addObject("msg","No products are available");
		}else {
			mView.addObject("products",products);
		}
		return mView;
	}
	@GetMapping("/user/deals/{id}")
	public ModelAndView getDeals(@PathVariable("id") int id) {

		ModelAndView mView = new ModelAndView("uDeals");

		User customer = this.userService.getUser(id);
		mView.addObject("user", customer);

		return mView;
	}

	@RequestMapping(value = "newuserregister", method = RequestMethod.POST)
	public String newUseRegister(@ModelAttribute User user)
	{
		user.setRole("ROLE_NORMAL");
		this.userService.addUser(user);

		return "redirect:/";
	}
	//CARTS 
	//--------------------------------------------------------------------------------------------------------------------------
	@GetMapping("user/carts/new/{id}")
	public String createEmptyCart(@PathVariable("id") int id)
	{
		User u = this.userService.getUser(id);
		List<Cart> carts = this.cartService.getCartsByUserId(customerId);

		for(Cart cart : carts){
			cart.setIsSelected(false);
			this.cartService.updateCart(cart);
		}

		Cart newCart = new Cart();
		newCart.setIsSelected(true);
		newCart.setCustomer(u);

		this.cartService.addCart(newCart);
		return "redirect:/carts/"+id;
	}

	@GetMapping("carts/{id}")
	@Transactional
	public ModelAndView getCartDetail(@PathVariable("id") int id) {
		ModelAndView mView = new ModelAndView();

		User u = this.userService.getUser(id);
		mView.addObject("user", u);
		List<Cart> carts = this.cartService.getCartsByUserId(customerId);

		if(carts.isEmpty()){
			System.out.println("Emprty cart :(");
		} else {
			double subtotal = 0.0; // Initialize the subtotal variable
			Cart selectedCart = carts.stream().filter(cart -> cart.getIsSelected() == true).toArray( Cart[]::new )[0];
			List<Product> products = selectedCart.getProducts();

			if (products.isEmpty()) {
				mView.addObject("msg", "No products in cart");
				System.out.println("no products cart :(");
			} else {
				System.out.println("yay products !! :)");
				System.out.println(products.size());





//
//				for (int i = 0; i < selectedCart.getProducts().size() - 1; i++) {
//					int productId = carts.get(selectedCart.getId()).getId();
//					Product product = this.productService.getProduct(productId);
//					products.add(product);
//
//					subtotal += product.getPrice(); // Calculate the subtotal by adding product prices
//				}
//				System.out.println(products.size());

				mView.addObject("products", products);
			}
			// Add the subtotal to the model
			mView.addObject("subtotal", subtotal);

			// Calculate the tax amount (assuming the tax rate is 9.975%)
			double taxRate = 0.09975; // 9.975% as a decimal
			double taxAmount = subtotal * taxRate;

			// Add the tax amount to the model
			mView.addObject("taxAmount", taxAmount);

			// Set the view name (make sure it points to your JSP file)
			mView.setViewName("carts");
		}
		mView.addObject("cartList",carts);
		return mView;
	}

	@RequestMapping(value = "carts/add", method = RequestMethod.POST)
	public String addToCart(@RequestParam("customerId") int customerId, @RequestParam("productId") int productId) {

		User user = this.userService.getUser(customerId);
		Product product = this.productService.getProduct(productId);
		List<Cart> userCarts = this.cartService.getCartsByUserId(customerId);

		if(userCarts.isEmpty()){
			Cart newCart = new Cart();
			newCart.setIsSelected(true);
			newCart.setCustomer(user);
			newCart.addProduct(product);

			this.cartService.addCart(newCart);
		} else {
			Cart selectedCart = userCarts.stream().filter(cart -> cart.getIsSelected() == true).toArray( Cart[]::new )[0];
			this.cartService.addProductToCart(selectedCart, product);
		}
		return "redirect:/carts/"+customerId+"";
	}

	@GetMapping(value = "carts/add/{customerId}/{productId}")
	public String addToCartFromDashboard(@PathVariable("customerId") int customerId,@PathVariable("productId") int productId) {

		User user = this.userService.getUser(customerId);

		Cart cart = new Cart();
		cart.setId(productId);
		cart.setCustomer(user);

		try {
			this.cartService.addCart(cart);
		} catch (Exception e) {
			return "redirect:/home/{customerId}";
		}
		return "redirect:/home/{customerId}";
	}

	@GetMapping("carts/delete")
	public String removeCartDb(@RequestParam("id") int id) {	
		this.cartService.deleteCart(id);
		return "redirect:/carts";
	}

	@GetMapping("carts/empty")
	public String removeEntireCart() {	
		List<Cart> carts = this.cartService.getCartsByUserId(customerId);
		for(int i = 0; i < carts.size(); i++) {
			int productId = carts.get(i).getId();
			this.cartService.deleteCart(productId);
		}
		return "redirect:/carts";
	}
	//--------------------------------------------------------------------------------------------------------------------------
	@GetMapping("payment/{id}")
	public ModelAndView paymentDetails(@PathVariable("id") int id) {

		ModelAndView mView = new ModelAndView();

		User u = this.userService.getUser(id);
		mView.addObject("user", u);

		return mView;
	}
}
