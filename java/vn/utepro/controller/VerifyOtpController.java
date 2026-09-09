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
public class VerifyOtpController {

    @Autowired
    private UserService userService;

    private static final Pattern OTP_PATTERN = Pattern.compile("^[0-9]{6}$");

    @GetMapping("/verify-otp")
    public String verifyOtpGet() {
        return "verify-otp";
    }

    @PostMapping("/verify-otp")
    public String verifyOtpPost(@RequestParam("email") String email,
                                @RequestParam("otp") String otp,
                                @RequestParam("action") String action,
                                HttpSession session,
                                Model model) {

        if (email == null || email.trim().isEmpty()) {
            model.addAttribute("error", "Email không hợp lệ");
            return "verify-otp";
        }
        if (action == null || action.trim().isEmpty()) {
            model.addAttribute("error", "Thiếu thông tin action");
            return "verify-otp";
        }
        if (otp == null || otp.trim().isEmpty()) {
            model.addAttribute("error", "Mã OTP không được để trống");
            model.addAttribute("email", email);
            model.addAttribute("action", action);
            return "verify-otp";
        }
        if (!OTP_PATTERN.matcher(otp).matches()) {
            model.addAttribute("error", "Mã OTP phải là 6 chữ số");
            model.addAttribute("email", email);
            model.addAttribute("action", action);
            return "verify-otp";
        }

        boolean valid = userService.verifyOTP(email, otp);
        if (valid) {
            if ("register".equals(action)) {
                userService.verifyAccount(email);
                return "redirect:/login";
            } else if ("forgot".equals(action)) {
                session.setAttribute("resetEmail", email);
                return "redirect:/reset-password";
            } else {
                return "redirect:/login";
            }
        } else {
            model.addAttribute("error", "Mã OTP không hợp lệ hoặc đã hết hạn");
            model.addAttribute("email", email);
            model.addAttribute("action", action);
            return "verify-otp";
        }
    }
}