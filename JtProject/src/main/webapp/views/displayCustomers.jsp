<%@page import="java.sql.*" %>
<%@page import="java.util.*" %>
<%@page import="java.text.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!doctype html>
<html lang="en" xmlns:th="http://www.thymeleaf.org">
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
<body class="bg-image"
      style="background-image: url('https://www.geneltransport.com.tr/wp-content/uploads/2021/06/perishable-small.png');
             background-repeat: no-repeat; background-size: 100%;">

<nav class="navbar navbar-expand-lg bg-body-tertiary text-bg-success" id="navbarSupportedContent">
    <div class="container-fluid ">
        <a class="navbar-brand " href="/admin/Dashboard">My Store</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNavAltMarkup"
                aria-controls="navbarNavAltMarkup" aria-expanded="false" aria-label="Toggle navigation">
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
<div class="container">
    <div class="row ">
        <div class="h-50 shadow-lg card col text-bg-success ">
            <div class="card-header row">
                <i class="align-self-center col far fa-user fa-lg "></i>
                <div class="col-8">
                    <span>Hi admin!</span>
                </div>
            </div>
            <div class="card-body">
                <div class="d-flex flex-column bd-highlight mb-3 ">
                    <a href="/admin/product" class="row card-link btn btn-success">Products</a>
                    <a href="/admin/category" class="row  btn btn-success">Category</a>
                    <a href="/admin/customers" class="row btn btn-success">Customer</a>
                </div>
            </div>
        </div>
        <div class="col-10">
            <div class="d-inline-flex justify-content-start">
                <h1 class="mb-2 fw-bold text-success">Customer</h1>
            </div>
            <div class="d-flex justify-content-end">

                <!-- Button trigger modal -->
                <button type="button" class="btn btn-outline-success m-2 align-self-center"
                        data-bs-toggle="modal" data-bs-target="#exampleModalCenter"><i class="fas fa-plus"></i> Add User
                </button>

                <!-- Modal -->
                <div class="modal text-success fade" id="exampleModalCenter" tabindex="-1" role="dialog"
                     aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
                    <div class="modal-dialog modal-dialog-centered" role="document">
                        <div class="modal-content bg-light border border-success">
                            <form action="/admin/customers/add/" method="POST">
                                <div class="modal-header">
                                    <h5 class="text-success mb-2 fw-bold modal-title" id="exampleModalLongTitle">Add New
                                        User</h5>
                                    <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                                        <span aria-hidden="true">&times;</span>
                                    </button>
                                </div>
                                <div class="modal-body  text-left">
                                    <div class="form-group ">
                                        <label for="username">Username</label>
                                        <input class="form-control border border-success" type="text" name="username"
                                               id="username" required="required" placeholder="Username">
                                    </div>
                                    <div class="form-group">
                                        <label for="password">Password</label>
                                        <input class="form-control" type="password" name="password" id="password"
                                               required="required" placeholder="Password">
                                    </div>
                                    <div class="form-group">
                                        <label for="email">Email</label>
                                        <input class="form-control border border-success" type="text" name="email"
                                               id="email" required="required" placeholder="email@address.here">
                                    </div>
                                    <div class="form-group">
                                        <label for="address">Address</label>
                                        <input class="form-control border border-success" type="text" name="address"
                                               id="address" required="required" placeholder="123 somestreet">
                                    </div>
                                    <div class="form-group">
                                        <label for="role">Role</label>
                                        <select class="form-control border border-success"
                                                class="form-control border border-warning" name="role"
                                                required="required">
                                            <option disabled selected value="0">Select a Role</option>
                                            <option value="ROLE_ADMIN">Admin</option>
                                            <option value="ROLE_NORMAL">Customer</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close
                                    </button>
                                    <input type="submit" value="Save Changes" class="btn btn-success">
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
                <br>
            </div>
            <br>
            <table class="shadow table table-success rounded">
                <tr>
                    <th scope="col">Customer Username</th>
                    <th scope="col">Email</th>
                    <th scope="col">Address</th>
                    <th scope="col">Role</th>
                    <th scope="col">Update</th>
                    <th scope="col">Delete</th>
                </tr>
                <tbody>
                <c:forEach var="customer" items="${customers}">
                    <tr>
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
                            <form action="/admin/customers/update/" method="GET">
                                <input type="hidden" name="id" value="${customer.id}">
                                <button type="submit" class="btn btn-warning"><i class="far fa-edit"></i></button>
                            </form>
                        </td>
                        <td>
                            <form action="/admin/customers/delete/" method="GET">
                                <input type="hidden" name="id" value="${customer.id}">
                                <button type="submit" value="Delete" class="btn btn-danger rounded"><i
                                        class="fas fa-trash-alt"></i></button>
                            </form>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>
<script src="https://code.jquery.com/jquery-3.4.1.slim.min.js"
        integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n"
        crossorigin="anonymous"></script>
<script
        src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"
        integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo"
        crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4"
        crossorigin="anonymous"></script>

</body>
</html>