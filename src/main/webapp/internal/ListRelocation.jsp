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
            <h2 style="font-weight: bold; text-align: center;">Chuyển vị trí hàng hóa</h2>
        </div>
        <div class="background-main">
            <p style="color: green">${requestScope.success}</p>
            <div class="toolbar d-flex justify-content-between">
                <div id="search" class="input-group mb-3">
                    <input id="search-input" type="text" class="form-control shadow-none" placeholder="Tìm theo tên hoặc số mã sản phẩm">
                    <button id="search-button" type="button" class="input-group-text" title="Tìm kiếm"><i class="fa-solid fa-magnifying-glass"></i></button>
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
                        <th scope="col">Kho lưu trữ mới</th>
                        <th scope="col">Vị trí mới</th>
                        <th scope="col">Chức năng</th>
                    </tr>
                    </thead>
                    <tbody id="product-table-body">
                    <c:forEach items="${lr}" var="s">
                        <tr>
                            <td style="vertical-align: middle;">${s.id_Product.productCode}</td>
                            <td style="vertical-align: middle;">${s.id_Product.product_name}</td>
                            <td style="vertical-align: middle;">${s.id_Product.car_id.carName}</td>
                            <td style="vertical-align: middle;">${s.id_Product.inventory}</td>
                            <td style="vertical-align: middle;">${s.id_Product.unit}</td>
                            <td style="vertical-align: middle;">${s.wareHouse.name}</td>
                            <td style="vertical-align: middle;">${s.id_ShipmentNew.place_include}</td>
                            <td style="vertical-align: middle;">
                                <form action="ConfirmRe" method="post" style="display: inline;">
                                    <input type="hidden" name="id_freight" value="${s.id_freight}"/>
                                    <input type="hidden" name="productid" value="${s.id_Product.p_id}"/>
                                    <input type="hidden" name="placeNew" value="${s.id_ShipmentNew.shipment_Id}"/>

                                    <c:if test="${s.check == 'NOT'}">
                                        <button type="submit" class="btn btn-success btn-transfer" name="buttonValue" value="1">Chuyển</button>
                                        <button type="submit" class="btn btn-danger btn-reject" name="buttonValue" value="0">Từ chối</button>
                                    </c:if>
                                    <c:if test="${s.check == 'OK'}">
                                        <c:if test="${s.status_product == 'OK'}">
                                            Đã chuyển
                                        </c:if>
                                        <c:if test="${s.status_product == 'NOT'}">
                                            Từ chối
                                        </c:if>
                                    </c:if>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
                <p id="no-results-message" style="display: none; color: red;">Không có kết quả phù hợp</p>
            </div>
        </div>
    </main>
</div>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
    function setOK(id) {
        document.getElementById('buttonValue-' + id).value = 1;
        document.querySelector(`form [name='id_freight'][value='${id}']`).closest('form').submit();
    }

    document.getElementById('search-button').addEventListener('click', function() {
        const searchValue = document.getElementById('search-input').value.toLowerCase();
        const productRows = document.querySelectorAll('#product-table-body tr');
        let hasResults = false;

        productRows.forEach(row => {
            const productCode = row.querySelector('td:nth-child(1)').textContent.toLowerCase();
            const productName = row.querySelector('td:nth-child(2)').textContent.toLowerCase();

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
