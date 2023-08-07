<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<%@page import="java.sql.*"%>
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
		<a class="navbar-brand " href="/admin/Dashboard">My Store</a>
		<button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNavAltMarkup" aria-controls="navbarNavAltMarkup" aria-expanded="false" aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>
		<div class="vr"></div>
		<div class="d-flex collapse navbar-collapse flex-row-reverse bd-highlight" id="navbarNavAltMarkup">
			<div class="navbar-nav ">
				<a class="nav-link" href="/admin/Dashboard">ADMIN DASHBOARD</a>
				<a class=" nav-link text-bg-success " href="/">Logout<i class="fas fa-sign-out-alt text-light p-1"></i></a>
			</div>
		</div>
	</div>
</nav>
<br>
	<div class=" bg-opacity-75 container bg-light border rounded-3 border-success p-3">
		<h3>Update Existing Product</h3>
		<form action="/admin/products/update/" method="POST">
			<div class="row">
				<div class="col-sm-5">
					<div class="form-group">
						<label for="name">Id</label>
						<input type="number" readonly="readonly" class="form-control border border-success" name="id"  value="${product.id}">
					</div

					<div class="form-group">
						<label for="name">Name</label>
						<input type="text" class="form-control border border-success" required name="name" value="${product.name}" placeholder="Enter name">
					</div>

					<div class="form-group">
						<label for="category">Select Category</label>
						<select class="form-control" class="form-control border border-success" name="categoryid">
                              <option disabled selected value="0" >Select a Category</option>
                              <c:forEach var="category" items="${categories}">
                                   <c:choose>
                                        <c:when test = "${category.id eq product.category.id}">
                                            <option selected value="${category.id}">${category.name}</option>
                                        </c:when>
                                        <c:otherwise>
                                            <option value="${category.id}">${category.name}</option>
                                        </c:otherwise>
                                   </c:choose>
                              </c:forEach>
                         </select>
					</div>

					<div class="form-group">
						<label for="price">Price</label>
						<input type="number" class="form-control border border-success" required name="price" value="${ product.price }" min="1" placeholder="Price">
					</div>
					<div class="form-group">
						<label for="weight">Weight in grams</label>
						<input type="number" class="form-control border border-success" required name="weight" value="${product.weight }" min="1" placeholder="Weight">
					</div>
					<div class="form-group">
						<label for="weight">Available Quantity</label>
						<input type="number" class="form-control border border-success" required name="quantity" value="${ product.quantity }" min="1" placeholder="Quantity">
					</div>
			    </div>

			     <div class="col-sm-5">
			         <div class="form-group">
                        <label for="suggestedProduct">Suggested Product</label>
                        <select class="form-control border border-success" name="suggestedProduct">
                             <option selected value="0">Select a Product</option>
                             <c:forEach var="prod" items="${products}">
                                  <c:choose>
                                     <c:when test = "${product.productSuggestion.id eq prod.id}">
                                         <option selected value="${prod.id}">${prod.name}</option>
                                     </c:when>
                                     <c:otherwise>
                                         <option value="${prod.id}">${prod.name}</option>
                                     </c:otherwise>
                                </c:choose>
                             </c:forEach>
                         </select>
                    </div>
                    <div class="form-group">
                        <label for="description">Product Description</label>
                        <textarea class="form-control border border-success" rows="4" name="description" placeholder="Product Details" >${ product.description }</textarea>
                    </div>
                    <div class="form-group">
                        <label for="Image">Image Link</label>
                        <input type="text" class="form-control border border-success" required name="productImage" value="${product.image}" placeholder="Enter Short Image Link">
                    </div>
                    <div class="form-group">
                        <input type="submit" value="Update Details" class="btn btn-success mt-1">
                    </div>
			    </div>
			</div>
		</form>
	</div>


	<script src="https://code.jquery.com/jquery-3.4.1.slim.min.js"
		integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n"
		crossorigin="anonymous">
	</script>
	<script
		src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"
		integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo"
		crossorigin="anonymous">
	</script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
</body>
</html>