package vn.utepro.controller;

import jakarta.servlet.http.HttpSession;
import vn.utepro.entity.User;
import vn.utepro.util.Constant;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class WaitingController {

    @GetMapping("/waiting")
    public String waiting(HttpSession session) {
        if (session != null && session.getAttribute(Constant.SESSION_ACCOUNT) != null) {
            User user = (User) session.getAttribute(Constant.SESSION_ACCOUNT);
            if (user.getRoleId() == 1) {
                return "redirect:/admin/categories";
            } else {
                return "redirect:/home";
            }
        } else {
            return "redirect:/login";
        }
    }
}