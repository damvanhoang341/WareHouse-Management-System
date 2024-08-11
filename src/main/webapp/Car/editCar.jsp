<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chỉnh sửa xe</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css" type="text/css">
</head>
<body>
<div class="editcar" style="display: flex">
    <%@include file="/function.jsp"%>
    <div class="container">
        <h1 class="my-4">Chỉnh sửa xe</h1>
        <p style="color: red">${error}</p>
        <form action="/editCar" method="post">
            <input type="hidden" name="carID" value="${car.carId}">
            <div class="mb-3">
                <label for="carName" class="form-label">Tên xe</label>
                <input type="text" class="form-control" id="carName" name="carName" value="${car.carName}" required>
            </div>
            <div class="mb-3">
                <label for="carOrigin" class="form-label">Xuất xứ</label>
                <input type="text" class="form-control" id="carOrigin" name="carOrigin" value="${car.carOrigin}" required>
            </div>
            <div class="mb-3">
                <label for="carDescription" class="form-label">Mô tả</label>
                <textarea class="form-control" id="carDescription" name="carDescription" rows="3" required>${car.carDescription}</textarea>
            </div>

            <button type="submit" class="btn btn-primary">Lưu thay đổi</button>
        </form>
    </div>
</div>
<script src="https://code.jquery.com/jquery-3.6.0.js"
        integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
</body>
</html>
