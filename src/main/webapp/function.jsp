<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.example.qlkh.model.User" %>
<%
    User user = (User) session.getAttribute("account");
    if (user == null) {
        response.sendRedirect("index.jsp");
        return;
    }
    int roleId = user.getRoleId();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css" type="text/css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/common.css" type="text/css">
</head>
<body>
<div id="page" class="d-flex">
    <nav id="sidebar" class="nav flex-column">
        <li style="list-style-type: none; cursor: pointer; padding: 10px; transition: background-color 0.3s ease;">
            <div class="d-flex align-items-center">
                <div class="rounded-circle logo-img me-2" style="overflow: hidden; width: 32px; height: 32px; border: 1px solid #ccc; border-radius: 50%;" onclick="location.href='userProfileServlet'">
                    <img src="${sessionScope.account.profileImage}" alt="Profile Picture" style="object-fit: cover; width: 100%; height: 100%; ">
                </div>
                <div class="nav-item logo">
                    ${sessionScope.account.name}
                </div>
            </div>
        </li>

        <menu class="d-flex justify-content-center">
            <div id="logout-btn" class="d-flex align-items-center">
                <a href="${pageContext.request.contextPath}/logout" style="text-decoration: none">
                    <i class="fa-solid fa-arrow-right-from-bracket fa-lg"></i>
                    Đăng xuất
                </a>
            </div>
        </menu>

        <% if (roleId == 1 || roleId == 2) { %>
        <li class="sidebar-item nav-item active" data-menu="0">
            <div class="nav-link d-flex">
                <div class="icon-item">
                    <i class="fa-solid fa-box-archive fa-lg"></i>
                </div>
                <div>
                    <a href="${pageContext.request.contextPath}/ListUserServlet" style="text-decoration: none; color: black"> Quản lý nhân viên</a>
                </div>
            </div>
        </li>
        <% } %>

        <li class="sidebar-item nav-item" data-menu="product">
            <div class="nav-link d-flex">
                <div class="icon-item">
                    <i class="fa-solid fa-cart-plus fa-lg"></i>
                </div>
                <div>
                    <a href="${pageContext.request.contextPath}/generanity" style="text-decoration: none; color: black">Tổng quát</a>
                </div>
            </div>
        </li>

        <li class="sidebar-item nav-item" data-menu="1">
            <div class="nav-link d-flex">
                <div class="icon-item">
                    <i class="fa-solid fa-cart-plus fa-lg"></i>
                </div>
                <div>
                    Hàng hóa
                    <ul class="sub-menu">
                        <li>
                            <a href="/CarIntro">Nhóm xe phục vụ</a>
                        </li>
                        <li>
                            <a href="${pageContext.request.contextPath}/product-category">Kho hàng hóa</a>
                        </li>
                    </ul>
                </div>
            </div>
        </li>

        <% if (roleId == 1 || roleId == 2 || roleId == 3) { %>
        <li class="sidebar-item nav-item" data-menu="2">
            <div class="nav-link d-flex">
                <div class="icon-item">
                    <i class="fa-solid fa-cart-plus fa-lg"></i>
                </div>
                <div>
                    Đối tác
                    <ul class="sub-menu">
                        <% if (roleId == 1 || roleId == 2 ) { %>
                        <li>
                            <a href="${pageContext.request.contextPath}/supplier">Danh sách đối tác nhập</a>
                        </li>
                        <% } %>
                        <li>
                            <a href="${pageContext.request.contextPath}/CustomerServlet">Khách hàng</a>
                        </li>
                    </ul>
                </div>
            </div>
        </li>
        <% } %>

        <% if (roleId == 1 || roleId == 2 || roleId == 3) { %>
        <li class="sidebar-item nav-item" data-menu="3">
            <div class="nav-link d-flex">
                <div class="icon-item">
                    <i class="fa-solid fa-cart-plus fa-lg"></i>
                </div>
                <div>
                    Xuất hàng hóa
                    <ul class="sub-menu">
                        <% if (roleId == 1 || roleId == 2 || roleId == 3) { %>
                        <li>
                            <a href="${pageContext.request.contextPath}/listExportServlet">Danh sách hóa đơn</a>
                        </li>
                        <% } %>
                        <li>
                            <a href="${pageContext.request.contextPath}/ExportServlet">Tạo phiếu xuất mới</a>
                        </li>
                    </ul>
                </div>
            </div>
        </li>
        <% } %>


        <% if (roleId == 1 || roleId == 2 || roleId == 3) { %>
        <li class="sidebar-item nav-item" data-menu="4">
            <div class="nav-link d-flex">
                <div class="icon-item">
                    <i class="fa-solid fa-cart-plus fa-lg"></i>
                </div>
                <div>
                    Nhập hàng hóa vào kho
                    <ul class="sub-menu">
                        <% if (roleId == 1 || roleId == 2) { %>
                        <li>
                            <a href="${pageContext.request.contextPath}/listImport">Danh sách phiếu nhập</a>
                        </li>
                        <% } %>
                        <li>
                            <a href="${pageContext.request.contextPath}/importServlet">Tạo phiếu nhập mới</a>
                        </li>
                    </ul>
                </div>
            </div>
        </li>
        <% } %>

        <% if (roleId == 1 || roleId == 2 || roleId == 3) { %>
        <li class="sidebar-item nav-item" data-menu="5">
            <div class="nav-link d-flex">
                <div class="icon-item">
                    <i class="fa-solid fa-cart-plus fa-lg"></i>
                </div>
                <div>
                    Xuất - Nhập hàng nội bộ
                    <ul class="sub-menu">
                        <% if (roleId == 1 || roleId == 2 ||  roleId == 3) { %>
                        <li>
                            <a href="${pageContext.request.contextPath}/RelocationServlet">Tạo mới xuất - nhập hàng</a>
                        </li>
                            <% } %>
                    </ul>
                    <ul class="sub-menu">
                        <% if (roleId == 1 || roleId == 2 ||  roleId == 3) { %>
                        <li>
                            <a href="${pageContext.request.contextPath}/ConfirmRe">Danh sách lệnh chuyển kho</a>
                        </li>
                        <% } %>
                    </ul>
                </div>
            </div>
        </li>
        <% } %>

        <% if (roleId == 1 || roleId == 2 || roleId == 3) { %>
        <li class="sidebar-item nav-item" data-menu="6">
            <div class="nav-link d-flex">
                <div class="icon-item">
                    <i class="fa-solid fa-cart-plus fa-lg"></i>
                </div>
                <div>
                    Thu nợ - Trả nợ
                    <ul class="sub-menu">
                        <% if (roleId == 1 || roleId == 2 || roleId == 3) { %>
                        <li>
                            <a href="/debt">Phiếu thu nợ</a>
                        </li>
                        <% } %>
                        <% if (roleId == 1 || roleId == 2) { %>
                        <li>
                            <a href="/repayment">Phiếu trả nợ</a>
                        </li>
                        <% } %>
                        <% if (roleId == 1 || roleId == 2 || roleId == 3) { %>
                        <li>
                            <a href="/listDebt">Danh sách phiếu thu</a>
                        </li>
                        <% } %>
                        <% if (roleId == 1 || roleId == 2) { %>
                        <li>
                            <a href="/listRepayment">Danh sách phiếu trả</a>
                        </li>
                        <% } %>
                    </ul>
                </div>
            </div>
        </li>
        <% } %>
        <% if (roleId == 1 || roleId == 2 || roleId == 3) { %>
        <li class="sidebar-item nav-item" data-menu="7">
            <div class="nav-link d-flex">
                <div class="icon-item">
                    <i class="fa-solid fa-cart-plus fa-lg"></i>
                </div>
                <div>
                    Thống kê
                    <ul class="sub-menu">
                        <% if (roleId == 1 || roleId == 2) { %>
                        <li>
                            <a href="${pageContext.request.contextPath}/productprice">Báo giá</a>
                        </li>
                        <li>
                            <a href="${pageContext.request.contextPath}/inventory">Tồn kho</a>
                        </li>
                        <% } %>
                        <% if (roleId == 1) { %>
                        <li>
                            <a href="${pageContext.request.contextPath}/RevenueReportServlet">Báo cáo doanh thu</a>
                        </li>
                        <li>
                            <a href="${pageContext.request.contextPath}/debt-paid">Công nợ phải trả</a>
                        </li>
                        <% } %>
                        <% if (roleId == 1 || roleId == 2 || roleId == 3 ) { %>
                        <li>
                            <a href="${pageContext.request.contextPath}/debt-collection">Công nợ phải thu</a>
                        </li>
                        <li>
                            <a href="${pageContext.request.contextPath}/generateContract">Chứng từ</a>
                        </li>
                        <% } %>
                        <% } %>
                    </ul>
                </div>
            </div>
        </li>
    </nav>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p"
        crossorigin="anonymous"></script>
<script>
    document.addEventListener('DOMContentLoaded', function () {
        const menuItems = document.querySelectorAll('.sidebar-item');
        const subMenuItems = document.querySelectorAll('.sub-menu a');

        // Đặt sự kiện click để lưu lựa chọn
        menuItems.forEach(item => {
            item.addEventListener('click', function () {
                localStorage.setItem('selectedMenu', this.getAttribute('data-menu'));
                highlightMenu();
            });
        });

        subMenuItems.forEach(item => {
            item.addEventListener('click', function (event) {
                event.stopPropagation();
                localStorage.setItem('selectedSubMenu', this.getAttribute('href'));
                highlightMenu();
            });
        });

        // Khôi phục lựa chọn
        highlightMenu();

        function highlightMenu() {
            const selectedMenu = localStorage.getItem('selectedMenu');
            const selectedSubMenu = localStorage.getItem('selectedSubMenu');

            menuItems.forEach(item => {
                const menu = item.getAttribute('data-menu');
                if (menu === selectedMenu || (selectedSubMenu && item.querySelector(`.sub-menu a[href="${selectedSubMenu}"]`))) {
                    item.classList.add('active');
                } else {
                    item.classList.remove('active');
                }
            });
        }
    });
</script>
</body>
</html>
