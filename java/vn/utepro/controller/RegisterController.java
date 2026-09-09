package vn.utepro.controller;

import vn.utepro.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.regex.Pattern;

@Controller
public class RegisterController {

    @Autowired
    private UserService userService;

    private static final Pattern USERNAME_PATTERN = Pattern.compile("^[a-zA-Z0-9_]{3,20}$");
    private static final Pattern PASSWORD_PATTERN = Pattern.compile("^.{6,}$");
    private static final Pattern EMAIL_PATTERN = Pattern.compile("^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+$");
    private static final Pattern PHONE_PATTERN = Pattern.compile("^[0-9]{10,11}$");
    private static final Pattern FULLNAME_PATTERN = Pattern.compile("^[\\p{L}\\s]{2,50}$");

    @GetMapping("/register")
    public String registerGet() {
        return "register";
    }

    @PostMapping("/register")
    public String registerPost(@RequestParam("username") String username,
                               @RequestParam("password") String password,
                               @RequestParam("email") String email,
                               @RequestParam("fullname") String fullname,
                               @RequestParam("phone") String phone,
                               Model model) {

        String alertMsg = "";
        boolean hasError = false;

        // Validation: Fullname
        if (fullname == null || fullname.trim().isEmpty()) {
            alertMsg = "Họ và tên không được để trống";
            hasError = true;
        } else if (!FULLNAME_PATTERN.matcher(fullname).matches()) {
            alertMsg = "Họ và tên phải có 2-50 ký tự";
            hasError = true;
        }

        // Validation: Email
        if (!hasError) {
            if (email == null || email.trim().isEmpty()) {
                alertMsg = "Email không được để trống";
                hasError = true;
            } else if (!EMAIL_PATTERN.matcher(email).matches()) {
                alertMsg = "Email không hợp lệ (ví dụ: user@domain.com)";
                hasError = true;
            } else if (userService.checkExistEmail(email)) {
                alertMsg = "Email đã tồn tại!";
                hasError = true;
            }
        }

        // Validation: Phone
        if (!hasError) {
            if (phone == null || phone.trim().isEmpty()) {
                alertMsg = "Số điện thoại không được để trống";
                hasError = true;
            } else if (!PHONE_PATTERN.matcher(phone).matches()) {
                alertMsg = "Số điện thoại phải có 10-11 chữ số";
                hasError = true;
            } else if (userService.checkExistPhone(phone)) {
                alertMsg = "Số điện thoại đã tồn tại!";
                hasError = true;
            }
        }

        // Validation: Username
        if (!hasError) {
            if (username == null || username.trim().isEmpty()) {
                alertMsg = "Tên đăng nhập không được để trống";
                hasError = true;
            } else if (!USERNAME_PATTERN.matcher(username).matches()) {
                alertMsg = "Tên đăng nhập phải có 3-20 ký tự (chữ, số, gạch dưới)";
                hasError = true;
            } else if (userService.checkExistUsername(username)) {
                alertMsg = "Tài khoản đã tồn tại!";
                hasError = true;
            }
        }

        // Validation: Password
        if (!hasError) {
            if (password == null || password.trim().isEmpty()) {
                alertMsg = "Mật khẩu không được để trống";
                hasError = true;
            } else if (!PASSWORD_PATTERN.matcher(password).matches()) {
                alertMsg = "Mật khẩu phải có ít nhất 6 ký tự";
                hasError = true;
            }
        }

        if (hasError) {
            model.addAttribute("alert", alertMsg);
            return "register";
        }

        boolean isSuccess = userService.register(username, password, email, fullname, phone);
        if (isSuccess) {
            userService.sendOTP(email, "Xác thực tài khoản", "Mã OTP của bạn là: {otp}. Có hiệu lực trong 5 phút.");
            model.addAttribute("email", email);
            model.addAttribute("action", "register");
            return "verify-otp";
        } else {
            model.addAttribute("alert", "Lỗi hệ thống!");
            return "register";
        }
    }
}