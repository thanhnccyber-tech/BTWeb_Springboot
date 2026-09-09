package vn.utepro.controller;

import vn.utepro.entity.Product;
import vn.utepro.service.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Controller
public class ProductListController {

    @Autowired
    private ProductService productService;

    private static final int PAGE_SIZE = 6;

    @GetMapping("/product")
    public String productList(@RequestParam(value = "page", defaultValue = "1") int page, Model model) {
        if (page < 1) page = 1;

        List<Product> products = productService.findAll(page - 1, PAGE_SIZE);
        int total = productService.count();
        int totalPages = (int) Math.ceil((double) total / PAGE_SIZE);

        model.addAttribute("products", products);
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", totalPages);
        return "product-list";
    }
}