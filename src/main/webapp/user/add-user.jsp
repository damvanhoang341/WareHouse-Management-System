<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Thêm nhân viên </title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css" type="text/css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/common.css" type="text/css">
  <link class="jsbin" href="http://ajax.googleapis.com/ajax/libs/jqueryui/1/themes/base/jquery-ui.css" rel="stylesheet" type="text/css" />
  <script class="jsbin" src="http://ajax.googleapis.com/ajax/libs/jquery/1/jquery.min.js"></script>
  <script class="jsbin" src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8.0/jquery-ui.min.js"></script>
</head>
<body>
<div id="page" class="d-flex" style="display: flex">
  <%@include file="../function.jsp"%>
  <div class="flex-grow-1">
    <form  action="CreateUserServlet" class="form__add-product" method="post" >
      <div class="app__add-product" >
        <div class="content__header">
          <div class="content__name defaultCursor">
            <a href="/ListUserServlet">
              <i class="fa-solid fa-arrow-left-long me-2 fa-lg" style="cursor: pointer"></i>
            </a>
            Thêm nhân viên
          </div>
          <div id="successNotify"></div>
          <button type="submit" class="btn-accept btn-accept-button btn-save">Xác nhận</button>
        </div>
        <div class="content__attributes">
          <div class="content__attributes-items">
            <div class="item-name defaultCursor">Thông tin chung</div>
            <p style="color: red">${requestScope.error2}</p>
            <div class="item-content container">
              <div class="item-content__main-row row">
                <div class="col-9 general-info">
                  <div class="container">
                    <div class="row general-info__basic">
                      <div class="row">
                        <div class="atb col-4">
                          <span class="atb-name defaultCursor">Tên nhân viên<span style="color: red"> *</span></span>
                          <input type="text" id="name" name="name" class="atb-input input-group form-control shadow-none" placeholder="Nhập Tên nhân viên" >
                          <span id="nameWarnning" class="warningText validateWarnning" hidden="true"></span>
                        </div>
                        <div class="atb col-4">
                          <span class="atb-name defaultCursor">Số điện thoại<span style="color: red"> *</span></span>
                          <input type="text" id="phone" name="phone" class="atb-input input-group form-control shadow-none" placeholder="Nhập số điện thoại" >
                          <span id="phoneWarnning" class="warningText validateWarnning" hidden="true"></span>
                        </div>
                      </div>
                      <div class="row">
                        <div class="atb col-4">
                          <span class="atb-name defaultCursor">Email<span style="color: red"> *</span></span>
                          <input type="text" id="email" name="email" class="atb-input input-group form-control shadow-none" placeholder="Nhập Email" >
                          <span id="emailWarnning" class="warningText validateWarnning" hidden="true"></span>
                        </div>
                        <div class="atb col-4">
                          <span class="atb-name defaultCursor">Địa chỉ<span style="color: red"> *</span></span>
                          <input type="text" id="address" name="address" class="atb-input input-group form-control shadow-none" placeholder="Nhập Địa chỉ" >
                          <span id="addressWarnning" class="warningText validateWarnning" hidden="true"></span>
                        </div>
                      </div>
                      <div class="row">
                        <div class="atb col-4">
                          <span class="atb-name defaultCursor">Tài khoản đăng nhập<span style="color: red"> *</span></span>
                          <input type="text" id="username" name="username" class="atb-input input-group form-control shadow-none" placeholder="Nhập Tài khoản đăng nhập" >
                          <span id="usernameWarnning" class="warningText validateWarnning" hidden="true"></span>
                        </div>
                        <div class="atb col-4">
                          <span class="atb-name defaultCursor">Mật khẩu<span style="color: red"> *</span></span>
                          <input type="password" id="password" name="password" class="atb-input input-group form-control shadow-none" placeholder="Nhập Mật khẩu" >
                          <span id="passwordWarnning" class="warningText validateWarnning" hidden="true"></span>
                        </div>
                        <div class="row">
                          <div class="atb col-4">
                            <span class="atb-name defaultCursor">Quyền<span style="color: red"> *</span></span>
                            <select name="role" class="atb-input input-group form-control shadow-none" style="width: 250px">
                              <option value="0">Ban</option>
                              <option value="2">Manager</option>
                              <option value="3">Employee</option>
                            </select>
                          </div>
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
      </div>>
    </form>
  </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-3.6.0.js"
        integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
<script  type="module">
  $("#btnAdd").click(function () {
    console.log("a")
    window.location.href = "CreateUserServlet";
  });
  $(document).on('click', '.btn-delete-table', function () {
    var value = $(this).parent().parent().children().first().attr('value');
    var name = $(this).parent().parent().children().first().attr('nameNhanVien');
    doDelete(value, name);
  });

  function doDelete(id, name) {
    if (confirm("Bạn có muốn xóa nhân viên <" + name + ">")) {
      window.location = "DeleteUserServlet?id=" + id;
    }
  }

  $("#logout-btn").click(function () {
            window.location.href = "/";
          }
  );

  document.getElementById('nameProd').addEventListener('input', function() {
    const searchTerm = this.value.toLowerCase();
    const items = document.querySelectorAll('.infoPro td');

    items.forEach(function(item) {
      if (item.textContent.toLowerCase().includes(searchTerm)) {
        item.classList.remove('hidden');
      } else {
        item.classList.add('hidden');
      }
    });
  });

</script>
</body>
</html>
