<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<div style="padding: 15px; max-width: 600px; margin: 0 auto;">
    <h2>${user.id != null ? 'CHỈNH SỬA NGƯỜI DÙNG' : 'THÊM MỚI NGƯỜI DÙNG'}</h2>

    <c:if test="${not empty error}">
        <div style="padding: 10px; background-color: #f8d7da; color: #842029; border-radius: 4px; margin-bottom: 15px;">
            ${error}
        </div>
    </c:if>

    <form action="/admin/users/saveOrUpdate" method="post" style="background: #fdfdfd; padding: 25px; border: 1px solid #dee2e6; border-radius: 6px;">
        <c:if test="${user.id != null}">
            <div style="margin-bottom: 15px;">
                <label style="display: block; font-weight: bold; margin-bottom: 5px;">Mã người dùng (ID):</label>
                <input type="text" name="id" value="${user.id}" readonly style="width: 100%; padding: 8px; background-color: #e9ecef; border: 1px solid #ced4da; border-radius: 4px;" />
            </div>
        </c:if>

        <div style="margin-bottom: 15px;">
            <label style="display: block; font-weight: bold; margin-bottom: 5px;">Tên đăng nhập (Username) <span style="color: red;">*</span>:</label>
            <input type="text" name="username" value="${user.username}" placeholder="Nhập username" ${user.id != null ? 'readonly style="background-color: #e9ecef;"' : 'required'} style="width: 100%; padding: 8px; border: 1px solid #ced4da; border-radius: 4px;" />
        </div>

        <div style="margin-bottom: 15px;">
            <label style="display: block; font-weight: bold; margin-bottom: 5px;">Mật khẩu ${user.id == null ? '<span style="color: red;">*</span>' : '(để trống nếu không đổi)'}:</label>
            <input type="password" name="password" placeholder="${user.id != null ? 'Nhập mật khẩu mới (hoặc để trống)' : 'Nhập mật khẩu'}" ${user.id == null ? 'required' : ''} style="width: 100%; padding: 8px; border: 1px solid #ced4da; border-radius: 4px;" />
        </div>

        <div style="margin-bottom: 15px;">
            <label style="display: block; font-weight: bold; margin-bottom: 5px;">Email <span style="color: red;">*</span>:</label>
            <input type="email" name="email" value="${user.email}" placeholder="example@domain.com" required style="width: 100%; padding: 8px; border: 1px solid #ced4da; border-radius: 4px;" />
        </div>

        <div style="margin-bottom: 15px;">
            <label style="display: block; font-weight: bold; margin-bottom: 5px;">Họ và tên:</label>
            <input type="text" name="fullname" value="${user.fullname}" placeholder="Nguyễn Văn A" style="width: 100%; padding: 8px; border: 1px solid #ced4da; border-radius: 4px;" />
        </div>

        <div style="margin-bottom: 15px;">
            <label style="display: block; font-weight: bold; margin-bottom: 5px;">Số điện thoại:</label>
            <input type="text" name="phone" value="${user.phone}" placeholder="0901234567" style="width: 100%; padding: 8px; border: 1px solid #ced4da; border-radius: 4px;" />
        </div>

        <div style="margin-bottom: 15px;">
            <label style="display: block; font-weight: bold; margin-bottom: 5px;">Vai trò (Role):</label>
            <select name="role" style="width: 100%; padding: 8px; border: 1px solid #ced4da; border-radius: 4px;">
                <option value="USER" ${user.role eq 'USER' ? 'selected' : ''}>USER (Người dùng thông thường)</option>
                <option value="ADMIN" ${user.role eq 'ADMIN' ? 'selected' : ''}>ADMIN (Quản trị viên)</option>
            </select>
        </div>

        <div style="margin-bottom: 20px;">
            <label style="display: block; font-weight: bold; margin-bottom: 5px;">Trạng thái:</label>
            <select name="status" style="width: 100%; padding: 8px; border: 1px solid #ced4da; border-radius: 4px;">
                <option value="1" ${user.status == 1 ? 'selected' : ''}>Hoạt động</option>
                <option value="0" ${user.status == 0 ? 'selected' : ''}>Khóa</option>
            </select>
        </div>

        <div style="display: flex; gap: 10px;">
            <button type="submit" style="padding: 10px 20px; background-color: #28a745; color: white; border: none; border-radius: 4px; font-weight: bold; cursor: pointer;">
                ${user.id != null ? 'Cập nhật' : 'Thêm mới'}
            </button>
            <a href="/admin/users/searchpaginated" style="padding: 10px 20px; background-color: #6c757d; color: white; text-decoration: none; border-radius: 4px; display: inline-block;">Hủy bỏ</a>
        </div>
    </form>
</div>
