<%@ page import="com.example.qlkh.model.RepaymentSlip" %>
<%@ page import="java.util.List" %><%--
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
    </style>
</head>
<body>
<div class="func" style="display: flex">
    <%@include file="../../function.jsp"%>
    <main style="background: #c8cfca; height: auto">
        <div style="display: flex; justify-content: space-between">
            <div>
                <h1 style="color: #0048ff; margin-bottom: 20px">Thông tin Phiếu Trả Nợ</h1>
            </div>
            <div class="header-time" style="margin-top: 10px">
                <form action="replaymentslip" method="post">
                    Date: <input type="date" name="dateCard" value="${dateCardt}" onchange="this.form.submit()"/>
                </form>

            </div>

        </div>
        <table border="1">
            <tr>
                <th>ID Phiếu</th>
                <th>Ngày</th>
                <th>Thành Giá</th>
                <th>Phương Thức Thanh Toán</th>
                <th>ID Nhân viên</th>
                <th>ID Đối tác</th>
                <th>Lý Do</th>
            </tr>
            <c:forEach var="phieu" items="${listreplaymetndate}">
                <tr>
                    <td>${phieu.idCard}</td>
                    <td>${phieu.date}</td>
                    <td>${phieu.amountMoney}</td>
                    <td>
                        <c:choose>
                            <c:when test="${phieu.methodPay}">
                                Tiền Mặt
                            </c:when>
                            <c:otherwise>
                                Ngân Hàng
                            </c:otherwise>
                        </c:choose>
                    </td>
                    <td>${phieu.employee}</td>
                    <td>${phieu.partner}</td>
                    <td>${phieu.reason}</td>
                </tr>
            </c:forEach>
        </table>
    </main>
</div>
</body>
</html>
