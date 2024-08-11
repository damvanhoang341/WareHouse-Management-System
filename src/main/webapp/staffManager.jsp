<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý nhân viên</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css" type="text/css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/common.css" type="text/css">
    <style>
        .table-function button {
            margin: 0 5px;
        }
        body {
            background-color: #f4f4f9;
            font-family: 'Arial', sans-serif;
        }
        .header-main {
            background-color: lightblue;
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
        /* Additional custom styles can be added here */

        .background-main {
            padding: 20px;
            background-color: #fff; /* White background */
            border: 1px solid #dee2e6; /* Gray border */
            border-radius: 5px;
            margin-top: 20px;
        }
        .btn-save i, .btn-delete i {
            margin-right: 5px;
        }
    </style>
</head>

<body>

<div class="flex-grow-1">
    <div class="abc" style="display: flex">
        <%@include file="/function.jsp"%>
        <!--  phần nhét code -->
        <main>
            <div class="header-main">
                <h4 style="font-weight: bold; align-items: center;">Danh sách nhân viên</h4>
            </div>
            <div class="background-main">
                <p style="color: green">${requestScope.success}</p>
                <div class="toolbar d-flex justify-content-between">
                    <div id="search" class="input-group mb-3">
                        <input id="searchInput" type="text" class="form-control shadow-none" placeholder="Tìm theo tên, số điện thoại hoặc email">
                    </div>
                    <div>
                        <button type="button" title="Thêm" id="btnAdd" class="btn btn-primary btn-save" onclick="location.href = 'CreateUserServlet';">
                            <i class="fa-solid fa-plus"></i> Thêm
                        </button>
                    </div>
                </div>
                <div id="product-data">
                    <table class="table table-borderless">
                        <thead class="sticky-top">
                        <tr>
                            <th scope="col">Tên nhân viên</th>
                            <th scope="col">Số điện thoại</th>
                            <th scope="col">Email</th>
                            <th scope="col">Địa chỉ</th>
                            <th scope="col">Chức vụ</th>
                            <th class="table-function">Thao tác</th>
                        </tr>
                        </thead>
                        <tbody>
                        <tr id="no-results" style="display: none;">
                            <td colspan="6" class="text-center">Không có kết quả phù hợp</td>
                        </tr>
                        <c:forEach items="${data}" var="m">
                            <tr>
                                <td style="vertical-align: middle;" value="${m.getId()}" nameNhanVien="${m.getName()}">${m.getName()}</td>
                                <td style="vertical-align: middle;">${m.getPhone()}</td>
                                <td style="vertical-align: middle;">${m.getEmail()}</td>
                                <td style="vertical-align: middle;">${m.getAddress()}</td>
                                <td style="align-items: center;">
                                    <c:choose>
                                        <c:when test="${m.getRoleId() eq 0}"><span  style="color: red">Cấm</span></c:when>
                                        <c:when test="${m.getRoleId() eq 2}"><span class="badge bg-primary">Quản lý</span></c:when>
                                        <c:when test="${m.getRoleId() eq 3}"><span class="badge bg-info text-dark">Nhân viên</span></c:when>
                                    </c:choose>
                                </td>
                                <td class="table-function text-center">
                                    <button type="button" title="Sửa" class="btn btn-save btn-save-table" onclick="location.href = 'UpdateUserServlet?uid=${m.getId()}'">
                                        <i class="fa-solid fa-pencil"></i> Sửa
                                    </button>
                                    <button type="button" title="Xóa" class="btn btn-delete btn-delete-table" onclick="doDelete(${m.getId()}, '${m.getName()}')">
                                        <i class="fa-solid fa-trash"></i> Xóa
                                    </button>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </main>
    </div>
</div>

<!-- bootstrap -->
<script src="https://code.jquery.com/jquery-3.6.0.js" crossorigin="anonymous"></script>
<script type="module">
    $("#btnAdd").click(function () {
        window.location.href = "CreateUserServlet";
    });
    $(document).on('click', '.btn-delete-table', function () {
        var value = $(this).parent().parent().children().first().attr('value');
        var name = $(this).parent().parent().children().first().attr('nameNhanVien');
        doDelete(value, name);
    });

    function doDelete(id, name) {
        if (confirm("Bạn có muốn xóa nhân viên <" + name + ">")) {
            window.location = "DeleteUserServlet?id=" + id;
        }
    }

    $("#logout-btn").click(function () {
        window.location.href = "/";
    });

    document.getElementById('searchInput').addEventListener('input', function() {
        const searchTerm = this.value.toLowerCase();
        const rows = document.querySelectorAll('#product-data tbody tr');
        let hasResults = false;
        const isEmail = searchTerm.includes('@');
        const isPhone = /^[0-9]+$/.test(searchTerm);

        rows.forEach(function(row) {
            const nameCell = row.querySelector('td[nameNhanVien]');
            const phoneCell = row.querySelector('td:nth-child(2)');
            const emailCell = row.querySelector('td:nth-child(3)');
            if (nameCell) {
                const nameMatches = nameCell.textContent.toLowerCase().includes(searchTerm);
                const phoneMatches = isPhone && phoneCell && phoneCell.textContent.includes(searchTerm);
                const emailMatches = isEmail && emailCell && emailCell.textContent.toLowerCase().includes(searchTerm);

                if (nameMatches || phoneMatches || emailMatches) {
                    row.style.display = '';
                    hasResults = true;
                } else {
                    row.style.display = 'none';
                }
            }
        });

        if (!hasResults) {
            document.getElementById('no-results').style.display = '';
        } else {
            document.getElementById('no-results').style.display = 'none';
        }
    });
</script>

</body>
</html>
