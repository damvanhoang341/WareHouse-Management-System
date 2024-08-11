<%--
  Created by IntelliJ IDEA.
  User: damva
  Date: 7/5/2024
  Time: 12:20 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Phiếu Thu Nợ</title>
    <link rel="stylesheet" href="/css/styles_SaveReceiptSlip.css">
</head>
<body>
<div class="receipt-container">
    <div class="header">
        <div class="left-header">
            <h2>Cơ Sở Bìa Sổ SIMILI TÂN PHÁT</h2>
            <p>Địa chỉ: 151 Nguyễn Ngọc Lộc, P14, Q.10</p>
            <p>Điện thoại: 3866 3279 – Fax: 3866 1114</p>
            <p>Email: biasomenu@gmail.com</p>
        </div>
        <div class="right-header">
            <p>Mẫu số: 02 - TT</p>
        </div>
    </div>
    <h1>PHIẾU THU NỢ</h1>
    <div class="head-slip" style="display: flex; justify-content: center;">
        <div class="form-group date">
            <label for="date">Ngày:</label>
            <input type="text" id="date" name="date" class="dotted-input" value="${receipt.date}">
        </div>
        <div class="form-group id">
            <label for="so">Số Phiếu:</label>
            <input type="text" id="so" name="so" class="dotted-input" value="${receipt.idPhieu}" >
        </div>
    </div>
    <div class="form-group">
        <label for="hoten">Họ và tên người nộp tiền:</label>
        <input type="text" id="hoten" name="hoten" class="dotted-input long-input" value="${CustomerById.customerName}">
    </div>
    <div class="form-group">
        <label for="diachi">Địa chỉ:</label>
        <input type="text" id="diachi" name="diachi" class="dotted-input long-input">
    </div>
    <div class="form-group">
        <label for="kemtheo">Người nhận tiền:</label>
        <input type="text" id="kemtheo" name="kemtheo" class="dotted-input" value="${UserById.name}">
    </div>
    <div class="form-group">
        <label for="lydo">Lý do nộp:</label>
        <input type="text" id="lydo" name="lydo" class="dotted-input long-input" value="${receipt.dienG}">
    </div>
    <div class="form-group">
        <label for="sotien">Số tiền:</label>
        <input type="text" id="sotien" name="sotien" class="dotted-input" value="${receipt.count}" >
    </div>
    <div class="signature-section">
        <div class="signature-block">
            <p>Người lập phiếu</p>
            <p>(Ký, họ tên)</p>
        </div>
        <div class="signature-block">
            <p>Người nộp tiền</p>
            <p>(Ký, họ tên)</p>
        </div>
        <div class="signature-block">
            <p>Chủ cơ sở</p>
            <p>(Ký, họ tên)</p>
        </div>
    </div>
</div>
</body>
</html>
