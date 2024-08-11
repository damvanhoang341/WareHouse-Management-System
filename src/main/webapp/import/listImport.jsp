<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Warehouse Export Management</title>
    <link rel="stylesheet" href="../css/listExport.css">
    <style>
        /* Thêm CSS tùy chỉnh ở đây nếu cần */
    </style>
</head>
<body>
<div class="mainImport" style="display: flex">
    <%@include file="../function.jsp"%>
    <main>
        <div class="container">
            <h2 style=" text-align: center;">Danh sách phiếu nhập kho</h2>
            <div class="search-container">
                <input type="text" id="maPhieu" placeholder="Mã phiếu">
                <select id="tinhTrang">
                    <option value="">Tình trạng</option>
                    <option value="Chờ duyệt">Chờ duyệt</option>
                    <option value="Từ chối">Từ chối</option>
                    <option value="Đã duyệt">Đã duyệt</option>
                </select>
                <input type="date" id="tuNgay">
                <button id="timKiem" class="button-29">Tìm kiếm</button>
            </div>

            <h3>${ms}</h3>
            <table id="importTable">
                <thead>
                <tr>
                    <th>Mã phiếu</th>
                    <th>Giá trị đơn hàng</th>
                    <th>Người tạo phiếu</th>
                    <th>Thời gian</th>
                    <th>Ghi chú</th>
                    <th>Kho nhập</th>
                    <th>Trạng thái</th>
                    <th>Thao tác</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${list}" var="lis">
                    <tr data-ma-phieu="${lis.getImport_Id()}"
                        data-tinh-trang="${lis.getCheck_Status()}"
                        data-ngay="${lis.getInput_Date()}">
                        <td>${lis.getImport_Id()}</td>
                        <td class="number">${lis.getInput_Amount()}</td>
                        <td>${lis.getAcc().getName()}</td>
                        <td>${lis.getInput_Date()}</td>
                        <td>${lis.getProblem()}</td>
                        <td>${lis.wareHouse.getName()}</td>
                        <td>${lis.getCheck_Status()}</td>
                        <td>
                            <form action="detailImport" method="get">
                                <input type="hidden" value="${lis.getImport_Id()}" name="ImportId">
                                <input type="hidden" value="${lis.getAcc().getId()}" name="idCreater">
                                <input type="hidden" value="${lis.wareHouse.getId()}" name="idWare">
                                <input type="hidden" value="${lis.getProblem()}" name="note">
                                <input type="hidden" value="${lis.getInput_Date()}" name="time">
                                <input type="hidden" value="${lis.getInput_Amount()}" name="total">
                                <input type="hidden" value="${lis.getAddedImport()}" name="addImport">
                                <input type="hidden" value="${lis.getImport_Id()}" name="idImport">
                                <input type="hidden" value="${lis.getCheck_Status()}" name="status">
                                <input type="hidden" value="${lis.getEnvident()}" name="img">
                                <button type="submit" class="button-29">Xét duyệt</button>
                            </form>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </main>
</div>

<script>
    // Định dạng số với phân cách hàng nghìn
    document.querySelectorAll('.number').forEach(function(element) {
        let number = parseFloat(element.textContent);
        element.textContent = number.toLocaleString('de-DE'); // Sử dụng 'de-DE' cho dấu chấm phân cách hàng nghìn
    });

    // Hàm lọc bảng
    document.getElementById('timKiem').addEventListener('click', function() {
        var maPhieu = document.getElementById('maPhieu').value.toLowerCase();
        var tinhTrang = document.getElementById('tinhTrang').value.toLowerCase();
        var tuNgay = document.getElementById('tuNgay').value;

        var rows = document.querySelectorAll('#importTable tbody tr');

        rows.forEach(function(row) {
            var rowMaPhieu = row.getAttribute('data-ma-phieu').toLowerCase();
            var rowTinhTrang = row.getAttribute('data-tinh-trang').toLowerCase();
            var rowNgay = row.getAttribute('data-ngay');

            var showRow = true;

            if (maPhieu && !rowMaPhieu.includes(maPhieu)) {
                showRow = false;
            }
            if (tinhTrang && rowTinhTrang !== tinhTrang) {
                showRow = false;
            }
            if (tuNgay && rowNgay !== tuNgay) {
                showRow = false;
            }

            row.style.display = showRow ? '' : 'none';
        });
    });
</script>
</body>
</html>
