package com.jtspringproject.JtSpringProject.controller;

import com.jtspringproject.JtSpringProject.models.Cart;
import com.jtspringproject.JtSpringProject.models.Payment;
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

import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import com.jtspringproject.JtSpringProject.services.userService;
import com.jtspringproject.JtSpringProject.services.productService;
import com.jtspringproject.JtSpringProject.services.cartService;
import com.jtspringproject.JtSpringProject.services.paymentService;



@Controller
public class UserController{

	private int customerId;

	@Autowired
	private userService userService;

	@Autowired
	private productService productService;

	@Autowired
	private cartService cartService;
	
	@Autowired
	private paymentService paymentService;

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
	//CARTS 
	//--------------------------------------------------------------------------------------------------------------------------
	@GetMapping("carts")
	public ModelAndView getCartDetail() {
		ModelAndView mView = new ModelAndView();
		List<Cart> carts = this.cartService.getCartsByUserId(customerId);
		List<Product> products = new ArrayList<>();
		double subtotal = 0.0; // Initialize the subtotal variable

		for (int i = 0; i < carts.size(); i++) {
			int productId = carts.get(i).getId();
			Product product = this.productService.getProduct(productId);
			products.add(product);
			subtotal += product.getPrice(); // Calculate the subtotal by adding product prices
		}

		if (products.isEmpty()) {
			mView.addObject("msg", "No products in cart");
		} else {
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

	//Checkout payment
	@GetMapping("payment")
	public ModelAndView paymentDetails() {
		ModelAndView mView = new ModelAndView();
		Payment payment = this.paymentService.getPaymentMethod(customerId);
		
		if (payment == null) {
			mView.addObject("msg", "No payment methods!");
		} else {
			mView.addObject("payment", payment);
		}
		
		return mView;
	}
	
	//PAYMENT DETAILS
	//--------------------------------------------------------------------------------------------------------------------------
	
	@GetMapping("/paymentMethod")
	public ModelAndView paymentMethod() {
		ModelAndView mView = new ModelAndView();
		Payment payment = this.paymentService.getPaymentMethod(customerId);
		
		if (payment == null) {
			mView.addObject("msg", "No payment methods!");
		} else {
			mView.addObject("payment", payment);
		}
		
		return mView;
	}
	
	@GetMapping("/paymentMethod/update")
	public ModelAndView updatePaymentMethod(){
		ModelAndView mView = new ModelAndView("paymentMethodUpdate");
		Payment payment = this.paymentService.getPaymentMethod(customerId);
		mView.addObject("payment", payment);
		return mView;
	}
	
	@RequestMapping(value="/paymentMethod/update", method=RequestMethod.POST)
	public String updatePaymentMethodInfo(@RequestParam("nameOnCard") String nameOnCard,
												@RequestParam("cardNumber") String cardNumber,
												@RequestParam("cvs") String cvs,
												@RequestParam("expiryDate") String expiryDate){
		
		Payment payment = new Payment();
		payment.setId(customerId);
		payment.setNameOnCard(nameOnCard);
		payment.setCardNumber(cardNumber);
		payment.setCvs(cvs);
		payment.setExpiryDate(expiryDate);
		
		Payment payment2 = this.paymentService.getPaymentMethod(customerId);
		if (payment2 == null) {
			this.paymentService.addPaymentMethod(payment);
			return "redirect:/paymentMethod";
		} else {
			this.paymentService.deletePaymentMethod(customerId);
			this.paymentService.addPaymentMethod(payment);
			return "redirect:/paymentMethod";
		}
		
	}
	@GetMapping("paymentMethod/delete")
	public String removePaymentDb() {	
		Payment payment = this.paymentService.getPaymentMethod(customerId);
		if (payment == null) {
			return "redirect:/paymentMethod";
		} else {
			this.paymentService.deletePaymentMethod(customerId);
			return "redirect:/paymentMethod";
		}
		
	}
	
	//--------------------------------------------------------------------------------------------------------------------------

}
