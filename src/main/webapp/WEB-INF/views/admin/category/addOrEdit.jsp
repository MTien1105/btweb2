<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<div style="padding: 15px; max-width: 600px; margin: 0 auto;">
    <h2>${category.id != null ? 'CHỈNH SỬA DANH MỤC' : 'THÊM MỚI DANH MỤC'}</h2>

    <c:if test="${not empty error}">
        <div style="padding: 10px; background-color: #f8d7da; color: #842029; border-radius: 4px; margin-bottom: 15px;">
            ${error}
        </div>
    </c:if>

    <form action="/admin/categories/saveOrUpdate" method="post" style="background: #fdfdfd; padding: 25px; border: 1px solid #dee2e6; border-radius: 6px;">
        <c:if test="${category.id != null}">
            <div style="margin-bottom: 15px;">
                <label style="display: block; font-weight: bold; margin-bottom: 5px;">Mã danh mục (ID):</label>
                <input type="text" name="id" value="${category.id}" readonly style="width: 100%; padding: 8px; background-color: #e9ecef; border: 1px solid #ced4da; border-radius: 4px;" />
            </div>
        </c:if>

        <div style="margin-bottom: 15px;">
            <label style="display: block; font-weight: bold; margin-bottom: 5px;">Tên danh mục <span style="color: red;">*</span>:</label>
            <input type="text" name="name" value="${category.name}" placeholder="Nhập tên danh mục" required style="width: 100%; padding: 8px; border: 1px solid #ced4da; border-radius: 4px;" />
        </div>

        <div style="margin-bottom: 15px;">
            <label style="display: block; font-weight: bold; margin-bottom: 5px;">Hình ảnh (Images):</label>
            <input type="text" name="images" value="${category.images}" placeholder="VD: laptop.png" style="width: 100%; padding: 8px; border: 1px solid #ced4da; border-radius: 4px;" />
        </div>

        <div style="margin-bottom: 20px;">
            <label style="display: block; font-weight: bold; margin-bottom: 5px;">Trạng thái:</label>
            <select name="status" style="width: 100%; padding: 8px; border: 1px solid #ced4da; border-radius: 4px;">
                <option value="1" ${category.status == 1 ? 'selected' : ''}>Hoạt động</option>
                <option value="0" ${category.status == 0 ? 'selected' : ''}>Khóa</option>
            </select>
        </div>

        <div style="display: flex; gap: 10px;">
            <button type="submit" style="padding: 10px 20px; background-color: #28a745; color: white; border: none; border-radius: 4px; font-weight: bold; cursor: pointer;">
                ${category.id != null ? 'Cập nhật' : 'Thêm mới'}
            </button>
            <a href="/admin/categories/searchpaginated" style="padding: 10px 20px; background-color: #6c757d; color: white; text-decoration: none; border-radius: 4px; display: inline-block;">Hủy bỏ</a>
        </div>
    </form>
</div>
