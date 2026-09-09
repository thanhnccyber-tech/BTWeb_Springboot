package vn.utepro.service;

import vn.utepro.entity.Product;
import vn.utepro.repository.ProductRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ProductService {

    @Autowired
    private ProductRepository productRepository;

    public void insert(Product product) {
        productRepository.save(product);
    }

    public void update(Product product) {
        productRepository.save(product);
    }

    public void delete(int id) {
        productRepository.deleteById(id);
    }

    public Product findById(int id) {
        return productRepository.findById(id).orElse(null);
    }

    public List<Product> findAll() {
        return productRepository.findAll();
    }

    public List<Product> findLatest(int limit) {
        return productRepository.findLatest().stream().limit(limit).toList();
    }

    public List<Product> findAll(int page, int pagesize) {
        Pageable pageable = PageRequest.of(page, pagesize);
        Page<Product> pageResult = productRepository.findAll(pageable);
        return pageResult.getContent();
    }

    public int count() {
        return (int) productRepository.count();
    }

    public List<Product> searchByName(String keyword) {
        return productRepository.searchByName(keyword);
    }

    public List<Product> findByCategory(int categoryId) {
        return productRepository.findByCategoryId(categoryId);
    }
}