<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Danh sách sản phẩm</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        .page-header { background: linear-gradient(135deg, #667eea, #764ba2); padding: 30px; border-radius: 16px; color: #fff; margin-bottom: 30px; }
        .section-title { display: flex; justify-content: space-between; align-items: center; border-bottom: 3px solid #e2e8f0; padding-bottom: 12px; margin-bottom: 25px; }
        .section-title h3 { font-weight: 700; color: #2d3748; }
        .product-card { background: #fff; border-radius: 12px; overflow: hidden; box-shadow: 0 2px 12px rgba(0,0,0,0.06); transition: 0.3s; border: 1px solid #f0f2f5; height: 100%; }
        .product-card:hover { transform: translateY(-5px); box-shadow: 0 8px 30px rgba(0,0,0,0.1); }
        .product-card img { width: 100%; height: 180px; object-fit: cover; }
        .product-card .body { padding: 14px; }
        .product-card .body .name { font-weight: 600; font-size: 0.95rem; height: 42px; overflow: hidden; margin-bottom: 4px; }
        .product-card .body .price { font-weight: 700; color: #e74c3c; font-size: 1.1rem; }
        .product-card .body .btn-sm { background: #667eea; color: #fff; border-radius: 20px; padding: 4px 16px; border: none; }
        .product-card .body .btn-sm:hover { background: #764ba2; }
        .category-tag { background: #f0f2f5; padding: 2px 10px; border-radius: 12px; font-size: 0.7rem; color: #6c757d; display: inline-block; margin-bottom: 6px; }
        .pagination .page-link { color: #667eea; }
        .pagination .page-item.active .page-link { background: #667eea; border-color: #667eea; color: #fff; }
        .product-grid .row { margin: 0 -10px; }
        .product-grid .col { padding: 0 10px; margin-bottom: 20px; }
        @media (max-width: 768px) {
            .product-card img { height: 140px; }
            .product-grid .col { flex: 0 0 50%; max-width: 50%; }
        }
        @media (max-width: 480px) {
            .product-card img { height: 120px; }
            .product-card .body { padding: 10px; }
            .product-card .body .name { font-size: 0.85rem; height: 38px; }
            .product-card .body .price { font-size: 1rem; }
        }
    </style>
</head>
<body>

<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container">
        <a class="navbar-brand fw-bold" href="${pageContext.request.contextPath}/"><i class="fas fa-store me-2"></i>UteProWeb</a>
        <button class="navbar-toggler" data-bs-toggle="collapse" data-bs-target="#nav"><span class="navbar-toggler-icon"></span></button>
        <div class="collapse navbar-collapse" id="nav">
            <ul class="navbar-nav ms-auto">
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/home">Trang chủ</a></li>
                <li class="nav-item"><a class="nav-link active" href="${pageContext.request.contextPath}/product">Sản phẩm</a></li>
                <c:if test="${sessionScope.account != null && sessionScope.account.roleId == 1}">
                    <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/admin/categories">Quản lý</a></li>
                </c:if>
                <c:choose>
                    <c:when test="${sessionScope.account != null}">
                        <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/user/profile">Hồ sơ</a></li>
                        <li class="nav-item"><a class="nav-link text-danger" href="${pageContext.request.contextPath}/logout">Đăng xuất</a></li>
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

<!-- Main -->
<div class="container mt-4">

    <!-- Header -->
    <div class="page-header">
        <div class="row align-items-center">
            <div class="col-md-9">
                <h1 class="fw-bold"><i class="fas fa-box me-3"></i>Tất cả sản phẩm</h1>
                <p>Khám phá bộ sưu tập sản phẩm công nghệ đa dạng</p>
            </div>
            <div class="col-md-3 d-none d-md-block text-end"><i class="fas fa-laptop-code" style="font-size:4rem;opacity:0.3;"></i></div>
        </div>
    </div>

    <!-- Danh sách sản phẩm - 2 hàng x 3 cột -->
    <c:choose>
        <c:when test="${not empty products}">
            <div class="product-grid">
                <div class="row">
                    <c:forEach items="${products}" var="p">
                        <div class="col-xl-4 col-lg-4 col-md-6 col-sm-6">
                            <div class="product-card">
                                <img src="${pageContext.request.contextPath}/image?fname=${p.images}" 
                                     onerror="this.src='https://via.placeholder.com/300x180?text=No+Image'">
                                <div class="body">
                                    <span class="category-tag"><i class="fas fa-folder me-1"></i>${p.category.categoryname}</span>
                                    <div class="name">${p.productName}</div>
                                    <div class="d-flex justify-content-between align-items-center mt-1">
                                        <span class="price"><fmt:formatNumber value="${p.price}" pattern="#,##0"/>₫</span>
                                        <a href="${pageContext.request.contextPath}/product/detail?id=${p.productId}" class="btn btn-sm"><i class="fas fa-eye me-1"></i>Xem</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>

            <!-- Phân trang -->
            <nav>
                <ul class="pagination justify-content-center">
                    <c:if test="${currentPage > 1}">
                        <li class="page-item"><a class="page-link" href="?page=${currentPage-1}">«</a></li>
                    </c:if>
                    <c:forEach begin="1" end="${totalPages}" var="i">
                        <li class="page-item ${i == currentPage ? 'active' : ''}"><a class="page-link" href="?page=${i}">${i}</a></li>
                    </c:forEach>
                    <c:if test="${currentPage < totalPages}">
                        <li class="page-item"><a class="page-link" href="?page=${currentPage+1}">»</a></li>
                    </c:if>
                </ul>
            </nav>
        </c:when>
        <c:otherwise>
            <div class="text-center py-5" style="background:#f8f9fa;border-radius:12px;">
                <i class="fas fa-box-open fa-3x text-muted mb-2 d-block"></i>
                <h5 class="text-muted">Chưa có sản phẩm</h5>
            </div>
        </c:otherwise>
    </c:choose>
</div>

<!-- Footer -->
<footer class="bg-dark text-white-50 text-center py-3 mt-4">
    <p class="mb-0"><i class="fas fa-copyright me-1"></i> 2026 UteProWeb</p>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>