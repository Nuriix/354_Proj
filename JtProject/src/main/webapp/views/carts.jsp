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
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
    <link rel="stylesheet"
          href="https://use.fontawesome.com/releases/v5.7.0/css/all.css"
          integrity="sha384-lZN37f5QGtY3VHgisS14W3ExzMWZxybE1SJSEsQp9S+oqd12jhcu+A56Ebc1zFSJ"
          crossorigin="anonymous">
    <title>Document</title>
</head>
<body>
<section class="wrapper">
    <div class="container-fostrap">
        <nav class="navbar navbar-expand-lg bg-body-tertiary text-bg-success" id="navbarSupportedContent">
            <div class="container-fluid ">
            <a class="navbar-brand " href="/home/${user.id}">My Store</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                    data-bs-target="#navbarNavAltMarkup" aria-controls="navbarNavAltMarkup" aria-expanded="false"
                    aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
            </button>
            <div class="vr"></div>
            <div class="d-flex collapse navbar-collapse " id="navbarNavAltMarkup">
                <div class="navbar-nav ">
                    <a class="nav-link" href="/home/${user.id}">SHOP</a>
                    <a class="nav-link" href="/home/${user.id}">ABOUT US</a>
                    <a class="nav-link" href="/home/${user.id}">CONTACT</a>
                    <a class="nav-link text-bg-success" href="/user/profileDisplay/${user.id}">MY ACCOUNT</a>
                </div>
            </div>
            <div class="d-flex collapse navbar-collapse  flex-row-reverse" id="navbarNavAltMarkup">
                <div class="navbar-nav ">
                    <a class="nav-link mr-1" th:href="@{/}" href="#"><i class="fas fa-search"></i></a>
                    <div class="vr"></div>
                    <a class="nav-link ml-1" th:href="@{/}" href="/carts/${user.id}"><i class="fas fa-shopping-cart fa-flip-horizontal"></i></a>
                </div>
            </div>
        </nav>
        <br>
        <div class="container-fluid">
            <c:choose>
                <c:when test="${empty cartList}">
                    <div class="d-flex justify-content-between">
                        <h3 class="m-2 fw-bold text-success">My Custom Cart</h3>
                    </div>
                    <br />
                    <div class="position-absolute top-50 start-50 translate-middle">
                        <p class="fs-3">You currently do not have any carts.</p>
                        </br>
                        <div  class="text-center justify-content-center">
                            <a class="btn btn-light" href="/user/products/${user.id}">
                                 Add items to create your cart?
                            <a/><p></p>
                            <p>OR</p>
                            <a class="btn btn-light" href="/user/carts/new/${user.id}">
                                 Initialize an empty cart?
                            <a/>
                        </div>
                    </div>
                </c:when>
            <c:otherwise>
                <div class="d-flex justify-content-between">
                    <h3 class="m-2 fw-bold text-success">My Custom Cart</h3>
                </div>
                <div class="d-flex justify-content-between">
                    <a class="btn btn-primary " href="/user/carts/new/${user.id}">Create an Empty Cart</a><br>
                    <a class="btn btn-dark " href="/carts/removeAll/${user.id}">Empty Cart</a>
                </div>
                <br>
                <div class="d-flex justify-content-start">
                <div class="btn-group">
                    <c:forEach var="ucart" items="${cartList}">
                        <c:choose>
                            <c:when test="${ucart.isSelected eq true}">
                                <a href="/carts/selection/${user.id}/${ucart.id}" class="text-white text-decoration-none">
                                <div class="card align-middle text-white bg-success mb-2" style="width: 18rem;" aria-current="page">
                                  <div class="card-body ">
                                    <h5 class="card-title">Cart #${ucart.id}</h5>
                                    <h6 class="card-subtitle mb-2  text-white ">Number of articles: ${ucart.products.size()}</h6>
                                    <p class="card-text">Some quick example text to build on the card title and make up the bulk of the card's content.</p>
                                    <a href="/carts/delete/${user.id}/${ucart.id}">
                                        Delete
                                    </a>
                                  </div>
                                </a>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="card " style="width: 18rem;">
                                <a href="/carts/selection/${user.id}/${ucart.id}" class="text-decoration-none">
                                  <div class="card-body">
                                    <h5 class="card-title text-success">Cart #${ucart.id}</h5>
                                    <h6 class="card-subtitle mb-2 text-muted">Number of articles: ${ucart.products.size()}</h6>
                                    <p class="card-text text-dark">Some quick example text to build on the card title and make up the bulk of the card's content.</p>
                                    <a href="/carts/delete/${user.id}/${ucart.id}">
                                        Delete
                                    </a>
                                  </div>
                                  </a>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>
                </div>
                </div>
                <br>
                <c:choose>
                    <c:when test="${empty products}">
                        <div class="position-absolute bottom-10 start-50 translate-middle-x">
                            <p class="fs-3">You currently do not have any articles in your cart.</p>
                            </br>
                            <div  class="text-center justify-content-center">
                                <a class="btn btn-light" href="/user/products/${user.id}">
                                     Add items to create your cart?
                                <a/><p></p>
                                <p>OR</p>
                                <a class="btn btn-light" href="/user/carts/new/${user.id}">
                                     Initialize an empty cart?
                                <a/>
                            </div>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <table class="shadow table table-success rounded">
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
                                               onchange="updatePrice(${product.id})"/>
                                    </td>
                                    <td>
                                        $<span id="price_${product.id}" data-price="${product.price}">
                                            <fmt:formatNumber value="${product.price}" type="number" minFractionDigits="2" maxFractionDigits="2"/>
                                         </span>
                                    </td>
                                    <td>${product.weight}</td>
                                    <td>${product.description}</td>
                                    <td>
                                        <form action="/carts/remove/${user.id}/${product.id}" method="get">
                                            <input type="hidden" name="id" value="${product.id}"/>
                                            <input type="submit" value="Delete" class="btn btn-danger"/>
                                        </form>
                                    </td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                        <br />
                        <div class="row my-5">
                            <div class="col-lg-8 col-sm-12"></div>
                                <div class="col-lg-4 col-sm-12">
                                    <div class="container bg-light border rounded-3 border-success p-3 order-box">
                                        <h3>Order summary</h3>
                                        <hr>
                                        <div class="d-flex">
                                            <h4>Subtotal</h4>
                                            <div class="ml-auto font-weight-bold">
                                                <!-- Add a dollar sign before the subtotal using JSTL -->
                                                <span id="subtotal">
                                                    <fmt:formatNumber value="${subtotal}" type="number" minFractionDigits="2" maxFractionDigits="2"/>
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
                                                    <fmt:formatNumber value="${taxAmount}" type="number" minFractionDigits="2" maxFractionDigits="2"/>
                                                </span>
                                            </div>
                                        </div>
                                        <div class="d-flex">
                                            <h5>Grand Total</h5>
                                            <div class="ml-auto font-weight-bold">
                                                <!-- Calculate and display the grand total with a dollar sign -->
                                                <span id="grandTotal">
                                                    <fmt:formatNumber value="${subtotal + taxAmount}" type="number" minFractionDigits="2" maxFractionDigits="2"/>
                                                </span>
                                            </div>
                                        </div>
                                        <hr>
                                        <form action="/payment/${user.id}">
                                            <input type="submit" value="Checkout" class="ml-auto btn hvr-hover; btn btn-success"/>
                                        </form>
                                        <a class="btn btn-success mt-1" href="/user/products/${user.id}">Add Product</a>
                                    </div>
                                </div>
                                <div>
                                </div>
                            </div>
                        </div>
                        </c:otherwise>
                    </c:choose>
                    <br>
            </c:otherwise>
            </c:choose>
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
<script src="https://code.jquery.com/jquery-3.4.1.slim.min.js"
        integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n"
        crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"
        integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo"
        crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4"
        crossorigin="anonymous"></script>
</body>
</html>