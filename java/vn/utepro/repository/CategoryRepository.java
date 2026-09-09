package vn.utepro.repository;

import vn.utepro.entity.Category;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import org.springframework.data.domain.Pageable;  // ← THÊM DÒNG NÀY
import java.util.List;

@Repository
public interface CategoryRepository extends JpaRepository<Category, Integer> {

    // Tìm kiếm theo tên (không phân biệt hoa thường)
    @Query("SELECT c FROM Category c WHERE LOWER(c.categoryname) LIKE LOWER(CONCAT('%', :keyword, '%'))")
    List<Category> searchByName(@Param("keyword") String keyword);
    
    // Đếm số lượng category theo keyword
    @Query("SELECT COUNT(c) FROM Category c WHERE LOWER(c.categoryname) LIKE LOWER(CONCAT('%', :keyword, '%'))")
    long countByKeyword(@Param("keyword") String keyword);
    
    // Tìm kiếm có phân trang
    @Query("SELECT c FROM Category c WHERE LOWER(c.categoryname) LIKE LOWER(CONCAT('%', :keyword, '%'))")
    List<Category> searchByName(@Param("keyword") String keyword, Pageable pageable);
}