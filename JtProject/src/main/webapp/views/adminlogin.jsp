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

<br>
<div class=" p-2">
    <div class="col-sm-6"><h1 class="fw-bold text-success">MyStore</h1></div>

    <div class=" bg-light border rounded-3 border-success p-3 col-sm-5  bg-opacity-75 ">
        <h2 class=" mb-2 fw-bold text-success">Admin Login</h2><br>
        <form action="/admin/loginvalidate" method="post">
            <div class="form-group text-success">
                <label for="username">Username :</label>
                <input type="text" name="username" id="username" placeholder="Admin username" required
                       class="border border-success form-control form-control-lg">
            </div>

            <div class="form-group text-success">
                <label for="password">Password :</label>
                <input type="password" class="form-control form-control-lg border border-success	"
                       placeholder="Admin Password" required name="password" id="password">
            </div>
            <br>
            <a class="linkControl text-success" href="/">User Login</a> <br><br>
            <input type="submit" value="Login" class="btn btn-success btn-block">
            <br>
            <h3 style="color:red;">${message }</h3>
            <br>
        </form>
    </div>
</div>
</body>
</html>