<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chuyển vị trí hàng hóa</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css" type="text/css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/Relocation.css" type="text/css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/common.css" type="text/css">
    <style>
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
        .btn-save {
            background-color: #28a745;
            color: white;
        }
        .btn-save:hover {
            background-color: #218838;
        }
        .btn-secondary {
            background-color: #6c757d;
            color: white;
        }
        .btn-secondary:hover {
            background-color: #5a6268;
        }
        .table-function button {
            margin: 0 5px;
        }
        .modal-header {
            background-color: #007bff;
            color: white;
        }
        .modal-footer .btn-secondary {
            background-color: #6c757d;
        }
        .modal-footer .btn-primary {
            background-color: #28a745;
        }
        .table-container {
            max-height: 500px; /* Adjust this value as needed */
            overflow-y: auto;
        }
        .sticky-top {
            background-color: white;
            z-index: 1;
        }
        .error-message {
            color: red;
            font-size: 20px;
            display: none;
        }
    </style>
</head>

<body>

<div class="flex-grow-1" style="display: flex">
    <%@include file="/function.jsp"%>
    <main>

        <div class="header-main">
            <h2 style="font-weight: bold; text-align: center;">Chuyển vị trí hàng hóa</h2>
        </div>
        <form action="RelocationServlet" method="post" id="relocationForm">
            <input type="hidden" name="selectedData" id="selectedData">
            <div class="background-main">
                <p style="color: green">${requestScope.success}</p>
                <div class="toolbar d-flex justify-content-between">
                    <div id="search" class="input-group mb-3">
                        <input id="search-input" type="text" class="form-control shadow-none" placeholder="Tìm theo tên hoặc số mã sản phẩm">
                        <button type="button" class="input-group-text" id="search-button" title="Tìm kiếm"><i class="fa-solid fa-magnifying-glass"></i></button>
                    </div>
                    <div class="error-message" id="error-message">Hãy chọn sản phẩm cần chuyển kho</div>
                    <div class="ware" style="align-items: center; justify-content: end;">
                        <h3>Chuyển tới kho:</h3>
                        <select name="warehouse" style="font-size: 18px;">
                            <c:forEach items="${lw}" var="l">
                                <option value="${l.id}">${l.name}</option>
                            </c:forEach>
                        </select>
                    </div>
                </div>
                <div id="product-data" class="table-container">
                    <table class="table table-borderless">
                        <thead class="sticky-top">
                        <tr>
                            <th scope="col"><input type="checkbox" id="select-all"></th>
                            <th scope="col">Mã sản phẩm</th>
                            <th scope="col">Tên sản phẩm</th>
                            <th scope="col">Hãng xe</th>
                            <th scope="col">Số lượng</th>
                            <th class="table-function">Đơn vị tính</th>
                            <th scope="col">Kho lưu trữ</th>
                            <th scope="col">Vị trí</th>
                        </tr>
                        </thead>
                        <tbody id="product-table-body">
                        <c:forEach items="${list}" var="s" varStatus="status">
                            <tr>
                                <td style="vertical-align: middle;">
                                    <input type="checkbox" name="selectedProduct" value="${status.index}">
                                </td>
                                <input type="hidden" name="p_id[${status.index}]" value="${s.p_id}">
                                <td style="vertical-align: middle;">
                                    <input type="hidden" name="productCode[${status.index}]" value="${s.productCode}">${s.productCode}
                                </td>
                                <td style="vertical-align: middle;">
                                    <input type="hidden" name="product_name[${status.index}]" value="${s.product_name}">${s.product_name}
                                </td>
                                <td style="vertical-align: middle;">
                                    <input type="hidden" name="car_name[${status.index}]" value="${s.car_id.carName}">${s.car_id.carName}
                                </td>
                                <td style="vertical-align: middle;">
                                    <input type="hidden" name="inventory[${status.index}]" value="${s.inventory}">${s.inventory}
                                </td>
                                <td style="vertical-align: middle;">
                                    <input type="hidden" name="unit[${status.index}]" value="${s.unit}">${s.unit}
                                </td>
                                <td style="vertical-align: middle;">
                                    <input type="hidden" name="warehouse[${status.index}]" value="${s.warehouse_id.name}">${s.warehouse_id.name}
                                </td>
                                <td style="vertical-align: middle;">
                                    <input type="hidden" name="location[${status.index}]" value="${s.shipment.place_include}">${s.shipment.place_include}
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                    <p id="no-results-message" style="display: none; color: red;">Không có kết quả phù hợp</p>
                </div>

                <div>${ms}</div>
                <div class="button-container">
                    <button type="submit" style="margin-left: 44%" class="button-79">Tạo lệnh chuyển kho</button>
                </div>
            </div>
        </form>
    </main>
</div>

<script src="https://code.jquery.com/jquery-3.6.0.js"
        integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.17.4/xlsx.full.min.js"></script>
<script>
    document.getElementById('select-all').addEventListener('change', function() {
        const checkboxes = document.querySelectorAll('input[name="selectedProduct"]');
        checkboxes.forEach(checkbox => checkbox.checked = this.checked);
    });

    document.getElementById('search-button').addEventListener('click', function() {
        const searchValue = document.getElementById('search-input').value.toLowerCase();
        const productRows = document.querySelectorAll('#product-table-body tr');
        let hasResults = false;

        productRows.forEach(row => {
            const productCode = row.querySelector('input[name^="productCode"]').value.toLowerCase();
            const productName = row.querySelector('input[name^="product_name"]').value.toLowerCase();

            if (productCode.includes(searchValue) || productName.includes(searchValue)) {
                row.style.display = '';
                hasResults = true;
            } else {
                row.style.display = 'none';
            }
        });

        document.getElementById('no-results-message').style.display = hasResults ? 'none' : 'block';
    });

    document.getElementById('relocationForm').addEventListener('submit', function(event) {
        const checkboxes = document.querySelectorAll('input[name="selectedProduct"]');
        const isSelected = Array.from(checkboxes).some(checkbox => checkbox.checked);

        if (!isSelected) {
            document.getElementById('error-message').style.display = 'block';
            event.preventDefault();
        } else {
            document.getElementById('error-message').style.display = 'none';
        }
    });
</script>
</body>
</html>
