package vn.iotstar.services;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import vn.iotstar.entity.User;

import java.util.List;
import java.util.Optional;

public interface UserService {
    User login(String usernameOrEmail, String password);
    User register(User user);
    boolean checkExistUsername(String username);
    boolean checkExistEmail(String email);
    Optional<User> findByUsername(String username);
    Optional<User> findByEmail(String email);
    <S extends User> S save(S entity);
    List<User> findAll();
    Optional<User> findById(Long id);
    long count();
    void deleteById(Long id);

    // Phân trang và tìm kiếm User
    Page<User> findAll(Pageable pageable);
    Page<User> search(String keyword, Pageable pageable);
}
