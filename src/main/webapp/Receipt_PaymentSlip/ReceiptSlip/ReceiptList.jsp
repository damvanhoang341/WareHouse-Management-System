<%@ page import="java.util.List" %>
<%@ page import="com.example.qlkh.model.PhieuThuNo" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="com.example.qlkh.model.User" %>
<%--
  Created by IntelliJ IDEA.
  User: damva
  Date: 6/20/2024
  Time: 5:05 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Danh sách phiếu thu nợ</title>
    <style>
        body {
            font-family: Arial, sans-serif;
        }
        .container {
            width: 100%;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            background-color: #fff;
        }
        .header {
            background-color: #FFA726;
            padding: 20px;
            text-align: center;
            border-radius: 10px 10px 0 0;
        }
        .header h1 {
            margin: 0;
            color: white;
        }
        .form-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            width: 100%;
            margin: 20px 0;
        }
        .form-group {
            flex: 1;
            margin: 0 10px;
        }
        .form-group label {
            display: block;
            font-weight: bold;
            margin-bottom: 5px;
        }
        .form-group select, .form-group input {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        .button-group {
            text-align: center;
            margin-top: 20px;
        }
        .button-group button {
            background-color: #4CAF50;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        .button-group button:hover {
            background-color: #45a049;
        }
        table {
            width: 100%;
            border-collapse: collapse;
        }
        th, td {
            border: 1px solid #dddddd;
            text-align: left;
            padding: 8px;
        }
        tr:nth-child(even) {
            background-color: #f2f2f2;
        }
        th {
            background-color: #f2f2f2;
            color: black;
        }
        tr.highlighted {
            background-color: #d1e7fd;
        }
        .addSlip_css{
            background: green;
            margin-top: 20px;
            border-radius: 4px;
            height: 35px;
            width: 90px;
            border: none;
        }
    </style>
</head>
<body>
<div class="func" style="display: flex">
    <%@include file="../../function.jsp"%>
    <main style="background: #f8f9fa">
        <div class="container">
            <div class="header">
                <h1>Danh Sách Phiếu Thu Nợ</h1>
            </div>
            <form>
                <div class="form-row">
                    <form action="receiptlist" method="get">
                        <div class="form-group">
                            <input type="hidden" name="action" value="SearchByTime">
                            <label for="timeOn">Thời gian từ:</label>
                            <input id="timeOn" type="date" name="timeOn" value="${param.timeOn}">
                        </div>
                        <div class="form-group">
                            <label for="todate">Đến:</label>
                            <input id="todate" type="date" name="todate" value="${param.todate}">
                        </div>
                        <div class="form-group">
                            <label for="nameEmployee">Nhân viên:</label>
                            <select id="nameEmployee" name="nameEmployee" onchange="this.form.submit()">
                                <option>---Chọn N.v nhận---</option>
                                <%
                                    if (request.getAttribute("users") != null) {
                                        List<User> list = (List<User>) request.getAttribute("users");
                                        String selectedEmployeeId = request.getParameter("nameEmployee1");
                                        for (User user : list) {
                                %>
                                <option value="<%= user.getId() %>" <%= user.getName().equals(selectedEmployeeId) ? "selected" : "" %>><%= user.getName() %></option>
                                <%
                                        }
                                    }
                                %>
                            </select>
                        </div>
                    </form>

                </div>
            </form>
        </div>
        <button  class="addSlip_css">
            <a href="updatereceipt" style="color:white;text-decoration: none">Thêm Phiếu</a>
        </button>
        <h1>${countlist}</h1>
        <table border="1">
            <thead>
            <tr>
                <th>ID Phiếu</th>
                <th>Ngày</th>
                <th>Thành Giá</th>
                <th>Phương Thức Thanh Toán</th>
                <th>ID Nhân Viên</th>
                <th>ID Đối tác</th>
                <th>Diễn Giải</th>
                <th>Thao Tác</th>
            </tr>
            </thead>
            <tbody>
            <%
                if(request.getAttribute("listofreceipt") == null) {
                    out.println("<h1>Danh sách phiếu thu rỗng hoặc không tồn tại</h1>");
                } else {
                    List<PhieuThuNo> list = (List<PhieuThuNo>) request.getAttribute("listofreceipt");
                    for (PhieuThuNo phieu : list) {
            %>
            <tr>
                <td><%= phieu.getIdPhieu() %></td>
                <td><%= phieu.getDate() %></td>
                <td><%= phieu.getCount() %></td>
                <td><%= phieu.isPhuongThucChuyen() ? "Tiền Mặt" : "Ngân Hàng" %></td>
                <td><%= phieu.getIdNv() %></td>
                <td><%= phieu.getIdDt() %></td>
                <td><%= phieu.getDienG() %></td>
                <td>
                    <form method="GET" action="receiptlist">
                        <input type="hidden" name="action" value="rerceiptById">
                        <input type="hidden" name="idReceipt" value="<%= phieu.getIdPhieu() %>">
                        <button type="submit">In Phiếu</button>
                    </form>
                </td>
            </tr>
            <%
                    }
                }
            %>
            </tbody>
        </table>
    </main>
</div>
</body>
</html>
