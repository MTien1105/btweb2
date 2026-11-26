<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<div style="padding: 15px;">
    <h2>QUẢN LÝ DANH MỤC (CATEGORY)</h2>
    <div style="margin-bottom: 15px;">
        <a href="/admin/categories/add" style="display: inline-block; padding: 6px 12px; background: #28a745; color: white; text-decoration: none; border-radius: 4px;">+ Add category</a>
    </div>

    <!-- Hiển thị thông báo -->
    <c:if test="${message != null}">
        <div style="padding: 10px; background-color: #d4edda; color: #155724; border-radius: 4px; margin-bottom: 10px;">
            <i>${message}</i>
        </div>
    </c:if>
    <!-- Hết thông báo -->

    <form action="/admin/categories/searchpaginated" method="get" style="margin-bottom: 15px; display: flex; gap: 8px;">
        <input type="text" name="name" id="name" value="${name}" placeholder="Nhập từ khóa để tìm" style="padding: 6px 10px; width: 300px; border: 1px solid #ccc; border-radius: 4px;" />
        <button type="submit" style="padding: 6px 15px; background: #007bff; color: white; border: none; border-radius: 4px; cursor: pointer;">Search</button>
    </form>

    <c:if test="${!categoryPage.hasContent()}">
        <p style="color: #888; font-style: italic;">No Category</p>
    </c:if>

    <c:if test="${categoryPage.hasContent()}">
        <table border="1" cellpadding="8" cellspacing="0" style="width: 100%; border-collapse: collapse; border: 1px solid #ddd;">
            <thead style="background-color: #343a40; color: white;">
                <tr>
                    <th style="width: 60px; text-align: center;">STT</th>
                    <th>Images</th>
                    <th>Category name</th>
                    <th style="width: 100px; text-align: center;">Status</th>
                    <th style="width: 150px; text-align: center;">Action</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${categoryPage.content}" var="cate" varStatus="STT">
                    <tr style="border-bottom: 1px solid #eee;">
                        <td style="text-align: center;">${STT.index + 1}</td>
                        <td>${cate.images}</td>
                        <td><strong>${cate.name}</strong></td>
                        <td style="text-align: center;">
                            <span style="color: ${cate.status == 1 ? 'green' : 'red'};">${cate.status == 1 ? 'Hoạt động' : 'Khóa'}</span>
                        </td>
                        <td style="text-align: center;">
                            <a href="/admin/categories/edit/${cate.id}" style="color: #007bff; margin-right: 8px;">Sửa</a>
                            <a href="/admin/categories/delete/${cate.id}" style="color: #dc3545;" onclick="return confirm('Bạn có chắc chắn muốn xóa không?');">Xóa</a>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </c:if>

    <div style="display: flex; justify-content: space-between; align-items: center; margin-top: 15px;">
        <form action="/admin/categories/searchpaginated" method="get">
            <input type="hidden" name="name" value="${name}" />
            <label for="size">Page size: </label>
            <select name="size" id="size" onchange="this.form.submit()" style="padding: 4px 8px; border-radius: 4px;">
                <option ${categoryPage.size == 3 ? 'selected':''} value="3">3</option>
                <option ${categoryPage.size == 5 ? 'selected':''} value="5">5</option>
                <option ${categoryPage.size == 10 ? 'selected':''} value="10">10</option>
                <option ${categoryPage.size == 15 ? 'selected':''} value="15">15</option>
                <option ${categoryPage.size == 20 ? 'selected':''} value="20">20</option>
            </select>
        </form>

        <c:if test="${categoryPage.totalPages > 0}">
            <ul style="display: flex; list-style: none; padding: 0; margin: 0; gap: 5px;">
                <c:forEach items="${pageNumbers}" var="pageNumber">
                    <c:if test="${categoryPage.totalPages > 1}">
                        <li class="${pageNumber == categoryPage.number + 1 ? 'page-item active' : 'page-item'}" style="margin: 0;">
                            <a href="<c:url value='/admin/categories/searchpaginated?name=${name}&size=${categoryPage.size}&page=${pageNumber}'/>"
                               style="display: inline-block; padding: 5px 12px; border: 1px solid #dee2e6; text-decoration: none; border-radius: 4px; ${pageNumber == categoryPage.number + 1 ? 'background-color: #007bff; color: white; font-weight: bold;' : 'color: #007bff;'}">
                                ${pageNumber}
                            </a>
                        </li>
                    </c:if>
                </c:forEach>
            </ul>
        </c:if>
    </div>
</div>
