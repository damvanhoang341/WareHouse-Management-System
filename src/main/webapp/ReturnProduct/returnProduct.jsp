<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <style>
        table {
            width: 100%;
            border-collapse: collapse;
        }

        th, td {
            border: 1px solid #000;
            padding: 5px;
            text-align: left;
        }

        .container {
            width: 90%;
            margin: auto;
        }

        .header {
            display: flex;
            justify-content: space-between;
        }

        .header div {
            margin: 5px;
        }

        .footer {
            margin-top: 20px;
            display: flex;
            justify-content: space-between;
        }

        .footer div {
            margin: 5px;
        }

        .buttons {
            margin-top: 10px;
            display: flex;
            justify-content: space-between;
        }
    </style>
</head>
<body>
<div class="container">
    <div class="header">
        <div>
            <label for="partner">Đối tác*</label>
            <select id="partner">
                <option value="khach_le">Khách lẻ</option>
            </select>
        </div>
        <div>
            <label for="k_doanh">K.doanh*</label>
            <select id="k_doanh">
                <option value="nhan_vien">Nhân viên</option>
            </select>
        </div>
        <div>
            <label for="kho">Kho*</label>
            <select id="kho">
                <option value="kho_trung_tam">Kho trung tâm</option>
            </select>
        </div>
    </div>

    <table>
        <thead>
        <tr>
            <th>Tên hàng</th>
            <th>Mã hàng</th>
            <th>ĐVT</th>
            <th>SL bán</th>
            <th>SL Nh...</th>
            <th>Đơn giá</th>
            <th>Ngày xuất</th>
            <th>Số phiếu</th>
            <th>Serial</th>
        </tr>
        </thead>
        <tbody>
        <!-- Dynamic rows will be inserted here -->
        </tbody>
    </table>

    <div class="footer">
        <div>
            <label for="ngay">Ngày*</label>
            <input type="date" id="ngay" value="2024-06-15">
        </div>
        <div>
            <label for="tong_cong">Tổng cộng</label>
            <input type="text" id="tong_cong" disabled>
        </div>
        <div>
            <label for="tra_ngay">Trả ngay*</label>
            <input type="text" id="tra_ngay">
        </div>
        <div>
            <label for="tai_khoan">Tài khoản</label>
            <input type="text" id="tai_khoan">
        </div>
        <div>
            <label for="ghi_no">Ghi nợ*</label>
            <input type="text" id="ghi_no">
        </div>
        <div>
            <label for="dien_giai">Diễn giải</label>
            <input type="text" id="dien_giai">
        </div>
    </div>

    <table>
        <thead>
        <tr>
            <th>Tên mặt hàng</th>
            <th>Mã hàng</th>
            <th>ĐVT</th>
            <th>Giá bán</th>
            <th>Giá nhập trả</th>
            <th>Trả <=</th>
            <th>SL Trả</th>
            <th>Thành tiền</th>
            <th>Serial</th>
        </tr>
        </thead>
        <tbody>
        <!-- Dynamic rows will be inserted here -->
        </tbody>
    </table>

    <div class="buttons">
        <button>Ghi phiếu</button>
        <button>Trả phiếu</button>
        <button>Loại hàng</button>
        <button>Chọn hàng</button>
    </div>
</div>
</body>
</html>
