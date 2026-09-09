package vn.utepro.controller.admin;

import jakarta.servlet.http.HttpSession;
import vn.utepro.entity.User;
import vn.utepro.service.UserService;
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
import java.sql.Date;
import java.util.List;
import java.util.regex.Pattern;

@Controller
@RequestMapping("/admin")
public class UserController {

    @Autowired
    private UserService userService;

    @Value("${upload.dir:D:/upload}")
    private String uploadDir;

    private static final Pattern USERNAME_PATTERN = Pattern.compile("^[a-zA-Z0-9_]{3,20}$");
    private static final Pattern PASSWORD_PATTERN = Pattern.compile("^.{6,}$");
    private static final Pattern EMAIL_PATTERN = Pattern.compile("^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+$");
    private static final Pattern PHONE_PATTERN = Pattern.compile("^[0-9]{10,11}$");
    private static final Pattern FULLNAME_PATTERN = Pattern.compile("^[\\p{L}\\s]{2,50}$");

    // ===== LIST + SEARCH =====
    @GetMapping("/users")
    public String listUsers(
            @RequestParam(value = "keyword", required = false) String keyword,
            Model model, HttpSession session) {
        
        User admin = (User) session.getAttribute(Constant.SESSION_ACCOUNT);
        if (admin == null || admin.getRoleId() != 1) {
            return "redirect:/login";
        }

        List<User> list;
        if (keyword != null && !keyword.trim().isEmpty()) {
            list = userService.search(keyword.trim());
            model.addAttribute("keyword", keyword.trim());
        } else {
            list = userService.findAll();
        }
        
        model.addAttribute("listuser", list);
        model.addAttribute("totalCount", list.size());
        return "admin/user-list";
    }

    // ===== ADD =====
    @GetMapping("/user/add")
    public String addUserForm(HttpSession session) {
        User admin = (User) session.getAttribute(Constant.SESSION_ACCOUNT);
        if (admin == null || admin.getRoleId() != 1) {
            return "redirect:/login";
        }
        return "admin/user-add";
    }

    @PostMapping("/user/insert")
    public String insertUser(
            @RequestParam("username") String username,
            @RequestParam("password") String password,
            @RequestParam("email") String email,
            @RequestParam("fullname") String fullname,
            @RequestParam("phone") String phone,
            @RequestParam("roleId") int roleId,
            @RequestParam(value = "verified", defaultValue = "true") boolean verified,
            @RequestParam(value = "avatar", required = false) MultipartFile file,
            HttpSession session,
            Model model) {

        User admin = (User) session.getAttribute(Constant.SESSION_ACCOUNT);
        if (admin == null || admin.getRoleId() != 1) {
            return "redirect:/login";
        }

        // Validation
        String error = validateUser(username, password, email, fullname, phone, true);
        if (error != null) {
            model.addAttribute("error", error);
            return "admin/user-add";
        }

        // Xử lý avatar
        String avatar = processAvatar(file, null);

        User user = new User();
        user.setUserName(username);
        user.setPassword(password);
        user.setEmail(email);
        user.setFullName(fullname);
        user.setPhone(phone);
        user.setRoleId(roleId);
        user.setVerified(verified);
        user.setAvatar(avatar);
        user.setCreatedDate(new Date(System.currentTimeMillis()));

        userService.insert(user);
        return "redirect:/admin/users";
    }

    // ===== EDIT =====
    @GetMapping("/user/edit")
    public String editUserForm(@RequestParam("id") int id, Model model, HttpSession session) {
        User admin = (User) session.getAttribute(Constant.SESSION_ACCOUNT);
        if (admin == null || admin.getRoleId() != 1) {
            return "redirect:/login";
        }

        User user = userService.getById(id);
        if (user == null) {
            return "redirect:/admin/users";
        }
        model.addAttribute("user", user);
        return "admin/user-edit";
    }

