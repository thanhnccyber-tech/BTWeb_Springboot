<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Chi tiết sản phẩm</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>
    <!-- Navbar -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <div class="container">
            <a class="navbar-brand" href="${pageContext.request.contextPath}/">UteProWeb</a>
            <button class="navbar-toggler" data-bs-toggle="collapse" data-bs-target="#nav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="nav">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/home">Trang chủ</a></li>
                    <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/product">Sản phẩm</a></li>
                    <c:if test="${sessionScope.account != null && sessionScope.account.roleId == 1}">
                        <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/admin/categories">Quản lý</a></li>
                    </c:if>
                    <c:choose>
                        <c:when test="${sessionScope.account != null}">
                            <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/user/profile">Hồ sơ</a></li>
                            <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/logout">Đăng xuất</a></li>
                        </c:when>
                        <c:otherwise>
                            <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/login">Đăng nhập</a></li>
                            <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/register">Đăng ký</a></li>
                        </c:otherwise>
                    </c:choose>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Content -->
    <div class="container mt-4">
        <c:if test="${not empty product}">
            <div class="row">
                <div class="col-md-5">
                    <img src="${pageContext.request.contextPath}/image?fname=${product.images}" class="img-fluid rounded" style="max-height:400px;width:100%;object-fit:cover;" onerror="this.src='https://via.placeholder.com/500x400?text=No+Image'">
                </div>
                <div class="col-md-7">
                    <h2>${product.productName}</h2>
                    <p class="text-muted"><i class="fas fa-folder"></i> ${product.category.categoryname}</p>
                    <h3 class="text-danger"><fmt:formatNumber value="${product.price}" pattern="#,##0"/>₫</h3>
                    <div class="mt-3 p-3 bg-light rounded">
                        <p>${product.description != null ? product.description : 'Chưa có mô tả'}</p>
                    </div>
                    <a href="${pageContext.request.contextPath}/product" class="btn btn-secondary mt-3">← Quay lại</a>
                </div>
            </div>
        </c:if>
        <c:if test="${empty product}">
            <div class="alert alert-danger">Sản phẩm không tồn tại</div>
            <a href="${pageContext.request.contextPath}/product" class="btn btn-secondary">Quay lại</a>
        </c:if>
    </div>

    <footer class="bg-dark text-white text-center py-3 mt-4">
        <p class="mb-0">© 2026 UteProWeb</p>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>