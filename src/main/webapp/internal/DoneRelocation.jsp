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
    </style>
</head>

<body>

<div class="flex-grow-1" style="display: flex">
    <%@include file="/function.jsp"%>
    <main>
        <div class="header-main">
            <h2 style="font-weight: bold;  text-align: center;">Chuyển vị trí hàng hóa</h2>
        </div>
        <form action="DoneRelocation" method="post">
            <div class="background-main">
                <p style="color: green">${requestScope.success}</p>
                <div class="toolbar d-flex justify-content-between">
                    <div id="search" class="input-group mb-3">
                        <input id="search-input" type="text" class="form-control shadow-none" placeholder="Tìm theo tên hoặc số mã sản phẩm">
                        <button id="search-button" type="button" class="input-group-text" title="Tìm kiếm"><i class="fa-solid fa-magnifying-glass"></i></button>
                    </div>
                    <div style="align-items: center; justify-content: end;">
                        <h3>Chuyển tới kho: ${nWare.name}</h3>
                    </div>
                </div>
                <div id="product-data" class="table-container">
                    <table class="table table-borderless" id="product-table">
                        <thead class="sticky-top">
                        <tr>
                            <th scope="col">Mã sản phẩm</th>
                            <th scope="col">Tên sản phẩm</th>
                            <th scope="col">Hãng xe</th>
                            <th scope="col">Số lượng</th>
                            <th class="table-function">Đơn vị tính</th>
                            <th scope="col">Vị trí</th>
                        </tr>
                        </thead>
                        <tbody id="product-table-body">
                        <c:forEach items="${selectedData}" var="s">
                            <tr>
                                <input value="${s.p_id}" type="hidden"/>
                                <td style="vertical-align: middle;" data-product-code="${s.productCode}">${s.productCode}</td>
                                <td style="vertical-align: middle;" data-product-name="${s.product_name}">${s.product_name}</td>
                                <td style="vertical-align: middle;" data-car-name="${s.car_name}">${s.car_name}</td>
                                <td style="vertical-align: middle;" data-quantity="${s.inventory}">${s.inventory}</td>
                                <td style="vertical-align: middle;" data-unit="${s.unit}">${s.unit}</td>
                                <td style="vertical-align: middle;">
                                    <select name="idShipment_${s.p_id}">
                                        <c:forEach items="${lware}" var="lw">
                                            <option value="${lw.shipment_Id}">${lw.place_include}</option>
                                        </c:forEach>
                                    </select>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                    <p id="no-results-message" style="display: none; color: red;">Không có kết quả phù hợp</p>
                </div>
                <button type="submit" class="button-79" style="margin-left: 44%">Hoàn thành</button>
            </div>
        </form>
    </main>
</div>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
    document.getElementById('search-button').addEventListener('click', function() {
        const searchValue = document.getElementById('search-input').value.toLowerCase();
        const productRows = document.querySelectorAll('#product-table-body tr');
        let hasResults = false;

        productRows.forEach(row => {
            const productCode = row.querySelector('[data-product-code]').textContent.toLowerCase();
            const productName = row.querySelector('[data-product-name]').textContent.toLowerCase();

            if (productCode.includes(searchValue) || productName.includes(searchValue)) {
                row.style.display = '';
                hasResults = true;
            } else {
                row.style.display = 'none';
            }
        });

        document.getElementById('no-results-message').style.display = hasResults ? 'none' : 'block';
    });
</script>

</body>
</html>
