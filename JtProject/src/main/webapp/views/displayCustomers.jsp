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
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css"
	integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh"
	crossorigin="anonymous">

<title>Document</title>
</head>
<body class="bg-light">
	<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
		<div class="container-fluid">
			<a class="navbar-brand" href="#"> <img
				th:src="@{/images/logo.png}" src="../static/images/logo.png"
				width="auto" height="40" class="d-inline-block align-top" alt="" />
			</a>
			<button class="navbar-toggler" type="button" data-toggle="collapse"
				data-target="#navbarSupportedContent"
				aria-controls="navbarSupportedContent" aria-expanded="false"
				aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>

			<div class="collapse navbar-collapse" id="navbarSupportedContent">
				<ul class="navbar-nav mr-auto"></ul>
				<ul class="navbar-nav">
					<li class="nav-item active"><a class="nav-link" href="/admin/Dashboard">Home
							Page</a></li>
					<li class="nav-item active"><a class="nav-link" href="/">Logout</a>
					</li>
				</ul>
			</div>
		</div>
	</nav><br>
	<div class="container-fluid">
	    <!-- Button trigger modal -->
        <button type="button" style="margin: 20px 0" class="btn btn-primary"
            data-toggle="modal" data-target="#exampleModalCenter">Add New User</button>

        <!-- Modal -->
        <div class="modal fade" id="exampleModalCenter" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered" role="document">
                <div class="modal-content">
                    <form action="/admin/customers/add" method="POST">
                        <div class="modal-header">
                            <h5 class="modal-title" id="exampleModalLongTitle">Add New User</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body  text-left">
                           <div class="form-group">
                                <label for="username">Username</label>
                                <input class="form-control" type="text" name ="username" id="username" required="required"  placeholder="Username">
                            </div>
                            <div class="form-group">
                                <label for="password">Password</label>
                                <input class="form-control" type="password" name ="password" id="password" required="required"  placeholder="Password">
                            </div>
                            <div class="form-group">
                                <label for="email">Email</label>
                                <input class="form-control" type="text" name= "email" id="email" required="required"  placeholder="email@address.here">
                            </div>
                            <div class="form-group">
                                <label for="address">Address</label>
                                <input class="form-control" type="text" name= "address" id="address" required="required"  placeholder="123 somestreet">
                            </div>
                            <div class="form-group">
                                <label for="role">Role</label>
                                <select class="form-control" class="form-control border border-warning" name="role" required="required">
                                   <option disabled selected value="0" >Select a Role</option>
                                   <option value="ROLE_ADMIN">Admin</option>
                                   <option value="ROLE_NORMAL">Customer</option>
                                </select>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                            <input type="submit" value="Save Changes" class="btn btn-primary">
                        </div>
                    </form>
                </div>
            </div>
        </div><br>

		<table class="table">
			<tr>
				<th scope="col">Customer Username</th>
				<th scope="col">Email</th>
				<th scope="col">Address</th>
				<th scope="col">Delete</th>
				<th scope="col">Update</th>
			</tr>
			<tbody>
				<c:forEach var="customer" items="${customers}">
				<tr>
                    <td>
                        ${customer.id}
                    </td>
					<td>
						${customer.username}
					</td>
					<td>
					    ${customer.email}
					</td>
					<td>
					    ${customer.address}
				    </td>
				    <td>
                        ${customer.role}
                    </td>
				    <td>
				        <form action="" method="get">
                            <input type="submit" value="Delete" class="btn btn-danger">
                        </form>
				    </td>
				    <td>
				        <form>
                            <!-- Button trigger modal -->
							<button type="button" class="btn btn-warning" data-toggle="modal" data-target="#exampleModalCenter2"
								onclick="">Update
							</button>

							<!-- Modal -->
							<div class="modal fade" id="exampleModalCenter2" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
								<div class="modal-dialog modal-dialog-centered" role="document">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <h5 class="modal-title" id="exampleModalLongTitle">Update Customer Details</h5>
                                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                <span aria-hidden="true">&times;</span>
                                            </button>
                                        </div>
                                        <div class="modal-body text-left">
                                            <div class="form-group">
                                                <label for="customerUsername">Username</label>
                                                <input class="form-control" type="text" readonly="readonly" name ="username" id="username" value="${customer.username}">
                                            </div>
                                            <div class="form-group">
                                                <label for="customerEmail">Email</label>
                                                <input class="form-control" type="text" name= "email" id="email" value="${customer.email}">
                                            </div>
                                            <div class="form-group">
                                                <label for="customerAddress">Address</label>
                                                <input class="form-control" type="text" name= "address" id="address" value="${customer.address}">
                                            </div>
                                            <div class="form-group">
                                                <label for="customerRole">Role</label>
                                                <select class="form-control" class="form-control border border-success" name="role">
                                                   <option disabled selected value="0" >Select a Role</option>
                                                   <c:choose>
                                                        <c:when test = "${customer.role == 'ROLE_ADMIN'}">
                                                            <option selected value="ROLE_ADMIN">Admin</option>
                                                            <option value="ROLE_NORMAL">Customer</option>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <option selected value="ROLE_NORMAL">Customer</option>
                                                            <option value="ROLE_ADMIN">Admin</option>
                                                        </c:otherwise>
                                                   </c:choose>
                                                </select>
                                            </div>
                                        </div>
                                        <div class="modal-footer">
                                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                                            <button type="submit" class="btn btn-primary">Update changes</button>
                                        </div>
                                    </div>
								</div>
							</div>
						</form>
				    </td>
				</tr>
                </c:forEach>
			</tbody>
		</table>
	</div>
	<script src="https://code.jquery.com/jquery-3.4.1.slim.min.js"
		integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n"
		crossorigin="anonymous"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"
		integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo"
		crossorigin="anonymous"></script>
	<script
		src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"
		integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6"
		crossorigin="anonymous"></script>
</body>
</html>