<%--
  Created by IntelliJ IDEA.
  User: DungBeo
  Date: 6/18/2024
  Time: 1:32 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thêm Sản Phẩm Mới</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .main_add {
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            background-color: #f8f9fa; /* Light gray background */
        }
        .container {
            background-color: #ffffff; /* White container background */
            padding: 30px;
            border-radius: 8px;
            border: 2px solid #0d6efd;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1); /* Shadow effect */
            max-width: 600px; /* Limit container width for better readability */
        }
        .form-group label {
            font-weight: bold;
        }
        .preview {
            margin-top: 10px;
            max-width: 200px;
            display: block;
        }
    </style>
</head>
<body>
<div class="main_add">
    <%@include file="../function.jsp"%>
    <main>
        <div class="container">
            <h1 class="mb-4">Thêm Sản Phẩm Mới</h1>
            <c:if test="${errorMessage != null}">
                <div class="alert alert-danger" role="alert">
                        ${errorMessage}
                </div>
            </c:if>
            <a href="product-category" class="btn btn-success mb-3">Trở về trang trước</a>
            <form action="product-category?action=add" method="post" enctype="multipart/form-data">
                <div class="form-group row">
                    <label for="productName" class="col-sm-3 col-form-label">Tên hàng</label>
                    <div class="col-sm-9">
                        <input type="text" class="form-control" id="productName" name="productName" required>
                    </div>
                </div>
                <div class="form-group row">
                    <label for="productCode" class="col-sm-3 col-form-label">Mã Hàng</label>
                    <div class="col-sm-9">
                        <input type="text" class="form-control" id="productCode" name="productCode" required>
                    </div>
                </div>
                <div class="form-group row">
                    <label for="carId" class="col-sm-3 col-form-label">Hãng xe</label>
                    <div class="col-sm-9">
                        <select class="form-control" id="carId" name="carId" required>
                            <option value="">Hãy chọn hãng xe</option>
                            <c:forEach var="car" items="${cars}">
                                <option value="${car.carId}">${car.carName}</option>
                            </c:forEach>
                        </select>
                    </div>
                </div>

                <div class="form-group row">
                    <label for="unit" class="col-sm-3 col-form-label">Đơn vị tính</label>
                    <div class="col-sm-9">
                        <input type="text" class="form-control" id="unit" name="unit" required>
                    </div>
                </div>

                <div class="form-group row">
                    <label for="supplierId" class="col-sm-3 col-form-label">Nhà cung cấp</label>
                    <div class="col-sm-9">
                        <select class="form-control" id="supplierId" name="supplierId" required>
                            <option value="">Hãy chọn nhà cung cấp</option>
                            <c:forEach var="supplier" items="${suppliers}">
                                <option value="${supplier.supplierId}">${supplier.supplierName} (${supplier.supplierId})</option>
                            </c:forEach>
                        </select>
                    </div>
                </div>

                <div class="form-group row">
                    <label for="producerId" class="col-sm-3 col-form-label">Nhà sản xuất</label>
                    <div class="col-sm-9">
                        <select class="form-control" id="producerId" name="producerId" required>
                            <option value="">Hãy chọn nhà sản xuất</option>
                            <c:forEach var="producer" items="${producers}">
                                <option value="${producer.producer_Id}">${producer.producer_Name}</option>
                            </c:forEach>
                        </select>
                    </div>
                </div>

                <div class="form-group row">
                    <label for="importPrice" class="col-sm-3 col-form-label">Giá nhập</label>
                    <div class="col-sm-9">
                        <input type="text" class="form-control" id="importPrice" name="importPrice" required>
                    </div>
                </div>

                <div class="form-group row">
                    <label for="salesPrice" class="col-sm-3 col-form-label">Giá bán</label>
                    <div class="col-sm-9">
                        <input type="text" class="form-control" id="salesPrice" name="salesPrice" required>
                    </div>
                </div>

                <div class="form-group row">
                    <label for="img" class="col-sm-3 col-form-label">Hình ảnh</label>
                    <div class="col-sm-9">
                        <input type="file" class="form-control-file" id="img" name="img" required onchange="previewImage(event)">
                        <img id="imgPreview" class="preview" src="" alt="Image preview">
                    </div>
                </div>

                <div class="form-group row">
                    <label for="desc" class="col-sm-3 col-form-label">Ghi chú</label>
                    <div class="col-sm-9">
                        <textarea id="desc" name="desc" class="form-control" rows="5" cols="10"></textarea>
                    </div>
                </div>

                <div class="form-group row">
                    <div class="col-sm-9 offset-sm-3">
                        <button type="submit" class="btn btn-primary">Thêm sản phẩm</button>
                    </div>
                </div>
            </form>
        </div>
    </main>
</div>
// test i ong  no co 1 cais enroll nay ong

<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.2/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script>
    function previewImage(event) {
        const input = event.target;
        const reader = new FileReader();

        reader.onload = function () {
            const imgPreview = document.getElementById('imgPreview');
            imgPreview.src = reader.result;
        };

        if (input.files && input.files[0]) {
            reader.readAsDataURL(input.files[0]);
        }
    }
</script>
</body>
</html>
