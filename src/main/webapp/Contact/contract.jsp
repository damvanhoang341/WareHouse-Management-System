<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Hợp đồng cung cấp linh kiện ô tô</title>
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6">
    <style>
        body {
            padding: 20px;
        }
        .contract-header {
            text-align: center;
            margin-bottom: 30px;
        }
        .contract-content {
            margin-bottom: 20px;
        }
        .contract-content p {
            margin-bottom: 5px;
        }
        table {
            width: 100%;
            margin-bottom: 20px;
        }
        table, th, td {
            border: 1px solid black;
            border-collapse: collapse;
        }
        th, td {
            padding: 10px;
            text-align: left;
        }
    </style>
</head>

<div class="main_file" style="display: flex">
    <%@include file="../function.jsp" %>
    <main>
<div class="container" >

    <div class="contract-header">
        <h1>CỘNG HÒA XÃ HỘI CHỦ NGHĨA VIỆT NAM</h1>
        <h2>Độc lập - Tự do - Hạnh phúc</h2>
        <hr>
        <h3>HỢP ĐỒNG CUNG CẤP LINH KIỆN Ô TÔ</h3>
    </div>
    <form id="contractForm" action="/generateContract" method="post">
        <div class="contract-content">
            <p><strong>Căn cứ:</strong> Bộ luật dân sự 2015</p>
            <p>Hôm nay, ngày <input type="date" name="contractDate" class="form-control" required>, tại <input type="text" name="contractLocation" class="form-control" >, chúng tôi gồm:</p>
        </div>
        <div class="form-group">
            <h4>BÊN A: (Bên bán)</h4>
            <label for="sellerName">Tên:</label>
            <input type="text" class="form-control" name="sellerName"  id="sellerName" placeholder="Nhập tên bên bán" >
            <label for="sellerID">CMND số:</label>
            <input type="text" class="form-control" name="sellerID" id="sellerID" placeholder="Nhập số CMND" >
            <label for="sellerAddress">Địa chỉ thường trú:</label>
            <input type="text" class="form-control" name="sellerAddress"  id="sellerAddress" placeholder="Nhập địa chỉ" >
            <label for="sellerTax">Mã số thuế:</label>
            <input type="text" class="form-control" name="sellerTax" id="sellerTax" placeholder="Nhập mã số thuế" >
            <label for="sellerPhone">Số điện thoại liên lạc:</label>
            <input type="text" class="form-control" name="sellerPhone" id="sellerPhone" placeholder="Nhập số điện thoại" >
        </div>
        <div class="form-group">
            <h4>BÊN B: (Bên mua)</h4>
            <label for="buyerName">Tên:</label>
            <input type="text" class="form-control" name="buyerName" id="buyerName" placeholder="Nhập tên bên mua" >
            <label for="buyerID">CMND số:</label>
            <input type="text" class="form-control" name="buyerID" id="buyerID" placeholder="Nhập số CMND" >
            <label for="buyerAddress">Địa chỉ thường trú:</label>
            <input type="text" class="form-control" name="buyerAddress" id="buyerAddress" placeholder="Nhập địa chỉ" >
            <label for="buyerTax">Mã số thuế:</label>
            <input type="text" class="form-control" name="buyerTax" id="buyerTax" placeholder="Nhập mã số thuế" >
            <label for="buyerPhone">Số điện thoại liên lạc:</label>
            <input type="text" class="form-control" name="buyerPhone" id="buyerPhone" placeholder="Nhập số điện thoại" >
        </div>
        <div class="contract-content">
            <h4>ĐIỀU 1: Nội dung của hợp đồng</h4>
            <p>1. Đối tượng của hợp đồng: Cung cấp linh kiện ô tô theo danh sách dưới đây:</p>
            <table id="itemListTable">
                <thead>
                <tr>
                    <th>STT</th>
                    <th>Tên mặt hàng</th>
                    <th>Giá nhập</th>
                </tr>
                </thead>
                <tbody>
                <tr>
                    <td><input type="text" class="form-control" name="itemIndex" placeholder="STT"></td>
                    <td><input type="text" class="form-control" name="itemName" placeholder="Tên mặt hàng"></td>
                    <td><input type="text" class="form-control" name="itemPrice" placeholder="Giá nhập"></td>
                </tr>
                </tbody>
            </table>
            <button type="button" class="btn btn-secondary" onclick="addRow()">Thêm hàng</button>
            <p>2. Địa điểm giao hàng: <input type="text" name="deliveryLocation" class="form-control" placeholder="Nhà xưởng số ..." ></p>
        </div>
        <div class="contract-content">
            <h4>ĐIỀU 2: Thời hạn thực hiện hợp đồng</h4>
            <p>Hợp đồng được thực hiện từ ngày <input type="date" name="startDate" class="form-control" required> đến ngày <input type="date" name="endDate" class="form-control" >.</p>
        </div>
        <div class="contract-content">
            <h4>Chữ ký của các bên</h4>
            <div class="row">
                <div class="col-md-6 text-center">
                    <p><strong>BÊN A</strong></p>
                    <p>(Ký và ghi rõ họ tên)</p>
                    <br><br><br>
                </div>
                <div class="col-md-6 text-center">
                    <p><strong>BÊN B</strong></p>
                    <p>(Ký và ghi rõ họ tên)</p>
                    <br><br><br>
                </div>
            </div>
        </div>
        <button type="submit" class="btn btn-primary">Xuất ra file Word</button>
    </form>
</div>
    </main>
</div>

<script>
    function addRow() {
        var table = document.getElementById("itemListTable").getElementsByTagName('tbody')[0];
        var newRow = table.insertRow(table.rows.length);
        var cell1 = newRow.insertCell(0);
        var cell2 = newRow.insertCell(1);
        var cell3 = newRow.insertCell(2);

        cell1.innerHTML = '<input type="text" class="form-control" name="itemIndex" placeholder="STT">';
        cell2.innerHTML = '<input type="text" class="form-control" name="itemName" placeholder="Tên mặt hàng">';
        cell3.innerHTML = '<input type="text" class="form-control" name="itemPrice" placeholder="Giá nhập">';
    }
</script>

</html>
