<%@ page import="java.util.List" %>
<%@ page import="com.example.qlkh.model.User" %>
<%@ page import="com.example.qlkh.model.Customers" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Phiếu Thu Nợ</title>
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
    <main style="background: #f8f9fa">
        <div class="form-container">
            <h2>Phiếu Thu Nợ</h2>
            <form action="receiptslip" method="post">
                <div class="form-group">
                    <label for="id">Số phiếu</label>
                    <input type="text" id="id" name="phieuId" readonly>
                </div>
                <div class="form-group">
                    <label for="date">Ngày</label>
                    <input type="date" id="date" name="date" required>
                </div>
                <div class="form-group">
                    <label for="amount">Số tiền</label>
                    <input type="number" id="amount" name="amount" value="${amountmoney}">
                </div>
                <div class="form-group">
                    <div>
                        <label for="account">Phương thức thanh toán</label>
                        <select style="width: 40%" id="account" name="account">
                            <option value="cash">Tiền mặt</option>
                            <option value="bank">Ngân hàng</option>
                        </select>
                    </div>
                    <div>
                        <img src="qr-code.png" alt="QR Code" class="qr-code" id="qr-code" style="display: none; margin-top: 10px">
                    </div>
                </div>
                <div class="form-group">
                    <label for="recipient">N.v nhận</label>
                    <select id="recipient" name="recipient">
                        <option value="">--Chọn N.v nhận--</option>
                        <%
                            if (request.getAttribute("listusers") != null) {
                                List<User> list = (List<User>) request.getAttribute("listusers");
                                for (User user : list) {
                        %>
                        <option value="<%=user.getId() %>"><%= user.getName() %></option>
                        <%
                                }
                            }
                        %>
                    </select>
                </div>
                <div class="form-group">
                    <label for="partner">Đối tác nhận</label>
                    <select id="partner" name="partner">
                        <option value="">--Chọn đối tác nhận--</option>
                        <%
                            if (request.getAttribute("CustomersList") != null) {
                                List<Customers> list = (List<Customers>) request.getAttribute("CustomersList");
                                for (Customers customers : list) {
                        %>
                        <option value="<%= customers.getCustomerId() %>"><%= customers.getCustomerName() %></option>
                        <%
                                }
                            }
                        %>
                    </select>
                </div>
                <div class="form-group">
                    <label for="description">Diễn giải</label>
                    <textarea id="description" name="description" rows="4"></textarea>
                </div>
                <div class="form-buttons">
                    <button type="submit" style="width: 125px; background: red; color: white; font-family: Arial, sans-serif; font-weight: bold; font-size: 16px; box-sizing: border-box;"> Submit</button>

                    <button type="reset" style="width: 125px; background: red; color: white; font-family: Arial, sans-serif; font-weight: bold; font-size: 16px; box-sizing: border-box;">Phiếu mới</button>
                    <button type="button" style="width: 125px; background: red; color: white; font-family: Arial, sans-serif; font-weight: bold; font-size: 16px; box-sizing: border-box;" onclick="window.location.href='function.jsp'">
                        Thoát
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
