<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Xác thực OTP</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #ffecd2 0%, #fcb69f 100%);
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 20px;
        }
        .otp-container {
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
        .otp-header {
            text-align: center;
            margin-bottom: 30px;
        }
        .otp-header h1 {
            font-size: 28px;
            color: #333;
            margin-bottom: 5px;
        }
        .otp-header p {
            color: #666;
            font-size: 14px;
        }
        .otp-header .icon {
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
            text-align: center;
            letter-spacing: 5px;
            font-size: 24px;
            font-weight: bold;
        }
        .form-group input:focus {
            border-color: #fcb69f;
            box-shadow: 0 0 0 3px rgba(252, 182, 159, 0.3);
        }
        .btn-verify {
            width: 100%;
            padding: 14px;
            background: linear-gradient(135deg, #ffecd2 0%, #fcb69f 100%);
            color: #333;
            border: none;
            border-radius: 10px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
        }
        .btn-verify:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 20px rgba(252, 182, 159, 0.4);
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
        .otp-footer {
            text-align: center;
            margin-top: 20px;
            padding-top: 20px;
            border-top: 1px solid #e5e7eb;
        }
        .otp-footer a {
            color: #667eea;
            text-decoration: none;
            font-weight: 500;
            transition: color 0.3s;
        }
        .otp-footer a:hover {
            color: #764ba2;
            text-decoration: underline;
        }
        .otp-footer p {
            color: #6b7280;
            font-size: 14px;
            margin: 5px 0;
        }
        .email-display {
            background: #f3f4f6;
            padding: 8px 15px;
            border-radius: 8px;
            display: inline-block;
            font-weight: 500;
            color: #333;
            margin-bottom: 10px;
        }
        .otp-hint {
            font-size: 12px;
            color: #6b7280;
            text-align: center;
            margin-top: 10px;
        }
        .resend-link {
            color: #fcb69f !important;
            font-weight: 600 !important;
        }
        @media (max-width: 480px) {
            .otp-container {
                padding: 25px;
            }
        }
    </style>
</head>
<body>
    <div class="otp-container">
        <div class="otp-header">
            <span class="icon">📧</span>
            <h1>Xác thực OTP</h1>
            <p>Nhập mã OTP đã được gửi đến email của bạn</p>
        </div>

        <div style="text-align: center;">
            <span class="email-display">📧 ${email}</span>
        </div>

        <c:if test="${not empty error}">
            <div class="alert alert-danger">
                <span>⚠️</span> ${error}
            </div>
        </c:if>

        <form action="${pageContext.request.contextPath}/verify-otp" method="post">
            <input type="hidden" name="email" value="${email}">
            <input type="hidden" name="action" value="${action}">
            
            <div class="form-group">
                <label for="otp">🔑 Mã OTP</label>
                <input type="text" id="otp" name="otp" placeholder="Nhập mã OTP" maxlength="6" required>
            </div>

            <button type="submit" class="btn-verify">Xác thực</button>
        </form>

        <div class="otp-footer">
            <p>Bạn chưa nhận được mã? <a href="#" class="resend-link" onclick="alert('Vui lòng kiểm tra email hoặc thử lại sau 5 phút')">Gửi lại</a></p>
            <p><a href="${pageContext.request.contextPath}/login">← Quay lại đăng nhập</a></p>
        </div>
    </div>
</body>
</html>