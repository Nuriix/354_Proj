package com.jtspringproject.JtSpringProject.controller;

import java.lang.reflect.Array;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import lombok.Getter;
import lombok.Setter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import com.jtspringproject.JtSpringProject.models.Category;
import com.jtspringproject.JtSpringProject.models.Product;
import com.jtspringproject.JtSpringProject.models.User;
import com.jtspringproject.JtSpringProject.services.categoryService;
import com.jtspringproject.JtSpringProject.services.productService;
import com.jtspringproject.JtSpringProject.services.userService;

@Controller
@Getter
@Setter
@RequestMapping("/admin")
public class AdminController {

	@Autowired
	private userService userService;
	@Autowired
	private categoryService categoryService;
	@Autowired
	private productService productService;

	int adminlogcheck = 0;
	String usernameforclass = "";

	@RequestMapping(value = {"/","/logout"})
	public String returnIndex() {
		adminlogcheck =0;
		usernameforclass = "";
		return "userLogin";
	}
	@GetMapping("/index")
	public String index(Model model) {
		if(usernameforclass.equalsIgnoreCase(""))
			return "userLogin";
		else {
			model.addAttribute("username", usernameforclass);
			return "index";
		}
	}
	@GetMapping("login")
	public String adminlogin() {
		return "adminlogin";
	}

	@GetMapping("Dashboard")
	public String adminHome(Model model) {
		if(adminlogcheck==1)
			return "adminHome";
		else
			return "redirect:/admin/login";
	}
	@GetMapping("/loginvalidate")
	public String adminlog(Model model) {
		return "adminlogin";
	}
	@RequestMapping(value = "loginvalidate", method = RequestMethod.POST)
	public ModelAndView adminlogin( @RequestParam("username") String username, @RequestParam("password") String pass) {

		User user=this.userService.checkLogin(username, pass);
		if(user.getRole().equals("ROLE_ADMIN")) {
			ModelAndView mv = new ModelAndView("adminHome");
			adminlogcheck=1;
			mv.addObject("admin", user);
			return mv;
		}
		else {
			ModelAndView mv = new ModelAndView("adminlogin");
			mv.addObject("msg", "Please enter correct username and password");
			return mv;
		}
	}
	//	 --------------------------Categories --------------------
	@GetMapping("category")
	public ModelAndView getcategory() {
		if(adminlogcheck==0){
			ModelAndView mView = new ModelAndView("adminlogin");
			return mView;
		}
		else {
			ModelAndView mView = new ModelAndView("categories");
			List<Category> categories = this.categoryService.getCategories();
			mView.addObject("categories", categories);
			return mView;
		}
	}

	//@RequestMapping(value = "categories",method = RequestMethod.POST)
	@PostMapping("category")
	public String addCategory(@RequestParam("categoryname") String category_name)
	{
		Category category =  this.categoryService.addCategory(category_name);
		return "redirect:category";
	}
	@GetMapping("categories/delete/")
	public String removeCategoryDb(@RequestParam("id") int id)
	{
		this.categoryService.deleteCategory(id);
		return "redirect:/admin/category";
	}
	@GetMapping("categories/update")
	public String updateCategory(@RequestParam("categoryid") int id, @RequestParam("categoryname") String categoryname)
	{
		Category category = this.categoryService.updateCategory(id, categoryname);
		return "redirect:/admin/category";
	}
	//	 --------------------------Products --------------------
	@GetMapping("product")
	public ModelAndView getproduct() {
		if(adminlogcheck==0){
			ModelAndView mView = new ModelAndView("adminlogin");
			return mView;
		}
		else {
			ModelAndView mView = new ModelAndView("products");
			List<Product> products = this.productService.getProducts();

			if (products.isEmpty()) {
				mView.addObject("msg", "No products are available");
			} else {
				mView.addObject("products", products);
			}
			return mView;
		}
	}
	@GetMapping("products/add")
	public ModelAndView addProduct() {
		ModelAndView mView = new ModelAndView("productsAdd");
		List<Category> categories = this.categoryService.getCategories();
		List<Product> products = this.productService.getProducts();
		mView.addObject("products",products);
		mView.addObject("categories",categories);
		return mView;
	}

	@PostMapping("products/add")
	public String addProduct(@RequestParam("name") String name,
	                         @RequestParam("categoryid") int categoryId,
	                         @RequestParam("price") double price,
	                         @RequestParam("weight") int weight,
	                         @RequestParam("quantity") int quantity,
	                         @RequestParam("description") String description,
	                         @RequestParam("productImage") String productImage,
	                         @RequestParam("suggestedProduct") int suggestedProductID) {

	    // Validate inputs (e.g., non-empty name, positive price, etc.)
	    // Implement error handling if validation fails.

	    Category category = this.categoryService.getCategory(categoryId);
	    if (category == null) { System.out.println("dkjvldkjvldk");
	        // Handle the case when the category with the given categoryId is not found.
	        // You may choose to display an error message to the user or redirect to an error page.
	        return "redirect:/admin/error";
	    }

	    Product product = new Product();
      	Product suggestedProduct = this.productService.getProduct(suggestedProductID);
	    // product.setId(categoryId); // Assuming the ID is auto-generated in the database.
	    product.setName(name);
	    product.setCategory(category);
	    product.setDescription(description);
	    product.setPrice(price);
	    product.setImage(productImage);
	    product.setWeight(weight);
	    product.setQuantity(quantity);
      	product.setProductSuggestion(suggestedProduct);

	    try {
	        this.productService.addProduct(product);
	    } catch (Exception ex) {
	        // Handle the case when there's an issue with adding the product to the database.
	        // You may choose to log the error or redirect to an error page.
	        return "redirect:/admin/error";
	    }
	    return "redirect:/admin/product";
	}
	@GetMapping("products/update/")
	public ModelAndView updateproductinfo(@RequestParam("id") int id) {

		ModelAndView mView = new ModelAndView("productsUpdate");
		List<Product> products = this.productService.getProducts();
		Product product = this.productService.getProduct(id);
		List<Category> categories = this.categoryService.getCategories();

		mView.addObject("products", products);
		mView.addObject("categories",categories);
		mView.addObject("product", product);

		return mView;
	}

