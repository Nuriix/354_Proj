<%@page import="java.sql.*" %>
<%@page import="java.util.*" %>
<%@page import="java.text.*" %>
<%@page import="java.io.FileOutputStream" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@page import=" java.io.ObjectOutputStream" %>
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
    <div class="row">
        <div class="h-50 shadow card col text-bg-success ">
            <div class="card-header row">
                <i class="align-self-center col far fa-user fa-lg "></i>
                <div class="col-8 align-middle">
                    <span>Hi admin!</span>
                </div>
            </div>
            <div class="card-body">
                <div  class="d-flex flex-column bd-highlight mb-3">
                    <a href="/admin/product" class="row card-link btn btn-success">Products</a>
                    <a href="/admin/category" class="row  btn btn-success">Category</a>
                    <a href="/admin/customers" class="row btn btn-success">Customer</a>
                </div>
            </div>
        </div> <div class="col-10">
            <div class="d-inline-flex justify-content-start">
                <h1 class="mb-2 fw-bold text-success">Mostly Sold Item Pairs</h1>
            </div>
            <div class="d-flex justify-content-end" role="search">
                <a href="/admin/product" class="btn btn-outline-secondary m-2 align-self-center" type="button">View Products List</a>
            </div>
            <br>

            <table class="table table-borderless table-responsive-lg">
                <tbody >
                    <c:forEach var="pair" items="${productPairs}">
                        <tr>
                            <td>
                                <div class="row row-cols-md-3 ">
                                  <div class="col-md-5">
                                    <div class="card">
                                    <div class="row">
                                        <div class="col-md-4">
                                          <img src="${pair[0].image}" height="100px" width="100px">
                                        </div>
                                        <div class="col-md-8">
                                          <div class="card-body">
                                            <h5 class="card-title">${pair[0].name}</h5>
                                            <p class="card-text">
                                                <small class="text-muted">${pair[0].description}</small>
                                            </p>
                                          </div>
                                        </div>
                                      </div>
                                    </div>
                                  </div>
                                  <div class="col-md-1 d-flex justify-content-center">
                                    <div class="row position-relative top-50">
                                        <span><i class="fas fa-exchange-alt fa-lg"></i></span>
                                    </div>
                                  </div>
                                  <div class="col-md-5">
                                      <div class="card">
                                      <div class="row">
                                          <div class="col-md-4">
                                            <img src="${pair[1].image}" height="100px" width="100px">
                                          </div>
                                          <div class="col-md-8">
                                            <div class="card-body">
                                              <h5 class="card-title">${pair[1].name}</h5>
                                              <p class="card-text">
                                                <small class="text-muted">${pair[1].description}</small>
                                              </p>
                                            </div>
                                          </div>
                                        </div>
                                      </div>
                                    </div>
                                </div>
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
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"
        integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo"
        crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4"
        crossorigin="anonymous"></script>
</body>
</html>