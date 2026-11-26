<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<div style="padding: 15px;">
    <h2>QUẢN LÝ NGƯỜI DÙNG (USER)</h2>
    <div style="margin-bottom: 15px;">
        <a href="/admin/users/add" style="display: inline-block; padding: 6px 12px; background: #28a745; color: white; text-decoration: none; border-radius: 4px;">+ Thêm người dùng</a>
    </div>

    <!-- Hiển thị thông báo -->
    <c:if test="${not empty message}">
        <div style="padding: 10px; background-color: #d4edda; color: #155724; border-radius: 4px; margin-bottom: 10px;">
            <i>${message}</i>
        </div>
    </c:if>
    <c:if test="${not empty error}">
        <div style="padding: 10px; background-color: #f8d7da; color: #842029; border-radius: 4px; margin-bottom: 10px;">
            <i>${error}</i>
        </div>
    </c:if>

    <!-- Form tìm kiếm -->
    <form action="/admin/users/searchpaginated" method="get" style="margin-bottom: 15px; display: flex; gap: 8px;">
        <input type="text" name="keyword" id="keyword" value="${keyword}" placeholder="Tìm theo username, họ tên hoặc email" style="padding: 6px 10px; width: 320px; border: 1px solid #ccc; border-radius: 4px;" />
        <button type="submit" style="padding: 6px 15px; background: #007bff; color: white; border: none; border-radius: 4px; cursor: pointer;">Search</button>
        <c:if test="${not empty keyword}">
            <a href="/admin/users/searchpaginated" style="padding: 6px 12px; background: #6c757d; color: white; text-decoration: none; border-radius: 4px;">Xóa tìm</a>
        </c:if>
    </form>

    <c:if test="${!userPage.hasContent()}">
        <p style="color: #888; font-style: italic;">Không tìm thấy người dùng nào</p>
    </c:if>

    <c:if test="${userPage.hasContent()}">
        <table border="1" cellpadding="8" cellspacing="0" style="width: 100%; border-collapse: collapse; border: 1px solid #ddd;">
            <thead style="background-color: #343a40; color: white;">
                <tr>
                    <th style="width: 50px; text-align: center;">STT</th>
                    <th>Username</th>
                    <th>Họ và tên</th>
                    <th>Email</th>
                    <th>Số điện thoại</th>
                    <th style="width: 80px; text-align: center;">Role</th>
                    <th style="width: 90px; text-align: center;">Trạng thái</th>
                    <th style="width: 120px; text-align: center;">Thao tác</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${userPage.content}" var="u" varStatus="STT">
                    <tr style="border-bottom: 1px solid #eee;">
                        <td style="text-align: center;">${STT.index + 1}</td>
                        <td><strong>${u.username}</strong></td>
                        <td>${u.fullname}</td>
                        <td>${u.email}</td>
                        <td>${u.phone}</td>
                        <td style="text-align: center;">
                            <span style="font-weight: bold; color: ${u.role eq 'ADMIN' ? '#dc3545' : '#0d6efd'};">${u.role}</span>
                        </td>
                        <td style="text-align: center;">
                            <span style="color: ${u.status == 1 ? 'green' : 'red'};">${u.status == 1 ? 'Hoạt động' : 'Khóa'}</span>
                        </td>
                        <td style="text-align: center;">
                            <a href="/admin/users/edit/${u.id}" style="color: #007bff; margin-right: 8px;">Sửa</a>
                            <a href="/admin/users/delete/${u.id}" style="color: #dc3545;" onclick="return confirm('Bạn có chắc chắn muốn xóa người dùng này không?');">Xóa</a>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </c:if>

    <!-- Phân trang và Page Size -->
    <div style="display: flex; justify-content: space-between; align-items: center; margin-top: 15px;">
        <form action="/admin/users/searchpaginated" method="get">
            <input type="hidden" name="keyword" value="${keyword}" />
            <label for="size">Số dòng / trang: </label>
            <select name="size" id="size" onchange="this.form.submit()" style="padding: 4px 8px; border-radius: 4px;">
                <option ${userPage.size == 3 ? 'selected':''} value="3">3</option>
                <option ${userPage.size == 5 ? 'selected':''} value="5">5</option>
                <option ${userPage.size == 10 ? 'selected':''} value="10">10</option>
                <option ${userPage.size == 15 ? 'selected':''} value="15">15</option>
            </select>
        </form>

        <c:if test="${userPage.totalPages > 0}">
            <ul style="display: flex; list-style: none; padding: 0; margin: 0; gap: 5px;">
                <c:forEach items="${pageNumbers}" var="pageNumber">
                    <c:if test="${userPage.totalPages > 1}">
                        <li class="${pageNumber == userPage.number + 1 ? 'page-item active' : 'page-item'}" style="margin: 0;">
                            <a href="<c:url value='/admin/users/searchpaginated?keyword=${keyword}&size=${userPage.size}&page=${pageNumber}'/>"
                               style="display: inline-block; padding: 5px 12px; border: 1px solid #dee2e6; text-decoration: none; border-radius: 4px; ${pageNumber == userPage.number + 1 ? 'background-color: #007bff; color: white; font-weight: bold;' : 'color: #007bff;'}">
                                ${pageNumber}
                            </a>
                        </li>
                    </c:if>
                </c:forEach>
            </ul>
        </c:if>
    </div>
</div>
