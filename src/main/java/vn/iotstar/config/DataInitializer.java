package vn.iotstar.config;

import org.springframework.boot.CommandLineRunner;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import vn.iotstar.entity.Category;
import vn.iotstar.entity.User;
import vn.iotstar.repository.CategoryRepository;
import vn.iotstar.repository.UserRepository;

@Configuration
public class DataInitializer {

    @Bean
    public CommandLineRunner initData(CategoryRepository categoryRepository, UserRepository userRepository) {
        return args -> {
            // Nạp dữ liệu tài khoản mẫu
            if (userRepository.count() == 0) {
                userRepository.save(new User(null, "admin", "123456", "admin@hcmute.edu.vn", "Nguyễn Văn Admin", "0901234567", "admin.png", "ADMIN", 1));
                userRepository.save(new User(null, "user", "123456", "user@hcmute.edu.vn", "Trần Thị User", "0907654321", "user.png", "USER", 1));
                System.out.println(">>> Đã khởi tạo 2 tài khoản mẫu (admin/123456 và user/123456) thành công!");
            }

            // Nạp dữ liệu danh mục mẫu
            if (categoryRepository.count() == 0) {
                categoryRepository.save(new Category(null, "Laptop Dell XPS", "laptop.png", 1));
                categoryRepository.save(new Category(null, "Điện thoại iPhone 16", "iphone.png", 1));
                categoryRepository.save(new Category(null, "Máy tính bảng iPad Pro", "ipad.png", 1));
                categoryRepository.save(new Category(null, "Đồng hồ thông minh Apple Watch", "watch.png", 1));
                categoryRepository.save(new Category(null, "Bàn phím cơ không dây", "keyboard.png", 1));
                categoryRepository.save(new Category(null, "Tai nghe chống ồn Sony", "headphone.png", 1));
                categoryRepository.save(new Category(null, "Màn hình 4K LG", "monitor.png", 1));
                categoryRepository.save(new Category(null, "Chuột gaming Logitech", "mouse.png", 1));
                categoryRepository.save(new Category(null, "Loa Bluetooth Marshall", "speaker.png", 1));
                categoryRepository.save(new Category(null, "Máy ảnh Canon EOS", "camera.png", 1));
                System.out.println(">>> Đã khởi tạo 10 danh mục mẫu thành công!");
            }
        };
    }
}
