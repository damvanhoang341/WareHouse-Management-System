<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý phiếu nhập kho</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/export.css" type="text/css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/common.css" type="text/css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css" type="text/css">
</head>
<body>
<div class="form-main" style="display: flex">
    <%@include file="../function.jsp"%>
    <!--  phần nhét code -->
    <form action="ExportServlet" method="post" enctype="multipart/form-data" onsubmit="return validateForm()">

    <main>
            <div class="header-main">
                <h2 style="font-weight: bold;  text-align: center;">Phiếu xuất hàng</h2>
            </div>
            <div class="inputInfo">
                <div class="infoBill">
                    <table class="info">
                        <thead>
                        <tr>
                            <td>
                                Quyền hạn:
                                <c:choose>
                                    <c:when test="${sessionScope.account.roleId == 1}">
                                        Admin
                                    </c:when>
                                    <c:when test="${sessionScope.account.roleId == 2}">
                                        Manager
                                    </c:when>
                                    <c:otherwise>
                                        Unknown Role
                                    </c:otherwise>
                                </c:choose>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                Mã phiếu:
                                <input type="text" class="atb-input input-group form-control shadow-none"
                                       name="orderCode" value="<%= generateRandomCode() %>" readonly />
                                <%!
                                    private String generateRandomCode() {
                                        int length = 8;
                                        String characters = "0123456789";
                                        StringBuilder code = new StringBuilder();
                                        java.util.Random random = new java.util.Random();
                                        for (int i = 0; i < length; i++) {
                                            code.append(characters.charAt(random.nextInt(characters.length())));
                                        }
                                        return code.toString();
                                    }
                                %>
                            </td>
                        </tr>
                        </thead>
                        <tbody>
                        <tr>
                            <td>
                                Khách hàng*
                                <select id="nameSelect" class="atb-input input-group form-control shadow-none" name="customer" onchange="updateInfo()">
                                    <option value="0">-- Chọn khách hàng --</option>
                                    <c:forEach items="${lc}" var="c">
                                        <option value="${c.customerId}" data-phone="${c.customerPhone}" data-address="${c.customerAddress}" >
                                                ${c.customerName}
                                        </option>

                                    </c:forEach>
                                </select>

                                Phone:
                                <input type="text" class="atb-input input-group form-control shadow-none" id="phone" readonly>
                                Địa chỉ:
                                <input type="text" class="atb-input input-group form-control shadow-none" id="address" readonly>

                            </td>
                        </tr>
                        <tr>
                            <td>
                                Ngày nhập *
                                <input type="text" name="day" class="atb-input input-group form-control shadow-none" value="<%= new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date()) %>" readonly />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <input type="text" name="note" class="atb-input input-group form-control shadow-none" placeholder="Ghi chú..." />
                            </td>
                        </tr>
                        </tbody>

                    </table>
                </div>
                <div class="product">
                    <div class="searchProd" style="display: flex">
                        <input type="text" id="searchInput" onkeyup="searchProduct()" placeholder="Tìm kiếm tên hàng hóa"/>
                    </div>
                    <!-- Thêm phần tử hiển thị thông báo khi không có kết quả -->
                    <p id="noResultsMessage" style="display: none; color: red;">Không có kết quả phù hợp</p>
                    <table id="productTable">
                        <thead>
                        <tr>
                            <th style="width: 200px">Tên mặt hàng</th>
                            <th>Mã hàng</th>
                            <th>Hãng xe</th>
                            <th>Giá bán (VND)</th>
                            <th>Kho</th>
                            <th>Lô hàng</th>
                            <th>Giá hàng</th>
                            <th>Số lượng tồn</th>
                            <th>Đơn vị tính</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${list}" var="lis">
                            <tr onclick="selectProduct(this)">
                                <td style="width: 200px" nameProd="${lis.product_name}">${lis.product_name}</td>
                                <td>${lis.p_id}</td>
                                <td>${lis.car_name}</td>
                                <td>${lis.sale_price}</td>
                                <td>${lis.nameWareH}</td>
                                <td>${lis.place}</td>
                                <td>${lis.sub_place}</td>
                                <td>${lis.inventory}</td>
                                <td>${lis.unit}</td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>

            <div class="listProduct" style="border: #888888">
                <h4 style="font-weight: bold">Danh sách hàng trong phiếu</h4>
                <div class="listProductChoose">
                    <table id="selectedProductTable">
                        <thead>
                        <tr>
                            <th style="width: 200px">Tên mặt hàng</th>
                            <th>Mã hàng</th>
                            <th>Hãng xe</th>
                            <th>Giá bán (VND)</th>
                            <th>Kho</th>
                            <th>Lô hàng</th>
                            <th>Giá hàng</th>
                            <th>Số lượng</th>
                            <th>Đơn vị tính</th>
                            <th>Tổng tiền (VND)</th>
                            <th>Xóa</th>
                        </tr>
                        </thead>
                        <tbody>
                        <!-- Rows will be added dynamically here -->
                        </tbody>
                        <tfoot>
                        <tr>
                            <td style="text-align: left; font-weight: bold; width: 1250px">Chiết khấu (%):</td>
                        </tr>
                        <tr>
                            <td>
                                <input type="number" name="discount" id="discount" class="form-control" value="0" step="0.001" min="0" max="100" oninput="updateTotalPrice()"/>
                            </td>
                        </tr>
                        <tr>
                            <td style="text-align: left; font-weight: bold; width: 200px">Tổng tiền:</td>
                        </tr>
                        <tr>
                            <td id="totalPrice">0 VND</td>
                        </tr>
                        <tr>
                            <td style="text-align: left; font-weight: bold; width: 1250px">Số tiền đã thanh toán:</td>
                        </tr>
                        <tr>
                            <td>
                                <input type="number" name="amountPaid" id="amountPaid" class="form-control" value="0" step="0.001" min="0" oninput="updateRemainingDebt()"/>
                            </td>
                        </tr>
                        <tr>
                            <td style="text-align: left; font-weight: bold; width: 1250px">Nợ còn lại:</td>
                        </tr>
                        <tr>
                            <td id="remainingDebt">0 VND</td>
                        </tr>
                        </tfoot>
                    </table>
                </div>
            </div>

            <!-- Sở cứ section -->
            <div class="evidence-section">
                <h4 style="font-weight: bold">Sở cứ</h4>
                <div class="input-group mb-3">
                    <input type="file" class="form-control" id="evidenceUpload" name="evidenceUpload" required>
                    <label class="input-group-text" for="evidenceUpload">Upload</label>
                </div>
                <div id="evidencePreview"></div>
            </div>
            <div class="funcBill">
                ${ms}
                <button type="submit" style="margin-left: 43%" class="button-71">Tạo phiếu</button>
            </div>
        </main>
    </form>
</div>
<!-- bootstrap -->

<script>
    function updateInfo() {
        const select = document.getElementById("nameSelect");
        const phoneInput = document.getElementById("phone");
        const addressInput = document.getElementById("address");


        const selectedOption = select.options[select.selectedIndex];
        const phone = selectedOption.getAttribute("data-phone");
        const address = selectedOption.getAttribute("data-address");



        phoneInput.value = phone || "";
        addressInput.value = address || "";

    }

</script>
<script src="../js/export.js"></script>

</body>
</html>
