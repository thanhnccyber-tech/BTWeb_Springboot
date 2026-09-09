package vn.utepro.util;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Component;

@Component
public class EmailUtil {

    @Autowired
    private JavaMailSender mailSender;

    public void sendOTP(String toEmail, String otp, String subject, String bodyTemplate) {
        SimpleMailMessage message = new SimpleMailMessage();
        message.setTo(toEmail);
        message.setSubject(subject);
        String content = bodyTemplate.replace("{otp}", otp);
        message.setText(content);
        mailSender.send(message);
        System.out.println("📧 OTP sent to: " + toEmail + " | OTP: " + otp);
    }
}