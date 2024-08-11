<%--
  Created by IntelliJ IDEA.
  User: DungBeo
  Date: 6/18/2024
  Time: 1:32 AM
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:useBean class="com.example.qlkh.DAO.CarDAO" id="getCar" />
<jsp:useBean class="com.example.qlkh.DAO.SupplierDAO" id="getSupplier" />
<jsp:useBean class="com.example.qlkh.DAO.WareHouseDAO" id="getWareHouse" />
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Danh sách sản phẩm </title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">

    <style>
        /* Custom styles for this page */
        .main_add {
            display: flex;
            background-color: #f8f9fa;
        }
        .container {
            background-color: #ffffff;
            padding: 20px;
            border-radius: 20px;
            border: 2px solid #0d6efd;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
        }
        .header {
            margin-bottom: 20px;
        }
        .title {
            font-weight: bold;
            font-size: 24px;
            color: #007bff;
            text-align: center;
        }
        .input-form {
            display: flex;
            flex-wrap: wrap;
            justify-content: space-between;
        }
        .label-form {
            font-weight: bold;
        }
        .form-group {
            margin-bottom: 15px;
            flex-basis: calc(33.33% - 15px);
        }
        .table-container {
            overflow-y: auto;
            max-height: 600px;
        }
        .table-data {
            margin-top: 20px;
        }
        .table-data table {
            width: 100%;
            border-collapse: collapse;
            background-color: #ffffff;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
        }
        .table-data th, .table-data td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #dee2e6;
        }
        .table-data th {
            position: sticky;
            top: 0;
            background-color: #007bff;
            color: #ffffff;
            z-index: 10;
        }
        .table-data td img {
            cursor: pointer;
            display:block;
            margin: 0 auto;
        }
        .alert {
            margin-top: 20px;
        }
        .modal-content {
            border-radius: 12px;
        }
        .modal-title {
            font-weight: bold;
            color: #007bff;
        }
        .pagination {
            margin-top: 20px;
            text-align: center;
        }
        .pagination a {
            margin: 0 5px;
            padding: 10px;
            background-color: #007bff;
            color: #ffffff;
            text-decoration: none;
            border-radius: 5px;
        }
        .pagination a.disabled {
            background-color: #e0e0e0;
            color: #a0a0a0;
            pointer-events: none;
        }
    </style>
