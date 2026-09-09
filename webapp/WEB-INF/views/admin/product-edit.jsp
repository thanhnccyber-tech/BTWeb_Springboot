<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sửa sản phẩm</title>
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
                    <li class="nav-item"><a class="nav-link active" href="${pageContext.request.contextPath}/admin/products"><i class="fas fa-boxes me-1"></i> Sản phẩm</a></li>
                    <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/admin/users"><i class="fas fa-users me-1"></i> Người dùng</a></li>
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
                <div class="card-header bg-warning">
                    <h4 class="mb-0"><i class="fas fa-edit me-2"></i>Sửa sản phẩm</h4>
                </div>
                <div class="card-body">
                    <form action="${pageContext.request.contextPath}/admin/product/update" method="post" enctype="multipart/form-data">
                        <input type="hidden" name="productId" value="${product.productId}">
                        <div class="mb-3">
                            <label class="fw-bold">Tên sản phẩm <span class="text-danger">*</span></label>
                            <input type="text" name="productName" class="form-control" value="${product.productName}" required>
                        </div>
                        <div class="mb-3">
                            <label class="fw-bold">Giá <span class="text-danger">*</span></label>
                            <input type="number" name="price" class="form-control" step="0.01" value="${product.price}" required>
                        </div>
                        <div class="mb-3">
                            <label class="fw-bold">Mô tả</label>
                            <textarea name="description" class="form-control" rows="3">${product.description}</textarea>
                        </div>
                        <div class="mb-3">
                            <label class="fw-bold">Danh mục <span class="text-danger">*</span></label>
                            <select name="categoryId" class="form-select" required>
                                <c:forEach items="${categories}" var="c">
                                    <option value="${c.categoryId}" ${c.categoryId == product.category.categoryId ? 'selected' : ''}>${c.categoryname}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="mb-3">
                            <label class="fw-bold">Upload ảnh mới</label>
                            <input type="file" name="images" class="form-control" accept="image/*">
                            <small class="text-muted">Để trống nếu giữ ảnh cũ</small>
                        </div>
                        <button type="submit" class="btn btn-warning">Cập nhật</button>
                        <a href="${pageContext.request.contextPath}/admin/products" class="btn btn-secondary">Quay lại</a>
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
</body>
</html>