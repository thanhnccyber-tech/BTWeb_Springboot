<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng ký</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 20px;
        }
        .register-container {
            background: white;
            border-radius: 20px;
            box-shadow: 0 15px 35px rgba(0,0,0,0.2);
            padding: 40px;
            max-width: 480px;
            width: 100%;
            animation: slideIn 0.5s ease;
        }
        @keyframes slideIn {
            from {
                opacity: 0;
                transform: translateY(-30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
        .register-header {
            text-align: center;
            margin-bottom: 30px;
        }
        .register-header h1 {
            font-size: 28px;
            color: #333;
            margin-bottom: 5px;
        }
        .register-header p {
            color: #666;
            font-size: 14px;
        }
        .register-header .icon {
            font-size: 60px;
            display: block;
            margin-bottom: 10px;
        }
        .form-group {
            margin-bottom: 18px;
        }
        .form-group label {
            display: block;
            font-weight: 600;
            margin-bottom: 5px;
            color: #333;
            font-size: 14px;
        }
        .form-group input {
            width: 100%;
            padding: 12px 15px;
            border: 2px solid #e0e0e0;
            border-radius: 10px;
            font-size: 14px;
            transition: all 0.3s;
            outline: none;
        }
        .form-group input:focus {
            border-color: #f5576c;
            box-shadow: 0 0 0 3px rgba(245, 87, 108, 0.1);
        }
        .form-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 15px;
        }
        .btn-register {
            width: 100%;
            padding: 14px;
            background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
            color: white;
            border: none;
            border-radius: 10px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
        }
        .btn-register:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 20px rgba(245, 87, 108, 0.4);
        }
        .btn-register:active {
            transform: translateY(0);
        }
        .alert {
            padding: 12px 15px;
            border-radius: 10px;
            margin-bottom: 20px;
            font-size: 14px;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        .alert-danger {
            background: #fee2e2;
            color: #dc2626;
            border: 1px solid #fecaca;
        }
        .alert-success {
            background: #dcfce7;
            color: #16a34a;
            border: 1px solid #bbf7d0;
        }
        .register-footer {
            text-align: center;
            margin-top: 20px;
            padding-top: 20px;
            border-top: 1px solid #e5e7eb;
        }
        .register-footer a {
            color: #f5576c;
            text-decoration: none;
            font-weight: 500;
            transition: color 0.3s;
        }
        .register-footer a:hover {
            color: #c0392b;
            text-decoration: underline;
        }
        .register-footer p {
            color: #6b7280;
            font-size: 14px;
            margin: 5px 0;
        }
        .back-home {
            display: inline-block;
            margin-top: 10px;
            color: #6b7280 !important;
            font-size: 13px;
        }
        .back-home:hover {
            color: #333 !important;
        }
        .password-hint {
            font-size: 12px;
            color: #6b7280;
            margin-top: 4px;
        }
        @media (max-width: 480px) {
            .register-container {
                padding: 25px;
            }
            .register-header h1 {
                font-size: 24px;
            }
            .form-row {
                grid-template-columns: 1fr;
                gap: 0;
            }
        }
    </style>
</head>
<body>
    <div class="register-container">
        <div class="register-header">
            <span class="icon">✨</span>
            <h1>Tạo tài khoản</h1>
            <p>Đăng ký để trải nghiệm dịch vụ của chúng tôi</p>
        </div>

        <c:if test="${not empty alert}">
            <div class="alert alert-danger">
                <span>⚠️</span> ${alert}
            </div>
        </c:if>

        <form action="${pageContext.request.contextPath}/register" method="post">
            <div class="form-group">
                <label for="fullname">👤 Họ và tên</label>
                <input type="text" id="fullname" name="fullname" placeholder="Nhập họ và tên" required>
            </div>

            <div class="form-row">
                <div class="form-group">
                    <label for="email">📧 Email</label>
                    <input type="email" id="email" name="email" placeholder="Email" required>
                </div>
                <div class="form-group">
                    <label for="phone">📱 Số điện thoại</label>
                    <input type="text" id="phone" name="phone" placeholder="Số điện thoại" required>
                </div>
            </div>

            <div class="form-group">
                <label for="username">👤 Tên đăng nhập</label>
                <input type="text" id="username" name="username" placeholder="Chọn tên đăng nhập" required>
            </div>

            <div class="form-group">
                <label for="password">🔑 Mật khẩu</label>
                <input type="password" id="password" name="password" placeholder="Tạo mật khẩu" required>
                <div class="password-hint">Mật khẩu nên có ít nhất 6 ký tự</div>
            </div>

            <button type="submit" class="btn-register">Đăng ký</button>
        </form>

        <div class="register-footer">
            <p>Đã có tài khoản? <a href="${pageContext.request.contextPath}/login">Đăng nhập</a></p>
            <a href="${pageContext.request.contextPath}/home" class="back-home">← Về trang chủ</a>
        </div>
    </div>
</body>
</html>