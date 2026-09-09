package vn.utepro.controller;

import jakarta.servlet.http.HttpSession;
import vn.utepro.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.regex.Pattern;

@Controller
public class ResetPasswordController {

    @Autowired
    private UserService userService;

    private static final Pattern PASSWORD_PATTERN = Pattern.compile("^.{6,}$");

    @GetMapping("/reset-password")
    public String resetPasswordGet() {
        return "reset-password";
    }

    @PostMapping("/reset-password")
    public String resetPasswordPost(@RequestParam("password") String password,
                                    @RequestParam("confirm") String confirm,
                                    HttpSession session,
                                    Model model) {

        String email = (String) session.getAttribute("resetEmail");
        if (email == null) {
            return "redirect:/forgot-password";
        }

        if (password == null || password.trim().isEmpty()) {
            model.addAttribute("error", "Mật khẩu không được để trống");
            return "reset-password";
        }
        if (!PASSWORD_PATTERN.matcher(password).matches()) {
            model.addAttribute("error", "Mật khẩu phải có ít nhất 6 ký tự");
            return "reset-password";
        }
        if (confirm == null || confirm.trim().isEmpty()) {
            model.addAttribute("error", "Xác nhận mật khẩu không được để trống");
            return "reset-password";
        }
        if (!password.equals(confirm)) {
            model.addAttribute("error", "Mật khẩu xác nhận không khớp");
            return "reset-password";
        }

        userService.resetPassword(email, password);
        session.removeAttribute("resetEmail");
        return "redirect:/login";
    }
}