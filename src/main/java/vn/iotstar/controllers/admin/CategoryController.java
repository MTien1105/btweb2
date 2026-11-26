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
import vn.iotstar.entity.Category;
import vn.iotstar.services.CategoryService;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;
import java.util.stream.IntStream;

@Controller
@RequestMapping("/admin/categories")
public class CategoryController {

    @Autowired
    private CategoryService categoryService;

    @GetMapping("")
    public String index() {
        return "redirect:/admin/categories/searchpaginated";
    }

    // 1. Tìm kiếm và Phân trang Category
    @RequestMapping("/searchpaginated")
    public String search(ModelMap model,
                         @RequestParam(name = "name", required = false) String name,
                         @RequestParam("page") Optional<Integer> page,
                         @RequestParam("size") Optional<Integer> size) {

        int count = (int) categoryService.count();
        int currentPage = page.orElse(1);
        int pageSize = size.orElse(3);

        Pageable pageable = PageRequest.of(currentPage - 1, pageSize, Sort.by("name"));
        Page<Category> resultPage = null;

        if (StringUtils.hasText(name)) {
            resultPage = categoryService.findByNameContaining(name, pageable);
            model.addAttribute("name", name);
        } else {
            resultPage = categoryService.findAll(pageable);
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
        model.addAttribute("categoryPage", resultPage);
        return "admin/category/list";
    }

    // 2. Thêm mới Category (Form Add)
    @GetMapping("/add")
    public String add(ModelMap model) {
        Category category = new Category();
        category.setStatus(1);
        model.addAttribute("category", category);
        return "admin/category/addOrEdit";
    }

    // 3. Chỉnh sửa Category (Form Edit)
    @GetMapping("/edit/{id}")
    public String edit(ModelMap model, @PathVariable("id") Long id, RedirectAttributes redirectAttributes) {
        Optional<Category> opt = categoryService.findById(id);
        if (opt.isPresent()) {
            model.addAttribute("category", opt.get());
            return "admin/category/addOrEdit";
        }
        redirectAttributes.addFlashAttribute("error", "Danh mục không tồn tại!");
        return "redirect:/admin/categories/searchpaginated";
    }

    // 4. Lưu hoặc Cập nhật Category (Save / Update)
    @PostMapping("/saveOrUpdate")
    public String saveOrUpdate(ModelMap model,
                               @ModelAttribute("category") Category category,
                               RedirectAttributes redirectAttributes) {
        if (!StringUtils.hasText(category.getName())) {
            model.addAttribute("error", "Tên danh mục không được để trống!");
            return "admin/category/addOrEdit";
        }

        categoryService.save(category);
        redirectAttributes.addFlashAttribute("message", "Lưu danh mục '" + category.getName() + "' thành công!");
        return "redirect:/admin/categories/searchpaginated";
    }

    // 5. Xóa Category
    @GetMapping("/delete/{id}")
    public String delete(@PathVariable("id") Long id, RedirectAttributes redirectAttributes) {
        Optional<Category> opt = categoryService.findById(id);
        if (opt.isPresent()) {
            categoryService.deleteById(id);
            redirectAttributes.addFlashAttribute("message", "Đã xóa danh mục thành công!");
        } else {
            redirectAttributes.addFlashAttribute("error", "Không tìm thấy danh mục để xóa!");
        }
        return "redirect:/admin/categories/searchpaginated";
    }
}
