package vn.utepro.controller.admin;

import jakarta.servlet.http.HttpSession;
import vn.utepro.entity.Category;
import vn.utepro.entity.User;
import vn.utepro.service.CategoryService;
import vn.utepro.util.Constant;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.util.List;

@Controller
@RequestMapping("/admin")
public class CategoryController {

    @Autowired
    private CategoryService categoryService;

    @Value("${upload.dir:D:/upload}")
    private String uploadDir;

    // LIST + SEARCH
    @GetMapping("/categories")
    public String listCategories(
            @RequestParam(value = "keyword", required = false) String keyword,
            Model model, HttpSession session) {
        
        User user = (User) session.getAttribute(Constant.SESSION_ACCOUNT);
        if (user == null || user.getRoleId() != 1) {
            return "redirect:/login";
        }

        List<Category> list;
        if (keyword != null && !keyword.trim().isEmpty()) {
            list = categoryService.searchByName(keyword.trim());
            model.addAttribute("keyword", keyword.trim());
        } else {
            list = categoryService.findAll();
        }
        
        model.addAttribute("listcate", list);
        model.addAttribute("totalCount", list.size());
        return "admin/category-list";
    }

    @GetMapping("/category/add")
    public String addCategoryForm(HttpSession session) {
        User user = (User) session.getAttribute(Constant.SESSION_ACCOUNT);
        if (user == null || user.getRoleId() != 1) {
            return "redirect:/login";
        }
        return "admin/category-add";
    }

    @PostMapping("/category/insert")
    public String insertCategory(@RequestParam("categoryname") String categoryname,
                                 @RequestParam("status") int status,
                                 @RequestParam(value = "images", required = false) String images,
                                 @RequestParam(value = "images1", required = false) MultipartFile file,
                                 HttpSession session) {

        User user = (User) session.getAttribute(Constant.SESSION_ACCOUNT);
        if (user == null || user.getRoleId() != 1) {
            return "redirect:/login";
        }

        Category category = new Category();
        category.setCategoryname(categoryname);
        category.setStatus(status);

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
                category.setImages(fname);
            } else if (images != null && !images.isEmpty()) {
                category.setImages(images);
            } else {
                category.setImages("avatar.png");
            }
        } catch (IOException e) {
            e.printStackTrace();
            category.setImages("avatar.png");
        }

        categoryService.insert(category);
        return "redirect:/admin/categories";
    }

    @GetMapping("/category/edit")
    public String editCategoryForm(@RequestParam("id") int id, Model model, HttpSession session) {
        User user = (User) session.getAttribute(Constant.SESSION_ACCOUNT);
        if (user == null || user.getRoleId() != 1) {
            return "redirect:/login";
        }

        Category category = categoryService.findById(id);
        model.addAttribute("cate", category);
        return "admin/category-edit";
    }

    @PostMapping("/category/update")
    public String updateCategory(@RequestParam("categoryid") int categoryid,
                                 @RequestParam("categoryname") String categoryname,
                                 @RequestParam("status") int status,
                                 @RequestParam(value = "images", required = false) String images,
                                 @RequestParam(value = "images1", required = false) MultipartFile file,
                                 HttpSession session) {

        User user = (User) session.getAttribute(Constant.SESSION_ACCOUNT);
        if (user == null || user.getRoleId() != 1) {
            return "redirect:/login";
        }

        Category category = categoryService.findById(categoryid);
        String fileold = category.getImages();
        category.setCategoryname(categoryname);
        category.setStatus(status);

        String fname = "";
        File uploadDirFile = new File(uploadDir);
        if (!uploadDirFile.exists()) uploadDirFile.mkdirs();

        try {
            if (file != null && !file.isEmpty()) {
                if (fileold != null && !fileold.isEmpty() && !fileold.startsWith("http")) {
                    File oldFile = new File(uploadDir + File.separator + fileold);
                    if (oldFile.exists()) oldFile.delete();
                }
                String filename = Paths.get(file.getOriginalFilename()).getFileName().toString();
                int index = filename.lastIndexOf(".");
                String ext = filename.substring(index + 1);
                fname = System.currentTimeMillis() + "." + ext;
                File dest = new File(uploadDir + File.separator + fname);
                file.transferTo(dest);
                category.setImages(fname);
            } else if (images != null && !images.isEmpty()) {
                category.setImages(images);
            } else {
                category.setImages(fileold);
            }
        } catch (IOException e) {
            e.printStackTrace();
            category.setImages(fileold);
        }

        categoryService.update(category);
        return "redirect:/admin/categories";
    }

    @GetMapping("/category/delete")
    public String deleteCategory(@RequestParam("id") int id, HttpSession session) {
        User user = (User) session.getAttribute(Constant.SESSION_ACCOUNT);
        if (user == null || user.getRoleId() != 1) {
            return "redirect:/login";
        }

        categoryService.delete(id);
        return "redirect:/admin/categories";
    }
}