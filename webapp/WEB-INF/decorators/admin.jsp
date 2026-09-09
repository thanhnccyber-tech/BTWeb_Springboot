<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><sitemesh:title default="Admin - UteProWeb" /></title>
    
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome 6 -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <style>
        body {
            background: #f0f2f5;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }
        .sidebar {
            min-height: calc(100vh - 56px);
            background: #2d3748;
            padding: 20px 0;
            box-shadow: 2px 0 10px rgba(0,0,0,0.1);
        }
        .sidebar .nav-link {
            color: rgba(255,255,255,0.7);
            padding: 12px 20px;
            border-radius: 10px;
            margin: 4px 15px;
            transition: all 0.3s;
        }
        .sidebar .nav-link:hover {
            background: rgba(255,255,255,0.1);
            color: white;
        }
        .sidebar .nav-link.active {
            background: rgba(255,255,255,0.15);
            color: white;
        }
        .sidebar .nav-link i {
            width: 24px;
            margin-right: 10px;
        }
        .sidebar .nav-header {
            color: rgba(255,255,255,0.5);
            font-size: 12px;
            text-transform: uppercase;
            letter-spacing: 1px;
            padding: 10px 20px;
            margin-top: 10px;
        }
        .main-content {
            padding: 30px;
        }
        .navbar-admin {
            background: white;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
        }
        .avatar-nav {
            width: 35px;
            height: 35px;
            border-radius: 50%;
            object-fit: cover;
            margin-right: 8px;
        }
        .card-dashboard {
            border-radius: 15px;
            border: none;
            box-shadow: 0 2px 15px rgba(0,0,0,0.05);
            transition: all 0.3s;
        }
        .card-dashboard:hover {
            transform: translateY(-5px);
            box-shadow: 0 5px 25px rgba(0,0,0,0.1);
        }
        @media (max-width: 768px) {
            .sidebar {
                min-height: auto;
                padding: 10px 0;
            }
            .main-content {
                padding: 15px;
            }
        }
    </style>
    
    <sitemesh:write property='head' />
</head>
<body>
    <!-- Admin Navbar -->
    <nav class="navbar navbar-expand-lg navbar-admin">
        <div class="container-fluid">
            <a class="navbar-brand fw-bold" href="${pageContext.request.contextPath}/admin/categories">
                <i class="fas fa-cog text-primary me-2"></i>Admin Panel
            </a>
            <div class="ms-auto d-flex align-items-center">
                <c:if test="${sessionScope.account != null}">
                    <span class="me-3 d-none d-sm-inline">
                        <i class="fas fa-user me-1"></i> ${sessionScope.account.fullName}
                    </span>
                    <a href="${pageContext.request.contextPath}/logout" class="btn btn-danger btn-sm rounded-pill">
                        <i class="fas fa-sign-out-alt me-1"></i> Đăng xuất
                    </a>
                </c:if>
            </div>
        </div>
    </nav>

    <div class="container-fluid">
        <div class="row">
            <!-- Sidebar -->
            <div class="col-md-3 col-lg-2 p-0">
                <div class="sidebar">
                    <div class="nav-header">Navigation</div>
                    <a class="nav-link ${fn:contains(pageContext.request.requestURI, '/categories') ? 'active' : ''}" 
                       href="${pageContext.request.contextPath}/admin/categories">
                        <i class="fas fa-folder"></i> Danh mục
                    </a>
                    <a class="nav-link ${fn:contains(pageContext.request.requestURI, '/products') ? 'active' : ''}" 
                       href="${pageContext.request.contextPath}/admin/products">
                        <i class="fas fa-boxes"></i> Sản phẩm
                    </a>
                    <a class="nav-link ${fn:contains(pageContext.request.requestURI, '/profile') ? 'active' : ''}" 
                       href="${pageContext.request.contextPath}/user/profile">
                        <i class="fas fa-user"></i> Hồ sơ
                    </a>
                    <div class="nav-header">System</div>
                    <a class="nav-link" href="${pageContext.request.contextPath}/home">
                        <i class="fas fa-arrow-left"></i> Về trang chủ
                    </a>
                </div>
            </div>
            
            <!-- Main Content -->
            <div class="col-md-9 col-lg-10 main-content">
                <sitemesh:write property='body' />
            </div>
        </div>
    </div>

    <!-- Bootstrap 5 JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <sitemesh:write property='bottom' />
</body>
</html>