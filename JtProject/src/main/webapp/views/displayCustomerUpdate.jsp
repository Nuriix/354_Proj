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
	<div class=" container bg-light border rounded-3 border-success p-3">
		<h3 class="mb-2 fw-bold text-success">Update Existing Customer Info</h3>
		<form action="/admin/customers/update/" method="POST">
            <div class="row">
		        <div class="col">
		            <div class="form-group">
                        <label for="customerUsername">Username</label>
                        <input class="border border-success form-control" type="text" readonly="readonly" name ="username" id="username" value="${user.username}">
                    </div>
                    <div class="form-group">
                        <label for="customerEmail">Email</label>
                        <input class="border border-success form-control" type="text" name= "email" id="email" value="${user.email}">
                    </div>
                    <div class="form-group">
                        <label for="customerAddress">Address</label>
                        <input class="border border-success form-control" type="text" name= "address" id="address" value="${user.address}">
                    </div>
                    <div class="form-group">
                        <label for="customerRole">Role</label>
                        <select class="border border-success form-control" class="form-control border border-success" name="role">
                           <option disabled selected value="0" >Select a Role</option>
                           <c:choose>
                                <c:when test = "${user.role == 'ROLE_ADMIN'}">
                                    <option selected value="ROLE_ADMIN">Admin</option>
                                    <option value="ROLE_NORMAL">Customer</option>
                                </c:when>
                                <c:otherwise>
                                    <option value="ROLE_ADMIN">Admin</option>
                                    <option selected value="ROLE_NORMAL">Customer</option>
                                </c:otherwise>
                           </c:choose>
                        </select>
                    </div>
                    <div class="form-group">
                        <input type="hidden" name="id" id="id" value="${user.id}">
                        <input type="submit" value="Update Details" class="m-1 btn btn-success">
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