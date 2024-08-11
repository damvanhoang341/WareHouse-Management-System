<%--
  Created by IntelliJ IDEA.
  User: PC
  Date: 7/1/2024
  Time: 9:43 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Thông tin tài khoản</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
  <link rel="stylesheet" href="styles.css">
  <style>
    body {
      background-color: #f8f9fa;
      font-family: Arial, sans-serif;
    }

    .card {
      border-radius: 10px;
      box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    }

    .card-header {
      background-color: #007bff;
      color: white;
      border-top-left-radius: 10px;
      border-top-right-radius: 10px;
    }

    .form-control {
      background-color: #e9ecef;
      border: none;
      border-radius: 5px;
      font-size: 1rem;
    }

    .form-control[readonly] {
      background-color: #f8f9fa;
    }

    .img-placeholder {
      background-color: #6c757d;
      color: white;
      width: 150px;
      height: 150px;
      display: flex;
      align-items: center;
      justify-content: center;
      border-radius: 50%;
      margin: 0 auto 20px auto;
      position: relative;
      overflow: hidden;
    }

    .img-placeholder img {
      border-radius: 50%;
      object-fit: cover;
      width: 100%;
      height: 100%;
      clip-path: circle(50% at center);
    }

    .img-overlay {
      position: absolute;
      top: 0;
      left: 0;
      right: 0;
      bottom: 0;
      background-color: rgba(0, 0, 0, 0.5);
      display: flex;
      justify-content: center;
      align-items: center;
      opacity: 0;
      transition: opacity 0.3s ease;
      cursor: pointer;
    }

    .img-overlay:hover {
      opacity: 1;
    }

    .img-overlay i {
      color: white;
      font-size: 24px;
    }

    .form-label i {
      margin-right: 8px;
      color: #007bff;
    }
  </style>
</head>

<body>
<div class="profile" style="display: flex">
  <%@include file="../function.jsp"%>
  <c:set value="${requestScope.user}" var="u"/>
  <div class="container mt-5">
    <div class="row">
      <div class="col-md-6 offset-md-3">
        <div class="card">
          <div class="card-header text-center" style="background-color: #0B5ED7">
            <h2>Thông tin</h2>
          </div>
          <div class="card-body">
            <div class="text-center mb-4">
              <div class="img-placeholder">
                <img src="${u.profileImage != null ? u.profileImage : 'https://via.placeholder.com/150'}" alt="Profile Picture" class="rounded-circle">
                <div class="img-overlay" data-bs-toggle="modal" data-bs-target="#imageModal">
                  <i class="fas fa-camera"></i>
                </div>
              </div>
            </div>
            <form id="uploadForm" enctype="multipart/form-data" action="UploadProfileImageServlet" method="POST">
              <div class="form-group mb-3" style="display: none;">
                <input type="file" id="profileImageUpload" name="profileImageUpload" onchange="this.form.submit();">
              </div>
            </form>
            <div class="form-group mb-3">
              <label for="name" class="form-label"><i class="fas fa-user"></i> Tên</label>
              <input type="text" class="form-control" id="name" value="${u.name}" readonly>
            </div>
            <div class="form-group mb-3">
              <label for="address" class="form-label"><i class="fas fa-map-marker-alt"></i> Địa chỉ</label>
              <input type="text" class="form-control" id="address" value="${u.address}" readonly>
            </div>
            <div class="form-group mb-3">
              <label for="phone" class="form-label"><i class="fas fa-phone"></i> Số điện thoại</label>
              <input type="text" class="form-control" id="phone" value="${u.phone}" readonly>
            </div>
            <c:set var="roleName">
              <c:choose>
                <c:when test="${u.roleId == 1}">Admin</c:when>
                <c:when test="${u.roleId == 2}">Quản lý</c:when>
                <c:when test="${u.roleId == 3}">Nhân viên</c:when>
                <c:otherwise>Không xác định</c:otherwise>
              </c:choose>
            </c:set>

            <div class="form-group mb-3">
              <label for="position" class="form-label"><i class="fas fa-briefcase"></i> Chức vụ</label>
              <input type="text" class="form-control" id="position" value="${roleName}" readonly>
            </div>
            <div class="form-group mb-3">
              <label for="email" class="form-label"><i class="fas fa-envelope"></i> Email</label>
              <input type="email" class="form-control" id="email" value="${u.email}" readonly>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>

  <!-- Image Modal -->
  <div class="modal fade" id="imageModal" tabindex="-1" aria-labelledby="imageModalLabel" aria-hidden="true">
    <div class="modal-dialog">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title" id="imageModalLabel">Tùy chọn ảnh</h5>
          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
        </div>
        <div class="modal-body">
          <button type="button" class="btn btn-primary w-100 mb-2" data-bs-toggle="modal" data-bs-target="#viewImageModal">Xem ảnh</button>
          <button type="button" class="btn btn-secondary w-100" onclick="document.getElementById('profileImageUpload').click();">Tải lên ảnh mới</button>
        </div>
      </div>
    </div>
  </div>

  <!-- View Image Modal -->
  <div class="modal fade" id="viewImageModal" tabindex="-1" aria-labelledby="viewImageModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title" id="viewImageModalLabel">Ảnh đại diện</h5>
          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
        </div>
        <div class="modal-body text-center">
          <img src="${u.profileImage != null ? u.profileImage : 'https://via.placeholder.com/150'}" alt="Profile Picture" class="img-fluid">
        </div>
      </div>
    </div>
  </div>

  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
  <script>
    // Auto-submit form when file input changes
    document.getElementById('profileImageUpload').addEventListener('change', function() {
      document.getElementById('uploadForm').submit();
    });

    // Ensure modals close properly
    document.querySelectorAll('.modal').forEach(function(modal) {
      modal.addEventListener('hidden.bs.modal', function () {
        if (document.querySelectorAll('.modal.show').length === 0) {
          document.body.classList.remove('modal-open');
          var backdrop = document.querySelector('.modal-backdrop');
          if (backdrop) {
            backdrop.remove();
          }
          window.location.reload(); // Reload page when viewImageModal is closed
        }
      });
    });
  </script>
</body>
</html>