    @PostMapping("/user/update")
    public String updateUser(
            @RequestParam("id") int id,
            @RequestParam("fullname") String fullname,
            @RequestParam("phone") String phone,
            @RequestParam("roleId") int roleId,
            @RequestParam(value = "verified", defaultValue = "true") boolean verified,
            @RequestParam(value = "avatar", required = false) MultipartFile file,
            HttpSession session,
            Model model) {

        User admin = (User) session.getAttribute(Constant.SESSION_ACCOUNT);
        if (admin == null || admin.getRoleId() != 1) {
            return "redirect:/login";
        }

        User user = userService.getById(id);
        if (user == null) {
            return "redirect:/admin/users";
        }

        // Validation
        if (fullname == null || fullname.trim().isEmpty() || !FULLNAME_PATTERN.matcher(fullname).matches()) {
            model.addAttribute("error", "Họ và tên phải có 2-50 ký tự");
            model.addAttribute("user", user);
            return "admin/user-edit";
        }
        if (phone == null || phone.trim().isEmpty() || !PHONE_PATTERN.matcher(phone).matches()) {
            model.addAttribute("error", "Số điện thoại phải có 10-11 chữ số");
            model.addAttribute("user", user);
            return "admin/user-edit";
        }

        // Xử lý avatar
        String avatar = processAvatar(file, user.getAvatar());

        user.setFullName(fullname);
        user.setPhone(phone);
        user.setRoleId(roleId);
        user.setVerified(verified);
        user.setAvatar(avatar);

        userService.update(user);
        return "redirect:/admin/users";
    }

    // ===== DELETE =====
    @GetMapping("/user/delete")
    public String deleteUser(@RequestParam("id") int id, HttpSession session) {
        User admin = (User) session.getAttribute(Constant.SESSION_ACCOUNT);
        if (admin == null || admin.getRoleId() != 1) {
            return "redirect:/login";
        }

        // Không cho xóa chính mình
        if (admin.getId() == id) {
            return "redirect:/admin/users?error=Không thể xóa tài khoản đang đăng nhập";
        }

        userService.delete(id);
        return "redirect:/admin/users";
    }

    // ===== HELPER METHODS =====
    private String validateUser(String username, String password, String email, 
                                String fullname, String phone, boolean checkPassword) {
        if (!USERNAME_PATTERN.matcher(username).matches()) {
            return "Tên đăng nhập phải có 3-20 ký tự (chữ, số, gạch dưới)";
        }
        if (checkPassword && !PASSWORD_PATTERN.matcher(password).matches()) {
            return "Mật khẩu phải có ít nhất 6 ký tự";
        }
        if (!EMAIL_PATTERN.matcher(email).matches()) {
            return "Email không hợp lệ";
        }
        if (!FULLNAME_PATTERN.matcher(fullname).matches()) {
            return "Họ và tên phải có 2-50 ký tự";
        }
        if (!PHONE_PATTERN.matcher(phone).matches()) {
            return "Số điện thoại phải có 10-11 chữ số";
        }
        if (userService.checkExistUsername(username)) {
            return "Tên đăng nhập đã tồn tại";
        }
        if (userService.checkExistEmail(email)) {
            return "Email đã tồn tại";
        }
        if (userService.checkExistPhone(phone)) {
            return "Số điện thoại đã tồn tại";
        }
        return null;
    }

    private String processAvatar(MultipartFile file, String oldAvatar) {
        if (file == null || file.isEmpty()) {
            return oldAvatar != null ? oldAvatar : "avatar.png";
        }

        File uploadDirFile = new File(uploadDir);
        if (!uploadDirFile.exists()) uploadDirFile.mkdirs();

        try {
            String filename = Paths.get(file.getOriginalFilename()).getFileName().toString();
            int index = filename.lastIndexOf(".");
            String ext = filename.substring(index + 1);
            String newFileName = System.currentTimeMillis() + "." + ext;
            File dest = new File(uploadDir + File.separator + newFileName);
            file.transferTo(dest);

            // Xóa ảnh cũ
            if (oldAvatar != null && !oldAvatar.isEmpty() && !oldAvatar.startsWith("http")) {
                File oldFile = new File(uploadDir + File.separator + oldAvatar);
                if (oldFile.exists()) oldFile.delete();
            }
            return newFileName;
        } catch (IOException e) {
            e.printStackTrace();
            return oldAvatar != null ? oldAvatar : "avatar.png";
        }
    }
}