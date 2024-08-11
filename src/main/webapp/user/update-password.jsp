<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Đặt lại mật khẩu</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/password.css">
</head>
<body>
<div id="logreg-forms">

        <form class="form-signin" action="ResetPasswordServlet" method="post">
            <h1 class="h3 mb-3 font-weight-normal" style="text-align: center">Đặt lại mật khẩu</h1>
            <p style="color: red">${requestScope.error3}</p>
            <div class="form-group">
                <label for="otp">OTP:</label>
                <input type="text" id="otp" name="otp" style="margin-left: 60px" class="form-control" placeholder="Nhập mã OTP" required>
            </div>
            <div class="form-group">
                <label for="newPassword">Mật khẩu mới:</label>
                <input type="password" id="newPassword" name="newPassword" class="form-control"
                       placeholder="Nhập mật khẩu mới" required>
            </div>
            <div class="form-group">
                <label for="repassword">Nhập lại mật khẩu</label>
                <input type="password" id="repassword" name="repassword" class="form-control"
                       placeholder="Nhập lại mật khẩu" required>
            </div>
            <button class="btn btn-success btn-block" type="submit"><i class="fas fa-key"></i> Đặt lại mật khẩu</button>
        </form>
</div>
</body>
</html>
