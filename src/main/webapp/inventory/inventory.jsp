<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title> Tồn Kho </title>

    <style>
        /* Custom styles for this page */

        .container {
            background-color: #f8f9fa; /* Light grey background */
            padding: 20px;
            border-radius: 10px;
            border: 1px solid #ced4da; /* Light grey border */
            box-shadow: 0 4px 8px rgba(0,0,0,0.1); /* Subtle shadow effect */
        }

        .title {
            font-weight: bold;
            font-size: 28px;
            color: #007bff; /* Blue title color */
            text-align: center;
            margin-bottom: 20px;
        }
        .btn {
            background-color: #007bff;
            color: #fff;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .btn:hover {
            background-color: #0056b3; /* Darker shade of blue on hover */
        }
        .btn-primary {
            background-color: #007bff; /* Màu nền mặc định */
            color: #ffffff; /* Màu chữ mặc định */
            border: none;
            padding: 10px 20px;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s ease; /* Hiệu ứng màu nền khi hover */
        }

        .btn-primary:hover {
            background-color: #0056b3; /* Màu nền khi hover */
        }

        .table-data table {
            width: 100%;
            border-collapse: collapse;
            background-color: #ffffff; /* White table background */
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1); /* Shadow effect */
        }

        .table-data table th,
        .table-data table td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #dee2e6; /* Light grey border */
        }

        .table-data table th {
            background-color: #007bff; /* Blue header background */
            color: #ffffff; /* White header text */
            text-align: center; /* Center align table headers */
        }

        .table-data table td img {
            display: block;
            width: 70px;
            margin: 0 auto; /* Center align images */
            border-radius: 5px;
            cursor: pointer;
            transition: transform 0.3s ease;
        }

        .table-data table td img:hover {
            transform: scale(1.1); /* Scale up image on hover */
        }

        .modal-content {
            border-radius: 12px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1); /* Subtle shadow effect */
        }

        .modal-title {
            font-weight: bold;
            color: #007bff; /* Blue modal title */
        }

    </style>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="allMain" style="display: flex">
    <%@include file="../function.jsp" %>
    <main>
        <div class="container">
            <div class="header">
                <p class="title">Hàng tồn kho</p>
            </div>
            <form id="inventoryForm" action="inventory" method="get" class="form-inline">
                <div class="form-group mb-2">
                    <label for="warehouse" class="sr-only">Kho trung tâm</label>
                    <select id="warehouse" class="form-control mr-2" name="ware" onchange="document.getElementById('inventoryForm').submit()">
                        <option value="">---Kho trung tâm---</option>
                        <c:forEach items="${wares}" var="w">
                            <option value="${w.id}" <c:if test="${ware != null && ware == w.id}">selected</c:if>>${w.name}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="form-group mb-2">
                    <label for="sort" class="sr-only">Sắp xếp theo</label>
                    <select id="sort" class="form-control mr-2" name="sort" onchange="document.getElementById('inventoryForm').submit()">
                        <option value="">---Mặc định---</option>
                        <option value="desc" <c:if test="${sort != null && sort == 'desc'}">selected</c:if>>Mới nhất</option>
                        <option value="asc" <c:if test="${sort != null && sort == 'asc'}">selected</c:if>>Cũ nhất</option>
                    </select>
                </div>
                <div class="form-group mb-2">
                    <label for="search" class="sr-only">Tìm kiếm</label>
                    <input id="search" type="text" class="form-control mr-2" placeholder="Tìm kiếm" name="search" value="${search}" onchange="document.getElementById('inventoryForm').submit()"/>
                </div>
                <button type="submit" class="btn btn-primary mb-2">Thực hiện</button>
            </form>
            <div class="data-form">
                <button class="btn btn-primary" onclick="exportToExcel()">Xuất dữ liệu</button>
            </div>
            <div class="table-data">
                <table>
                    <thead>
                    <tr>
                        <th><input type="checkbox" id="select-all"></th>
                        <th>Mã hàng</th>
                        <th>Tên hàng</th>
                        <th>Hình ảnh</th>
                        <th>Xe</th>
                        <th>SL tồn</th>
                        <th>ĐVT</th>
                        <th>Đơn giá</th>
                        <th>Tiền tồn</th>
                        <th>Kho</th>
                        <th>Nơi</th>
                        <th>Nhà cung cấp</th>
                        <th>Nhà sản xuất</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${products}" var="product">
                        <tr>
                            <td><input type="checkbox" class="select-row"></td>
                            <td>${product.productCode}</td>
                            <td>${product.product_name}</td>
                            <td>
                                <img src="${product.image_Link}" width="70px" alt="alt" class="img-thumbnail" onclick="showImageModal('${product.image_Link}')"/>
                            </td>
                            <td>${product.car_id != null ? product.car_id.carName : "N/A"}</td>
                            <td>${product.inventory}</td>
                            <td>${product.unit}</td>
                            <td><fmt:formatNumber value="${product.sale_price}" type="number" /></td>
                            <td><fmt:formatNumber value="${product.inventory * product.sale_price}" type="number" /></td>
                            <td>${product.warehouse_id != null ? product.warehouse_id.name : "N/A"}</td>
                            <td>${product.place}</td>
                            <td>${product.supplier_id != null ? product.supplier_id.supplierName : "N/A"}</td>
                            <td>${product.getProducer_Id().getProducer_Name()}</td>
                        </tr>
                    </c:forEach>
                    <c:if test="${products.size() == 0}">
                        <tr>
                            <td colspan="13">Không có sản phẩm nào</td>
                        </tr>
                    </c:if>
                    </tbody>
                </table>
            </div>
            <!-- Pagination controls -->
            <nav aria-label="Page navigation">
                <ul class="pagination">
                    <c:if test="${currentPage > 1}">
                        <li class="page-item">
                            <a class="page-link" href="inventory?page=${currentPage - 1}&search=${search}&ware=${ware}&sort=${sort}" aria-label="Previous">
                                <span aria-hidden="true">&laquo;</span>
                            </a>
                        </li>
                    </c:if>
                    <c:forEach var="i" begin="1" end="${totalPages}">
                        <li class="page-item <c:if test='${i == currentPage}'>active</c:if>">
                            <a class="page-link" href="inventory?page=${i}&search=${search}&ware=${ware}&sort=${sort}">${i}</a>
                        </li>
                    </c:forEach>
                    <c:if test="${currentPage < totalPages}">
                        <li class="page-item">
                            <a class="page-link" href="inventory?page=${currentPage + 1}&search=${search}&ware=${ware}&sort=${sort}" aria-label="Next">
                                <span aria-hidden="true">&raquo;</span>
                            </a>
                        </li>
                    </c:if>
                </ul>
            </nav>
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

