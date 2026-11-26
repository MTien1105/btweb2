<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng nhập hệ thống</title>
    <style>
        * { box-sizing: border-box; }
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background-color: #eef2f7; display: flex; justify-content: center; align-items: center; min-height: 100vh; margin: 0; }
        .login-card { background: #ffffff; padding: 35px 30px; border-radius: 10px; box-shadow: 0 4px 15px rgba(0,0,0,0.1); width: 100%; max-width: 400px; }
        .login-card h2 { margin-top: 0; margin-bottom: 20px; text-align: center; color: #333; }
        .form-group { margin-bottom: 18px; }
        .form-group label { display: block; margin-bottom: 6px; font-weight: 500; color: #555; }
        .form-group input[type="text"], .form-group input[type="password"] { width: 100%; padding: 10px 12px; border: 1px solid #ced4da; border-radius: 5px; font-size: 14px; outline: none; transition: border-color 0.2s; }
        .form-group input[type="text"]:focus, .form-group input[type="password"]:focus { border-color: #0d6efd; }
        .form-check { display: flex; align-items: center; gap: 8px; font-size: 14px; color: #555; }
        .btn-submit { width: 100%; padding: 11px; background-color: #0d6efd; color: white; border: none; border-radius: 5px; font-size: 16px; font-weight: 600; cursor: pointer; transition: background-color 0.2s; margin-top: 10px; }
        .btn-submit:hover { background-color: #0b5ed7; }
        .alert-error { background-color: #f8d7da; color: #842029; padding: 10px 14px; border-radius: 5px; margin-bottom: 15px; font-size: 14px; }
        .alert-success { background-color: #d1e7dd; color: #0f5132; padding: 10px 14px; border-radius: 5px; margin-bottom: 15px; font-size: 14px; }
        .card-footer { text-align: center; margin-top: 20px; font-size: 14px; color: #666; }
        .card-footer a { color: #0d6efd; text-decoration: none; font-weight: 500; }
        .card-footer a:hover { text-decoration: underline; }
        .demo-accounts { margin-top: 20px; padding: 10px; background-color: #f8f9fa; border: 1px dashed #adb5bd; border-radius: 6px; font-size: 12px; color: #495057; }
    </style>
</head>
<body>
    <div class="login-card">
        <h2>ĐĂNG NHẬP</h2>

        <c:if test="${not empty error}">
            <div class="alert-error">${error}</div>
        </c:if>

        <c:if test="${not empty message}">
            <div class="alert-success">${message}</div>
        </c:if>

        <c:if test="${param.logout eq 'true'}">
            <div class="alert-success">Bạn đã đăng xuất thành công!</div>
        </c:if>

        <c:if test="${not empty param.redirect}">
            <div class="alert-error">Vui lòng đăng nhập với quyền Admin để truy cập trang này!</div>
        </c:if>

        <form action="/login" method="post">
            <div class="form-group">
                <label for="username">Tên đăng nhập hoặc Email</label>
                <input type="text" id="username" name="username" value="${loginModel.username}" placeholder="Nhập username hoặc email" required autofocus />
            </div>

            <div class="form-group">
                <label for="password">Mật khẩu</label>
                <input type="password" id="password" name="password" placeholder="Nhập mật khẩu" required />
            </div>

            <div class="form-group form-check">
                <input type="checkbox" id="rememberMe" name="rememberMe" value="true" ${loginModel.rememberMe ? 'checked' : ''} />
                <label for="rememberMe" style="margin-bottom: 0; cursor: pointer;">Ghi nhớ đăng nhập</label>
            </div>

            <button type="submit" class="btn-submit">Đăng nhập</button>
        </form>

        <div class="card-footer">
            Chưa có tài khoản? <a href="/register">Đăng ký ngay</a> | <a href="/">Về trang chủ</a>
        </div>

        <div class="demo-accounts">
            <strong>Tài khoản thử nghiệm có sẵn:</strong><br/>
            - Admin: <code>admin</code> / pass: <code>123456</code><br/>
            - User: <code>user</code> / pass: <code>123456</code>
        </div>
    </div>
</body>
</html>
