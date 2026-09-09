package vn.utepro.service;

import vn.utepro.entity.User;
import vn.utepro.repository.UserRepository;
import vn.utepro.util.EmailUtil;
import vn.utepro.util.OTPGenerator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.sql.Date;
import java.sql.Timestamp;
import java.util.List;

@Service
public class UserService {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private EmailUtil emailUtil;

    // ===== AUTH =====
    public User login(String username, String password) {
        User user = get(username);
        if (user != null && password.equals(user.getPassword()) && user.isVerified()) {
            return user;
        }
        return null;
    }

    public User get(String username) {
        return userRepository.findByUserName(username).orElse(null);
    }

    public User getByEmail(String email) {
        return userRepository.findByEmail(email).orElse(null);
    }

    public User getById(int id) {
        return userRepository.findById(id).orElse(null);
    }

    // ===== CRUD =====
    public void insert(User user) {
        userRepository.save(user);
    }

    public void update(User user) {
        userRepository.save(user);
    }

    public void delete(int id) {
        userRepository.deleteById(id);
    }

    public List<User> findAll() {
        return userRepository.findAll();
    }

    // ===== SEARCH =====
    public List<User> search(String keyword) {
        if (keyword == null || keyword.trim().isEmpty()) {
            return findAll();
        }
        return userRepository.search(keyword.trim());
    }

    public long countSearch(String keyword) {
        if (keyword == null || keyword.trim().isEmpty()) {
            return userRepository.count();
        }
        return userRepository.countByKeyword(keyword.trim());
    }

    // ===== REGISTER =====
    public boolean register(String username, String password, String email, String fullname, String phone) {
        if (userRepository.existsByUserName(username) || 
            userRepository.existsByEmail(email) || 
            userRepository.existsByPhone(phone)) {
            return false;
        }

        long millis = System.currentTimeMillis();
        Date date = new Date(millis);
        User user = new User(email, username, fullname, password, null, 2, phone, date);
        user.setVerified(false);
        userRepository.save(user);
        return true;
    }

    public boolean checkExistEmail(String email) {
        return userRepository.existsByEmail(email);
    }

    public boolean checkExistUsername(String username) {
        return userRepository.existsByUserName(username);
    }

    public boolean checkExistPhone(String phone) {
        return userRepository.existsByPhone(phone);
    }

    // ===== OTP =====
    public void sendOTP(String email, String subject, String body) {
        String otp = OTPGenerator.generateOTP();
        Timestamp expiry = new Timestamp(System.currentTimeMillis() + 5 * 60 * 1000);
        userRepository.saveOTP(email, otp, expiry);
        emailUtil.sendOTP(email, otp, subject, body);
    }

    public boolean verifyOTP(String email, String otp) {
        User user = getByEmail(email);
        if (user != null && user.getOtp() != null && user.getOtp().equals(otp)) {
            Timestamp expiry = user.getOtpExpiry();
            if (expiry != null && expiry.after(new Timestamp(System.currentTimeMillis()))) {
                userRepository.saveOTP(email, null, null);
                return true;
            }
        }
        return false;
    }

    public void resetPassword(String email, String newPassword) {
        userRepository.updatePassword(email, newPassword);
    }

    public void verifyAccount(String email) {
        userRepository.setVerified(email, true);
    }

    public void updateProfile(int userId, String fullname, String phone, String avatar) {
        userRepository.updateProfile(userId, fullname, phone, avatar);
    }
}