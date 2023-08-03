<%@page import="java.sql.*" %>
<%@page import="java.util.*" %>
<%@page import="java.text.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!doctype html>
<html lang="en"
      xmlns:th="http://www.thymeleaf.org"
      xmlns:sec="http://www.thymeleaf.org/thymeleaf-extras-springsecurity3">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport"
            content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
        <meta http-equiv="X-UA-Compatible" content="ie=edge">
        <link rel="stylesheet"
            href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css"
            integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh"
            crossorigin="anonymous">
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.0/css/all.css"
            integrity="sha384-lZN37f5QGtY3VHgisS14W3ExzMWZxybE1SJSEsQp9S+oqd12jhcu+A56Ebc1zFSJ"
            crossorigin="anonymous">
        <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"
            integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN"
            crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.11.0/umd/popper.min.js"
            integrity="sha384-b/U6ypiBEHpOf/4+1nzFpr53nxSS+GLCkfwBdFNTxtclqqenISfwAzpKaMNFNmj4"
            crossorigin="anonymous"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/js/bootstrap.min.js"
            integrity="sha384-h0AbiXch4ZDo7tp9hKZ4TsHbi047NrKGLO3SEJAg45jXxnGIfYzk4Si90RDIqNm1"
            crossorigin="anonymous"></script>
        <title>Document</title>
    </head>
    <body>
        <section class="wrapper">
            <div class="container-fostrap">
                <nav class="navbar navbar-expand-lg navbar-light bg-light">
                    <div class="container-fluid">
                        <a class="navbar-brand" href="#">
                            <img th:src="@{/images/logo.png}" src="../static/images/logo.png" width="auto" height="40" class="d-inline-block align-top" alt="" />
                        </a>
                        <button class="navbar-toggler" type="button" data-toggle="collapse"
                            data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent"
                            aria-expanded="false" aria-label="Toggle navigation">
                            <span class="navbar-toggler-icon"></span>
                        </button>
                        <div class="collapse navbar-collapse" id="navbarSupportedContent">
                            <ul class="navbar-nav mr-auto"></ul>
                            <ul class="navbar-nav">
                                <li class="nav-item active"><a class="nav-link" href="/home/${user.id}" >Home Page</a></li>
                                <li class="nav-item active"><a class="nav-link" href="/carts/${user.id}">CART</a></li>
                                <li class="nav-item active"><a class="nav-link" href="/user/profileDisplay/${user.id}">Profile</a></li>
                                <li class="nav-item active"><a class="nav-link" sec:authorize="isAuthenticated()" href="/">Logout</a></li>
                            </ul>
                        </div>
                    </div>
                </nav>
                <div class="container-fluid">
                    <table style="width: 100%;">
                        <tr>
                            <td align="left"><a class="btn btn-primary" href="/user/products">Add Product</a></td>
                            <td align="right"><a class="btn btn-secondary" href="/carts/empty">Empty Cart</a></td>
                        </tr>
                    </table>
                    <br>
                    <table class="table">
                        <tr>
                            <th scope="col">Product Name</th>
                            <th scope="col">Category</th>
                            <th scope="col">Preview</th>
                            <th scope="col">Quantity</th>
                            <th scope="col">Price</th>
                            <th scope="col">Weight</th>
                            <th scope="col">Description</th>
                            <th scope="col">Delete</th>
                        </tr>
                        <tbody>
                            <c:forEach var="product" items="${products}">
                                <tr>
                                    <td>${product.name}</td>
                                    <td>${product.category.name}</td>
                                    <td><img src="${product.image}" height="100px" width="100px"></td>
                                    <td>
                                        <input type="number" id="quantity_${product.id}" min="1"
                                            value="${product.quantity}"
                                            onchange="updatePrice(${product.id})" />
                                    </td>
                                    <td>
                                        $<span id="price_${product.id}" data-price="${product.price}">
                                            <fmt:formatNumber value="${product.price}" type="number" minFractionDigits="2" maxFractionDigits="2" />
                                        </span>
                                    </td>
                                    <td>${product.weight}</td>
                                    <td>${product.description}</td>
                                    <td>
                                        <form action="carts/delete" method="get">
                                            <input type="hidden" name="id" value="${product.id}" />
                                            <input type="submit" value="Delete" class="btn btn-danger" />
                                        </form>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                    <div class="row my-5">
                        <div class="col-lg-8 col-sm-12"></div>
                        <div class="col-lg-4 col-sm-12">
                            <div class="order-box">
                                <h3>Order summary</h3>
                                <hr>
                                <div class="d-flex">
                                    <h4>Subtotal</h4>
                                    <div class="ml-auto font-weight-bold">
                                        <!-- Add a dollar sign before the subtotal using JSTL -->
                                        <span id="subtotal">
                                            <fmt:formatNumber value="${subtotal}" type="number" minFractionDigits="2" maxFractionDigits="2" />
                                        </span>
                                    </div>
                                </div>
                                <div class="d-flex">
                                    <h4>Discount</h4>
                                    <div class="ml-auto font-weight-bold" id="discount">
                                        <!-- Discount amount will be dynamically updated by the JavaScript -->
                                    </div>
                                </div>
                                <div class="d-flex">
                                    <h4>Tax (Rate: 9.975%)</h4>
                                    <div class="ml-auto font-weight-bold">
                                        <!-- Add a dollar sign before the tax amount using JSTL -->
                                        <span id="tax">
                                            <fmt:formatNumber value="${taxAmount}" type="number"
                                                minFractionDigits="2" maxFractionDigits="2" />
                                        </span>
                                    </div>
                                </div>
                                <div class="d-flex">
                                    <h5>Grand Total</h5>
                                    <div class="ml-auto font-weight-bold">
                                        <!-- Calculate and display the grand total with a dollar sign -->
                                        <span id="grandTotal">
                                            <fmt:formatNumber value="${subtotal + taxAmount}"
                                                type="number" minFractionDigits="2"
                                                maxFractionDigits="2" />
                                        </span>
                                    </div>
                                </div>
                                <hr>
                                <form action="/payment">
                                    <input type="submit" value="Checkout" class="ml-auto btn hvr-hover; btn btn-success" />
                                </form>
                            </div>
                        </div>
                        <div>
                        </div>
                    </div>
                </div>
            </div>
            <script>
                function updatePrice(productId) {
                    const quantityInput = document.getElementById('quantity_' + productId);
                    const priceElement = document.getElementById('price_' + productId);
                    const productPrice = parseFloat(priceElement.getAttribute('data-price'));

                    // Get the new quantity value, or default to 1 if not a valid number
                    const newQuantity = parseInt(quantityInput.value, 10) || 1;

                    const newPrice = productPrice * newQuantity;

                    // Update the price display
                    priceElement.innerText = ' ' + newPrice.toFixed(2);

                    // Update the order summary
                    updateOrderSummary();
                }

                function updateOrderSummary() {
                    const taxRate = 0.09975;
                    let subtotal = 0;

                    // Calculate the updated subtotal by summing all product prices
                    const priceElements = document.querySelectorAll('[id^="price_"]');
                    priceElements.forEach(element => {
                        const productPrice = parseFloat(element.innerText.substring(1));
                        subtotal += productPrice;
                    });

                    // Apply the discount if the subtotal reaches a multiple of 100
                    const discountAmount = Math.floor(subtotal / 100) * 5;


                    // Update the discount display in the order summary
                    const discountElement = document.getElementById('discount');
                    discountElement.innerText = '- $' + discountAmount.toFixed(2);

                    // Update the subtotal display in the order summary
                    const subtotalElement = document.getElementById('subtotal');
                    subtotalElement.innerText = '$' + subtotal.toFixed(2);
                    subtotal -= discountAmount;

                    // Calculate and update the tax amount
                    const taxAmount = (subtotal - discountAmount) * taxRate;
                    const taxElement = document.getElementById('tax');
                    taxElement.innerText = '$' + taxAmount.toFixed(2);

                    // Calculate and update the grand total
                    const grandTotal = subtotal + taxAmount - discountAmount;
                    const grandTotalElement = document.getElementById('grandTotal');
                    grandTotalElement.innerText = '$' + grandTotal.toFixed(2);
                }

                // Initialize all quantity inputs to 1
                const quantityInputs = document.querySelectorAll('[id^="quantity_"]');
                quantityInputs.forEach(input => {
                    input.value = 1;
                });

                // Call the updateOrderSummary function whenever quantity inputs are changed
                quantityInputs.forEach(input => {
                    input.addEventListener('change', updateOrderSummary);
                });

                // Update the order summary initially
                updateOrderSummary();
            </script>
        </section>
        <footer>
            <div class="container">
                <p>&copy; 2023 Perishable Shop. All rights reserved
                <script src="https://code.jquery.com/jquery-3.4.1.slim.min.js"
                    integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n"
                    crossorigin="anonymous"></script>
                <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"
                    integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo"
                    crossorigin="anonymous"></script>
                <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"
                    integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6"
                    crossorigin="anonymous"></script>
            </div>
        </footer>
    </body>
</html>