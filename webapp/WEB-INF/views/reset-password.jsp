<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đặt lại mật khẩu</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #89f7fe 0%, #66a6ff 100%);
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 20px;
        }
        .reset-container {
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
        .reset-header {
            text-align: center;
            margin-bottom: 30px;
        }
        .reset-header h1 {
            font-size: 28px;
            color: #333;
            margin-bottom: 5px;
        }
        .reset-header p {
            color: #666;
            font-size: 14px;
        }
        .reset-header .icon {
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
            border-color: #66a6ff;
            box-shadow: 0 0 0 3px rgba(102, 166, 255, 0.2);
        }
        .btn-reset {
            width: 100%;
            padding: 14px;
            background: linear-gradient(135deg, #89f7fe 0%, #66a6ff 100%);
            color: white;
            border: none;
            border-radius: 10px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
        }
        .btn-reset:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 20px rgba(102, 166, 255, 0.4);
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
        .reset-footer {
            text-align: center;
            margin-top: 20px;
            padding-top: 20px;
            border-top: 1px solid #e5e7eb;
        }
        .reset-footer a {
            color: #66a6ff;
            text-decoration: none;
            font-weight: 500;
            transition: color 0.3s;
        }
        .reset-footer a:hover {
            color: #4a7fc7;
            text-decoration: underline;
        }
        .password-hint {
            font-size: 12px;
            color: #6b7280;
            margin-top: 4px;
        }
        @media (max-width: 480px) {
            .reset-container {
                padding: 25px;
            }
        }
    </style>
</head>
<body>
    <div class="reset-container">
        <div class="reset-header">
            <span class="icon">🔒</span>
            <h1>Đặt lại mật khẩu</h1>
            <p>Tạo mật khẩu mới cho tài khoản của bạn</p>
        </div>

        <c:if test="${not empty error}">
            <div class="alert alert-danger">
                <span>⚠️</span> ${error}
            </div>
        </c:if>

        <form action="${pageContext.request.contextPath}/reset-password" method="post">
            <div class="form-group">
                <label for="password">🔑 Mật khẩu mới</label>
                <input type="password" id="password" name="password" placeholder="Nhập mật khẩu mới" required>
                <div class="password-hint">Mật khẩu nên có ít nhất 6 ký tự</div>
            </div>

            <div class="form-group">
                <label for="confirm">✅ Xác nhận mật khẩu</label>
                <input type="password" id="confirm" name="confirm" placeholder="Nhập lại mật khẩu" required>
            </div>

            <button type="submit" class="btn-reset">Đặt lại mật khẩu</button>
        </form>

        <div class="reset-footer">
            <p><a href="${pageContext.request.contextPath}/login">← Quay lại đăng nhập</a></p>
        </div>
    </div>
</body>
</html>