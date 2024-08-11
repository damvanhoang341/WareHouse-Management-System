<%@ page import="java.util.List" %>
<%@ page import="com.example.qlkh.model.PhieuThuNo" %>
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
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        body {
            background-color: #f4f4f9;
            font-family: 'Arial', sans-serif;
        }
        .header-main {
            background-color: #007bff;
            color: white;
            padding: 15px;
            border-radius: 5px;
            margin-bottom: 20px;
        }
        .background-main {
            background-color: white;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        h1 {
            color: #007bff;
            margin-bottom: 20px;
        }
        table {
            width: 100%;
        }
        th, td {
            text-align: left;
            padding: 8px;
            border: 1px solid #dee2e6;
        }
        tr:nth-child(even) {
            background-color: #f8f9fa;
        }
        th {
            background-color: #007bff;
            color: white;
        }
        tr.highlighted {
            background-color: #d1e7fd;
        }
        .no-results {
            text-align: center;
            color: #ff0000;
            margin-top: 20px;
        }
        .table-responsive {
            overflow-x: auto;
        }
    </style>
    <script>
        function searchByName() {
            var input, filter, table, tr, td, i, txtValue, found;
            input = document.getElementById("searchInput");
            filter = input.value.toUpperCase();
            table = document.getElementById("phieuThuTable");
            tr = table.getElementsByTagName("tr");
            found = false;

            for (i = 1; i < tr.length; i++) {
                td = tr[i].getElementsByTagName("td")[3]; // Cột thứ 4 là Tên khách hàng
                if (td) {
                    txtValue = td.textContent || td.innerText;
                    if (txtValue.toUpperCase().indexOf(filter) > -1) {
                        tr[i].style.display = "";
                        found = true;
                    } else {
                        tr[i].style.display = "none";
                    }
                }
            }

            if (!found) {
                document.getElementById("noResultsMessage").style.display = "block";
            } else {
                document.getElementById("noResultsMessage").style.display = "none";
            }
        }
        function printReceipt(receiptId) {
            window.location.href = 'PrintServlet?receiptId=' + receiptId;
        }
    </script>
</head>
<body>
<div class="func d-flex">
    <%@include file="function.jsp"%>
    <main class="header-main">
        <h1 style="color: white; text-decoration: white; text-align: center" >Thông tin Phiếu Thu Nợ</h1>
        <div class="background-main">
            <div class="form-group">
                <label for="searchInput">Tìm kiếm theo tên khách hàng:</label>
                <input type="text" class="form-control" id="searchInput" onkeyup="searchByName()" placeholder="Nhập tên khách hàng">
            </div>
            <p style="color: green">${success}</p>

            <div class="table-responsive">
                <table id="phieuThuTable" class="table table-striped table-bordered">
                    <thead class="thead-dark">
                    <tr>
                        <th>Mã Phiếu</th>
                        <th>Ngày</th>
                        <th>Người thu</th>
                        <th>Khách hàng</th>
                        <th>Phương Thức Thanh Toán</th>
                        <th>Số tiền</th>
                        <th>Ghi chú</th>
                        <th>Thao tác</th>
                    </tr>
                    </thead>
                    <tbody>
                    <%
                        if(request.getAttribute("lt") != null) {
                            List<PhieuThuNo> list = (List<PhieuThuNo>)request.getAttribute("lt");
                            for(PhieuThuNo phieu : list){
                    %>
                    <tr>
                        <td><%=phieu.getCode()%></td>
                        <td><%=phieu.getDate()%></td>
                        <td><%=phieu.getEmployeesName()%></td>
                        <td><%=phieu.getCustomersName()%></td>
                        <td><%=phieu.getPhuongThucChuyen()%></td>
                        <td><%=phieu.getMoney()%></td>
                        <td><%=phieu.getDes()%></td>
                        <td><button type="button" onclick="printReceipt('<%=phieu.getCode()%>')">In phiếu</button></td>
                    </tr>
                    <%}
                    }%>
                    </tbody>
                </table>
                <div id="noResultsMessage" class="no-results" style="display: none;">
                    Không có kết quả phù hợp
                </div>
            </div>
        </div>
    </main>
</div>
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
