<%@ page import="java.util.List" %>
<%@ page import="com.example.qlkh.model.User" %>
<%@ page import="com.example.qlkh.model.Suppliers" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Phiếu Trả Nợ</title>
    <style>
    body {
    font-family: Arial, sans-serif;
    background: #f0f0f0; /* Màu nền */
    height: 100%;
    margin: 0;
    padding: 0;
    }
    main {
    display: flex;
    justify-content: center;
    align-items: center;
    height: 100vh;
    background: #c8cfca; /* Màu nền chính */
    }
    .form-container {
    width: 500px;
    padding: 20px;
    border: 1px solid #ccc;
    border-radius: 10px;
    background-color: #ffffff; /* Màu nền form */
    }
    .form-container h2 {
    text-align: center;
    margin-bottom: 20px;
    color: #333; /* Màu chữ */
    }
    .form-group {
    margin-bottom: 15px;
    }
    .form-group label {
    display: block;
    margin-bottom: 5px;
    color: #555; /* Màu chữ label */
    }
    .form-group input,
    .form-group select,
    .form-group textarea {
    width: calc(100% - 20px);
    padding: 8px;
    box-sizing: border-box;
    border: 1px solid #ccc;
    border-radius: 5px;
    }
    .form-group input[type="date"] {
    padding: 6px;
    }
    .form-buttons {
    text-align: center;
    margin-top: 20px;
    }
    .form-buttons button {
    padding: 10px 20px;
    margin: 5px;
    border: none;
    border-radius: 5px;
    cursor: pointer;
    }
    .form-buttons button[type="submit"] {
    background: #007bff; /* Màu nền nút ghi sổ */
    color: #fff;
    }
    .form-buttons button[type="submit"]:hover {
    background: #0056b3; /* Màu hover nút ghi sổ */
    }
    .form-buttons button[type="button"],
    .form-buttons button[type="reset"] {
    background: #dc3545; /* Màu nền nút in phiếu và phiếu mới */
    color: #fff;
    }
    .form-buttons button[type="button"]:hover,
    .form-buttons button[type="reset"]:hover {
    background: #bd2130; /* Màu hover nút in phiếu và phiếu mới */
    }
    .form-buttons a {
    text-decoration: none;
    color: #fff;
    }
    .form-buttons button[type="reset"] {
    margin-left: 10px;
    }
    </style>
</head>
<body>
<div class="func" style="display: flex">
    <%@include file="function.jsp"%>

<main>
    <div class="form-container">
        <h2>Phiếu Trả Nợ</h2>
        <p style="color: red">${error}</p>
        <form action="/replaymentslip" method="post">
            <div class="form-group">
                <label for="partner">Đối tác nhận</label>
                <select id="partner" name="partner" required>
                    <option value="">--Chọn đối tác nhận--</option>
                    <% if (request.getAttribute("listofsuppliers") != null) {
                        List<Suppliers> suppliersList = (List<Suppliers>) request.getAttribute("listofsuppliers");
                        for (Suppliers supplier : suppliersList) { %>
                    <option value="<%= supplier.getSupplierId() %>" data-name="<%= supplier.getSupplierName() %>"><%= supplier.getSupplierName() %></option>
                    <%     }
                    }
                    %>
                </select>
            </div>
            <input type="hidden" id="partnerName" name="partnerName">
            <div class="form-group">
                <label for="amount">Số tiền</label>
                <input type="number" id="amount" name="amount" required>
            </div>
            <div class="form-group">
                <label for="date">Ngày</label>
                <input type="date" id="date" name="date" required>
            </div>
            <div class="form-group">
                <label for="recipient">Nhân viên nhận</label>
                <select id="recipient" name="recipient" required>
                    <option value="">--Chọn Nhân viên nhận--</option>
                    <c:choose>
                        <c:when test="${not empty listofuser}">
                            <c:forEach var="user" items="${listofuser}">
                                <option value="${user.id}" data-name="${user.name}">${user.name}</option>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <!-- Option mặc định khi không có dữ liệu -->
                            <option value="">Không có nhân viên nào</option>
                        </c:otherwise>
                    </c:choose>
                </select>
            </div>
            <input type="hidden" id="recipientName" name="recipientName">
            <div class="form-group">
                <label for="account">Tài khoản</label>
                <select id="account" name="account" required>
                    <option value="Tiền mặt">Tiền mặt</option>
                    <option value="Ngân hàng">Ngân hàng</option>
                    <!-- Thêm các tùy chọn khác nếu cần -->
                </select>
            </div>
            <div class="form-group">
                <label for="description">Diễn giải</label>
                <textarea id="description" name="description" rows="4"></textarea>
            </div>
            <div class="form-buttons">
                <button type="submit">Ghi sổ</button>
                <button type="reset">Phiếu mới</button>
                <button><a href="generanity">Thoát</a></button>
            </div>
        </form>
    </div>

</main>
</div>
<script>
    document.getElementById('recipient').addEventListener('change', function() {
        const selectedOption = this.options[this.selectedIndex];
        document.getElementById('recipientName').value = selectedOption.getAttribute('data-name');
    });

    document.getElementById('partner').addEventListener('change', function() {
        const selectedOption = this.options[this.selectedIndex];
        document.getElementById('partnerName').value = selectedOption.getAttribute('data-name');
    });

    // Xóa thông báo lỗi khi nhấn nút reset
    document.querySelector('button[type="reset"]').addEventListener('click', function() {
        document.querySelector('p[style="color: red"]').textContent = '';
    });
</script>
</body>
</html>
