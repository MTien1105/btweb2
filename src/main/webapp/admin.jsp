<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title><sitemesh:write property='title'/> - Admin Panel</title>
    <style>
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; margin: 0; padding: 0; background-color: #f1f3f5; }
        header { background: #dc3545; color: white; padding: 15px 30px; display: flex; justify-content: space-between; align-items: center; }
        header h1 { margin: 0; font-size: 22px; }
        .auth-bar { font-size: 14px; }
        .auth-bar a { color: #fffa65; text-decoration: none; margin-left: 10px; font-weight: bold; }
        nav { background: #1a1e21; padding: 10px 30px; display: flex; justify-content: space-between; align-items: center; }
        .nav-links a { color: #f8f9fa; margin-right: 20px; text-decoration: none; font-weight: 500; }
        .nav-links a:hover { color: #dc3545; }
        main { padding: 30px; min-height: 400px; background: white; margin: 20px 30px; border-radius: 6px; box-shadow: 0 1px 3px rgba(0,0,0,0.1); }
        footer { background: #1a1e21; color: #adb5bd; text-align: center; padding: 15px; }
    </style>
    <sitemesh:write property='head'/>
</head>
<body>
    <header>
        <h1>[SITE MESH DECORATOR] - TRANG QUẢN TRỊ ADMIN</h1>
        <div class="auth-bar">
            <span>Admin: <strong>${sessionScope.account.fullname}</strong></span>
            <a href="/logout" style="color: #fffa65;">[Đăng xuất]</a>
        </div>
    </header>
    <nav>
        <div class="nav-links">
            <a href="/">Về Trang User</a>
            <a href="/admin/dashboard">Admin Dashboard</a>
            <a href="/admin/categories/searchpaginated">Quản lý Category</a>
            <a href="/admin/users/searchpaginated">Quản lý User</a>
        </div>
    </nav>
    <main>
        <sitemesh:write property='body'/>
    </main>
    <footer>
        <p>&copy; 2026 HCMUTE - Quản Trị Hệ Thống Admin</p>
    </footer>
</body>
</html>
