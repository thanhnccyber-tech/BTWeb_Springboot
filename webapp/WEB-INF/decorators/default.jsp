<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><sitemesh:title default="UteProWeb" /></title>
    
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome 6 -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <style>
        body {
            background: #f5f7fa;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }
        .navbar-custom {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            box-shadow: 0 2px 15px rgba(0,0,0,0.1);
        }
        .navbar-custom .navbar-brand {
            font-weight: 700;
            color: white;
            font-size: 1.5rem;
        }
        .navbar-custom .nav-link {
            color: rgba(255,255,255,0.8) !important;
            transition: all 0.3s;
        }
        .navbar-custom .nav-link:hover {
            color: white !important;
            transform: translateY(-2px);
        }
        .navbar-custom .nav-link.active {
            color: white !important;
            font-weight: 600;
        }
        .avatar-nav {
            width: 35px;
            height: 35px;
            border-radius: 50%;
            object-fit: cover;
            border: 2px solid white;
            margin-right: 8px;
        }
        .main-content {
            flex: 1;
            padding: 30px 0;
        }
        .footer-custom {
            background: #2d3748;
            color: #a0aec0;
            padding: 20px 0;
            margin-top: auto;
        }
        .footer-custom a {
            color: #a0aec0;
            text-decoration: none;
            transition: color 0.3s;
        }
        .footer-custom a:hover {
            color: white;
        }
        .toast-container {
            position: fixed;
            top: 20px;
            right: 20px;
            z-index: 9999;
        }
        .alert-custom {
            border-radius: 10px;
            border: none;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
        }
        .btn-gradient {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border: none;
            transition: all 0.3s;
        }
        .btn-gradient:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 20px rgba(102, 126, 234, 0.4);
            color: white;
        }
        .card-shadow {
            border-radius: 15px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.08);
            border: none;
            transition: all 0.3s;
        }
        .card-shadow:hover {
            box-shadow: 0 8px 30px rgba(0,0,0,0.12);
        }
        .badge-admin {
            background: #e74c3c;
            color: white;
            padding: 2px 10px;
            border-radius: 20px;
            font-size: 11px;
            margin-left: 5px;
        }
        .dropdown-menu-custom {
            border-radius: 12px;
            box-shadow: 0 10px 40px rgba(0,0,0,0.1);
            border: none;
            padding: 8px;
        }
        .dropdown-menu-custom .dropdown-item {
            border-radius: 8px;
            padding: 8px 16px;
            transition: all 0.2s;
        }
        .dropdown-menu-custom .dropdown-item:hover {
            background: #f0f0f0;
        }
        .dropdown-menu-custom .dropdown-item i {
            width: 20px;
            margin-right: 8px;
        }
    </style>
    
    <sitemesh:write property='head' />
