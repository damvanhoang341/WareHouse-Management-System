<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Báo giá</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css" type="text/css">
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

        .table-function button {
            margin: 0 5px;
        }
    </style>
</head>

<body>
<div class="flex-grow-1" style="display: flex">
    <%@include file="/function.jsp"%>
    <main>
        <div class="header-main">
            <h4 style="font-weight: bold">Báo giá sản phẩm</h4>
        </div>
        <div class="background-main">
            <div class="toolbar d-flex justify-content-between">
                <div id="search" class="input-group mb-3">
                    <input id="search-input" type="text" class="form-control shadow-none" placeholder="Tìm theo tên sản phẩm và giá bán">
                    <button type="button" class="input-group-text" title="Tìm kiếm"><i class="fa-solid fa-magnifying-glass"></i></button>
                </div>
                <div>
                    <button type="button" class="btn btn-success" onclick="exportToExcel()">Xuất Excel</button>
                </div>
            </div>
            <div id="product-data">
                <table class="table table-borderless">
                    <thead class="sticky-top">
                    <tr>
                        <th scope="col"><input type="checkbox" id="select-all"></th>
                        <th scope="col">Tên hàng</th>
                        <th scope="col">Mã sản phẩm</th>
                        <th scope="col">Xe</th>
                        <th scope="col">Đơn vị</th>
                        <th scope="col">Giá bán</th>
                        <th scope="col">Nhà cung cấp</th>
                        <th scope="col">Nhà sản xuất</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${products}" var="p">
                        <tr>
                            <td style="vertical-align: middle;"><input type="checkbox" class="select-row"></td>
                            <td style="vertical-align: middle;" value="${p.p_id}" nameproduct="${p.product_name}">${p.product_name}</td>
                            <td style="vertical-align: middle;">${p.productCode}</td>
                            <td style="vertical-align: middle;">${p.car_id.carName}</td>
                            <td style="vertical-align: middle;">${p.unit}</td>
                            <td style="vertical-align: middle;">${p.sale_price}</td>
                            <td style="vertical-align: middle;">${p.supplier_id.supplierName}</td>
                            <td style="vertical-align: middle;">${p.getProducer_Id().getProducer_Name()}</td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
                <p id="no-results-message" style="display: none; color: red;">Không có kết quả phù hợp</p>
            </div>
        </div>
    </main>
</div>

<!-- Bootstrap -->
<script src="https://code.jquery.com/jquery-3.6.0.js"
        integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.16.9/xlsx.full.min.js"></script>
<script>
    document.getElementById('select-all').addEventListener('change', function() {
        const checkboxes = document.querySelectorAll('.select-row');
        checkboxes.forEach(checkbox => {
            checkbox.checked = this.checked;
        });
    });

    function exportToExcel() {
        const rows = document.querySelectorAll('#product-data tbody tr');
        const selectedRows = Array.from(rows).filter(row => row.querySelector('.select-row').checked);
        if (selectedRows.length === 0) {
            alert('Không có dữ liệu để xuất Excel.');
            return;
        }

        // Chuẩn bị dữ liệu cho Excel
        let excelData = [['Tên hàng', 'Mã sản phẩm', 'Xe','Đơn vị', 'Giá bán', 'Nhà cung cấp','Nhà sản xuất']];
        selectedRows.forEach(function(row) {
            let rowData = [];
            rowData.push(row.cells[1].textContent.trim()); // Tên hàng
            rowData.push(row.cells[2].textContent.trim());
            rowData.push(row.cells[3].textContent.trim()); // Xe
            rowData.push(row.cells[4].textContent.trim()); // đơn vị
            rowData.push(row.cells[5].textContent.trim()); // giá
            rowData.push(row.cells[6].textContent.trim()); // Nhà cung cấp
            rowData.push(row.cells[7].textContent.trim());// Nhà sản xuất
            excelData.push(rowData);
        });

        // Tạo workbook và sheet Excel
        const wb = XLSX.utils.book_new();
        const ws = XLSX.utils.aoa_to_sheet(excelData);
        XLSX.utils.book_append_sheet(wb, ws, 'Danh sách sản phẩm');

        // Lưu file Excel
        const fileName = 'product_data.xlsx';
        XLSX.writeFile(wb, fileName);
    }
</script>
<script>
    function removeVietnameseTones(str) {
        str = str.normalize('NFD').replace(/[\u0300-\u036f]/g, '');
        return str.replace(/đ/g, 'd').replace(/Đ/g, 'D');
    }

    function isNumeric(value) {
        return /^\d+$/.test(value);
    }

    document.getElementById('search-input').addEventListener('input', function() {
        const searchTerm = removeVietnameseTones(this.value.toLowerCase());
        const rows = document.querySelectorAll('#product-data tbody tr');
        let hasVisibleRows = false;

        rows.forEach(function(row) {
            const name = removeVietnameseTones(row.querySelector('td[nameproduct]').textContent.toLowerCase());
            const price = row.querySelector('td:nth-child(4)').textContent.trim(); // Giả sử cột giá bán là cột thứ 4
            let match = false;

            if (isNumeric(searchTerm)) {
                match = price.includes(searchTerm);
            } else {
                match = name.includes(searchTerm);
            }

            row.style.display = match ? '' : 'none';
            if (match) hasVisibleRows = true;
        });

        document.getElementById('no-results-message').style.display = hasVisibleRows ? 'none' : 'block';
    });

</script>
</body>
</html>
