<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Hồ sơ của tôi</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body { background: #f0f2f5; min-height: 100vh; display: flex; flex-direction: column; }
        .navbar-custom { background: #2d3748; box-shadow: 0 2px 15px rgba(0,0,0,0.1); }
        .navbar-custom .navbar-brand { font-weight: 700; color: white; font-size: 1.5rem; }
        .navbar-custom .nav-link { color: rgba(255,255,255,0.8) !important; transition: all 0.3s; }
        .navbar-custom .nav-link:hover { color: white !important; }
        .navbar-custom .nav-link.active { color: white !important; font-weight: 600; }
        .main-content { flex: 1; padding: 30px 0; }
        .footer-custom { background: #2d3748; color: #a0aec0; padding: 20px 0; margin-top: auto; }
        .footer-custom a { color: #a0aec0; text-decoration: none; }
        .footer-custom a:hover { color: white; }
        .preview-image { width: 150px; height: 150px; object-fit: cover; border-radius: 50%; border: 3px solid #ddd; }
    </style>
</head>
<body>

    <!-- Navbar -->
    <nav class="navbar navbar-expand-lg navbar-custom">
        <div class="container">
            <a class="navbar-brand" href="${pageContext.request.contextPath}/">
                <i class="fas fa-store me-2"></i>UteProWeb
            </a>
            <button class="navbar-toggler" data-bs-toggle="collapse" data-bs-target="#nav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="nav">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/home"><i class="fas fa-home me-1"></i> Trang chủ</a></li>
                    <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/product"><i class="fas fa-box me-1"></i> Sản phẩm</a></li>
                    <c:if test="${sessionScope.account != null && sessionScope.account.roleId == 1}">
                        <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/admin/categories"><i class="fas fa-tools me-1"></i> Quản lý</a></li>
                    </c:if>
                    <li class="nav-item"><a class="nav-link active" href="${pageContext.request.contextPath}/user/profile"><i class="fas fa-user me-1"></i> Hồ sơ</a></li>
                    <li class="nav-item"><a class="nav-link text-danger" href="${pageContext.request.contextPath}/logout"><i class="fas fa-sign-out-alt me-1"></i> Đăng xuất</a></li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Content -->
    <div class="main-content">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-lg-8 col-md-10">
                    <div class="card">
                        <div class="card-header bg-primary text-white">
                            <h4 class="mb-0"><i class="fas fa-user-circle me-2"></i>Hồ sơ của tôi</h4>
                        </div>
                        <div class="card-body">
                            <c:if test="${not empty message}">
                                <div class="alert alert-success alert-dismissible fade show" role="alert">
                                    <i class="fas fa-check-circle me-2"></i> ${message}
                                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                                </div>
                            </c:if>
                            <c:if test="${not empty error}">
                                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                    <i class="fas fa-exclamation-circle me-2"></i> ${error}
                                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                                </div>
                            </c:if>

                            <form action="${pageContext.request.contextPath}/user/profile/update" method="post" enctype="multipart/form-data">
                                <!-- Avatar -->
                                <div class="text-center mb-4">
                                    <c:choose>
                                        <c:when test="${user.avatar != null && user.avatar != ''}">
                                            <c:choose>
                                                <c:when test="${user.avatar.startsWith('http')}">
                                                    <c:url value="${user.avatar}" var="avatarUrl"/>
                                                </c:when>
                                                <c:otherwise>
                                                    <c:url value="/image?fname=${user.avatar}" var="avatarUrl"/>
                                                </c:otherwise>
                                            </c:choose>
                                            <img id="avatarPreview" src="${avatarUrl}" class="preview-image mb-2" 
                                                 onerror="this.src='https://ui-avatars.com/api/?name=${user.fullName}&background=667eea&color=fff&size=150'"/>
                                        </c:when>
                                        <c:otherwise>
                                            <img id="avatarPreview" src="https://ui-avatars.com/api/?name=${user.fullName}&background=667eea&color=fff&size=150" 
                                                 class="preview-image mb-2" alt="Avatar"/>
                                        </c:otherwise>
                                    </c:choose>
                                    <div>
                                        <label for="avatar" class="btn btn-outline-primary rounded-pill">
                                            <i class="fas fa-camera me-2"></i>Đổi ảnh đại diện
                                        </label>
                                        <input type="file" class="d-none" id="avatar" name="avatar" accept="image/*" 
                                               onchange="previewImage(event)">
                                    </div>
                                    <small class="d-block text-muted mt-1">Hỗ trợ: JPG, PNG, GIF (Max 5MB)</small>
                                </div>

                                <!-- Thông tin -->
                                <div class="row g-3">
                                    <div class="col-md-6">
                                        <label class="fw-bold">Tên đăng nhập</label>
                                        <input type="text" class="form-control bg-light" value="${user.userName}" disabled>
                                    </div>
                                    <div class="col-md-6">
                                        <label class="fw-bold">Email</label>
                                        <input type="email" class="form-control bg-light" value="${user.email}" disabled>
                                    </div>
                                    <div class="col-md-6">
                                        <label for="fullname" class="fw-bold">Họ và tên <span class="text-danger">*</span></label>
                                        <input type="text" class="form-control" id="fullname" name="fullname" 
                                               value="${user.fullName}" required minlength="2" maxlength="50"
                                               placeholder="Nhập họ và tên">
                                    </div>
                                    <div class="col-md-6">
                                        <label for="phone" class="fw-bold">Số điện thoại <span class="text-danger">*</span></label>
                                        <input type="text" class="form-control" id="phone" name="phone" 
                                               value="${user.phone}" required pattern="[0-9]{10,11}"
                                               placeholder="Nhập số điện thoại">
                                    </div>
                                    <div class="col-md-6">
                                        <label class="fw-bold">Vai trò</label>
                                        <input type="text" class="form-control bg-light" 
                                               value="${user.roleId == 1 ? 'Quản trị viên' : 'Người dùng'}" disabled>
                                    </div>
                                    <div class="col-md-6">
                                        <label class="fw-bold">Ngày tham gia</label>
                                        <input type="text" class="form-control bg-light" value="${user.createdDate}" disabled>
                                    </div>
                                </div>

                                <div class="d-flex gap-2 mt-4">
                                    <a href="${pageContext.request.contextPath}/home" class="btn btn-secondary rounded-pill px-4">
                                        <i class="fas fa-arrow-left me-2"></i>Quay lại
                                    </a>
                                    <button type="submit" class="btn btn-primary rounded-pill px-4">
                                        <i class="fas fa-save me-2"></i>Cập nhật
                                    </button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Footer -->
    <footer class="footer-custom">
        <div class="container text-center">
            <p class="mb-0"><i class="fas fa-copyright me-1"></i> 2026 UteProWeb</p>
        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function previewImage(event) {
            const file = event.target.files[0];
            if (file) {
                const reader = new FileReader();
                reader.onload = function() {
                    document.getElementById('avatarPreview').src = reader.result;
                };
                reader.readAsDataURL(file);
            }
        }
    </script>
</body>
</html>