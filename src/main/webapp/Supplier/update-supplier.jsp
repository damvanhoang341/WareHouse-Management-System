<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cập nhật thông tin nhà cung cấp</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css" type="text/css">
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
        .btn-accept {
            background-color: #28a745;
            color: white;
        }
        .btn-accept:hover {
            background-color: #218838;
        }
        .atb-name {
            font-weight: bold;
        }
        .defaultCursor {
            cursor: pointer;
        }
        .form__add-product {
            padding: 20px;
        }
        .item-content__main-row {
            margin-top: 15px;
        }
    </style>
</head>
<body>
<div class="update-supplier" style="display: flex">
    <%@include file="/function.jsp"%>
<div class="flex-grow-1">

    <menu class="d-flex justify-content-end">
    </menu>
    <form action="/UpdateSupplierServlet" class="form__add-product" method="post">
        <div class="app__add-product">
            <div class="content__header header-main">
                <div class="content__name defaultCursor">
                    <a href="/supplier">
                        <i class="fa-solid fa-arrow-left-long me-2 fa-lg" style="cursor: pointer"></i>
                    </a>
                    Cập nhật thông tin nhà cung cấp
                </div>
                <div id="successNotify"></div>
                <button type="submit" class="btn-accept btn-accept-button btn-save">Xác nhận</button>
            </div>
            <div class="content__attributes">
                <div class="background-main content__attributes-items">
                    <div class="item-name defaultCursor">Thông tin chung</div>
                    <p style="color: red">${requestScope.error2}</p>
                    <div class="item-content container">
                        <div class="item-content__main-row row">
                            <div class="col-9 general-info">
                                <div class="container">
                                    <div class="row general-info__basic">
                                        <input type="hidden" name="supplierId" value="${supplier.supplierId}">
                                        <div class="row">
                                            <div class="atb col-4">
                                                <span class="atb-name defaultCursor">Tên Nhà cung cấp<span style="color: red"> *</span></span>
                                                <input type="text" id="usuppliername" name="usuppliername" class="atb-input input-group form-control shadow-none" placeholder="Nhập Tên nhà cung cấp" value="${supplier.supplierName}" required>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="atb col-4">
                                                <span class="atb-name defaultCursor">Số điện thoại<span style="color: red"> *</span></span>
                                                <input type="text" id="usupplierphone" name="usupplierphone" class="atb-input input-group form-control shadow-none" placeholder="Nhập số điện thoại" value="${supplier.supplierPhone}" required>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="atb col-4">
                                                <span class="atb-name defaultCursor">Địa chỉ<span style="color: red"> *</span></span>
                                                <input type="text" id="uaddress" name="uaddress" class="atb-input input-group form-control shadow-none" placeholder="Nhập Địa chỉ" value="${supplier.supplierAddress}">
                                            </div>
                                            <div class="atb col-4">
                                                <span class="atb-name defaultCursor">Mã số thuế<span style="color: red"> *</span></span>
                                                <input type="text" id="taxCode" name="taxCode" class="atb-input input-group form-control shadow-none" placeholder="Nhập mã số thuế" value="${supplier.tax}">
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <input type="hidden" id="attributeJSON" name="attributeJSON" value="">
                </div>
            </div>
        </div>
    </form>
</div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script type="module">
    // Additional JavaScript if necessary
</script>
</body>
</html>
