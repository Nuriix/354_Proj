package com.jtspringproject.JtSpringProject;


import com.jtspringproject.JtSpringProject.controller.UserController;
import com.jtspringproject.JtSpringProject.models.Cart;
import com.jtspringproject.JtSpringProject.models.User;
import com.jtspringproject.JtSpringProject.services.cartService;
import com.jtspringproject.JtSpringProject.services.productService;

import static org.mockito.ArgumentMatchers.any;


import static org.mockito.Mockito.*;



import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;
import org.springframework.boot.test.context.SpringBootTest;

@SpringBootTest
class UserControllerTests {


    @Mock
    private cartService cartServiceMock;

	@Mock
    private productService productServiceMock;

    @InjectMocks
    private UserController userController;


    @BeforeEach
    void setUp() {
        MockitoAnnotations.openMocks(this);
    }


    @Test
    void testAddToCartValid() {
        int productId = 1;
        int customerId = 2;


    // Mock the user
    User user = new User();
    user.setId(customerId);

    // Mock the cart
    Cart cart = new Cart();
    cart.setId(productId);
    cart.setCustomer(user);

    // Mock the cart service
    when(cartServiceMock.addCart(any(Cart.class))).thenReturn(cart);

    // Call the function
    String result = userController.addToCart(productId);

    // Verify that the cart service's addCart method was called with the correct arguments
    verify(cartServiceMock).addCart(any(Cart.class));

     // Verify that the result of the function is "redirect:/carts"
    assert result.equals("redirect:/carts");
    }

    @Test
void testDeleteCart() {
    int cartId = 1; // Set the cart ID for testing

    // Call the deleteCartDb method with the cartId
    String result = userController.removeCartDb(cartId);

    // Verify that the cartService's deleteCart method was called with the correct cartId
    verify(cartServiceMock).deleteCart(cartId);

    // Verify that the result of the method is "redirect:/carts"
    assert result.equals("redirect:/carts");
}



}
