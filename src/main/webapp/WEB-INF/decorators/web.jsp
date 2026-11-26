<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title><sitemesh:write property='title'/> - Web SiteMesh</title>
    <style>
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; margin: 0; padding: 0; background-color: #f8f9fa; }
        header { background: #0d6efd; color: white; padding: 15px 30px; display: flex; justify-content: space-between; align-items: center; }
        header h1 { margin: 0; font-size: 22px; }
        .auth-bar { font-size: 14px; }
        .auth-bar a { color: #fffa65; text-decoration: none; margin-left: 10px; font-weight: bold; }
        nav { background: #212529; padding: 10px 30px; display: flex; justify-content: space-between; align-items: center; }
        .nav-links a { color: #f8f9fa; margin-right: 20px; text-decoration: none; font-weight: 500; }
        .nav-links a:hover { color: #0d6efd; }
        main { padding: 30px; min-height: 400px; background: white; margin: 20px 30px; border-radius: 6px; box-shadow: 0 1px 3px rgba(0,0,0,0.1); }
        footer { background: #212529; color: #adb5bd; text-align: center; padding: 15px; }
    </style>
    <sitemesh:write property='head'/>
</head>
<body>
    <header>
        <h1>[SITE MESH DECORATOR] - WEBSITE GIAO DIỆN USER</h1>
        <div class="auth-bar">
            <c:choose>
                <c:when test="${not empty sessionScope.account}">
                    <span>Xin chào, <strong>${sessionScope.account.fullname}</strong> (${sessionScope.account.role})</span>
                    <c:if test="${sessionScope.account.role eq 'ADMIN'}">
                        <a href="/admin/categories/searchpaginated" style="color: #69d2e7;">[Vào Trang Quản Trị]</a>
                    </c:if>
                    <a href="/logout" style="color: #ff6b6b;">[Đăng xuất]</a>
                </c:when>
                <c:otherwise>
                    <a href="/login">Đăng nhập</a> |
                    <a href="/register">Đăng ký</a>
                </c:otherwise>
            </c:choose>
        </div>
    </header>
    <nav>
        <div class="nav-links">
            <a href="/">Trang chủ</a>
            <c:if test="${sessionScope.account.role eq 'ADMIN'}">
                <a href="/admin/categories/searchpaginated">Quản lý Category (Admin)</a>
                <a href="/admin/dashboard">Admin Dashboard</a>
            </c:if>
        </div>
    </nav>
    <main>
        <sitemesh:write property='body'/>
    </main>
    <footer>
        <p>&copy; 2026 HCMUTE - Lập Trình Web - Spring Boot + JSP + SiteMesh 3</p>
    </footer>
</body>
</html>
