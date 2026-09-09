package vn.utepro.controller;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import vn.utepro.entity.User;
import vn.utepro.service.UserService;
import vn.utepro.util.Constant;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class LoginController {

    @Autowired
    private UserService userService;

    @GetMapping("/login")
    public String loginGet(HttpServletRequest req, Model model) {
        HttpSession session = req.getSession(false);
        if (session != null && session.getAttribute(Constant.SESSION_ACCOUNT) != null) {
            return "redirect:/waiting";
        }

        Cookie[] cookies = req.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if (cookie.getName().equals(Constant.COOKIE_REMEMBER)) {
                    String username = cookie.getValue();
                    User user = userService.get(username);
                    if (user != null && user.isVerified()) {
                        session = req.getSession(true);
                        session.setAttribute(Constant.SESSION_ACCOUNT, user);
                        return "redirect:/waiting";
                    }
                }
            }
        }
        return "login";
    }

    @PostMapping("/login")
    public String loginPost(@RequestParam("username") String username,
                            @RequestParam("password") String password,
                            @RequestParam(value = "remember", required = false) String remember,
                            HttpServletRequest req,
                            HttpServletResponse resp,
                            Model model) {

        boolean isRememberMe = "on".equals(remember);
        String alertMsg = "";

        if (username == null || username.trim().isEmpty()) {
            alertMsg = "Tên đăng nhập không được để trống";
            model.addAttribute("alert", alertMsg);
            return "login";
        }
        if (password == null || password.trim().isEmpty()) {
            alertMsg = "Mật khẩu không được để trống";
            model.addAttribute("alert", alertMsg);
            return "login";
        }

        User user = userService.login(username, password);
        if (user != null) {
            HttpSession session = req.getSession(true);
            session.setAttribute(Constant.SESSION_ACCOUNT, user);
            if (isRememberMe) {
                Cookie cookie = new Cookie(Constant.COOKIE_REMEMBER, username);
                cookie.setMaxAge(30 * 60);
                resp.addCookie(cookie);
            }
            return "redirect:/waiting";
        } else {
            User existingUser = userService.get(username);
            if (existingUser != null && !existingUser.isVerified()) {
                alertMsg = "Tài khoản chưa được xác thực. Vui lòng kiểm tra email.";
            } else {
                alertMsg = "Tài khoản hoặc mật khẩu không đúng";
            }
            model.addAttribute("alert", alertMsg);
            return "login";
        }
    }
}