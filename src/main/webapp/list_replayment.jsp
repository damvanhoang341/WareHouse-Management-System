<%@ page import="com.example.qlkh.model.RepaymentSlip" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Thông tin Phiếu Trả Nợ</title>
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
            color: white;
            margin-bottom: 20px;
            text-align: center;
        }
        table {
            width: 100%;
        }
        th, td {
            text-align: left;
            padding: 8px;
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
    </style>
</head>
<body>
<div class="func d-flex">
    <%@include file="function.jsp"%>
    <main class="header-main">
        <h1>Thông tin Phiếu Trả Nợ</h1>
        <div class="background-main">
            <div class="form-group">
                <label for="searchInput">Tìm kiếm theo tên đối tác:</label>
                <input type="text" class="form-control" id="searchInput" onkeyup="searchByName()" placeholder="Nhập tên đối tác">
            </div>
            <p style="color: green">${success}</p>

            <table id="phieuThuTable" class="table table-striped table-bordered">
                <thead class="thead-dark">
                <tr>
                    <th>ID Phiếu</th>
                    <th>Ngày</th>
                    <th>Nhân viên</th>
                    <th>Đối tác</th>
                    <th>Thành Giá</th>
                    <th>Phương Thức Thanh Toán</th>
                    <th>Lý Do</th>
                    <th>Thao Tác</th>
                </tr>
                </thead>
                <tbody>
                <% if(request.getAttribute("listofreplayments") != null) {
                    List<RepaymentSlip> list = (List<RepaymentSlip>) request.getAttribute("listofreplayments");
                    for(RepaymentSlip repaymentSlip : list) {
                %>
                <tr>
                    <td><%=repaymentSlip.getCode()%></td>
                    <td><%=repaymentSlip.getDate()%></td>
                    <td><%=repaymentSlip.getEmployeeName()%></td>
                    <td><%=repaymentSlip.getSupplierName()%></td>
                    <td><%=repaymentSlip.getAmountMoney()%></td>
                    <td><%=repaymentSlip.getMethodPay()%></td>
                    <td><%=repaymentSlip.getReason()%></td>
                    <td><button type="button" onclick="printReceipt('<%=repaymentSlip.getCode()%>')">In phiếu</button></td>
                </tr>
                <% } } %>
                </tbody>
            </table>
            <div id="noResultsMessage" class="no-results" style="display: none;">
                Không có kết quả phù hợp
            </div>
        </div>
    </main>
</div>
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script>
    function searchByName() {
        var input, filter, table, tr, td, i, txtValue, found;
        input = document.getElementById("searchInput");
        filter = input.value.toUpperCase();
        table = document.getElementById("phieuThuTable");
        tr = table.getElementsByTagName("tr");
        found = false;

        for (i = 1; i < tr.length; i++) {
            td = tr[i].getElementsByTagName("td")[3]; // Cột thứ 4 là Đối tác
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

        var noResultsMessage = document.getElementById("noResultsMessage");
        if (!found) {
            noResultsMessage.style.display = "block";
        } else {
            noResultsMessage.style.display = "none";
        }
    }

    function printReceipt(receiptId) {
        window.location.href = 'PrintPaid?receiptId=' + receiptId;
    }
</script>
</body>
</html>
