package vn.utepro.repository;

import vn.utepro.entity.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.sql.Timestamp;
import java.util.List;
import java.util.Optional;

@Repository
public interface UserRepository extends JpaRepository<User, Integer> {

    Optional<User> findByUserName(String username);
    Optional<User> findByEmail(String email);
    boolean existsByEmail(String email);
    boolean existsByUserName(String username);
    boolean existsByPhone(String phone);

    // ===== SEARCH =====
    @Query("SELECT u FROM User u WHERE LOWER(u.userName) LIKE LOWER(CONCAT('%', :keyword, '%')) " +
           "OR LOWER(u.fullName) LIKE LOWER(CONCAT('%', :keyword, '%')) " +
           "OR LOWER(u.email) LIKE LOWER(CONCAT('%', :keyword, '%')) " +
           "OR u.phone LIKE CONCAT('%', :keyword, '%')")
    List<User> search(@Param("keyword") String keyword);

    @Query("SELECT COUNT(u) FROM User u WHERE LOWER(u.userName) LIKE LOWER(CONCAT('%', :keyword, '%')) " +
           "OR LOWER(u.fullName) LIKE LOWER(CONCAT('%', :keyword, '%')) " +
           "OR LOWER(u.email) LIKE LOWER(CONCAT('%', :keyword, '%')) " +
           "OR u.phone LIKE CONCAT('%', :keyword, '%')")
    long countByKeyword(@Param("keyword") String keyword);

    // ===== OTP =====
    @Modifying
    @Transactional
    @Query("UPDATE User u SET u.otp = :otp, u.otpExpiry = :expiry WHERE u.email = :email")
    void saveOTP(@Param("email") String email, @Param("otp") String otp, @Param("expiry") Timestamp expiry);

    @Modifying
    @Transactional
    @Query("UPDATE User u SET u.verified = :verified WHERE u.email = :email")
    void setVerified(@Param("email") String email, @Param("verified") boolean verified);

    @Modifying
    @Transactional
    @Query("UPDATE User u SET u.password = :password WHERE u.email = :email")
    void updatePassword(@Param("email") String email, @Param("password") String password);

    @Modifying
    @Transactional
    @Query("UPDATE User u SET u.fullName = :fullname, u.phone = :phone, u.avatar = :avatar WHERE u.id = :userId")
    void updateProfile(@Param("userId") int userId, 
                       @Param("fullname") String fullname, 
                       @Param("phone") String phone, 
                       @Param("avatar") String avatar);
}