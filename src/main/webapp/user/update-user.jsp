<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cập nhật thông tin nhân viên</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css" type="text/css">
</head>
<body>

    <div class="flex-grow-1" style="display: flex">
        <%@include file="../function.jsp"%>
        <form action="UpdateUserServlet" class="form__add-product" method="post">
            <div class="app__add-product">
                <div class="content__header">
                    <div class="content__name defaultCursor">
                        <a href="/ListUserServlet">
                            <i class="fa-solid fa-arrow-left-long me-2 fa-lg" style="cursor: pointer"></i>
                        </a>
                        Cập nhật thông tin nhân viên
                    </div>
                    <div id="successNotify"></div>
                    <button type="submit" class="btn-accept btn-accept-button btn-save">Xác nhận</button>
                </div>
                <div class="content__attributes">
                    <div class="content__attributes-items">
                        <div class="item-name defaultCursor">Thông tin chung</div>
                        <p style="color: red">${error}</p>
                        <div class="item-content container">
                            <div class="item-content__main-row row">
                                <div class="col-9 general-info">
                                    <div class="container">
                                        <div class="row general-info__basic">
                                            <!-- Hidden field for userId -->
                                            <input type="hidden" name="userId" value="${user.id}">
                                            <div class="row">
                                                <div class="atb col-4">
                                                    <span class="atb-name defaultCursor">Tên nhân viên<span style="color: red"> *</span></span>
                                                    <input type="text" name="name" class="atb-input input-group form-control shadow-none" value="${user.name}">
                                                </div>
                                                <div class="atb col-4">
                                                    <span class="atb-name defaultCursor">Số điện thoại<span style="color: red"> *</span></span>
                                                    <input type="text" name="phone" class="atb-input input-group form-control shadow-none" value="${user.phone}">
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="atb col-4">
                                                    <span class="atb-name defaultCursor">Email<span style="color: red"> *</span></span>
                                                    <input type="text" name="email" class="atb-input input-group form-control shadow-none" value="${user.email}">
                                                </div>
                                                <div class="atb col-4">
                                                    <span class="atb-name defaultCursor">Địa chỉ<span style="color: red"> *</span></span>
                                                    <input type="text" name="address" class="atb-input input-group form-control shadow-none" value="${user.address}">
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="atb col-4">
                                                    <span class="atb-name defaultCursor">Mật khẩu<span style="color: red"> *</span></span>
                                                    <input type="password" name="password" class="atb-input input-group form-control shadow-none" value="${user.password}" readonly>
                                                </div>
                                                <div class="atb col-4">
                                                    <span class="atb-name defaultCursor">Quyền<span style="color: red"> *</span></span>
                                                    <select name="role" style="width: 300px">
                                                        <option value="0" ${user.roleId == 2 ? 'selected' : ''}>Ban</option>
                                                        <option value="2" ${user.roleId == 2 ? 'selected' : ''}>Manager</option>
                                                        <option value="3" ${user.roleId == 3 ? 'selected' : ''}>Employee</option>
                                                    </select>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <input type="hidden" id="attributeJSON" name="attributeJSON" value="">
                    </div>
                </div>
            </div>
        </form>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script  type="module">
    // Additional JavaScript if necessary
</script>
</body>
</html>
