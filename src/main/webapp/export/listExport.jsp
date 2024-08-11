<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Warehouse Export Management</title>
    <link rel="stylesheet" href="../css/listExport.css">
</head>
<body>
<div class="mainImport" style="display: flex">
    <%@include file="../function.jsp"%>
    <main>
        <div class="container">
            <h2 style=" text-align: center;">Danh sách phiếu xuất hàng</h2>
            <div class="search-container">
                <input type="text" id="maPhieu" placeholder="Mã phiếu" class="filter-input">
                <input type="date" id="tuNgay" class="filter-input">
                <button class="button-29" id="timKiem">Tìm kiếm</button>
            </div>

            <table>
                <thead>
                <tr>
                    <th>Mã phiếu</th>
                    <th>Nguồn nhận</th>
                    <th>Người tạo phiếu</th>
                    <th>Thời gian</th>
                    <th>Chiết khấu %</th>
                    <th>Tổng tiền</th>
                    <th>Đã thanh toán</th>
                    <th>Còn nợ</th>
                    <th>Chi tiết</th>
                </tr>
                </thead>
                <tbody id="export-table-body">
                <c:forEach items="${list}" var="lis">
                    <tr>
                        <td class="ma-phieu">${lis.outputId}</td>
                        <td>${lis.customer.customerName}</td>
                        <td>${lis.sellerId.name}</td>
                        <td class="thoi-gian">${lis.outputDate}</td>
                        <td>${lis.discount}</td>
                        <td class="number">${lis.totalMoney}</td>
                        <td class="number">${lis.paid}</td>
                        <td class="number">${lis.amount_Owed}</td>

                        <td>
                            <form action="detailExport" method="get">
                                <input type="hidden" value="${lis.getSellerId().getId()}" name="idCreater">
                                <input type="hidden" value="${lis.getSellerId().getName()}" name="nCreater">
                                <input type="hidden" value="${lis.getCustomer().getCustomerId()}" name="idCustomer">
                                <input type="hidden" value="${lis.getCustomer().getCustomerName()}" name="nCustomer">
                                <input type="hidden" value="${lis.outputId}" name="outputId">
                                <input type="hidden" value="${lis.getNote()}" name="note">
                                <input type="hidden" value="${lis.outputDate}" name="time">
                                <input type="hidden" value="${lis.discount}" name="discount">
                                <input type="hidden" value="${lis.getTotalMoney()}" name="total">
                                <input type="hidden" value="${lis.getPaid()}" name="paid">
                                <input type="hidden" value="${lis.getAmount_Owed()}" name="owed">
                                <input type="hidden" value="${lis.customer.ct_Id.discount}" name="dis">

                                <input type="hidden" value="${lis.getAddedExport()}" name="addedExport">
                                <input type="hidden" value="${lis.envident}" name="img">
                                <button type="submit" class="button-29">Chi tiết</button>
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
    document.querySelectorAll('.number').forEach(function(element) {
        let number = parseFloat(element.textContent);
        element.textContent = number.toLocaleString('de-DE'); // Using 'de-DE' locale for dots as thousands separators
    });

    document.getElementById('timKiem').addEventListener('click', function() {
        const maPhieu = document.getElementById('maPhieu').value.toLowerCase();

        const tuNgay = document.getElementById('tuNgay').value;


        const rows = document.querySelectorAll('#export-table-body tr');
        rows.forEach(row => {
            const maPhieuText = row.querySelector('.ma-phieu').textContent.toLowerCase();

            const thoiGianText = row.querySelector('.thoi-gian').textContent;

            const thoiGian = new Date(thoiGianText);
            const tuNgayDate = new Date(tuNgay);


            const maPhieuMatch = maPhieu === "" || maPhieuText.includes(maPhieu);

            const tuNgayMatch = tuNgay === "" || thoiGian >= tuNgayDate;


            if (maPhieuMatch && tuNgayMatch) {
                row.style.display = '';
            } else {
                row.style.display = 'none';
            }
        });
    });
</script>

</body>
</html>
