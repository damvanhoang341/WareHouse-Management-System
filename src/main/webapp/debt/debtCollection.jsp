<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Nợ phải thu</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/debt.css" type="text/css">
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f4f4f9;
            margin: 0;
            padding: 0;
        }
        .main_page {
            display: flex;
        }
        .container {
            flex: 1;
            padding: 10px; /* Giảm padding */
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            margin: 10px; /* Giảm margin */
        }
        .form {
            margin-bottom: 10px; /* Giảm margin */
        }
        .form-top, .form-bottom {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 10px;
        }
        .css-btn {
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            padding: 8px 16px; /* Giảm padding */
            margin: 5px;
        }
        .css-btn:hover {
            background-color: #0056b3;
        }
        .css-ip {
            border: 1px solid #ccc;
            border-radius: 4px;
            padding: 8px; /* Giảm padding */
            width: 200px;
        }
        .search-button {
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            height: 30px; /* Giảm chiều cao */
            margin-top: 10px;
            width: 30px; /* Giảm chiều rộng */
        }
        .search-button:hover {
            background-color: #45a049;
        }
        .line {
            font-size: 20px; /* Giảm font-size */
            font-weight: bold;
            margin: 10px 0; /* Giảm margin */
            text-align: center;
            color: #007bff;
        }
        #table-container {
            overflow-x: auto;
        }
        #data {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 10px; /* Giảm margin */
        }
        #data th, #data td {
            border: 1px solid #ddd;
            padding: 5px; /* Giảm padding */
            text-align: left;
            font-size: 14px; /* Giảm font-size */
        }
        #data th {
            background-color: #007bff;
            color: white;
        }
        #data tr:nth-child(even) {
            background-color: #f2f2f2;
        }
        #data tr:hover {
            background-color: #ddd;
        }
        .actions {
            display: flex;
            justify-content: space-between;
        }
        .btn {
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            padding: 8px 16px; /* Giảm padding */
            margin: 5px;
        }
        .btn:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
<div class="main_page">
    <%@include file="../function.jsp" %>
    <div class="container">
        <div class="form">

            <form action="search-debt-collection" method="post">
                <div class="form-bottom">
                    <div>
                        <label >Tên</label>
                        <input name="ten" type="text" placeholder="Nhập tên ..." class="css-ip"/>
                    </div>
                    <div>
                        <label >Số điện thoại</label>
                        <input name="sdt" type="text" placeholder="Nhập số điện thoại" class="css-ip"/>
                    </div>
                    <div>
                        <button type="submit" class="search-button" title="Tìm kiếm"><i class="fa-solid fa-magnifying-glass"></i></button>
                    </div>
                </div>
            </form>
        </div>
        <div class="line">Danh sách khách hàng nợ</div>
        <div id="table-container">
            <table id="data">
                <thead>
                <tr>
                    <th>STT</th>
                    <th>Tên đối tác</th>
                    <th>Địa chỉ</th>
                    <th>Điện thoại</th>
                    <th>Phải trả</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${list}" var="s" varStatus="loop">
                    <tr>
                        <td>${loop.index + 1}</td>
                        <td>${s.name}</td>
                        <td>${s.address}</td>
                        <td>${s.phone}</td>
                        <td>${s.debt}</td>
                    </tr>
                </c:forEach>
                <c:if test="${empty list}">
                    <tr>
                        <td colspan="5" style="text-align: center;">Không có kết quả phù hợp</td>
                    </tr>
                </c:if>
                </tbody>
            </table>
        </div>
    </div>
</div>
<script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>
</body>
</html>
