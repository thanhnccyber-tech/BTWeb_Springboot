package vn.utepro.service;

import vn.utepro.entity.Category;
import vn.utepro.repository.CategoryRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CategoryService {

    @Autowired
    private CategoryRepository categoryRepository;

    public void insert(Category category) {
        categoryRepository.save(category);
    }

    public void update(Category category) {
        categoryRepository.save(category);
    }

    public void delete(int id) {
        categoryRepository.deleteById(id);
    }

    public Category findById(int id) {
        return categoryRepository.findById(id).orElse(null);
    }

    public List<Category> findAll() {
        return categoryRepository.findAll();
    }

    // Tìm kiếm theo keyword
    public List<Category> searchByName(String keyword) {
        if (keyword == null || keyword.trim().isEmpty()) {
            return findAll();
        }
        return categoryRepository.searchByName(keyword.trim());
    }

    public List<Category> findAll(int page, int pagesize) {
        Pageable pageable = PageRequest.of(page, pagesize);
        Page<Category> pageResult = categoryRepository.findAll(pageable);
        return pageResult.getContent();
    }

    public int count() {
        return (int) categoryRepository.count();
    }
    
    // Đếm kết quả tìm kiếm
    public long countSearch(String keyword) {
        if (keyword == null || keyword.trim().isEmpty()) {
            return categoryRepository.count();
        }
        return categoryRepository.countByKeyword(keyword.trim());
    }
}