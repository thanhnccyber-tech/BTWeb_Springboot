<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sửa người dùng</title>
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
        .preview-image { width: 120px; height: 120px; object-fit: cover; border-radius: 50%; border: 3px solid #ddd; }
    </style>
</head>
<body>

    <!-- Navbar Admin -->
    <nav class="navbar navbar-expand-lg navbar-custom">
        <div class="container">
            <a class="navbar-brand" href="${pageContext.request.contextPath}/">
                <i class="fas fa-cog me-2"></i>Admin Panel
            </a>
            <div class="collapse navbar-collapse">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/admin/categories"><i class="fas fa-folder me-1"></i> Danh mục</a></li>
                    <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/admin/products"><i class="fas fa-boxes me-1"></i> Sản phẩm</a></li>
                    <li class="nav-item"><a class="nav-link active" href="${pageContext.request.contextPath}/admin/users"><i class="fas fa-users me-1"></i> Người dùng</a></li>
                    <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/user/profile"><i class="fas fa-user me-1"></i> Hồ sơ</a></li>
                    <li class="nav-item">
                        <a class="nav-link text-warning" href="${pageContext.request.contextPath}/home">
                            <i class="fas fa-home me-1"></i> Về trang chủ
                        </a>
                    </li>
                    <li class="nav-item"><a class="nav-link text-danger" href="${pageContext.request.contextPath}/logout"><i class="fas fa-sign-out-alt me-1"></i> Đăng xuất</a></li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Content -->
    <div class="main-content">
        <div class="container">
            <div class="card">
                <div class="card-header bg-warning text-dark">
                    <h4 class="mb-0"><i class="fas fa-user-edit me-2"></i>Sửa người dùng</h4>
                </div>
                <div class="card-body">
                    <c:if test="${not empty error}">
                        <div class="alert alert-danger">${error}</div>
                    </c:if>

                    <form action="${pageContext.request.contextPath}/admin/user/update" method="post" enctype="multipart/form-data">
                        <input type="hidden" name="id" value="${user.id}">
                        
                        <div class="row">
                            <div class="col-md-8">
                                <div class="mb-3">
                                    <label class="fw-bold">Tên đăng nhập</label>
                                    <input type="text" class="form-control bg-light" value="${user.userName}" disabled>
                                </div>
                                <div class="mb-3">
                                    <label class="fw-bold">Email</label>
                                    <input type="email" class="form-control bg-light" value="${user.email}" disabled>
                                </div>
                                <div class="mb-3">
                                    <label class="fw-bold">Họ và tên <span class="text-danger">*</span></label>
                                    <input type="text" name="fullname" class="form-control" value="${user.fullName}" required>
                                </div>
                                <div class="mb-3">
                                    <label class="fw-bold">Số điện thoại <span class="text-danger">*</span></label>
                                    <input type="text" name="phone" class="form-control" value="${user.phone}" required>
                                </div>
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="mb-3">
                                            <label class="fw-bold">Vai trò</label>
                                            <select name="roleId" class="form-select">
                                                <option value="2" ${user.roleId == 2 ? 'selected' : ''}>User</option>
                                                <option value="1" ${user.roleId == 1 ? 'selected' : ''}>Admin</option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="mb-3">
                                            <label class="fw-bold">Trạng thái</label>
                                            <select name="verified" class="form-select">
                                                <option value="true" ${user.verified ? 'selected' : ''}>Đã xác thực</option>
                                                <option value="false" ${!user.verified ? 'selected' : ''}>Chưa xác thực</option>
                                            </select>
                                        </div>
                                    </div>
                                </div>
                                <div class="mb-3">
                                    <label class="fw-bold">Đổi avatar</label>
                                    <input type="file" name="avatar" class="form-control" accept="image/*" onchange="previewImage(event)">
                                    <small class="text-muted">Để trống nếu giữ ảnh cũ</small>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="border rounded p-3 text-center">
                                    <label class="fw-bold">Avatar hiện tại</label>
                                    <div class="mt-2">
                                        <c:choose>
                                            <c:when test="${user.avatar != null && user.avatar != ''}">
                                                <c:choose>
                                                    <c:when test="${user.avatar.startsWith('http')}">
                                                        <c:url value="${user.avatar}" var="imgUrl"/>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <c:url value="/image?fname=${user.avatar}" var="imgUrl"/>
                                                    </c:otherwise>
                                                </c:choose>
                                                <img id="preview" src="${imgUrl}" class="preview-image" 
                                                     onerror="this.src='https://ui-avatars.com/api/?name=${user.fullName}&background=667eea&color=fff&size=120'"/>
                                            </c:when>
                                            <c:otherwise>
                                                <img id="preview" src="https://ui-avatars.com/api/?name=${user.fullName}&background=667eea&color=fff&size=120" class="preview-image"/>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                    <small class="text-muted">Chọn ảnh mới để thay đổi</small>
                                </div>
                            </div>
                        </div>
                        
                        <div class="d-flex gap-2 mt-3">
                            <button type="submit" class="btn btn-warning rounded-pill px-4">
                                <i class="fas fa-save me-2"></i>Cập nhật
                            </button>
                            <a href="${pageContext.request.contextPath}/admin/users" class="btn btn-secondary rounded-pill px-4">
                                <i class="fas fa-arrow-left me-2"></i>Quay lại
                            </a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <!-- Footer -->
    <footer class="footer-custom">
        <div class="container text-center">
            <p class="mb-0"><i class="fas fa-copyright me-1"></i> 2026 UteProWeb Admin</p>
        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function previewImage(event) {
            const file = event.target.files[0];
            if (file) {
                const reader = new FileReader();
                reader.onload = function(e) {
                    document.getElementById('preview').src = e.target.result;
                };
                reader.readAsDataURL(file);
            }
        }
    </script>
</body>
</html>