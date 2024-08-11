<%@ page import="java.util.List" %>
<%@ page import="com.example.qlkh.model.User" %>
<%@ page import="com.example.qlkh.model.Suppliers" %><%--
  Created by IntelliJ IDEA.
  User: damva
  Date: 6/17/2024
  Time: 4:05 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Phiếu Trả Nợ</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: honeydew;
            height: 800px;
        }
        .form-container {
            width: 700px;
            margin: 20px auto 50px;
            padding: 20px;
            border: 1px solid #ccc;
            border-radius: 10px;
            background-color: antiquewhite;
        }
        .form-container h2 {
            text-align: center;
        }
        .form-group {
            margin-bottom: 15px;
        }
        .form-group label {
            display: block;
            margin-bottom: 5px;
        }
        .form-group input,
        .form-group select,
        .form-group textarea {
            width: 100%;
            padding: 8px;
            box-sizing: border-box;
        }
        .form-group input[type="date"] {
            padding: 6px;
        }
        .form-buttons {
            text-align: center;
        }
        .form-buttons button {
            padding: 10px 20px;
            margin: 5px;
        }
    </style>
</head>
<body>
<div class="func" style="display: flex">
    <%@include file="../../function.jsp"%>
    <main style="background: #c8cfca;height: auto">
<div class="form-container">
    <h2>Phiếu Trả Nợ</h2>
    <form action="replaymentslip" method="post">
        <div class="form-group">
            <label for="partner">Đối tác nhận</label>
            <select id="partner" name="partner">
                <option value="">--Chọn đối tác nhận--</option>
                <%
                    if(request.getAttribute("listofsuppliers")!=null){
                        List<Suppliers> suppliersList = (List<Suppliers>)request.getAttribute("listofsuppliers");
                        for(Suppliers supplier :suppliersList){
                %>
                <option value="<%=supplier.getSupplierId()%>"><%=supplier.getSupplierName()%></option>
                <%
                        }
                    }
                %>
            </select>
        </div>
        <div class="form-group">
            <label for="amount">Số tiền</label>
            <input type="number" id="amount" name="amount" required>
        </div>
        <div class="form-group">
            <label for="date">Ngày</label>
            <input type="date" id="date" name="date" required>
        </div>
        <div class="form-group">
            <label for="id">Số phiếu</label>
            <input type="text" id="id" name="phieuId" readonly>
        </div>
        <div class="form-group">
            <label for="recipient">N.v nhận</label>
            <select id="recipient" name="recipient">
                <option value="">--Chọn N.v nhận--</option>
                <%
                    if(request.getAttribute("listofuser")!=null){
                        List<User> userList = (List<User>)request.getAttribute("listofuser");
                        for(User user :userList){
                            %>
                <option value="<%=user.getId()%>"><%=user.getName()%></option>
                <%
                        }
                    }
                %>
            </select>
        </div>
        <div class="form-group">
            <label for="account">Tài khoản</label>
            <select style="width: 40%" id="account" name="account">
                <option value="cash">Tiền mặt</option>
                <option value="bank">Ngân hàng</option>
                <!-- Thêm các tùy chọn khác nếu cần -->
            </select>
            <img src="qr-code.png" alt="QR Code" class="qr-code" id="qr-code" style="display: none; margin-top: 10px">
        </div>
        <div class="form-group">
            <label for="description">Diễn giải</label>
            <textarea id="description" name="description" rows="4"></textarea>
        </div>
        <div class="form-buttons">
            <button type="submit" style="background: blue; color: white; font-family: Arial, sans-serif; font-weight: bold; font-size: 16px; box-sizing: border-box;">Ghi sổ</button>
            <button type="reset" style="background: red; color: white; font-family: Arial, sans-serif; font-weight: bold; font-size: 16px; box-sizing: border-box;">Phiếu mới</button>
            <button  style="background: red; color: white; font-family: Arial, sans-serif; font-weight: bold; font-size: 16px; box-sizing: border-box;">
                <a href="../../function.jsp" style="color: white; text-decoration: none">Thoát</a>
            </button>
        </div>
    </form>
</div>
    </main>
</div>
<script>
    document.getElementById('account').addEventListener('change', function() {
        var qrCode = document.getElementById('qr-code');
        if (this.value === 'bank') {
            qrCode.style.display = 'block';
        } else {
            qrCode.style.display = 'none';
        }
    });
</script>
</body>
</html>
