package vn.iotstar.repository;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import vn.iotstar.entity.Category;

import java.util.List;

@Repository
public interface CategoryRepository extends JpaRepository<Category, Long> {

    // 1. Phương thức tìm kiếm theo tên và phân trang trong repository
    Page<Category> findByNameContaining(String keyword, Pageable page);

    List<Category> findByNameContaining(String keyword);
}
