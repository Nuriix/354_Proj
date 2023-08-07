<%@page import="java.sql.*"%>
<%@page import="java.util.*"%>
<%@page import="java.text.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!doctype html>
<html lang="en" xmlns:th="http://www.thymeleaf.org">
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">

	<link rel="stylesheet"
		  href="https://use.fontawesome.com/releases/v5.7.0/css/all.css"
		  integrity="sha384-lZN37f5QGtY3VHgisS14W3ExzMWZxybE1SJSEsQp9S+oqd12jhcu+A56Ebc1zFSJ"
		  crossorigin="anonymous">

<title>Document</title>
</head>
<body class="bg-image"
	  style="background-image: url('https://www.geneltransport.com.tr/wp-content/uploads/2021/06/perishable-small.png');
             background-repeat: no-repeat; background-size: 100%;">

<nav class="navbar navbar-expand-lg bg-body-tertiary text-bg-success" id="navbarSupportedContent">
	<div class="container-fluid ">
		<a class="navbar-brand " href="/userloginvalidate#">My Store</a>
		<button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNavAltMarkup" aria-controls="navbarNavAltMarkup" aria-expanded="false" aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>
		<div class="vr"></div>
		<div class="d-flex collapse navbar-collapse " id="navbarNavAltMarkup">
			<div class="navbar-nav ">

				<a class="nav-link" href="/#">SHOP</a>
				<a class="nav-link" href="/#">ABOUT US</a>
				<a class="nav-link" href="#">CONTACT</a>
				<a class="nav-link text-bg-success" href="/user/profileDisplay/${user.id}" >MY ACCOUNT</a>

			</div>
		</div>

		<div class="d-flex collapse navbar-collapse  flex-row-reverse" id="navbarNavAltMarkup">

			<div class="navbar-nav ">
				<a class="nav-link mr-1" th:href="@{/}" href="#"><i class="fas fa-search"></i></a>

				<div class="vr"></div>
				<a class="nav-link ml-1" th:href="@{/}" href="/carts/${user.id}"><i class="fas fa-shopping-cart fa-flip-horizontal"></i></a>

			</div>

		</div> </div>

</nav>
<br>
	<div class="row m-3">
		<div class="shadow card col-2 text-bg-success ">
			<div class="card-header row">
				<i class="align-self-center col far fa-user fa-lg "></i>
				<div class="col-8 align-middle">
					<span>Hi ${user.username}</span>
				</div>
			</div>
			<div class="card-body">
				<div  class="d-flex flex-column bd-highlight mb-3">
					<a href="" class="  btn btn-success">Change Password</a>
					<a href="" class="   btn btn-success">Payment Methods</a>
					<hr>
					<a href="" class="btn btn-success">My Coupons</a>
					<a href="" class="btn btn-success">Best Deals of the Week</a>
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
		<div class="col-7">
			<div class="row">
				<h3 class="m-2 fw-bold text-success">Best Deal of the Week</h3>
<%--				<c:forEach var="product" items="${products}">--%>
					<div class="col-md-3">
						<div class="bg-opacity-75 bg-success text-light card border border-success mb-4">
							<img class="card-img-top" src="https://media.discordapp.net/attachments/815979391883542528/1136481403672989737/Brown_Simple_Cookies_Sale_Flyer.png?width=518&height=671" alt="Product 1">
							<div class="card-body">
								<b> <h4 class="card-title">Best Cookie Deal</h4></b>
								<h5 class="card-text">Category: Sweets</h5>
								<h5 class="card-text">Discount: 60% Off</h5>
								<a href="#" class="border border-light btn btn-success">Add Deal</a>
							</div>
						</div>
					</div>
<%--	</c:forEach>--%>
			</div></div>
		</div>



	<script src="https://code.jquery.com/jquery-3.4.1.slim.min.js"
		integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n"
		crossorigin="anonymous"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"
		integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo"
		crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>

</body>
</html>