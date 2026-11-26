package vn.iotstar.controllers.admin;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import vn.iotstar.entity.User;
import vn.iotstar.services.UserService;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;
import java.util.stream.IntStream;

@Controller
@RequestMapping("/admin/users")
public class UserController {

    @Autowired
    private UserService userService;

    @GetMapping("")
    public String index() {
        return "redirect:/admin/users/searchpaginated";
    }

    // 1. Tìm kiếm và Phân trang User
    @RequestMapping("/searchpaginated")
    public String search(ModelMap model,
                         @RequestParam(name = "keyword", required = false) String keyword,
                         @RequestParam("page") Optional<Integer> page,
                         @RequestParam("size") Optional<Integer> size) {

        int count = (int) userService.count();
        int currentPage = page.orElse(1);
        int pageSize = size.orElse(5);

        Pageable pageable = PageRequest.of(currentPage - 1, pageSize, Sort.by("id").descending());
        Page<User> resultPage = null;

        if (StringUtils.hasText(keyword)) {
            resultPage = userService.search(keyword.trim(), pageable);
            model.addAttribute("keyword", keyword.trim());
        } else {
            resultPage = userService.findAll(pageable);
        }

        int totalPages = resultPage.getTotalPages();
        if (totalPages > 0) {
            int start = Math.max(1, currentPage - 2);
            int end = Math.min(currentPage + 2, totalPages);
            if (totalPages > count) {
                if (end == totalPages) start = end - count;
                else if (start == 1) end = start + count;
            }
            List<Integer> pageNumbers = IntStream.rangeClosed(start, end)
                    .boxed()
                    .collect(Collectors.toList());
            model.addAttribute("pageNumbers", pageNumbers);
        }
        model.addAttribute("userPage", resultPage);
        return "admin/user/list";
    }

    // 2. Thêm mới User (Form Add)
    @GetMapping("/add")
    public String add(ModelMap model) {
        User user = new User();
        user.setStatus(1);
        user.setRole("USER");
        model.addAttribute("user", user);
        return "admin/user/addOrEdit";
    }

    // 3. Chỉnh sửa User (Form Edit)
    @GetMapping("/edit/{id}")
    public String edit(ModelMap model, @PathVariable("id") Long id, RedirectAttributes redirectAttributes) {
        Optional<User> opt = userService.findById(id);
        if (opt.isPresent()) {
            model.addAttribute("user", opt.get());
            return "admin/user/addOrEdit";
        }
        redirectAttributes.addFlashAttribute("error", "Người dùng không tồn tại!");
        return "redirect:/admin/users/searchpaginated";
    }

    // 4. Lưu hoặc Cập nhật User (Save / Update)
    @PostMapping("/saveOrUpdate")
    public String saveOrUpdate(ModelMap model,
                               @ModelAttribute("user") User user,
                               RedirectAttributes redirectAttributes) {
        if (!StringUtils.hasText(user.getUsername()) || !StringUtils.hasText(user.getEmail())) {
            model.addAttribute("error", "Tên đăng nhập và Email không được để trống!");
            return "admin/user/addOrEdit";
        }

        // Kiểm tra trùng username nếu là thêm mới (id == null)
        if (user.getId() == null) {
            if (!StringUtils.hasText(user.getPassword())) {
                model.addAttribute("error", "Mật khẩu không được để trống khi tạo mới!");
                return "admin/user/addOrEdit";
            }
            if (userService.checkExistUsername(user.getUsername().trim())) {
                model.addAttribute("error", "Tên đăng nhập '" + user.getUsername() + "' đã tồn tại!");
                return "admin/user/addOrEdit";
            }
            if (userService.checkExistEmail(user.getEmail().trim())) {
                model.addAttribute("error", "Email '" + user.getEmail() + "' đã tồn tại!");
                return "admin/user/addOrEdit";
            }
        } else {
            // Khi cập nhật: nếu không nhập mật khẩu mới, giữ lại mật khẩu cũ
            Optional<User> oldUserOpt = userService.findById(user.getId());
            if (oldUserOpt.isPresent()) {
                if (!StringUtils.hasText(user.getPassword())) {
                    user.setPassword(oldUserOpt.get().getPassword());
                }
            }
        }

        userService.save(user);
        redirectAttributes.addFlashAttribute("message", "Lưu người dùng '" + user.getUsername() + "' thành công!");
        return "redirect:/admin/users/searchpaginated";
    }

    // 5. Xóa User
    @GetMapping("/delete/{id}")
    public String delete(@PathVariable("id") Long id, RedirectAttributes redirectAttributes) {
        Optional<User> opt = userService.findById(id);
        if (opt.isPresent()) {
            userService.deleteById(id);
            redirectAttributes.addFlashAttribute("message", "Đã xóa người dùng thành công!");
        } else {
            redirectAttributes.addFlashAttribute("error", "Không tìm thấy người dùng để xóa!");
        }
        return "redirect:/admin/users/searchpaginated";
    }
}
