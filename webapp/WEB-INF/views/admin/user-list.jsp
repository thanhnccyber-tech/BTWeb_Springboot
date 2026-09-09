<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý người dùng</title>
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
        .search-box { max-width: 450px; }
        .result-count { font-size: 0.9rem; color: #6c757d; margin-left: 10px; }
        .avatar-thumb { width: 50px; height: 50px; object-fit: cover; border-radius: 50%; }
        .badge-role { font-size: 0.8rem; padding: 4px 12px; }
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
            <div class="d-flex justify-content-between align-items-center mb-4 flex-wrap gap-2">
                <div>
                    <h3><i class="fas fa-users me-2"></i>Quản lý người dùng</h3>
                    <span class="result-count">Tổng: ${totalCount} người dùng</span>
                </div>
                <div class="d-flex gap-2">
                    <!-- Search Form -->
                    <form action="${pageContext.request.contextPath}/admin/users" method="get" class="d-flex search-box">
                        <input type="text" name="keyword" class="form-control form-control-sm" 
                               placeholder="Tìm kiếm theo tên, email, số điện thoại..." value="${keyword}" 
                               style="border-radius: 20px 0 0 20px;">
                        <button type="submit" class="btn btn-primary btn-sm" style="border-radius: 0 20px 20px 0;">
                            <i class="fas fa-search"></i>
                        </button>
                        <c:if test="${not empty keyword}">
                            <a href="${pageContext.request.contextPath}/admin/users" class="btn btn-secondary btn-sm ms-1" style="border-radius: 20px;">
                                <i class="fas fa-times"></i>
                            </a>
                        </c:if>
                    </form>
                    <a href="${pageContext.request.contextPath}/admin/user/add" class="btn btn-primary rounded-pill">
                        <i class="fas fa-plus me-2"></i>Thêm
                    </a>
                </div>
            </div>

            <!-- Hiển thị keyword đang tìm -->
            <c:if test="${not empty keyword}">
                <div class="alert alert-info py-2">
                    <i class="fas fa-search me-2"></i>Kết quả tìm kiếm: "<strong>${keyword}</strong>"
                </div>
            </c:if>

            <c:choose>
                <c:when test="${not empty listuser}">
                    <div class="table-responsive">
                        <table class="table table-hover table-bordered align-middle">
                            <thead class="table-dark">
                                <tr>
                                    <th>STT</th>
                                    <th>Avatar</th>
                                    <th>Tên đăng nhập</th>
                                    <th>Họ và tên</th>
                                    <th>Email</th>
                                    <th>SĐT</th>
                                    <th>Vai trò</th>
                                    <th>Trạng thái</th>
                                    <th>Thao tác</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${listuser}" var="u" varStatus="STT">
                                    <tr>
                                        <td>${STT.index + 1}</td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${u.avatar != null && u.avatar != ''}">
                                                    <c:choose>
                                                        <c:when test="${u.avatar.startsWith('http')}">
                                                            <c:url value="${u.avatar}" var="imgUrl"/>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <c:url value="/image?fname=${u.avatar}" var="imgUrl"/>
                                                        </c:otherwise>
                                                    </c:choose>
                                                    <img src="${imgUrl}" class="avatar-thumb" 
                                                         onerror="this.src='https://ui-avatars.com/api/?name=${u.fullName}&background=667eea&color=fff&size=50'"/>
                                                </c:when>
                                                <c:otherwise>
                                                    <img src="https://ui-avatars.com/api/?name=${u.fullName}&background=667eea&color=fff&size=50" class="avatar-thumb"/>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td><strong>${u.userName}</strong></td>
                                        <td>${u.fullName}</td>
                                        <td>${u.email}</td>
                                        <td>${u.phone}</td>
                                        <td>
                                            <span class="badge ${u.roleId == 1 ? 'bg-danger' : 'bg-info'} badge-role">
                                                ${u.roleId == 1 ? 'Admin' : 'User'}
                                            </span>
                                        </td>
                                        <td>
                                            <c:if test="${u.verified}">
                                                <span class="badge bg-success">Đã xác thực</span>
                                            </c:if>
                                            <c:if test="${!u.verified}">
                                                <span class="badge bg-warning text-dark">Chưa xác thực</span>
                                            </c:if>
                                        </td>
                                        <td>
                                            <a href="${pageContext.request.contextPath}/admin/user/edit?id=${u.id}" 
                                               class="btn btn-warning btn-sm">
                                                <i class="fas fa-edit"></i>
                                            </a>
                                            <a href="${pageContext.request.contextPath}/admin/user/delete?id=${u.id}" 
                                               class="btn btn-danger btn-sm" 
                                               onclick="return confirm('Bạn có chắc muốn xóa người dùng này?')">
                                                <i class="fas fa-trash"></i>
                                            </a>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="alert alert-info text-center py-5">
                        <i class="fas fa-info-circle fa-3x mb-3 d-block"></i>
                        <h4>${not empty keyword ? 'Không tìm thấy người dùng nào' : 'Chưa có người dùng nào'}</h4>
                        <p class="text-muted">${not empty keyword ? 'Vui lòng thử lại với từ khóa khác' : 'Hãy thêm người dùng mới'}</p>
                    </div>
                </c:otherwise>
            </c:choose>
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