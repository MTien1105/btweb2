package vn.iotstar.services;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import vn.iotstar.entity.Category;

import java.util.List;
import java.util.Optional;

public interface CategoryService {

    // 3. Pull up lên interface service
    Page<Category> findByNameContaining(String keyword, Pageable page);

    List<Category> findByNameContaining(String keyword);

    Page<Category> findAll(Pageable pageable);

    List<Category> findAll();

    <S extends Category> S save(S entity);

    Optional<Category> findById(Long id);

    long count();

    void deleteById(Long id);
}
