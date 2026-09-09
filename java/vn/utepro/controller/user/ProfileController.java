package vn.utepro.controller.user;

import jakarta.servlet.http.HttpSession;
import vn.utepro.entity.User;
import vn.utepro.service.UserService;
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
import java.util.regex.Pattern;

@Controller
@RequestMapping("/user")
public class ProfileController {

    @Autowired
    private UserService userService;

    @Value("${upload.dir:D:/upload}")
    private String uploadDir;

    private static final Pattern PHONE_PATTERN = Pattern.compile("^[0-9]{10,11}$");
    private static final Pattern FULLNAME_PATTERN = Pattern.compile("^[\\p{L}\\s]{2,50}$");
    private static final Pattern IMAGE_EXTENSION_PATTERN = Pattern.compile("(?i)\\.(jpg|jpeg|png|gif)$");

    @GetMapping("/profile")
    public String profile(Model model, HttpSession session) {
        User currentUser = (User) session.getAttribute(Constant.SESSION_ACCOUNT);
        if (currentUser == null) {
            return "redirect:/login";
        }

        User user = userService.getById(currentUser.getId());
        model.addAttribute("user", user);
        return "user/profile";
    }

    @PostMapping("/profile/update")
    public String updateProfile(@RequestParam("fullname") String fullname,
                                @RequestParam("phone") String phone,
                                @RequestParam(value = "avatar", required = false) MultipartFile file,
                                Model model,
                                HttpSession session) {

        User currentUser = (User) session.getAttribute(Constant.SESSION_ACCOUNT);
        if (currentUser == null) {
            return "redirect:/login";
        }

        int userId = currentUser.getId();
        String oldAvatar = currentUser.getAvatar();
        String errorMsg = null;
        boolean hasError = false;

        // Validation
        if (fullname == null || fullname.trim().isEmpty()) {
            errorMsg = "Họ và tên không được để trống";
            hasError = true;
        } else if (!FULLNAME_PATTERN.matcher(fullname).matches()) {
            errorMsg = "Họ và tên phải có 2-50 ký tự";
            hasError = true;
        }

        if (!hasError) {
            if (phone == null || phone.trim().isEmpty()) {
                errorMsg = "Số điện thoại không được để trống";
                hasError = true;
            } else if (!PHONE_PATTERN.matcher(phone).matches()) {
                errorMsg = "Số điện thoại phải có 10-11 chữ số";
                hasError = true;
            } else if (!phone.equals(currentUser.getPhone()) && userService.checkExistPhone(phone)) {
                errorMsg = "Số điện thoại đã được sử dụng!";
                hasError = true;
            }
        }

        if (hasError) {
            model.addAttribute("error", errorMsg);
            User user = userService.getById(userId);
            model.addAttribute("user", user);
            return "user/profile";
        }

        // Xử lý upload avatar
        String avatar = oldAvatar;
        File uploadDirFile = new File(uploadDir);
        if (!uploadDirFile.exists()) uploadDirFile.mkdirs();

        try {
            if (file != null && !file.isEmpty()) {
                if (file.getSize() > 5 * 1024 * 1024) {
                    model.addAttribute("error", "File ảnh không được vượt quá 5MB");
                    User user = userService.getById(userId);
                    model.addAttribute("user", user);
                    return "user/profile";
                }

                String filename = Paths.get(file.getOriginalFilename()).getFileName().toString();
                if (!IMAGE_EXTENSION_PATTERN.matcher(filename).find()) {
                    model.addAttribute("error", "Chỉ hỗ trợ file ảnh (JPG, PNG, GIF)");
                    User user = userService.getById(userId);
                    model.addAttribute("user", user);
                    return "user/profile";
                }

                if (oldAvatar != null && !oldAvatar.isEmpty() && !oldAvatar.startsWith("http")) {
                    File oldFile = new File(uploadDir + File.separator + oldAvatar);
                    if (oldFile.exists()) oldFile.delete();
                }

                int index = filename.lastIndexOf(".");
                String ext = filename.substring(index + 1);
                String newFileName = System.currentTimeMillis() + "." + ext;
                File dest = new File(uploadDir + File.separator + newFileName);
                file.transferTo(dest);
                avatar = newFileName;
            }
        } catch (IOException e) {
            e.printStackTrace();
            model.addAttribute("error", "Lỗi upload ảnh: " + e.getMessage());
            User user = userService.getById(userId);
            model.addAttribute("user", user);
            return "user/profile";
        }

        userService.updateProfile(userId, fullname, phone, avatar);

        User updatedUser = userService.getById(userId);
        session.setAttribute(Constant.SESSION_ACCOUNT, updatedUser);

        model.addAttribute("message", "Cập nhật profile thành công!");
        model.addAttribute("user", updatedUser);
        return "user/profile";
    }
}