</head>
<div class="main_add" style="display: flex">
    <%@include file="../function.jsp"%>
    <main>
        <div class="container">
            <div class="header">
                <p class="title">Danh mục hàng hóa</p>
            </div>
            <form acion="product-category" class="input-form" style="display: flex; align-items: center;flex-wrap: wrap">
                <div class="form-group col-4">
                    <label class="label-form">Kho trung tâm</label>
                    <select  class="form-control" name="ware" onchange="this.form.submit()" >
                        <option value="">---Kho trung tâm---</option>
                        <c:forEach items="${wares}" var="w" >
                            <option value="${w.id}" ${ware != null && ware == w.id ? "selected" : ""}>${w.name}</option>
                        </c:forEach>
                    </select >
                </div>
                <div class="form-group col-4">
                    <label class="label-form">Nhà Cung Cấp</label>
                    <select class="form-control" name="supplier" onchange="this.form.submit()">
                        <option value="">---Nhà cung cấp---</option>
                        <c:forEach items="${suppliers}" var="sup">
                            <option value="${sup.supplierId}" ${supplier != null && supplier == sup.supplierId ? "selected" : ""}>${sup.supplierName}</option>
                        </c:forEach>
                    </select>
                </div>

                <div class="form-group col-4">
                    <label class="label-form">Sắp xếp theo</label>
                    <select class="form-control" name="sort" onchange="this.form.submit()">
                        <option value="">---Mặc định---</option>
                        <option value="1" ${sort != null && sort == '1' ? "selected" : ""}>Còn hàng</option>
                        <option value="0" ${sort != null && sort == '0' ? "selected" : ""}>Hết hàng</option>
                    </select>
                </div>
                <div class="form-group col-12">
                    <label class="label-form">Tìm kiếm</label>
                    <input class="form-control" class="input" placeholder="Tìm kiếm" name="search" value="${search}"/>
                </div>
                <div class="form-group col-12">
                    <button class="btn  btn-success" type="submit">Thực hiện</button>
                </div>
            </form>
        </div>
        <c:if test="${param.error != null}">
            <div class="alert alert-danger" role="alert">
                    ${param.error}
            </div>
        </c:if>
        <c:if test="${param.success != null}">
            <div class="alert alert-success" role="alert">
                    ${param.success}
            </div>
        </c:if>
        <div style="display: flex; justify-content: flex-end; margin-top: 10px">
            <div class="form-group col-2">
                <select name="inventory" class="form-control" onchange="sortByInventory(this.value)">
                    <option value="" ${inventory != null && inventory == "" ? "selected" : ""}>----Sắp Xếp Theo Số Lượng----</option>
                    <option value="desc" ${inventory != null && inventory == "desc" ? "selected" : ""}>Giảm dần</option>
                    <option value="asc" ${inventory != null && inventory == "asc" ? "selected" : ""}>Tăng Dần</option>
                </select>
            </div>
        </div>
        <a href="product-category?action=add" class="btn btn-success">Thêm sản phẩm mới </a>
        <div class="table-container">
            <div class="table-data">
                <table>
                    <thead>
                    <tr>
                        <th>Mã hàng</th>
                        <th>Tên hàng</th>
                        <th>Hình ảnh</th>
                        <th>Hãng xe</th>
                        <th>SL tồn</th>
                        <th>ĐVT</th>
                        <th>Giá nhập</th>
                        <th>Giá bán</th>
                        <th>Kho</th>
                        <th>Nhà Cung Cấp</th>
                        <th>Nơi</th>
                        <th>Thao tác</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${products}" var="product">
                        <c:set var="car" value="${product.car_id}" />
                        <c:set var="supplier" value="${product.supplier_id}" />
                        <c:set var="warehouse" value="${product.warehouse_id}" />
                        <tr>
                            <td>${product.productCode}</td>
                            <td>${product.product_name}</td>
                            <td>
                                <img src="${product.image_Link}" width="70px" alt="alt" class="img-thumbnail" onclick="showImageModal('${product.image_Link}')"/>
                            </td>
                            <td>${car != null ? car.carName : "N/A"}</td>
                            <td>
                                        <span class="badge badge-${product.inventory == 0 ? "danger" : "info"}">
                                                ${product.inventory > 0 ? product.inventory : "Hết hàng"}
                                        </span>
                            </td>
                            <td>${product.unit}</td>
                            <td>
                                <fmt:formatNumber value="${product.import_price}" type="number" />
                            </td>
                            <td>
                                <fmt:formatNumber value="${product.sale_price}" type="number" />
                            </td>
                            <td>
                                    ${warehouse != null ? warehouse.name : "N/A"}
                                <c:if test="${warehouse == null || warehouse.name  == null}">
                                    <span class="badge badge-danger">Kho Trống</span>
                                </c:if>
                                <c:if test="${warehouse != null && warehouse.name  != null}">
                                    <span class="badge badge-info">${warehouse.name}</span>
                                </c:if>
                            </td>
                            <td>${supplier != null ? supplier.supplierName : "N/A"}</td>
                            <td>
                                <c:if test="${product.place == null}">
                                    <span class="badge badge-danger">Nơi trống</span>
                                </c:if>
                                <c:if test="${product.place != null}">
                                    <span class="badge badge-info">${product.place}</span>
                                </c:if>
                            </td>
                            <td>
                                <a href="product-category?action=edit&id=${product.p_id}" class="btn btn-primary">Chỉnh sửa
                                    <i class="fa-solid fa-pencil"></i>
                                </a>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${products.size() == 0}">
                        <tr>
                            <td colspan="12">
                                Không có sản phẩm nào
                            </td>
                        </tr>
                    </c:if>
                    </tbody>
                </table>
            </div>
        </div>

        <!-- Pagination controls -->
        <div class="pagination">
            <c:if test="${currentPage > 1}">
                <a href="product-category?page=${currentPage - 1}" class="btn btn-primary">Previous</a>
            </c:if>
            <c:if test="${products.size() == pageSize}">
                <a href="product-category?page=${currentPage + 1}" class="btn btn-primary">Next</a>
            </c:if>
        </div>

    </main>
</div>

<div class="modal fade" id="imageModal" tabindex="-1" aria-labelledby="imageModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="imageModalLabel">Image Preview</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <img id="modalImage" src="" class="img-fluid" alt="Image preview"/>
            </div>
        </div>
    </div>
</div>
<script src="https://code.jquery.com/jquery-3.6.0.js"
        integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.16.9/xlsx.full.min.js"></script>
<script>
    function showImageModal(imageUrl) {
        $('#modalImage').attr('src', imageUrl);
        $('#imageModal').modal('show');
    }
</script>
<script>
    function sortByInventory(sort) {
        var url = "<%=request.getContextPath()%>/product-category?action=inventory&sort=" + sort;
        window.location.href = url;
    }
</script>
</html>
