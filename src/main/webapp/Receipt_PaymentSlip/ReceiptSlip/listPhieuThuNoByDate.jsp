<%@ page import="java.util.List" %>
<%@ page import="com.example.qlkh.model.PhieuThuNo" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
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
    <main style="background: #c8cfca">
        <div style="display: flex; justify-content: space-between">
            <div>
                <h1 style="color: #0048ff; margin-bottom: 20px">Thông tin Phiếu Thu Nợ</h1>
            </div>
            <div class="header-time" style="margin-top: 10px">
                <form action="pthuno" method="post">
                    Date: <input type="date" name="dateCard" value="${dateinlist}" onchange="this.form.submit()"/>
                </form>

            </div>

        </div>
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
            </tr>
            </thead>

            <c:forEach var="phieu" items="${listphieuthunoindate}">
                <tr>
                    <td>${phieu.idPhieu}</td>
                    <td>${phieu.date}</td>
                    <td>${phieu.count}</td>
                    <td>
                        <c:choose>
                            <c:when test="${phieu.phuongThucChuyen}">
                                Tiền Mặt
                            </c:when>
                            <c:otherwise>
                                Ngân Hàng
                            </c:otherwise>
                        </c:choose>
                    </td>
                    <td>${phieu.idNv}</td>
                    <td>${phieu.idDt}</td>
                    <td>${phieu.dienG}</td>
                </tr>
            </c:forEach>
        </table>
    </main>
</div>
</body>
</html>
