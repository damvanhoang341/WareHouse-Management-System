<%@ page import="com.example.qlkh.model.RepaymentSlip" %>
<%@ page import="java.util.List" %>
<%@ page import="com.example.qlkh.model.User" %><%--
  Created by IntelliJ IDEA.
  User: damva
  Date: 6/22/2024
  Time: 4:35 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Phiếu Trả Nợ</title>
    <style>
        body {
            font-family: Arial, sans-serif;
        }
        .container {
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
            margin-top: 30px;
            margin-bottom: 10px;
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
    <main style="background: #f8f9fa; height: auto">
        <div class="container">
            <div class="header">
                <h1>Danh Sách Phiếu Trả Nợ</h1>
            </div>
            <form>
                <div class="form-row">
                    <form action="replaymentslips" method="get">
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
                                    if (request.getAttribute("listusers") != null) {
                                        List<User> list = (List<User>) request.getAttribute("listusers");
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
            <a href="updaterepayment" style="color:white;text-decoration: none">Thêm Phiếu</a>
        </button>
<table border="1">
    <tr>
        <th>ID Phiếu</th>
        <th>Ngày</th>
        <th>Thành Giá</th>
        <th>Phương Thức Thanh Toán</th>
        <th>ID Nhân viên</th>
        <th>ID Đối tác</th>
        <th>Lý Do</th>
        <th>Thao Tác</th>
    </tr>
    <%
        if(request.getAttribute("listRepaymentSlips") != null) {
            List<RepaymentSlip> list = (List<RepaymentSlip>)request.getAttribute("listRepaymentSlips");
            for(RepaymentSlip repaymentSlip : list){
    %>
    <tr>
        <td><%=repaymentSlip.getIdCard()%></td>
        <td><%=repaymentSlip.getDate()%></td>
        <td><%=repaymentSlip.getAmountMoney()%></td>
        <%
            if(repaymentSlip.isMethodPay()==true){
                %>
        <td>Tiền mặt</td>
        <%
            }else{
                %>
        <td>Ngân hàng</td>
        <%
            }
        %>
        <td><%=repaymentSlip.getEmployee()%></td>
        <td><%=repaymentSlip.getPartner()%></td>
        <td><%=repaymentSlip.getReason()%></td>
        <td>
            <form action="replaymentslips" method="GET">
                <input type="hidden" name="action" value="repaymentslipbyid">
                <input type="hidden" name="id" value="<%=repaymentSlip.getIdCard()%>">
                <button type="submit">In phiếu</button>
            </form>
        </td>
    </tr>
    <%}
    }%>
</table>

    </main>
</div>
</body>
</html>
