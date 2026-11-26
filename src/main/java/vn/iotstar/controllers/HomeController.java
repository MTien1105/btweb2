package vn.iotstar.controllers;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class HomeController {

    @GetMapping("/")
    public String home(Model model) {
        model.addAttribute("message", "Xin chào từ Spring Boot JSP + SiteMesh 3!");
        return "web/home";
    }

    @GetMapping("/admin/dashboard")
    public String admin(Model model) {
        model.addAttribute("message", "Xin chào Admin! Đây là trang quản trị.");
        return "admin/dashboard";
    }
}