	@PostMapping("products/update/")
	public String updateProduct(@RequestParam("id") int id ,@RequestParam("name") String name,
								@RequestParam("categoryid") int categoryId ,
								@RequestParam("price") double price,
								@RequestParam("weight") int weight,
								@RequestParam("quantity")int quantity,
								@RequestParam("description") String description,
								@RequestParam("productImage") String productImage,
								@RequestParam("suggestedProduct") int suggestedProductID)
	{
		Category category = this.categoryService.getCategory(categoryId);
		Product suggestedProduct = this.productService.getProduct(suggestedProductID);
		Product product = new Product();

		product.setName(name);
		product.setCategory(category);
		product.setDescription(description);
		product.setPrice(price);
		product.setImage(productImage);
		product.setWeight(weight);
		product.setQuantity(quantity);
		product.setProductSuggestion(suggestedProduct);

		this.productService.updateProduct(id, product);
		return "redirect:/admin/product";
	}
	@GetMapping("products/delete/")
	public ModelAndView removeProduct(@RequestParam("id") int id)
	{
		this.productService.deleteProduct(id);

		ModelAndView mView = new ModelAndView("products");
		List<Product> products = this.productService.getProducts();

		if (products.isEmpty()) {
			mView.addObject("msg", "No products are available");
		} else {
			mView.addObject("products", products);
		}
		return mView;
	}
	@PostMapping("product")
	public String postproduct() {
		return "redirect:/admin/product";
	}

	// Products Utils Methods
	@GetMapping(value = "products/search")
	public ModelAndView searchProduct(String keyword){

		ModelAndView mView = new ModelAndView("products");
		if(keyword != null){
			List<Product> list = this.productService.getByKeyword(keyword);
			if (list.isEmpty()) {
				mView.addObject("msg", "No products are available");
			} else {
				mView.addObject("products", list);
			}
		}else{
			List<Product> list = this.productService.getProducts();
			if (list.isEmpty()) {
				mView.addObject("msg", "No products are available");
			} else {
				mView.addObject("products", list);
			}
		}
		return mView;
	}

	@GetMapping(value = "products/pairs")
	public ModelAndView getProductPairs(){
		ModelAndView mView = new ModelAndView("productsPair");

		List<Object []> productsPair = this.productService.getProductPairs();
		List<Product []>  pairsList = new ArrayList<>();

		for(Object[] pair : productsPair){

			Product[] prodPair = new Product[2];

			Product product1 = this.productService.getProduct((int) pair[0]);
			Product product2 = this.productService.getProduct((int) pair[1]);

			prodPair[0] = product1;
			prodPair[1] = product2;

			pairsList.add(prodPair);
		}
		mView.addObject("productPairs",pairsList);
		System.out.println(pairsList);
		return mView;
	}

	//	 --------------------------Customers --------------------
	@GetMapping("customers")
	public ModelAndView getCustomerDetail() {
		if(adminlogcheck==0){
			ModelAndView mView = new ModelAndView("adminlogin");
			return mView;
		} else {
			ModelAndView mView = new ModelAndView("displayCustomers");
			List<User> users = this.userService.getUsers();
			mView.addObject("customers", users);
			return mView;
		}
	}
	@RequestMapping(value = "customers/add/", method=RequestMethod.POST)
	public String addUserProfile(@ModelAttribute User user)
	{
		this.userService.addUser(user);
		return "redirect:/admin/customers";
	}
	@GetMapping("customers/delete/")
	public String removeUser(@RequestParam("id") int id)
	{
		this.userService.deleteUser(id);
		return "redirect:/admin/customers";
	}
	@GetMapping(value = "customers/update/")
	public ModelAndView displayUpdateUserInfo(@RequestParam("id") int id)
	{
		ModelAndView mView = new ModelAndView("displayCustomerUpdate");
		User user = this.userService.getUser(id);
		mView.addObject("user", user);
		return mView;
	}
	@RequestMapping(value = "customers/update/", method=RequestMethod.POST)
	public String updateUserInfo(@RequestParam("id") int id, @RequestParam("email") String email ,@RequestParam("address") String address, @RequestParam("role") String role)
	{
		User user = this.userService.getUser(id);
		user.setAddress(address);
		user.setEmail(email);
		user.setRole(role);

		this.userService.updateUser(id, user);
		return "redirect:/admin/customers";
	}
}