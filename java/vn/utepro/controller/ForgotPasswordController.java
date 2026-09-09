package vn.utepro.controller;

import vn.utepro.entity.User;
import vn.utepro.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.regex.Pattern;

@Controller
public class ForgotPasswordController {

    @Autowired
    private UserService userService;

    private static final Pattern EMAIL_PATTERN = Pattern.compile("^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+$");

    @GetMapping("/forgot-password")
    public String forgotPasswordGet() {
        return "forgot-password";
    }

    @PostMapping("/forgot-password")
    public String forgotPasswordPost(@RequestParam("email") String email, Model model) {
        if (email == null || email.trim().isEmpty()) {
            model.addAttribute("error", "Email không được để trống");
            return "forgot-password";
        }
        if (!EMAIL_PATTERN.matcher(email).matches()) {
            model.addAttribute("error", "Email không hợp lệ (ví dụ: user@domain.com)");
            return "forgot-password";
        }

        User user = userService.getByEmail(email);
        if (user == null) {
            model.addAttribute("error", "Email không tồn tại trong hệ thống");
            return "forgot-password";
        }

        userService.sendOTP(email, "Mã OTP đặt lại mật khẩu", "Mã OTP của bạn là: {otp}. Có hiệu lực trong 5 phút.");
        model.addAttribute("email", email);
        model.addAttribute("action", "forgot");
        return "verify-otp";
    }
}