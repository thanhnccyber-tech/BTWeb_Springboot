<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>UteProWeb</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        .hero { background: linear-gradient(135deg, #667eea, #764ba2); padding: 40px; border-radius: 16px; color: #fff; margin-bottom: 30px; }
        .hero .btn-hero { background: #fff; color: #667eea; border-radius: 30px; padding: 8px 30px; font-weight: 600; }
        .hero .btn-hero:hover { transform: translateY(-2px); box-shadow: 0 5px 20px rgba(0,0,0,0.2); }
        .section-title { display: flex; justify-content: space-between; align-items: center; border-bottom: 3px solid #e2e8f0; padding-bottom: 12px; margin-bottom: 25px; }
        .section-title h3 { font-weight: 700; color: #2d3748; }
        .section-title a { color: #667eea; text-decoration: none; font-weight: 600; }
        .product-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(200px,1fr)); gap: 20px; margin-bottom: 30px; }
        .product-card { background: #fff; border-radius: 12px; overflow: hidden; box-shadow: 0 2px 12px rgba(0,0,0,0.06); transition: 0.3s; border: 1px solid #f0f2f5; position: relative; }
        .product-card:hover { transform: translateY(-5px); box-shadow: 0 8px 30px rgba(0,0,0,0.1); }
        .product-card img { width: 100%; height: 160px; object-fit: cover; }
        .product-card .body { padding: 12px; }
        .product-card .body .name { font-weight: 600; font-size: 0.95rem; height: 42px; overflow: hidden; }
        .product-card .body .price { font-weight: 700; color: #e74c3c; font-size: 1.1rem; }
        .product-card .body .btn-sm { background: #667eea; color: #fff; border-radius: 20px; padding: 2px 14px; border: none; }
        .product-card .body .btn-sm:hover { background: #764ba2; }
        .badge-new { position: absolute; top: 10px; right: 10px; background: #e74c3c; color: #fff; padding: 2px 10px; border-radius: 12px; font-size: 0.7rem; }
        .category-tag { background: #f0f2f5; padding: 2px 10px; border-radius: 12px; font-size: 0.7rem; color: #6c757d; display: inline-block; margin-bottom: 4px; }
        @media (max-width:768px) { .hero { padding: 25px; } .product-grid { grid-template-columns: repeat(2,1fr); gap: 12px; } .product-card img { height: 130px; } }
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
                <li class="nav-item"><a class="nav-link active" href="${pageContext.request.contextPath}/home">Trang chủ</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/product">Sản phẩm</a></li>
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

    <!-- Hero -->
    <div class="hero">
        <div class="row align-items-center">
            <div class="col-md-9">
                <h1 class="fw-bold"><i class="fas fa-rocket me-3"></i>UteProWeb</h1>
                <p>Sản phẩm công nghệ chất lượng - Giá tốt nhất</p>
                <a href="${pageContext.request.contextPath}/product" class="btn btn-hero"><i class="fas fa-shopping-bag me-2"></i>Xem tất cả</a>
            </div>
            <div class="col-md-3 d-none d-md-block text-end"><i class="fas fa-laptop-code" style="font-size:4rem;opacity:0.3;"></i></div>
        </div>
    </div>

    <!-- Sản phẩm mới nhất -->
    <div class="section-title">
        <h3><i class="fas fa-clock text-primary me-2"></i>Sản phẩm mới nhất</h3>
        <a href="${pageContext.request.contextPath}/product">Xem tất cả <i class="fas fa-arrow-right ms-1"></i></a>
    </div>

    <c:choose>
        <c:when test="${not empty latestProducts}">
            <div class="product-grid">
                <c:forEach items="${latestProducts}" var="p" varStatus="status">
                    <div class="product-card">
                        <c:if test="${status.index < 3}"><span class="badge-new"><i class="fas fa-fire me-1"></i>Mới</span></c:if>
                        <img src="${pageContext.request.contextPath}/image?fname=${p.images}" onerror="this.src='https://via.placeholder.com/300x160?text=No+Image'">
                        <div class="body">
                            <span class="category-tag"><i class="fas fa-folder me-1"></i>${p.category.categoryname}</span>
                            <div class="name">${p.productName}</div>
                            <div class="d-flex justify-content-between align-items-center mt-1">
                                <span class="price"><fmt:formatNumber value="${p.price}" pattern="#,##0"/>₫</span>
                                <a href="${pageContext.request.contextPath}/product/detail?id=${p.productId}" class="btn btn-sm"><i class="fas fa-eye me-1"></i>Xem</a>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
            <div class="text-center mb-3"><a href="${pageContext.request.contextPath}/product" class="btn btn-primary rounded-pill px-4">Xem tất cả <i class="fas fa-arrow-right ms-2"></i></a></div>
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