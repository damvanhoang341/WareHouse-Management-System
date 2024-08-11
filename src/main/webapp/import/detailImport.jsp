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
        <h2>Chi tiết phiếu nhập kho</h2>
        <button onclick="goToServlet()" class="close-btn">X</button>
    </div>
    <div class="info-section">
        <div class="info-block">
            <label>Tạo bởi:</label>
            <span>${c}</span>
        </div>
        <div class="info-block">
            <label>Kho nhập:</label>
            <span>${ware}</span>
        </div>
        <div class="info-block">
            <label>Mã phiếu:</label>
            <span>${idImport}</span>
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
    <form action="detailImport" method="post">
        <div class="table-section">
            <table>
                <thead>
                <tr>
                    <th>Tên mặt hàng</th>
                    <th>Mã hàng</th>
                    <th>Hãng xe</th>
                    <th>Đơn giá (VND)</th>
                    <th>Nhà cung cấp</th>
                    <th>Số lượng</th>
                    <th>Đơn vị tính</th>
                    <th>Tổng tiền (VND)</th>
                    <th>Vị trí nhập kho</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${list}" var="lis" varStatus="status">
                    <tr>
                        <td>${lis.getProd().getProduct_name()}</td>
                        <td>${lis.getProd().getP_id()}</td>
                        <td>${lis.getProd().getCar_id().getCarName()}</td>
                        <td class="number">${lis.getProd().getImport_price()}</td>
                        <td>${lis.getProd().getSupplier_id().getSupplierName()}</td>
                        <td>${lis.getImport_quantity()}</td>
                        <td>${lis.getProd().getUnit()}</td>
                        <td class="number">${lis.getProduct_total()}</td>
                        <td>
                            <select name="products[${status.index}].shipment_id">
                                <c:forEach items="${shipment}" var="ship">
                                    <option value="${ship.getShipment_Id()}">
                                            ${ship.getPlace_include()}
                                    </option>
                                </c:forEach>
                            </select>
                        </td>
                    </tr>
                    <input type="hidden" name="products[${status.index}].addImport" value="${lis.getAddedImport()}" />
                    <input type="hidden" name="products[${status.index}].import_quantity" value="${lis.getImport_quantity()}" />
                    <input type="hidden" name="products[${status.index}].supplier_id" value="${lis.getProd().getSupplier_id().getSupplierId()}"/>
                    <input type="hidden" name="products[${status.index}].p_id" value="${lis.getProd().getP_id()}"/>
                    <input type="hidden" name="products[${status.index}].product_total" value="${lis.getProduct_total()}" />
                </c:forEach>
                </tbody>
                <tfoot>
                <tr>
                    <td colspan="7">Tổng</td>
                    <td class="number">${total}</td>
                </tr>
                </tfoot>
            </table>

            <div class="image-container">
                <img src="${img}" id="myImg" style="cursor: pointer;">
            </div>

            <input type="hidden" value="${total}" name="total"/>
            <input type="hidden" value="${idImport}" name="idImport"/>
            <input type="hidden" value="${addImport}" name="addImport"/>
        </div>
        <c:if test="${empty ms}">
            <div class="status-section" style="display: flex; text-align: center">
                <div>
                    <label>Duyệt bởi: ${acc}</label><br>
                    <h3>trạng thái</h3>
                    <button class="btn exported">${status}</button>
                </div>
                <table>
                    <tr>
                        <td></td>
                        <td>
                            <button type="submit" name="confirm" value="true" class="btn approve">Duyệt</button>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <textarea rows="5" cols="50" placeholder="Lý do từ chối"></textarea>
                        </td>
                        <td>
                            <button type="submit" name="confirm" value="false" class="btn reject">Từ chối</button>
                        </td>
                    </tr>
                </table>
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
        element.textContent = number.toLocaleString('de-DE');
    });

    function goToServlet() {
        window.location.href = "listImport";
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
