<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý nhà cung cấp</title>
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
            position: relative;
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
        #uploadForm {
            position: absolute;
            right: 0;
            top: 0;
            margin: 10px;
        }
    </style>
</head>

<body>

<div class="flex-grow-1" style="display: flex">
    <%@include file="/function.jsp"%>
    <main>
        <div class="header-main">
            <h4 style="font-weight: bold">Danh sách nhà cung cấp</h4>
        </div>
        <div class="background-main">
            <p style="color: green">${requestScope.success}</p>
            <form id="uploadForm" action="import" method="post" enctype="multipart/form-data">
                <input type="file" name="file" id="file" accept=".xls,.xlsx" required>
                <button type="submit" title="Tải lên" class="btn btn-info">
                    <i class="fa-solid fa-plus"></i> Tải lên
                </button>
            </form>
            <div class="toolbar d-flex justify-content-between">
                <div id="search" class="input-group mb-3">
                    <input id="search-input" type="text" class="form-control shadow-none" placeholder="Tìm theo tên hoặc số điện thoại">
                    <button type="button" class="input-group-text" title="Tìm kiếm"><i class="fa-solid fa-magnifying-glass"></i></button>
                </div>
                <div>
                    <button type="button" title="Thêm" id="btnAdd" class="btn btn-primary btn-save" onclick="location.href='AddSupplierServlet'">
                        <i class="fa-solid fa-plus"></i>
                    </button>
                    <button type="button" title="Xuất Excel" class="btn btn-success" onclick="exportToExcel()">
                        Xuất Excel
                    </button>
<%--                    <input type="file" id="fileInput" accept=".xlsx" style="display: none;" />--%>
<%--                    <label for="fileInput" class="btn btn-info">Tải lên</label>--%>
                </div>
            </div>
            <div id="product-data">
                <table class="table table-borderless">
                    <thead class="sticky-top">
                    <tr>
                        <th scope="col"><input type="checkbox" id="select-all"></th>
                        <th scope="col">Tên nhà cung cấp</th>
                        <th scope="col">Số điện thoại</th>
                        <th scope="col">Địa chỉ </th>
                        <th scope="col">Tiền nợ nhập hàng </th>
                        <th scope="col">Mã số thuế </th>
                        <th class="table-function">Thao tác</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${supplier}" var="s">
                        <tr>
                            <td style="vertical-align: middle;"><input type="checkbox" class="select-row"></td>
                            <td style="vertical-align: middle;" value="${s.supplierId}" nameSupplier="${s.supplierName}">${s.supplierName}</td>
                            <td style="vertical-align: middle;" nameSupplierPhone="${s.supplierPhone}">${s.supplierPhone}</td>
                            <td style="vertical-align: middle;" nameSupplierAddress="${s.supplierAddress}">${s.supplierAddress}</td>
                            <td style="vertical-align: middle;" debt="${s.getDebt()}">${s.debt} VND</td>
                            <td style="vertical-align: middle;" tax="${s.tax}">${s.tax}</td>
                            <td class="table-function text-center">
                                <button type="button" title="Sửa" class="btn btn-save btn-save-table" onclick="location.href = 'UpdateSupplierServlet?sid=${s.supplierId}'">
                                    <i class="fa-solid fa-pencil"></i>
                                </button>
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
</div>
<!-- bootstrap -->
<script src="https://code.jquery.com/jquery-3.6.0.js"
        integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.17.4/xlsx.full.min.js"></script>
