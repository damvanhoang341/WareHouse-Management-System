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
<html>
<head>
    <title>Chỉnh Sửa Sản Phẩm</title>
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet">
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
<div class="main_add" style="display: flex">
    <%@include file="../function.jsp"%>
    <main>
        <div class="container mt-5">
            <h1 class="mb-4">Chỉnh Sửa Sản Phẩm</h1>
            <c:if test="${errorMessage != null}">
                <div class="alert alert-danger" role="alert">
                        ${errorMessage}
                </div>
            </c:if>
            <c:if test="${param.error != null}">
                <div class="alert alert-danger" role="alert">
                        ${param.error}
                </div>
            </c:if>
            <a href="product-category" class="btn btn-success">Trở về trang trước</a>
            <form action="product-category?action=edit" method="post" enctype="multipart/form-data">
                <input type="hidden" name="pId" value="${product.p_id}" />

                <div class="form-group row">
                    <label for="productName" class="col-sm-2 col-form-label">Tên hàng</label>
                    <div class="col-sm-10">
                        <input type="text" class="form-control" id="productName" name="productName" value="${product.product_name}"  />
                    </div>
                </div>
                <div class="form-group row">
                    <label for="productCode" class="col-sm-2 col-form-label">Mã Hàng</label>
                    <div class="col-sm-10">
                        <input type="text" class="form-control" id="productCode" name="productCode" value="${product.productCode}" required>
                    </div>
                </div>

                <div class="form-group row">
                    <label for="carId" class="col-sm-2 col-form-label">Hãng xe</label>
                    <div class="col-sm-10">
                        <select class="form-control" id="carId" name="carId" required>
                            <c:forEach var="car" items="${cars}">
                                <option value="${car.carId}"  ${product.car_id != null && product.car_id.carId  == car.carId ? "selected" : ""}>${car.carName}</option>
                            </c:forEach>
                        </select>
                    </div>
                </div>

                <div class="form-group row">
                    <label for="inventory" class="col-sm-2 col-form-label">Số lượng</label>
                    <div class="col-sm-10">
                        <input type="text" class="form-control" id="inventory" name="inventory" value="${product.inventory}" readonly />
                    </div>
                </div>
                <div class="form-group row">
                    <label for="unit" class="col-sm-2 col-form-label">Đơn vị tính</label>
                    <div class="col-sm-10">
                        <input type="text" class="form-control" id="unit" name="unit" value="${product.unit}"  />
                    </div>
                </div>
                <div class="form-group row">
                    <label for="warehouseId" class="col-sm-2 col-form-label">Nơi kho</label>
                    <div class="col-sm-10">
                        <input type="text" class="form-control" id="warehouseId" name="warehouseId" value="${product.warehouse_id.name}"  readonly/>
                    </div>
                </div>
                <div class="form-group row">
                    <label for="supplierId" class="col-sm-2 col-form-label">Nhà cung cấp</label>
                    <div class="col-sm-10">
                        <select class="form-control" id="supplierId" name="supplierId">
                            <c:forEach var="supplier" items="${supplierList}">
                                <option value="${supplier.supplierId}" <c:if test="${supplier.supplierId == product.supplier_id.supplierId}">selected</c:if>>
                                        ${supplier.supplierName} (${supplier.supplierId})
                                </option>
                            </c:forEach>
                        </select>
                    </div>
                </div>
                <div class="form-group row">
                    <label for="importPrice" class="col-sm-2 col-form-label">Giá nhập</label>
                    <div class="col-sm-10">
                        <input type="text" class="form-control" id="importPrice" name="importPrice" value="${product.import_price}" />
                    </div>
                </div>
                <div class="form-group row">
                    <label for="salesPrice" class="col-sm-2 col-form-label">Giá bán</label>
                    <div class="col-sm-10">
                        <input type="text" class="form-control" id="salesPrice" name="salesPrice" value="${product.sale_price}" />
                    </div>
                </div>
                <div class="form-group row">
                    <label for="img" class="col-sm-2 col-form-label">Hình Ảnh</label>
                    <div class="col-sm-10">
                        <input type="file" class="form-control" id="img" name="img" onchange="previewImage(event)" />
                        <input type="hidden" value="${product.image_Link}" name="oldImage" />
                        <img id="imgPreview" class="preview" src="${product.image_Link}" alt="Image preview" style="width: 200px; margin-top: 10px" />
                    </div>
                </div>
                <div class="form-group row">
                    <label for="desc" class="col-sm-2 col-form-label">Ghi chú</label>
                    <div class="col-sm-10">
                        <textarea id="desc" name="desc" class="form-control" rows="5" cols="10">${product.desc}</textarea>
                    </div>
                </div>
                <div class="form-group row">
                    <div class="col-sm-10 offset-sm-2">
                        <button type="submit" class="btn btn-primary">Lưu thay đổi</button>
                    </div>
                </div>
            </form>
        </div>
    </main>
</div>
<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.11.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
<script>
    function previewImage(event) {
        const input = event.target;
        const reader = new FileReader();

        reader.onload = function () {
            const imgPreview = document.getElementById('imgPreview');
            imgPreview.src = reader.result;
            imgPreview.style.display = 'block';
        };

        if (input.files && input.files[0]) {
            reader.readAsDataURL(input.files[0]);
        }
    }
</script>

</html>