</head>
<body>
    <!-- Toast Container -->
    <div class="toast-container">
        <c:if test="${not empty sessionScope.message}">
            <div class="toast align-items-center text-white bg-success border-0 show" role="alert">
                <div class="d-flex">
                    <div class="toast-body">
                        <i class="fas fa-check-circle me-2"></i> ${sessionScope.message}
                    </div>
                    <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast"></button>
                </div>
            </div>
            <c:remove var="message" scope="session" />
        </c:if>
        <c:if test="${not empty sessionScope.error}">
            <div class="toast align-items-center text-white bg-danger border-0 show" role="alert">
                <div class="d-flex">
                    <div class="toast-body">
                        <i class="fas fa-exclamation-circle me-2"></i> ${sessionScope.error}
                    </div>
                    <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast"></button>
                </div>
            </div>
            <c:remove var="error" scope="session" />
        </c:if>
    </div>

    <!-- NAVBAR -->
    <nav class="navbar navbar-expand-lg navbar-custom">
        <div class="container">
            <a class="navbar-brand" href="${pageContext.request.contextPath}/">
                <i class="fas fa-store me-2"></i>UteProWeb
            </a>
            <button class="navbar-toggler border-0" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item">
                        <a class="nav-link ${fn:contains(pageContext.request.requestURI, '/home') ? 'active' : ''}" 
                           href="${pageContext.request.contextPath}/home">
                            <i class="fas fa-home me-1"></i> Trang chủ
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link ${fn:contains(pageContext.request.requestURI, '/product') ? 'active' : ''}" 
                           href="${pageContext.request.contextPath}/product">
                            <i class="fas fa-box me-1"></i> Sản phẩm
                        </a>
                    </li>
                    
                    <c:if test="${sessionScope.account != null && sessionScope.account.roleId == 1}">
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown">
                                <i class="fas fa-tools me-1"></i> Quản lý
                            </a>
                            <ul class="dropdown-menu dropdown-menu-end dropdown-menu-custom">
                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/admin/categories">
                                    <i class="fas fa-folder"></i> Danh mục
                                </a></li>
                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/admin/products">
                                    <i class="fas fa-boxes"></i> Sản phẩm
                                </a></li>
                            </ul>
                        </li>
                    </c:if>
                    
                    <c:choose>
                        <c:when test="${sessionScope.account != null}">
                            <li class="nav-item dropdown">
                                <a class="nav-link dropdown-toggle d-flex align-items-center" href="#" role="button" data-bs-toggle="dropdown">
                                    <c:choose>
                                        <c:when test="${sessionScope.account.avatar != null && sessionScope.account.avatar != ''}">
                                            <img class="avatar-nav" src="${pageContext.request.contextPath}/image?fname=${sessionScope.account.avatar}" 
                                                 onerror="this.src='https://ui-avatars.com/api/?name=${sessionScope.account.fullName}&background=667eea&color=fff&size=35'"/>
                                        </c:when>
                                        <c:otherwise>
                                            <img class="avatar-nav" src="https://ui-avatars.com/api/?name=${sessionScope.account.fullName}&background=667eea&color=fff&size=35" alt="avatar"/>
                                        </c:otherwise>
                                    </c:choose>
                                    <span>${sessionScope.account.fullName}</span>
                                    <c:if test="${sessionScope.account.roleId == 1}">
                                        <span class="badge-admin">Admin</span>
                                    </c:if>
                                </a>
                                <ul class="dropdown-menu dropdown-menu-end dropdown-menu-custom">
                                    <li><a class="dropdown-item" href="${pageContext.request.contextPath}/user/profile">
                                        <i class="fas fa-user-circle"></i> Hồ sơ
                                    </a></li>
                                    <li><hr class="dropdown-divider"></li>
                                    <li><a class="dropdown-item text-danger" href="${pageContext.request.contextPath}/logout">
                                        <i class="fas fa-sign-out-alt"></i> Đăng xuất
                                    </a></li>
                                </ul>
                            </li>
                        </c:when>
                        <c:otherwise>
                            <li class="nav-item">
                                <a class="nav-link btn btn-light text-dark px-4 rounded-pill ms-2" 
                                   href="${pageContext.request.contextPath}/login">
                                    <i class="fas fa-sign-in-alt me-1"></i> Đăng nhập
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link btn btn-outline-light px-4 rounded-pill ms-2" 
                                   href="${pageContext.request.contextPath}/register">
                                    <i class="fas fa-user-plus me-1"></i> Đăng ký
                                </a>
                            </li>
                        </c:otherwise>
                    </c:choose>
                </ul>
            </div>
        </div>
    </nav>

    <!-- MAIN CONTENT -->
    <div class="main-content">
        <sitemesh:write property='body' />
    </div>

    <!-- FOOTER -->
    <footer class="footer-custom">
        <div class="container text-center">
            <p class="mb-0">
                <i class="fas fa-copyright me-1"></i> 2026 UteProWeb. 
                <a href="#" class="text-white-50">Privacy Policy</a> | 
                <a href="#" class="text-white-50">Terms of Service</a>
            </p>
        </div>
    </footer>

    <!-- Bootstrap 5 JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Auto dismiss toasts after 3 seconds
        document.addEventListener('DOMContentLoaded', function() {
            var toasts = document.querySelectorAll('.toast');
            toasts.forEach(function(toast) {
                setTimeout(function() {
                    var bsToast = bootstrap.Toast.getInstance(toast);
                    if (bsToast) {
                        bsToast.hide();
                    }
                }, 3000);
            });
        });
    </script>
    <sitemesh:write property='bottom' />
</body>
</html>