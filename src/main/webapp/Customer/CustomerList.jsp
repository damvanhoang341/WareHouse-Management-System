<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý khách hàng</title>
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
            margin-right: 30px;
        }
    </style>
</head>

<body>
    <div class="flex-grow-1" style="display: flex">
        <%@include file="/function.jsp"%>
        <main class="w-100">
            <div class="header-main">
                <h4 style="font-weight: bold">Danh sách khách hàng</h4>
                <p style="color: green">${success}</p>
            </div>
            <div class="background-main">
                <form id="uploadForm" action="import-customer" method="post" enctype="multipart/form-data">
                    <input type="file" name="file" id="file" accept=".xls,.xlsx" required>
                    <button type="submit" title="Tải lên" class="btn btn-info">
                        <i class="fa-solid fa-plus"></i> Tải lên
                    </button>
                </form>
                <div class="toolbar d-flex justify-content-between align-items-center mb-4">
                    <div id="search" class="input-group mb-3">
                        <input id="search-input" type="text" class="form-control shadow-none" placeholder="Tìm theo tên khách hàng và số điện thoại ">
                        <button type="button" class="input-group-text" title="Tìm kiếm" id="search-button"><i class="fa-solid fa-magnifying-glass"></i></button>
                    </div>
                    <div class="d-flex">
                        <button type="button" title="Thêm thủ công" id="btnAdd" class="btn btn-primary btn-save me-2" onclick="location.href='/addCustomerServlet'">
                            <i class="fa-solid fa-plus"></i> Thêm thủ công
                        </button>
<%--                        <button type="button" title="Thêm từ Excel" class="btn btn-secondary btn-save me-2" onclick="showUploadDialog()">--%>
<%--                            <i class="fa-solid fa-file-excel"></i> Thêm từ Excel--%>
<%--                        </button>--%>
                        <button type="button" class="btn btn-success" onclick="exportToExcel()">Xuất Excel</button>
                    </div>
                </div>
                <div id="product-data">
                    <table class="table table-bordered table-hover">
                        <thead class="thead-light sticky-top">
                        <tr>
                            <th scope="col"><input type="checkbox" id="select-all"></th>
                            <th scope="col">Tên khách hàng</th>
                            <th scope="col">Loại khách</th>
                            <th scope="col">Số điện thoại</th>
                            <th scope="col">Địa chỉ</th>
                            <th scope="col">Mã số thuế</th>
                            <th scope="col">Chiết khấu</th>
                            <th scope="col">Thao tác</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${customer}" var="c">
                            <tr>
                                <td style="vertical-align: middle;"><input type="checkbox" class="select-row"></td>
                                <td style="vertical-align: middle;" value="${c.customerId}" nameproduct="${c.customerName}">${c.customerName}</td>
                                <td style="vertical-align: middle;">${c.ct_Id.customerTypeName}</td>
                                <td style="vertical-align: middle;">${c.customerPhone}</td>
                                <td style="vertical-align: middle;">${c.customerAddress}</td>
                                <td style="vertical-align: middle;">${c.customerTax}</td>
                                <td style="vertical-align: middle;">${c.ct_Id.discount}</td>
                                <td class="table-function text-center">
                                    <form action="updateDiscountServlet" method="post">
                                        <input type="hidden" name="customerTypeId" value="${c.ct_Id.customerTypeId}">
                                        <input type="hidden" name="currentDiscount" value="${c.ct_Id.discount}">
                                        <div class="d-flex align-items-center">
                                            <button type="button" title="Sửa" class="btn btn-save btn-save-table" onclick="location.href = 'editCustomerServlet?cid=${c.customerId}'">
                                                <i class="fa-solid fa-pencil"></i>
                                            </button>
                                            <button type="button" title="Sửa chiết khấu" class="btn btn-save btn-save-table d-inline-block btn-danger text-white" data-bs-toggle="modal" data-bs-target="#editDiscountModal" onclick="setFormValues('${c.ct_Id.customerTypeId}', '${c.ct_Id.discount}')">
                                                <i class="fa-solid fa-percent"></i>
                                            </button>
                                        </div>
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
</div>

<div class="modal fade" id="editDiscountModal" tabindex="-1" aria-labelledby="editDiscountModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="editDiscountModalLabel">Chỉnh sửa chiết khấu</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form id="editDiscountForm" action="updateDiscountServlet" method="post">
                    <div class="mb-3">
                        <span class="atb-name defaultCursor">Loại khách hàng<span style="color: red"> *</span></span>
                        <select id="customerTypeId" name="customerTypeId" disabled class="form-control">
                            <c:forEach var="ct" items="${customertype}">
                                <option value="${ct.customerTypeId}">${ct.customerTypeName}</option>
                            </c:forEach>
                        </select>
                        <input type="hidden" id="hiddenCustomerTypeId" name="customerTypeId">
                    </div>

                    <div class="mb-3">
                        <label for="editDiscount" class="form-label">Chiết khấu mới</label>
                        <input type="number" step="0.01" class="form-control" id="editDiscount" name="newDiscount" required min="0">
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                        <button type="submit" class="btn btn-primary">Lưu</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
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
        let excelData = [['Tên khách hàng', 'Loại khách', 'Số điện thoại','Địa chỉ','Mã số thuế', 'Chiết khấu']];
        selectedRows.forEach(row => {
            let rowData = [];
            rowData.push(row.cells[1].innerText); // Tên khách hàng
            rowData.push(row.cells[2].innerText); // Loại khách
            rowData.push(row.cells[3].innerText); // Số điện thoại
            rowData.push(row.cells[4].innerText); //Địa Chỉ
            rowData.push(row.cells[5].innerText); // Mã số thuế
            rowData.push(row.cells[6].innerText); // Chiết khấu
            excelData.push(rowData);
        });

        // Export to Excel
        let worksheet = XLSX.utils.aoa_to_sheet(excelData);
        let workbook = XLSX.utils.book_new();
        XLSX.utils.book_append_sheet(workbook, worksheet, 'Danh sách khách hàng');
        XLSX.writeFile(workbook, 'danh_sach_khach_hang.xlsx');
    }

    function setFormValues(customerTypeId, currentDiscount) {
        document.getElementById('customerTypeId').value = customerTypeId;
        document.getElementById('hiddenCustomerTypeId').value = customerTypeId;
        document.getElementById('editDiscount').value = currentDiscount;
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
<script>
    document.getElementById('editDiscountForm').addEventListener('submit', function(event) {
        var editDiscount = document.getElementById('editDiscount').value;

        if (editDiscount < 0) {
            alert('Chiết khấu không được bé hơn 0.');
            event.preventDefault(); // Prevent form submission
        }
    });
</script>
    <script>
        $(document).ready(function() {
            $('#uploadForm').on('submit', function(e) {
                e.preventDefault(); // Ngăn form submit mặc định
                console.log('Form submitted');

                var formData = new FormData(this);

                $.ajax({
                    type: "POST",
                    url: "import-customer",
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
                            window.location.href = "/CustomerServlet";
                        } else {
                            // Chuyển hướng đến trang test-cases nếu thành công
                            window.location.href = "/CustomerServlet";
                        }
                    },
                    error: function(xhr, status, error) {
                        alert("Lỗi: " + error); // Xử lý lỗi nếu gọi Ajax không thành công
                    }
                });
            });
        });

    </script>
</body>
</html>
