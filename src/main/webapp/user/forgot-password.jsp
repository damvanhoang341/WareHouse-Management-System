<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Quên mật khẩu</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/password.css">
</head>
<body>
<div id="logreg-forms">
    <form class="form-signin" action="SendOTPServlet" method="post">
        <h1 class="h3 mb-3 font-weight-normal" style="text-align: center">Quên mật khẩu</h1>
        <p style="color: red">${requestScope.error1}</p>
        <label for="email">Email:</label>
        <input type="email" id="email" name="email" class="form-control" placeholder="Email" required>
        <button class="btn btn-success btn-block" type="submit"><i class="fas fa-envelope"></i> Gửi mã OTP</button>
        <a href="index.jsp" id="cancel_reset">Quay lại đăng nhập</a>
    </form>
</div>
</body>
</html>
