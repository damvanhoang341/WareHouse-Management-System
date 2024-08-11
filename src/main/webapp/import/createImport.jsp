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
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/import.css" type="text/css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/common.css" type="text/css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css" type="text/css">
</head>
<body>
<div class="form-main" style="display: flex">
    <%@include file="../function.jsp"%>
    <!--  phần nhét code -->
    <form action="importServlet" method="post" enctype="multipart/form-data">
        <main>
            <div class="header-main">
                <h2 style="font-weight: bold;  text-align: center;">Phiếu nhập kho</h2>
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
                                    <c:when test="${sessionScope.account.roleId == 3}">
                                        Staff
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

                                    Nơi nhập kho*
                                    <select class="atb-input input-group form-control shadow-none" name="wareHouse">
                                        <c:forEach items="${lware}" var="lw">
                                            <option value="${lw.id}">${lw.name}</option>
                                        </c:forEach>
                                    </select>

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
                            <th>Đơn giá (VND)</th>
                            <th>Nhà cung cấp</th>
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
                                    <td>${lis.price}</td>
                                    <td>${lis.supplier.getSupplierName()}</td>
                                    <td>${lis.getInventory()}</td>
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
                            <th>Đơn giá (VND)</th>
                            <th>Nhà cung cấp</th>
                            <th>Số lượng</th>
                            <th>Đơn vị tính</th>
                            <th>Tổng tiền (VND)</th>
                            <th>Xóa</th>
                        </tr>
                        </thead>

                        <tbody>

                        </tbody>

                        <tfoot >
                        <tr>
                        <td style="text-align: center; font-weight: bold; width: 100px">Tổng đơn giá:</td>
                        </tr>
                        <tr>

                            <td id="totalPrice" style="font-weight: bold;text-align: center; width: 100px">0 VND</td>
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
                <button type="submit" class="button-71">Tạo phiếu</button>
            </div>
        </main>
    </form>
</div>
<!-- bootstrap -->
<script src="../js/import.js">

</script>
</body>
</html>
