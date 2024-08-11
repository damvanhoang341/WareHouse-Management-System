<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Nợ nhập hàng</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/debt.css" type="text/css">
    <style>
        body {
            background-color: #f4f4f9; /* Màu nền tổng thể */
            font-family: 'Arial', sans-serif; /* Font chữ */
        }

        .main_page {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            background-color: #007bff; /* Màu nền chính */
        }

        .container {
            background-color: #ffffff; /* Màu nền của container */
            border-radius: 10px; /* Bo tròn viền */
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1); /* Đổ bóng */
            padding: 20px;
            width: 80%;
            max-width: 1200px;
        }

        .form {
            margin-bottom: 20px;
        }

        .form-top {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }

        .print-left {
            display: flex;
            gap: 10px;
        }

        .print-right {
            display: flex;
            gap: 10px;
        }

        .css-btn {
            background-color: #007bff; /* Màu nút */
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 5px;
            cursor: pointer;
            font-size: 14px;
        }

        .css-btn:hover {
            background-color: #0056b3; /* Màu nền khi hover */
        }

        .css-ip {
            width: 100%;
            padding: 10px;
            margin-top: 5px;
            border: 1px solid #ddd; /* Viền input */
            border-radius: 4px;
            box-sizing: border-box;
        }

        .search-button {
            background-color: #4CAF50; /* Màu nút tìm kiếm */
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            height: 40px;
            margin-top: 20px;
            width: 45px;
        }

        .search-button:hover {
            background-color: #45a049; /* Màu nền khi hover */
        }

        .line {
            font-size: 20px;
            font-weight: bold;
            margin-top: 20px;
            margin-bottom: 10px;
            color: #007bff; /* Màu chữ */
        }

        #data {
            width: 100%;
            border-collapse: collapse;
            margin-top: 10px;
        }

        #data th,
        #data td {
            border: 1px solid #ddd; /* Viền ô */
            padding: 4px; /* Giảm padding để giảm độ cao của các dòng */
            text-align: center;
        }

        #data th {
            background-color: #f2f2f2; /* Màu nền header */
            color: #007bff; /* Màu chữ header */
        }

        .actions {
            display: flex;
            justify-content: space-between;
            margin-top: 20px;
        }

        .actions .btn {
            background-color: #007bff; /* Màu nút action */
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 5px;
            cursor: pointer;
            font-size: 14px;
        }

        .actions .btn:hover {
            background-color: #0056b3; /* Màu nền khi hover */
        }

        .actions .left .btn {
            margin-right: 10px;
        }

        .actions .right .btn {
            margin-left: 10px;
        }

    </style>
</head>
<div class="nonhap" style="display: flex">
    <%@include file="../function.jsp"%>
    <div class="container">

        <div class="form">
            <form action="search-debt-paid" method="post">
                <div class="form-bottom">
                    <div>
                        <label >Tên</label>
                        <input name="ten" type="text" placeholder="Nhập tên ..." class="css-ip" />
                    </div>
                    <div>
                        <label >Số điện thoại</label>
                        <input name = "sdt" type="text" placeholder="Nhập số điện thoại" class="css-ip" />
                    </div>

                    <div>
                        <label >Mã Số thuế</label>
                        <input name ="mst"
                               type="number"
                               placeholder="Nhập mã số thuế ..."
                               class="css-ip"
                        />
                    </div>
                    <div>
                        <button type="submit" class="search-button" title="Tìm kiếm"><i
                                class="fa-solid fa-magnifying-glass"></i></button>

                    </div>
                </div>
            </form>

        </div>
        <div class="line">Danh sách nợ nhập hàng</div>
        <div id="table-container">
            <table id="data">
                <tr>
                    <th>STT</th>
                    <th>Tên đối tác</th>
                    <th>Mã số thuế</th>
                    <th>Địa chỉ</th>
                    <th>Điện thoại</th>
                    <th>Phải trả</th>
                </tr>
                <tbody>
                <c:forEach items="${suppliers}" var="s" varStatus="loop">
                    <tr>
                        <td style="vertical-align: middle;">${loop.index + 1}</td>
                        <td style="vertical-align: middle;" value="${s.supplierId}" >${s.supplierName}</td>
                        <td style="vertical-align: middle;">${s.tax}</td>
                        <td style="vertical-align: middle;">${s.supplierAddress}</td>
                        <td style="vertical-align: middle;">${s.supplierPhone}</td>
                        <td style="vertical-align: middle;">${s.debt}</td>
                    </tr>
                </c:forEach>
                </tbody>

            </table>
            <p style="color: red">${message}</p>
        </div>
    </div>
</div>
</html>
