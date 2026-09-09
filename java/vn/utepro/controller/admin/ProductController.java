package vn.utepro.controller.admin;

import jakarta.servlet.http.HttpSession;
import vn.utepro.entity.Category;
import vn.utepro.entity.Product;
import vn.utepro.entity.User;
import vn.utepro.service.CategoryService;
import vn.utepro.service.ProductService;
import vn.utepro.util.Constant;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.util.List;

@Controller
@RequestMapping("/admin")
public class ProductController {

    @Autowired
    private ProductService productService;

    @Autowired
    private CategoryService categoryService;

    @Value("${upload.dir:D:/upload}")
    private String uploadDir;

    @GetMapping("/products")
    public String listProducts(Model model, HttpSession session) {
        User user = (User) session.getAttribute(Constant.SESSION_ACCOUNT);
        if (user == null || user.getRoleId() != 1) {
            return "redirect:/login";
        }

        List<Product> list = productService.findAll();
        model.addAttribute("listproduct", list);
        return "admin/product-list";
    }

    @GetMapping("/product/add")
    public String addProductForm(Model model, HttpSession session) {
        User user = (User) session.getAttribute(Constant.SESSION_ACCOUNT);
        if (user == null || user.getRoleId() != 1) {
            return "redirect:/login";
        }

        List<Category> categories = categoryService.findAll();
        model.addAttribute("categories", categories);
        return "admin/product-add";
    }

    @PostMapping("/product/insert")
    public String insertProduct(@RequestParam("productName") String productName,
                                @RequestParam("price") double price,
                                @RequestParam("description") String description,
                                @RequestParam("categoryId") int categoryId,
                                @RequestParam(value = "images", required = false) MultipartFile file,
                                HttpSession session) {

        User user = (User) session.getAttribute(Constant.SESSION_ACCOUNT);
        if (user == null || user.getRoleId() != 1) {
            return "redirect:/login";
        }

        Category category = categoryService.findById(categoryId);
        Product product = new Product();
        product.setProductName(productName);
        product.setPrice(price);
        product.setDescription(description);
        product.setCategory(category);

        // Xử lý upload ảnh
        String fname = "";
        File uploadDirFile = new File(uploadDir);
        if (!uploadDirFile.exists()) uploadDirFile.mkdirs();

        try {
            if (file != null && !file.isEmpty()) {
                String filename = Paths.get(file.getOriginalFilename()).getFileName().toString();
                int index = filename.lastIndexOf(".");
                String ext = filename.substring(index + 1);
                fname = System.currentTimeMillis() + "." + ext;
                File dest = new File(uploadDir + File.separator + fname);
                file.transferTo(dest);
                product.setImages(fname);
            } else {
                product.setImages("default-product.png");
            }
        } catch (IOException e) {
            e.printStackTrace();
            product.setImages("default-product.png");
        }

        productService.insert(product);
        return "redirect:/admin/products";
    }

    @GetMapping("/product/edit")
    public String editProductForm(@RequestParam("id") int id, Model model, HttpSession session) {
        User user = (User) session.getAttribute(Constant.SESSION_ACCOUNT);
        if (user == null || user.getRoleId() != 1) {
            return "redirect:/login";
        }

        Product product = productService.findById(id);
        List<Category> categories = categoryService.findAll();
        model.addAttribute("product", product);
        model.addAttribute("categories", categories);
        return "admin/product-edit";
    }

    @PostMapping("/product/update")
    public String updateProduct(@RequestParam("productId") int productId,
                                @RequestParam("productName") String productName,
                                @RequestParam("price") double price,
                                @RequestParam("description") String description,
                                @RequestParam("categoryId") int categoryId,
                                @RequestParam(value = "images", required = false) MultipartFile file,
                                HttpSession session) {

        User user = (User) session.getAttribute(Constant.SESSION_ACCOUNT);
        if (user == null || user.getRoleId() != 1) {
            return "redirect:/login";
        }

        Product product = productService.findById(productId);
        String fileold = product.getImages();

        product.setProductName(productName);
        product.setPrice(price);
        product.setDescription(description);
        product.setCategory(categoryService.findById(categoryId));

        File uploadDirFile = new File(uploadDir);
        if (!uploadDirFile.exists()) uploadDirFile.mkdirs();

        try {
            if (file != null && !file.isEmpty()) {
                if (fileold != null && !fileold.isEmpty() && !fileold.equals("default-product.png")) {
                    File oldFile = new File(uploadDir + File.separator + fileold);
                    if (oldFile.exists()) oldFile.delete();
                }
                String filename = Paths.get(file.getOriginalFilename()).getFileName().toString();
                int index = filename.lastIndexOf(".");
                String ext = filename.substring(index + 1);
                String fname = System.currentTimeMillis() + "." + ext;
                File dest = new File(uploadDir + File.separator + fname);
                file.transferTo(dest);
                product.setImages(fname);
            } else {
                product.setImages(fileold);
            }
        } catch (IOException e) {
            e.printStackTrace();
            product.setImages(fileold);
        }

        productService.update(product);
        return "redirect:/admin/products";
    }

    @GetMapping("/product/delete")
    public String deleteProduct(@RequestParam("id") int id, HttpSession session) {
        User user = (User) session.getAttribute(Constant.SESSION_ACCOUNT);
        if (user == null || user.getRoleId() != 1) {
            return "redirect:/login";
        }

        productService.delete(id);
        return "redirect:/admin/products";
    }
}