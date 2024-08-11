<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Phiếu Xuất Kho</title>
    <link rel="stylesheet" href="../css/detailImport.css">
    <style>
        /* Modal styles */
        .modal {
            display: none; /* Hidden by default */
            position: fixed; /* Stay in place */
            z-index: 1; /* Sit on top */
            padding-top: 100px; /* Location of the box */
            left: 0;
            top: 0;
            width: 100%; /* Full width */
            height: 100%; /* Full height */
            overflow: auto; /* Enable scroll if needed */
            background-color: rgb(0,0,0); /* Fallback color */
            background-color: rgba(0,0,0,0.9); /* Black w/ opacity */
        }

        /* Modal Content (Image) */
        .modal-content {
            margin: auto;
            display: block;
            width: 80%;
            max-width: 700px;
        }

        /* Caption of Modal Image */
        .modal-caption {
            margin: auto;
            display: block;
            width: 80%;
            max-width: 700px;
            text-align: center;
            color: #ccc;
            padding: 10px 0;
            height: 150px;
        }

        /* Add Animation */
        .modal-content, .modal-caption {
            -webkit-animation-name: zoom;
            -webkit-animation-duration: 0.6s;
            animation-name: zoom;
            animation-duration: 0.6s;
        }

        @-webkit-keyframes zoom {
            from {-webkit-transform:scale(0)}
            to {-webkit-transform:scale(1)}
        }

        @keyframes zoom {
            from {transform:scale(0.1)}
            to {transform:scale(1)}
        }

        /* The Close Button */
        .close {
            position: absolute;
            top: 50px;
            right: 50px;
            color: #f1f1f1;
            font-size: 40px;
            font-weight: bold;
            transition: 0.3s;
        }

        .close:hover,
        .close:focus {
            color: #bbb;
            text-decoration: none;
            cursor: pointer;
        }
    </style>
</head>
<body>
<div class="container">
    <div class="header">
        <h2>Chi tiết phiếu xuất kho</h2>
        <button onclick="goToServlet()" class="close-btn">X</button>
    </div>
    <div class="info-section">
        <div class="info-block">
            <label>Tạo Bởi:</label>
            <span>${c}</span>
            <label>Mã người tạo:</label>
            <span>${idCre}</span>
        </div>
        <div class="info-block">
            <label>Nguồn nhập:</label>
            <span>${nCustomer}</span>
            <label>Mã Nguồn nhập:</label>
            <span>${idCustomer}</span>
        </div>
        <div class="info-block">
            <label>Mã phiếu:</label>
            <span>${idExport}</span>
        </div>
        <div class="info-block">
            <label>Thời gian:</label>
            <span>${time}</span>
        </div>
        <div class="info-block">
            <label>Ghi chú:</label>
            <span>${note}</span>
        </div>
    </div>
    <form action="detailExport" method="post">
        <div class="table-section">
            <table>
                <thead>
                <tr>
                    <th>Tên mặt hàng</th>
                    <th>Mã hàng</th>
                    <th>Hãng xe</th>
                    <th>Kho lưu trữ</th>
                    <th>Vị trí kho</th>
                    <th>Đơn giá (VND)</th>
                    <th>Số lượng</th>
                    <th>Đơn vị tính</th>
                    <th>Tổng tiền (VND)</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${list}" var="lis" varStatus="status">
                    <tr>
                        <td>${lis.getProd().getProduct_name()}</td>
                        <td>${lis.getProd().getP_id()}</td>
                        <td>${lis.getProd().getCar_id().getCarName()}</td>
                        <td>${lis.getnShipment()}</td>
                        <td>${lis.getnWarehouse()}</td>
                        <td class="number">${lis.getProd().getSale_price()}</td>
                        <td>${lis.getExport_quantity()}</td>
                        <td>${lis.getProd().getUnit()}</td>
                        <td class="number">${lis.getProduct_total()}</td>
                    </tr>
                    <input type="hidden" name="products[${status.index}].export_quantity" value="${lis.getExport_quantity()}" />
                    <input type="hidden" name="products[${status.index}].p_id" value="${lis.getProd().getP_id()}"/>
                    <input type="hidden" name="products[${status.index}].product_total" value="${lis.getProduct_total()}" />
                    <input type="hidden" value="${idCustomer}" name="idCustomer"/>
                    <input type="hidden" value="${idExport}" name="idExport"/>
                </c:forEach>
                </tbody>
                <tfoot>
                <tr>
                    <td colspan="8">Chiết khấu %</td>
                    <td class="number">${discount}</td>
                </tr>
                <tr>
                    <td colspan="8">Tổng</td>
                    <td class="number">${total}</td>
                </tr>
                <tr>
                    <td colspan="8">Đã thanh toán</td>
                    <td class="number">${paid}</td>
                </tr>
                <tr>
                    <td colspan="8">Chưa thanh toán</td>
                    <td class="number">${owed}</td>
                </tr>
                </tfoot>
            </table>
        </div>
        <c:if test="${empty ms}">
            <div class="status-section" style="text-align: center">
                <img src="${img}" id="myImg" style="cursor: pointer;">
            </div>
        </c:if>
        <h3 style="text-align: center; color: red">${ms}</h3>
    </form>
</div>

<!-- The Modal -->
<div id="myModal" class="modal">
    <span class="close">&times;</span>
    <img class="modal-content" id="img01">
    <div class="modal-caption" id="caption"></div>
</div>

<script>
    document.querySelectorAll('.number').forEach(function (element) {
        let number = parseFloat(element.textContent);
        element.textContent = number.toLocaleString('de-DE'); // Using 'de-DE' locale for dots as thousands separators
    });

    function goToServlet() {
        window.location.href = "listExportServlet";
    }

    // Get the modal
    var modal = document.getElementById("myModal");

    // Get the image and insert it inside the modal - use its "alt" text as a caption
    var img = document.getElementById("myImg");
    var modalImg = document.getElementById("img01");
    var captionText = document.getElementById("caption");
    img.onclick = function() {
        modal.style.display = "block";
        modalImg.src = this.src;
        captionText.innerHTML = this.alt;
    }

    // Get the <span> element that closes the modal
    var span = document.getElementsByClassName("close")[0];

    // When the user clicks on <span> (x), close the modal
    span.onclick = function() {
        modal.style.display = "none";
    }
</script>
</body>
</html>
