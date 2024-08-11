<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>THỐNG KÊ</title>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f8f9fa;
        }
        .header{
            display: flex;
            justify-content: space-between;
        }
        .container {
            width: 100%;
            margin-bottom: 20px;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);

            height: auto;
        }

        .body_container {
            margin-top: 20px;
            height: auto;
        }

        .dashboard {
            display: flex;
            justify-content: space-around;
            flex-wrap: wrap;
            gap: 20px;
            height: 60%;
        }

        .card {
            flex: 1 1 200px;
            padding: 20px;
            border-radius: 10px;
            color: #fff;
            text-align: center;
            position: relative;
        }

        .card .icon {
            font-size: 40px;
            margin-bottom: 10px;
        }

        .card .number {
            font-size: 30px;
            font-weight: bold;
            margin-bottom: 5px;
        }

        .card .label {
            font-size: 16px;
        }

        .card.gradient1 {
            background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
        }

        .card.gradient2 {
            background: linear-gradient(135deg, #5ee7df 0%, #b490ca 100%);
        }

        .card.gradient3 {
            background: linear-gradient(135deg, #c3cfe2 0%, #c3cfe2 100%);
        }

        .card.gradient4 {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        }

        .chart-container {

            align-items: center;
            flex-direction: column;
        }

        .chart-wrapper {
            width: 300px; /* Đặt chiều rộng của biểu đồ */
            height: 300px; /* Đặt chiều cao của biểu đồ */
            align-self: flex-start; /* Di chuyển biểu đồ sát bên trái */
        }

        .chart-container canvas {
            width: 100% !important;
            height: 100% !important;
        }

        .legend {
            margin-left: 70px;
            margin-top: 20px;
        }

        .legend .dot {
            height: 10px;
            width: 10px;
            border-radius: 50%;
            display: inline-block;
            margin-right: 5px;
        }

        .legend .import {
            background-color: #ff6384;
        }

        .legend .export {
            background-color: #36a2eb;
        }

        .legend span {
            margin-right: 20px;
        }
        .import {
            font-family: Arial, sans-serif;
            font-size: 17px;
            font-weight: bold;
        }

        .export {
            font-family: Arial, sans-serif;
            font-size: 17px;
            font-weight: bold;
        }
        .chart-right {
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            height: 200px; /* Chiều cao của container, điều chỉnh theo nhu cầu */
            padding: 20px;
            box-sizing: border-box;
        }
        .body_chart{
            width: 70%;
            padding: 20px;
            margin-bottom: 20px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            justify-content: center;
            align-content: center;
            height: auto;
        }
    </style>
    <script>
        window.onload = function() {
            const today = new Date().toISOString().substr(0, 10);
            document.getElementById("dateInput").value = today;
            document.getElementById("dateForm").submit();
        }
    </script>
</head>

<body>
<div class="func" style="display: flex">
    <%@include file="function.jsp"%>
    <main>
        <div class="container">
            <div class="header">
                <div><h1 style="font-size: 19px; color: #0d6efd">Thống kê</h1></div>
                <div>
                    <form action="generanity" method="get">
                        <input type="date" name="date" value="${icomedate}" onchange="this.form.submit()">
                    </form>
                </div>
            </div>

            <div class="dashboard">
                <div class="card gradient1">
                    <div class="icon">&#128100;</div>
                    <div class="number">${sz}</div>
                    <div class="label">Nhân viên</div>
                </div>
                <div class="card gradient2">
                    <div class="icon">&#128722;</div>
                    <div class="number">${szPro}</div>
                    <div class="label">Số lượng mặt hàng</div>
                </div>
                <div class="card gradient3">
                    <div class="icon">&#128722;</div>
                    <div class="number">${numberProducts}</div>
                    <div class="label">Số đơn hàng bán ra</div>
                </div>
                <div class="card gradient4">
                    <div class="icon">&#36;</div>
                    <div class="number">${income}</div>
                    <div class="label">Tiền kiếm trong ngày</div>
                </div>
            </div>
        </div>

        <div style="display: flex; justify-content: center">
            <div class="body_chart">
                <div class="header-main" style="margin-left: 40px">
                    <h4 style="color: #0d6efd">Biểu Đồ Xuất - Nhập Khẩu</h4>
                </div>
                <div class="chart-container" >
                    <div class="chart-container-body" style="display: flex">
                        <div class="chart-wrapper">
                            <canvas id="doughnutChart"></canvas>
                        </div>
                        <div class="chart-right" style="margin-left: 120px; margin-top:30px">
                            <div>
                                <div class="export">${PercentageExport} %
                                    <span style="width: 20px; height: 20px; background: #36a2eb; display:inline-block"></span>
                                    Hàng xuất khẩu</div>
                            </div>
                            <div >
                                <div class="import">${PercentageImport} %
                                    <span style="width: 20px; height: 20px; background: #ff6384; display:inline-block"></span>
                                    Hàng nhập khẩu</div>

                            </div>

                        </div>
                    </div>
                    <div class="legend">
                        <span><span class="dot import"></span> Nhập khẩu</span>
                        <span><span class="dot export"></span> Xuất khẩu</span>
                    </div>
                </div>
            </div>
        </div>


        <script>
            const ctx = document.getElementById('doughnutChart').getContext('2d');
            const doughnutChart = new Chart(ctx, {
                type: 'doughnut',
                data: {
                    labels: ['Nhập khẩu', 'Xuất khẩu'],
                    datasets: [{
                        data: [${numberimport}, ${numberexport}],
                        backgroundColor: ['#ff6384', '#36a2eb'],
                        hoverBackgroundColor: ['#ff6384', '#36a2eb']
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    plugins: {
                        legend: {
                            display: false
                        }
                    }
                }
            });
        </script>
    </main>
</div>
</body>
</html>
