<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý nhân viên</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css" type="text/css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/common.css" type="text/css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/partner.css">
</head>
<head>
    <meta charset="UTF-8">
    <title>Thông Tin Đối Tác</title>
</head>
<body>
<div class="func" style="display: flex">
    <%@include file="/function.jsp"%>
    <!--  phần nhét code -->
<div class="container">
    <div class="search-bar">
        <input type="text" id="search" placeholder="Tìm kiếm đối tác..." />
    </div>
    <div class="actions">
        <button id="updateButton">Cập Nhật</button>
        <select id="customerType">
            <option value="all">Tất Cả</option>
            <option value="individual">Khách Lẻ</option>
            <option value="factory">Khách Xưởng</option>
        </select>
        <select id="transactionStatus">
            <option value="active">Còn Giao Dịch</option>
            <option value="inactive">Dừng Giao Dịch</option>
        </select>
    </div>
</div>

<table>
    <thead>
    <tr>
        <th>Tên Đối Tác</th>
        <th>Mã Đối Tác</th>
        <th>Địa Chỉ</th>
        <th>Điện Thoại</th>
        <th>Hành Động</th>
    </tr>
    </thead>
    <tbody>
    <!-- Ví dụ dữ liệu, phần này sẽ được thay thế bằng dữ liệu từ cơ sở dữ liệu -->
    <tr>
        <td>Đối Tác 1</td>
        <td>001</td>
        <td>Hà Nội</td>
        <td>0123456789</td>
        <td>
            <button class="btn"><img src="edit-icon.png" alt="Sửa" /></button>
            <button class="btn"><img src="delete-icon.png" alt="Xóa" /></button>
        </td>
    </tr>
    <tr>
        <td>Đối Tác 2</td>
        <td>002</td>
        <td>Hồ Chí Minh</td>
        <td>0987654321</td>
        <td>
            <button class="btn"><img src="edit-icon.png" alt="Sửa" /></button>
            <button class="btn"><img src="delete-icon.png" alt="Xóa" /></button>
        </td>
    </tr>
    </tbody>
</table>

<script>
    // JavaScript có thể được thêm vào để xử lý tìm kiếm, cập nhật, và lọc
</script>
</div>
</body>
</html>