<script>
    document.getElementById('select-all').addEventListener('change', function() {
        const checkboxes = document.querySelectorAll('.select-row');
        checkboxes.forEach(checkbox => {
            checkbox.checked = this.checked;
        });
    });

    document.getElementById('search-button').addEventListener('click', function() {
        const searchTerm = document.getElementById('search-input').value.toLowerCase();
        const rows = document.querySelectorAll('#product-data tbody tr');
        let hasResults = false;

        rows.forEach(row => {
            const customerName = row.cells[1].innerText.toLowerCase();
            const customerPhone = row.cells[3].innerText.toLowerCase();
            if (customerName.includes(searchTerm) || customerPhone.includes(searchTerm)) {
                row.style.display = '';
                hasResults = true;
            } else {
                row.style.display = 'none';
            }
        });

        document.getElementById('no-results-message').style.display = hasResults ? 'none' : '';
    });

    function exportToExcel() {
        const rows = document.querySelectorAll('#product-data tbody tr');
        const selectedRows = Array.from(rows).filter(row => row.querySelector('.select-row').checked);
        if (selectedRows.length === 0) {
            alert('Không có dữ liệu để xuất Excel.');
            return;
        }

        // Prepare Excel data
        let excelData = [['Tên nhà cung cấp', 'Số điện thoại', 'Địa chỉ','Tiền nợ nhập hàng','Mã số thuế']];
        selectedRows.forEach(row => {
            let rowData = [];
            rowData.push(row.cells[1].innerText); // Tên nhà cung cấp
            rowData.push(row.cells[2].innerText); // Số điện thoại
            rowData.push(row.cells[3].innerText); // Địa chỉ
            rowData.push(row.cells[4].innerText); // Tiền nợ nhập hàng
            rowData.push(row.cells[5].innerText);//Mã số thuế
            excelData.push(rowData);
        });

        // Export to Excel
        let worksheet = XLSX.utils.aoa_to_sheet(excelData);
        let workbook = XLSX.utils.book_new();
        XLSX.utils.book_append_sheet(workbook, worksheet, 'Danh sách nhà cung cấp');
        XLSX.writeFile(workbook, 'danh_sach_nha_cung_cap.xlsx');
    }

    $(document).on('click', '.btn-delete-table', function () {
        var value = $(this).parent().parent().children().first().attr('value');
        var name = $(this).parent().parent().children().first().attr('nameSupplier');
        doDelete(value, name);
    });

    function doDelete(id, name) {
        if (confirm("Bạn có muốn xóa nhà cung cấp <" + name + ">")) {
            window.location = "DeleteSupplierServlet?id=" + id;
        }
    }

</script>
<script>
    $(document).ready(function() {
        $('#uploadForm').on('submit', function(e) {
            e.preventDefault(); // Ngăn form submit mặc định
            console.log('Form submitted');

            var formData = new FormData(this);

            $.ajax({
                type: "POST",
                url: "import",
                data: formData,
                processData: false,
                contentType: false,
                success: function(response) {
                    if (typeof response === 'string') {
                        try {
                            response = JSON.parse(response);
                        } catch (e) {
                            alert("Lỗi khi parse JSON: " + e.message);
                            return;
                        }
                    }

                    if (response.error) {
                        alert("Lỗi: " + response.error); // Hiển thị thông báo lỗi
                        window.location.href = "/supplier";
                    } else {
                        // Chuyển hướng đến trang test-cases nếu thành công
                        window.location.href = "/supplier";
                    }
                },
                error: function(xhr, status, error) {
                    alert("Lỗi: " + error); // Xử lý lỗi nếu gọi Ajax không thành công
                }
            });
        });
    });
    document.getElementById('fileInput').addEventListener('change', function(e) {
        const file = e.target.files[0];
        if (!file) {
            return;
        }

        const reader = new FileReader();
        reader.onload = function(event) {
            const data = new Uint8Array(event.target.result);
            const workbook = XLSX.read(data, {type: 'array'});
            const sheetName = workbook.SheetNames[0];
            const worksheet = workbook.Sheets[sheetName];
            const jsonData = XLSX.utils.sheet_to_json(worksheet, {header: 1});
            const suppliers = [];

            for (let i = 1; i < jsonData.length; i++) {
                const row = jsonData[i];
                const supplier = {
                    supplierName: row[0],
                    supplierPhone: row[1],
                    supplierAddress: row[2],
                    debt: row[3],
                    tax: row[4]
                };
                suppliers.push(supplier);
            }

            // Process data as needed
            console.log('Uploaded data:', suppliers);
            alert('Tải lên thành công');
            // Optionally update UI or perform other actions
        };

        reader.readAsArrayBuffer(file);
    });
</script>
<script>
    function removeVietnameseTones(str) {
        str = str.normalize('NFD').replace(/[\u0300-\u036f]/g, '');
        return str.replace(/đ/g, 'd').replace(/Đ/g, 'D');
    }

    document.getElementById('search-input').addEventListener('input', function() {
        const searchTerm = removeVietnameseTones(this.value.toLowerCase());
        const isNumber = !isNaN(searchTerm);
        const rows = document.querySelectorAll('#product-data tbody tr');
        let hasVisibleRows = false;

        rows.forEach(function(row) {
            const name = removeVietnameseTones(row.querySelector('td[nameSupplier]').textContent.toLowerCase());
            const phone = row.querySelector('td[nameSupplierPhone]').textContent.toLowerCase();

            if (isNumber ? phone.includes(searchTerm) : name.includes(searchTerm)) {
                row.style.display = '';
                hasVisibleRows = true;
            } else {
                row.style.display = 'none';
            }
        });

        document.getElementById('no-results-message').style.display = hasVisibleRows ? 'none' : 'block';
    });
</script>
</body>
</html>
