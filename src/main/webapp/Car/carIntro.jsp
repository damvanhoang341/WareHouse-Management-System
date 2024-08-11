<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Nhóm xe</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/common.css" type="text/css">
    <style>
        body {
            font-family: 'Roboto', sans-serif;
            background-color: #f7f9fc;
            margin: 0;
            padding: 0;
        }

        .header-main {
            padding: 20px 0;
            text-align: center;
            color: white;
            background-color: #0d6efd;
            margin-bottom: 20px;
        }

        .background-main {
            background-color: #ffffff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        }

        .toolbar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }

        .input-group {
            max-width: 300px;
        }

        .btn-save {
            background-color: #007bff;
            color: #ffffff;
            border: none;
            transition: background-color 0.3s;
        }

        .btn-save:hover {
            background-color: #0056b3;
        }

        .table-function .btn-save-table {
            background-color: #28a745;
            color: #ffffff;
            border: none;
            transition: background-color 0.3s;
        }

        .table-function .btn-save-table:hover {
            background-color: #1e7e34;
        }

        #no-results-message {
            color: red;
            text-align: center;
            margin-top: 10px;
            display: none;
        }
    </style>
</head>

<body>
<div style="display: flex; min-height: 100vh;">
    <%@include file="/function.jsp"%>
    <main style="flex-grow: 1;">
        <div class="header-main">
            <h4 style="font-weight: bold">Danh sách nhóm xe</h4>
            <p style="color: green">${success}</p>
        </div>
        <div class="background-main">
            <div class="toolbar">
                <div id="search" class="input-group">
                    <input id="search-input" type="text" class="form-control shadow-none"
                           placeholder="Tìm theo tên xe">
                    <button type="button" class="input-group-text btn-save" title="Tìm kiếm" id="search-button"><i
                            class="fa-solid fa-magnifying-glass"></i></button>
                </div>
                <div>
                    <button type="button" title="Thêm thủ công" id="btnAdd" class="btn btn-primary btn-save me-2"
                            onclick="location.href='/addCar'">
                        <i class="fa-solid fa-plus"></i> Thêm thủ công
                    </button>
                </div>
            </div>
            <div id="product-data">
                <table class="table table-bordered">
                    <thead class="sticky-top">
                    <tr>
                        <th scope="col">Tên loại xe</th>
                        <th scope="col">Xuất xứ</th>
                        <th scope="col" style="white-space: normal; text-align: center;">Mô tả</th>
                        <th scope="col">Thao tác</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${car}" var="c">
                        <tr>
                            <td>${c.carName}</td>
                            <td>${c.carOrigin}</td>
                            <td style="white-space: normal; text-align: center;">${c.carDescription}</td>
                            <td class="table-function text-center">
                                <form action="/EditCar" method="post">
                                    <button type="button" title="Sửa" class="btn btn-save btn-save-table"
                                            onclick="location.href = 'editCar?cid=${c.carId}'">
                                        <i class="fa-solid fa-pencil"></i>
                                    </button>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty car}">
                        <tr>
                            <td colspan="4" style="text-align: center;">Không có kết quả phù hợp</td>
                        </tr>
                    </c:if>
                    </tbody>
                </table>
                <p id="no-results-message">Không có kết quả phù hợp</p>
            </div>
        </div>
    </main>
</div>

<!-- Bootstrap và các script -->
<script src="https://code.jquery.com/jquery-3.6.0.js"
        integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
<script>
    document.getElementById('search-input').addEventListener('input', function() {
        const searchTerm = this.value.trim().toLowerCase();
        const rows = document.querySelectorAll('#product-data tbody tr');
        let hasResults = false;

        rows.forEach(row => {
            const carName = row.cells[0].innerText.trim().toLowerCase(); // Lấy giá trị từ cột "Tên loại xe"
            if (carName.includes(searchTerm)) {
                row.style.display = ''; // Hiển thị hàng nếu chứa từ khóa tìm kiếm
                hasResults = true;
            } else {
                row.style.display = 'none'; // Ẩn hàng nếu không chứa từ khóa tìm kiếm
            }
        });

        document.getElementById('no-results-message').style.display = hasResults ? 'none' : 'block'; // Hiển thị thông báo nếu không có kết quả
    });
</script>
</body>

</html>
