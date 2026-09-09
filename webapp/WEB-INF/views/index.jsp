<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Trang chủ</title>
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
                    <li class="nav-item"><a class="nav-link active" href="${pageContext.request.contextPath}/home">Trang chủ</a></li>
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
        <div class="bg-primary text-white p-4 rounded mb-4 text-center">
            <h1>Chào mừng đến với UteProWeb</h1>
            <p>Sản phẩm chất lượng - Giá tốt nhất</p>
        </div>

        <h3>Sản phẩm mới nhất</h3>
        <div class="row mt-3">
            <c:forEach items="${latestProducts}" var="p">
                <div class="col-md-2 col-6 mb-3">
                    <div class="card h-100">
                        <img src="${pageContext.request.contextPath}/image?fname=${p.images}" class="card-img-top" style="height:150px;object-fit:cover;" onerror="this.src='https://via.placeholder.com/200x150?text=No+Image'">
                        <div class="card-body p-2">
                            <h6 class="card-title">${p.productName}</h6>
                            <p class="text-danger fw-bold"><fmt:formatNumber value="${p.price}" pattern="#,##0"/>₫</p>
                            <a href="${pageContext.request.contextPath}/product/detail?id=${p.productId}" class="btn btn-sm btn-primary">Xem</a>
                        </div>
                    </div>
                </div>
            </c:forEach>
            <c:if test="${empty latestProducts}">
                <p class="text-muted">Chưa có sản phẩm</p>
            </c:if>
        </div>
        <div class="text-center mt-3">
            <a href="${pageContext.request.contextPath}/product" class="btn btn-primary">Xem tất cả</a>
        </div>
    </div>

    <!-- Footer -->
    <footer class="bg-dark text-white text-center py-3 mt-4">
        <p class="mb-0">© 2026 UteProWeb</p>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>