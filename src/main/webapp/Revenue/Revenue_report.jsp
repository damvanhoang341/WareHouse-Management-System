<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>Báo Cáo Doanh Thu</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css">
    <style>
        .container {
            margin-top: 50px;
        }

        .card {
            margin-top: 20px;
        }

        #detailTable {
            margin-top: 20px;
        }

        .error-message {
            color: red;
            font-weight: bold;
            text-align: center;
            margin-top: 10px;
        }

        .negative-revenue {
            color: red;
            font-weight: bold;
        }
    </style>
</head>

<body>
<div class="revenue" style="display: flex">
    <%@include file="/function.jsp"%>
    <div class="container">
        <h2 class="text-center mb-4">Báo Cáo Doanh Thu</h2>
        <form method="get" action="RevenueReportServlet" id="reportForm">
            <div class="form-row align-items-center">
                <div class="col-sm-3 my-1">
                    <label for="month" class="sr-only">Chọn Tháng</label>
                    <select class="form-control" id="month" name="month">
                        <c:forEach var="i" begin="1" end="12">
                            <option value="${i}" <c:if test="${i == selectedMonth}">selected</c:if>>Tháng ${i}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="col-sm-3 my-1">
                    <label for="year" class="sr-only">Chọn Năm</label>
                    <select class="form-control" id="year" name="year">
                        <c:forEach var="i" begin="2020" end="2100">
                            <option value="${i}" <c:if test="${i == selectedYear}">selected</c:if>>Năm ${i}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="col-sm-3 my-1">
                    <button type="submit" class="btn btn-primary btn-block">Xem Báo Cáo</button>
                </div>
            </div>
        </form>
        <c:if test="${not empty totalRevenue}">
            <div class="card">
                <div class="card-body">
                    <h5 class="card-title">Doanh Thu Tháng ${selectedMonth}/${selectedYear}</h5>
                    <p class="card-text">Tổng Doanh Thu: ${totalRevenue} VND</p>
                    <button type="button" class="btn btn-success btn-block" onclick="toggleDetailTable()">
                        Xem Chi Tiết
                    </button>
                </div>
            </div>
        </c:if>

        <c:if test="${totalRevenue < 0}">
            <p class="error-message">Doanh thu bị âm</p>
        </c:if>

        <!-- Modal -->
        <div id="detailTable" style="display: none;">
            <h5 class="text-center mt-3">Chi Tiết Doanh Thu Tháng ${selectedMonth}/${selectedYear}</h5>
            <table class="table table-bordered">
                <thead>
                <tr>
                    <th scope="col">Ngày</th>
                    <th scope="col">Doanh Thu</th>
                </tr>
                </thead>
                <tbody id="detailTableBody">
                <c:forEach items="${revenue}" var="r">
                    <tr>
                        <td>${r.date}</td>
                        <td class="${r.money < 0 ? 'negative-revenue' : ''}">${r.money}</td>
                        <td class="${r.money < 0 ? 'negative-revenue' : ''}">
                            <c:if test="${r.money < 0}">Bị âm</c:if>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
            <div class="text-center">
                <button type="button" class="btn btn-secondary" onclick="toggleDetailTable()">Đóng</button>
            </div>
        </div>
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.3/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

<script>
    function toggleDetailTable() {
        $('#detailTable').toggle();
    }
</script>

</body>

</html>
