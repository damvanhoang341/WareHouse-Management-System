<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"
          integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.3.1/css/all.css"
          integrity="sha384-mzrmE5qonljUremFsqc01SB46JvROS7bZs3IO2EmfFsd15uHvIt+Y8vEf7N7fWAU" crossorigin="anonymous">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/login.css" type="text/css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css" type="text/css">
    <title>Đăng nhập</title>
    <style>
        body {
            background: url('${pageContext.request.contextPath}/image/mana.jpg') no-repeat center center fixed;
            background-size: cover;
            font-family: 'Roboto', sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }
        #logreg-forms {
            width: 100%;
            max-width: 400px;
            padding: 20px;
            background: rgba(255, 255, 255, 0.9);
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            backdrop-filter: blur(10px);
            background-size: cover;
            background-position: center;
        }
        .form-signin {
            width: 100%;
        }
        .form-signin h1 {
            margin-bottom: 20px;
        }
        .form-signin input {
            margin-bottom: 10px;
            border-radius: 5px;
            padding: 10px;
        }
        .btn {
            border-radius: 5px;
            transition: background-color 0.3s, box-shadow 0.3s;
            padding: 10px;
        }
        .btn:hover {
            background-color: #0056b3;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        }
        #forgot_pswd {
            display: block;
            text-align: center;
            margin-top: 10px;
            color: #007bff;
            text-decoration: none;
        }
        #forgot_pswd:hover {
            text-decoration: underline;
        }
        hr {
            margin: 20px 0;
        }
    </style>
</head>
<body>
<div id="logreg-forms">
    <form class="form-signin" action="CheckLoginServlet" method="post">
        <h1 class="h3 mb-3 font-weight-normal text-center">Đăng nhập</h1>

        <input name="user" type="text" id="inputEmail" class="form-control" placeholder="Tên tài khoản (*)" required autofocus>
        <input name="pass" type="password" id="inputPassword" class="form-control" placeholder="Mật khẩu (*)" required>
        <p style="color: red; text-align: center;">${requestScope.error}</p>
        <button class="btn btn-success btn-block" type="submit"><i class="fas fa-sign-in-alt"></i> Đăng nhập</button>
        <a href="SendOTPServlet" id="forgot_pswd">Quên mật khẩu</a>
        <hr>
        <button class="btn btn-primary btn-block" type="button" id="btn-signup" onclick="dangky()"><i class="fas fa-user-plus"></i> Đăng ký tài khoản mới</button>
    </form>
</div>

<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
<script src="${pageContext.request.contextPath}/js/login.js" type="module"></script>
<script>
    function dangky() {
        if (confirm("Không có chức năng đăng ký ?")) {
            window.location.href = "/";
        } else {
            window.location.href = "/";
        }
    }

    function quenmatkhau() {
        if (confirm("Không có chức năng quên mật khẩu ?")) {
            window.location.href = "/";
        } else {
            window.location.href = "/";
        }
    }
</script>
</body>
</html>
