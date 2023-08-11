package com.jtspringproject.JtSpringProject;

import com.jtspringproject.JtSpringProject.controller.AdminController;
import com.jtspringproject.JtSpringProject.models.Category;
import com.jtspringproject.JtSpringProject.services.categoryService;
import com.jtspringproject.JtSpringProject.models.User;
import com.jtspringproject.JtSpringProject.services.userService;
import com.jtspringproject.JtSpringProject.models.Product;
import com.jtspringproject.JtSpringProject.services.productService;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import static org.mockito.Mockito.*;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

@ExtendWith(MockitoExtension.class)
public class AdminControllerTest {

    private MockMvc mockMvc;

    @Mock
    private categoryService categoryService;

    @Mock
    private userService userService;

    @Mock
    private productService productService;

    @InjectMocks
    private AdminController adminController;

    /**********************************************| General |***********************************************/
    // To test admin logout
    @Test
    public void TestReturnIndex() throws Exception {
        this.adminController.setAdminlogcheck(1);
        this.mockMvc = MockMvcBuilders.standaloneSetup(adminController).build();

        mockMvc.perform(MockMvcRequestBuilders.get("/admin/"))
                .andExpect(status().isOk())
                .andExpect(view().name("userLogin"));

        mockMvc.perform(MockMvcRequestBuilders.get("/admin/logout"))
                .andExpect(status().isOk())
                .andExpect(view().name("userLogin"));
    }
    @Test
    public void TestAdminHome() throws Exception{
        this.adminController.setAdminlogcheck(1);
        this.mockMvc = MockMvcBuilders.standaloneSetup(adminController).build();

        mockMvc.perform(MockMvcRequestBuilders.get("/admin/Dashboard"))
                .andExpect(status().isOk())
                .andExpect(view().name("adminHome"));
    }
    @Test
    public void TestAdminLogin_Success() throws Exception{
        this.adminController.setAdminlogcheck(1);
        this.mockMvc = MockMvcBuilders.standaloneSetup(adminController).build();

        mockMvc.perform(MockMvcRequestBuilders.get("/admin/login"))
                .andExpect(status().isOk())
                .andExpect(view().name("adminlogin"));
    }
    @Test
    public void TestAdminHome_Fail() throws Exception{
        this.adminController.setAdminlogcheck(0);
        this.mockMvc = MockMvcBuilders.standaloneSetup(adminController).build();

        mockMvc.perform(MockMvcRequestBuilders.get("/admin/Dashboard"))
                .andExpect(view().name("redirect:/admin/login"));
    }
    @Test
    public void TestAdminLog() throws Exception{
        this.mockMvc = MockMvcBuilders.standaloneSetup(adminController).build();

        String username = "admin";
        String password = "admin";

        User user = new User(1,"admin","email@address.com","admin","ROLE_ADMIN", "123 address");
        when(userService.checkLogin(username,password)).thenReturn(user);

        mockMvc.perform(MockMvcRequestBuilders.post("/admin/loginvalidate").param("username",username).param("password",password))
                .andExpect(status().isOk())
                .andExpect(view().name("adminHome"))
                .andExpect(model().size(1))
                .andExpect(model().attributeExists("admin"));
    }
    /**********************************************| Categories |***********************************************/
    @Test
    public void TestGetAllCategories() throws Exception {
        this.adminController.setAdminlogcheck(1);
        this.mockMvc = MockMvcBuilders.standaloneSetup(adminController).build();

        Category cat1 = new Category(1,"Fruits");
        Category cat2 = new Category(2,"Vegetables");
        Category cat3 = new Category(3,"Meat");
        Category cat4 = new Category(3,"Fish");
        Category cat5 = new Category(3,"Dairy");

        List<Category> categoryList = new ArrayList<>(Arrays.asList(cat1,cat2,cat3,cat4,cat5));
        when(categoryService.getCategories()).thenReturn(categoryList);

        mockMvc.perform(MockMvcRequestBuilders.get("/admin/category"))
                .andExpect(status().isOk())
                .andExpect(view().name("categories"))
                .andExpect(model().size(1))
                .andExpect(model().attributeExists("categories"));
    }
    @Test
    public void TestAddCategory() throws Exception {
        this.adminController.setAdminlogcheck(1);
        this.mockMvc = MockMvcBuilders.standaloneSetup(adminController).build();

        String category_name = "Bakeryyyy";

        mockMvc.perform(MockMvcRequestBuilders.post("/admin/category").param("categoryname",category_name))
                .andExpect(redirectedUrl("category"));
    }
    @Test
    public void TestRemoveCategory() throws Exception {
        this.adminController.setAdminlogcheck(1);
        this.mockMvc = MockMvcBuilders.standaloneSetup(adminController).build();

        mockMvc.perform(MockMvcRequestBuilders.get("/admin/categories/delete/").param("id", String.valueOf(2)))
                .andExpect(redirectedUrl("/admin/category"));
    }
    @Test
    public void TestUpdateCategory() throws Exception {
        this.adminController.setAdminlogcheck(1);
        this.mockMvc = MockMvcBuilders.standaloneSetup(adminController).build();

        mockMvc.perform(MockMvcRequestBuilders.get("/admin/categories/update")
                        .param("categoryid", String.valueOf(2))
                        .param("categoryname", "Vegetable"))
                        .andExpect(redirectedUrl("/admin/category"));
    }
    /**********************************************| Products |***********************************************/

    // getproduct
    @Test
    public void TestGetProduct() throws Exception {
        this.adminController.setAdminlogcheck(1);
        this.mockMvc = MockMvcBuilders.standaloneSetup(adminController).build();

        // Case 1 - No products available from the db
        mockMvc.perform(MockMvcRequestBuilders.get("/admin/product"))
                .andExpect(status().isOk())
                .andExpect(view().name("products"))
                .andExpect(model().size(1))
                .andExpect(model().attributeExists("msg"));

        // Case 2 - There is products in the db
        Category cat1 = new Category(1,"Fruits");
        Product product1 = new Product(1,"Peach", "https://upload.wikimedia.org/wikipedia/en/thumb/1/16/Princess_Peach_Stock_Art.png/220px-Princess_Peach_Stock_Art.png", cat1, 1, 1000.00, 60000,"Some description", null, null );
        Product product2 = new Product(2,"Cherry", "https://static.libertyprim.com/files/familles/cerise-large.jpg?1569271737", cat1, 500, 3.50, 2500,"Some description", null, null );
        List<Product> productList = new ArrayList<>(Arrays.asList(product1,product2));
        when(productService.getProducts()).thenReturn(productList);
        mockMvc.perform(MockMvcRequestBuilders.get("/admin/product"))
                .andExpect(status().isOk())
                .andExpect(view().name("products"))
                .andExpect(model().size(1))
                .andExpect(model().attributeExists("products"));
    }

    // addproduct - Get
    // addproduct - Post
    // updateproductinfo - Get
    // updateproduct - Post
    // removeProduct
    // searchProduct

    /**********************************************| Users/Customers |***********************************************/

    // getCustomerDetail
    // addUserProfile
    // removeUser
    // displayUpdateUserInfo - Get
    // updateUserInfo - Post

}