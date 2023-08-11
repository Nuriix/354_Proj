<%@page import="java.sql.*" %>
<%@page import="java.util.*" %>
<%@page import="java.text.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

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
    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"
            integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN"
            crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.11.0/umd/popper.min.js"
            integrity="sha384-b/U6ypiBEHpOf/4+1nzFpr53nxSS+GLCkfwBdFNTxtclqqenISfwAzpKaMNFNmj4"
            crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4"
            crossorigin="anonymous"></script>
    <title>Document</title>

</head>
<body class="bg-image"
      style="background-image: url('https://www.geneltransport.com.tr/wp-content/uploads/2021/06/perishable-small.png');
             background-repeat: no-repeat; background-size: 100%;">


<nav class="navbar navbar-expand-lg bg-body-tertiary text-bg-success" id="navbarSupportedContent">
    <div class="container-fluid ">
        <a class="navbar-brand " href="/home/${user.id}">My Store</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNavAltMarkup"
                aria-controls="navbarNavAltMarkup" aria-expanded="false" aria-label="Toggle navigation">
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
                <a class="nav-link ml-1" th:href="@{/}" href="/carts/${user.id}"><i
                        class="fas fa-shopping-cart fa-flip-horizontal"></i></a>

            </div>

        </div>
</nav>
<br>
<div class="row m-3">
    <div class="shadow card col text-bg-success ">
        <div class="card-header row">
            <i class="align-self-center col far fa-user fa-lg "></i>
            <div class="col-8 align-middle">
                <span>Hi ${user.username}</span>
            </div>
        </div>
        <div class="card-body">
            <div class="d-flex flex-column bd-highlight mb-3">
                <a href="" class="  btn btn-success">Change Password</a>
                <a href="/paymentMethod/${user.id}" class="   btn btn-success">Payment Methods</a>
                <hr>
                <a href="" class="btn btn-success">My Coupons</a>
                <a href="/user/deals/${user.id}" class="btn btn-success">Best Deals of the Week</a>

                <hr>
                <a href="/user/products/${user.id}" class="btn btn-success">MyStore Food Items</a>
                <a href="/carts/${user.id}" class="btn btn-success">Custom Cart</a>
                <a href="" class="btn btn-success">My Orders</a>
                <hr>
                <a href="" class="btn btn-success">Customer Support</a>
                <hr>
                <a class="  btn btn-success " href="/">Logout<i class="fas fa-sign-out-alt text-light p-1"></i></a>

            </div>
        </div>
    </div>

    <div class="col-7 ">
        <div class="row ">
            <c:forEach var="product" items="${products}">
                <div class="col-md-3 ">
                    <div class="bg-success text-light bg-opacity-75  card border border-success mb-4">
                        <img class="card-img-top" src="${product.image}" alt="Product 1">
                        <div class="card-body">
                            <b><h4 class="card-title">${product.name}</h4></b>
                            <h5 class="card-text">Category: ${product.category.name}</h5>
                            <h5 class="card-text">Price: ${product.price}</h5>
                            <p class="card-text">Description: ${product.description}</p>
                            <a href="/carts/add/${user.id}/${product.id}" class="btn btn-success border border-light">Add to Cart</a>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>
    <div class="col">
        <div class="d-flex flex-column fw-bold text-end p-3">
            <p class="fs-1 text-success">Welcome Back, ${user.username}</p>
            <p>Shop your products at My Store</p>
        </div>

    </div>
</div>


</body>
</html>
