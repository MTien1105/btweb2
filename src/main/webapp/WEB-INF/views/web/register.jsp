<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng ký tài khoản</title>
    <style>
        * { box-sizing: border-box; }
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background-color: #eef2f7; display: flex; justify-content: center; align-items: center; min-height: 100vh; margin: 0; padding: 20px 0; }
        .register-card { background: #ffffff; padding: 35px 30px; border-radius: 10px; box-shadow: 0 4px 15px rgba(0,0,0,0.1); width: 100%; max-width: 450px; }
        .register-card h2 { margin-top: 0; margin-bottom: 20px; text-align: center; color: #333; }
        .form-group { margin-bottom: 15px; }
        .form-group label { display: block; margin-bottom: 6px; font-weight: 500; color: #555; }
        .form-group label span { color: #dc3545; }
        .form-group input { width: 100%; padding: 9px 12px; border: 1px solid #ced4da; border-radius: 5px; font-size: 14px; outline: none; transition: border-color 0.2s; }
        .form-group input:focus { border-color: #0d6efd; }
        .btn-submit { width: 100%; padding: 11px; background-color: #198754; color: white; border: none; border-radius: 5px; font-size: 16px; font-weight: 600; cursor: pointer; transition: background-color 0.2s; margin-top: 10px; }
        .btn-submit:hover { background-color: #157347; }
        .alert-error { background-color: #f8d7da; color: #842029; padding: 10px 14px; border-radius: 5px; margin-bottom: 15px; font-size: 14px; }
        .card-footer { text-align: center; margin-top: 20px; font-size: 14px; color: #666; }
        .card-footer a { color: #0d6efd; text-decoration: none; font-weight: 500; }
        .card-footer a:hover { text-decoration: underline; }
    </style>
</head>
<body>
    <div class="register-card">
        <h2>ĐĂNG KÝ TÀI KHOẢN</h2>

        <c:if test="${not empty error}">
            <div class="alert-error">${error}</div>
        </c:if>

        <form action="/register" method="post">
            <div class="form-group">
                <label for="username">Tên đăng nhập <span>*</span></label>
                <input type="text" id="username" name="username" value="${registerModel.username}" placeholder="Nhập tên đăng nhập" required />
            </div>

            <div class="form-group">
                <label for="email">Địa chỉ Email <span>*</span></label>
                <input type="email" id="email" name="email" value="${registerModel.email}" placeholder="example@domain.com" required />
            </div>

            <div class="form-group">
                <label for="fullname">Họ và tên</label>
                <input type="text" id="fullname" name="fullname" value="${registerModel.fullname}" placeholder="Nguyễn Văn A" />
            </div>

            <div class="form-group">
                <label for="phone">Số điện thoại</label>
                <input type="text" id="phone" name="phone" value="${registerModel.phone}" placeholder="0901234567" />
            </div>

            <div class="form-group">
                <label for="password">Mật khẩu <span>*</span></label>
                <input type="password" id="password" name="password" placeholder="Tối thiểu 6 ký tự" required />
            </div>

            <div class="form-group">
                <label for="confirmPassword">Xác nhận mật khẩu <span>*</span></label>
                <input type="password" id="confirmPassword" name="confirmPassword" placeholder="Nhập lại mật khẩu" required />
            </div>

            <button type="submit" class="btn-submit">Đăng ký tài khoản</button>
        </form>

        <div class="card-footer">
            Đã có tài khoản? <a href="/login">Đăng nhập</a> | <a href="/">Về trang chủ</a>
        </div>
    </div>
</body>
</html>