<script>
    function showImageModal(imageUrl) {
        $('#modalImage').attr('src', imageUrl);
        $('#imageModal').modal('show');
    }

    document.getElementById('select-all').addEventListener('change', function () {
        const checkboxes = document.querySelectorAll('.select-row');
        checkboxes.forEach(checkbox => {
            checkbox.checked = this.checked;
        });
    });

    function exportToExcel() {
        const rows = document.querySelectorAll('.table-data tbody tr');
        const selectedRows = Array.from(rows).filter(row => row.querySelector('.select-row').checked);
        if (selectedRows.length === 0) {
            alert('Không có dữ liệu để xuất Excel.');
            return;
        }

        // Prepare Excel data
        let excelData = [['Mã hàng', 'Tên hàng', 'Xe', 'SL tồn', 'ĐVT', 'Đơn giá', 'Tiền tồn', 'Kho', 'Nơi', 'Nhà cung cấp', 'Nhà sản xuất']];
        selectedRows.forEach(function (row) {
            let rowData = [];
            rowData.push(row.cells[1].textContent.trim());
            rowData.push(row.cells[2].textContent.trim());
            rowData.push(row.cells[4].textContent.trim());
            rowData.push(row.cells[5].textContent.trim());
            rowData.push(row.cells[6].textContent.trim());
            rowData.push(row.cells[7].textContent.trim());
            rowData.push(row.cells[8].textContent.trim());
            rowData.push(row.cells[9].textContent.trim());
            rowData.push(row.cells[10].textContent.trim());
            rowData.push(row.cells[11].textContent.trim());
            rowData.push(row.cells[12].textContent.trim());
            excelData.push(rowData);
        });

        // Create workbook and sheet
        const wb = XLSX.utils.book_new();
        const ws = XLSX.utils.aoa_to_sheet(excelData);
        XLSX.utils.book_append_sheet(wb, ws, 'Danh sách sản phẩm');

        // Save Excel file
        const fileName = 'tonkho.xlsx';
        XLSX.writeFile(wb, fileName);
    }
</script>
<script src="https://code.jquery.com/jquery-3.6.0.js"
        integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.16.9/xlsx.full.min.js"></script>

</body>
</html>
