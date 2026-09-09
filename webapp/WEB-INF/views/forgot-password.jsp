<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quên mật khẩu</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #a8edea 0%, #fed6e3 100%);
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 20px;
        }
        .forgot-container {
            background: white;
            border-radius: 20px;
            box-shadow: 0 15px 35px rgba(0,0,0,0.2);
            padding: 40px;
            max-width: 420px;
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
        .forgot-header {
            text-align: center;
            margin-bottom: 30px;
        }
        .forgot-header h1 {
            font-size: 28px;
            color: #333;
            margin-bottom: 5px;
        }
        .forgot-header p {
            color: #666;
            font-size: 14px;
        }
        .forgot-header .icon {
            font-size: 60px;
            display: block;
            margin-bottom: 10px;
        }
        .form-group {
            margin-bottom: 20px;
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
            border-color: #a8edea;
            box-shadow: 0 0 0 3px rgba(168, 237, 234, 0.3);
        }
        .btn-submit {
            width: 100%;
            padding: 14px;
            background: linear-gradient(135deg, #a8edea 0%, #fed6e3 100%);
            color: #333;
            border: none;
            border-radius: 10px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
        }
        .btn-submit:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 20px rgba(168, 237, 234, 0.4);
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
        .forgot-footer {
            text-align: center;
            margin-top: 20px;
            padding-top: 20px;
            border-top: 1px solid #e5e7eb;
        }
        .forgot-footer a {
            color: #667eea;
            text-decoration: none;
            font-weight: 500;
            transition: color 0.3s;
        }
        .forgot-footer a:hover {
            color: #764ba2;
            text-decoration: underline;
        }
        .forgot-footer p {
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
        @media (max-width: 480px) {
            .forgot-container {
                padding: 25px;
            }
        }
    </style>
</head>
<body>
    <div class="forgot-container">
        <div class="forgot-header">
            <span class="icon">🔑</span>
            <h1>Quên mật khẩu</h1>
            <p>Nhập email để nhận mã OTP đặt lại mật khẩu</p>
        </div>

        <c:if test="${not empty error}">
            <div class="alert alert-danger">
                <span>⚠️</span> ${error}
            </div>
        </c:if>

        <form action="${pageContext.request.contextPath}/forgot-password" method="post">
            <div class="form-group">
                <label for="email">📧 Email</label>
                <input type="email" id="email" name="email" placeholder="Nhập email đã đăng ký" required>
            </div>

            <button type="submit" class="btn-submit">Gửi mã OTP</button>
        </form>

        <div class="forgot-footer">
            <p><a href="${pageContext.request.contextPath}/login">← Quay lại đăng nhập</a></p>
            <a href="${pageContext.request.contextPath}/home" class="back-home">🏠 Về trang chủ</a>
        </div>
    </div>
</body>
</html>