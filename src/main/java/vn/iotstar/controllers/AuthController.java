package vn.iotstar.controllers;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import vn.iotstar.entity.User;
import vn.iotstar.models.LoginModel;
import vn.iotstar.models.RegisterModel;
import vn.iotstar.services.UserService;

@Controller
public class AuthController {

    @Autowired
    private UserService userService;

    // --- ĐĂNG NHẬP (LOGIN) ---
    @GetMapping("/login")
    public String showLoginForm(Model model, HttpSession session, HttpServletRequest request) {
        // Nếu đã đăng nhập thì điều hướng đến trang tương ứng
        User account = (User) session.getAttribute("account");
        if (account != null) {
            if ("ADMIN".equalsIgnoreCase(account.getRole())) {
                return "redirect:/admin/categories/searchpaginated";
            }
            return "redirect:/";
        }

        // Đọc Cookie "username" nếu có ghi nhớ đăng nhập
        LoginModel loginModel = new LoginModel();
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if ("rememberUsername".equals(cookie.getName())) {
                    loginModel.setUsername(cookie.getValue());
                    loginModel.setRememberMe(true);
                    break;
                }
            }
        }
        model.addAttribute("loginModel", loginModel);
        return "web/login";
    }

    @PostMapping("/login")
    public String processLogin(@ModelAttribute("loginModel") LoginModel loginModel,
                               Model model,
                               HttpSession session,
                               HttpServletResponse response) {
        if (!StringUtils.hasText(loginModel.getUsername()) || !StringUtils.hasText(loginModel.getPassword())) {
            model.addAttribute("error", "Vui lòng nhập đầy đủ tên đăng nhập và mật khẩu!");
            return "web/login";
        }

        User user = userService.login(loginModel.getUsername().trim(), loginModel.getPassword());
        if (user == null) {
            model.addAttribute("error", "Tên đăng nhập hoặc mật khẩu không chính xác!");
            return "web/login";
        }

        if (user.getStatus() == 0) {
            model.addAttribute("error", "Tài khoản của bạn đã bị khóa! Vui lòng liên hệ quản trị viên.");
            return "web/login";
        }

        // Lưu thông tin đăng nhập vào Session
        session.setAttribute("account", user);

        // Xử lý Cookie Remember Me
        Cookie cookie = new Cookie("rememberUsername", user.getUsername());
        if (loginModel.isRememberMe()) {
            cookie.setMaxAge(7 * 24 * 60 * 60); // 7 ngày
        } else {
            cookie.setMaxAge(0); // xóa cookie
        }
        cookie.setPath("/");
        response.addCookie(cookie);

        // Chuyển hướng theo quyền
        if ("ADMIN".equalsIgnoreCase(user.getRole())) {
            return "redirect:/admin/categories/searchpaginated";
        }
        return "redirect:/";
    }

    // --- ĐĂNG KÝ (REGISTER) ---
    @GetMapping("/register")
    public String showRegisterForm(Model model, HttpSession session) {
        User account = (User) session.getAttribute("account");
        if (account != null) {
            return "redirect:/";
        }
        model.addAttribute("registerModel", new RegisterModel());
        return "web/register";
    }

    @PostMapping("/register")
    public String processRegister(@ModelAttribute("registerModel") RegisterModel registerModel,
                                  Model model,
                                  RedirectAttributes redirectAttributes) {
        // Kiểm tra dữ liệu đầu vào
        if (!StringUtils.hasText(registerModel.getUsername()) ||
            !StringUtils.hasText(registerModel.getEmail()) ||
            !StringUtils.hasText(registerModel.getPassword())) {
            model.addAttribute("error", "Vui lòng điền đầy đủ các thông tin bắt buộc (*)");
            return "web/register";
        }

        if (!registerModel.getPassword().equals(registerModel.getConfirmPassword())) {
            model.addAttribute("error", "Mật khẩu xác nhận không khớp!");
            return "web/register";
        }

        if (userService.checkExistUsername(registerModel.getUsername().trim())) {
            model.addAttribute("error", "Tên đăng nhập '" + registerModel.getUsername() + "' đã tồn tại!");
            return "web/register";
        }

        if (userService.checkExistEmail(registerModel.getEmail().trim())) {
            model.addAttribute("error", "Email '" + registerModel.getEmail() + "' đã được đăng ký!");
            return "web/register";
        }

        // Tạo tài khoản mới
        User newUser = new User();
        newUser.setUsername(registerModel.getUsername().trim());
        newUser.setPassword(registerModel.getPassword());
        newUser.setEmail(registerModel.getEmail().trim());
        newUser.setFullname(registerModel.getFullname());
        newUser.setPhone(registerModel.getPhone());
        newUser.setRole("USER");
        newUser.setStatus(1);

        userService.register(newUser);

        redirectAttributes.addFlashAttribute("message", "Đăng ký tài khoản thành công! Bạn có thể đăng nhập ngay.");
        return "redirect:/login";
    }

    // --- ĐĂNG XUẤT (LOGOUT) ---
    @GetMapping("/logout")
    public String logout(HttpSession session, HttpServletRequest request, HttpServletResponse response) {
        session.removeAttribute("account");
        session.invalidate();

        return "redirect:/login?logout=true";
    }
}
