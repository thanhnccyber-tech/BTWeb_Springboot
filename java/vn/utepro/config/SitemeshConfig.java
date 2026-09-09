package vn.utepro.config;


// import org.sitemesh.builder.SiteMeshFilterBuilder;
// import org.sitemesh.config.ConfigurableSiteMeshFilter;
// import org.springframework.boot.web.servlet.FilterRegistrationBean;
// import org.springframework.context.annotation.Bean;
// import org.springframework.context.annotation.Configuration;
// import org.springframework.core.Ordered;

// @Configuration
public class SitemeshConfig {

    // @Bean
    // public FilterRegistrationBean<ConfigurableSiteMeshFilter> siteMeshFilter() {
    //     FilterRegistrationBean<ConfigurableSiteMeshFilter> registration = new FilterRegistrationBean<>();
    //     
    //     ConfigurableSiteMeshFilter filter = new ConfigurableSiteMeshFilter() {
    //         @Override
    //         protected void applyCustomConfiguration(SiteMeshFilterBuilder builder) {
    //             builder
    //                 .addDecoratorPath("/*", "/WEB-INF/decorators/default.jsp")
    //                 .addDecoratorPath("/admin/*", "/WEB-INF/decorators/admin.jsp")
    //                 .addExcludedPath("/login")
    //                 .addExcludedPath("/register")
    //                 .addExcludedPath("/forgot-password")
    //                 .addExcludedPath("/reset-password")
    //                 .addExcludedPath("/verify-otp")
    //                 .addExcludedPath("/image")
    //                 .addExcludedPath("/waiting")
    //                 .addExcludedPath("/error")
    //                 .addExcludedPath("/favicon.ico")
    //                 .addExcludedPath("/WEB-INF/views/login.jsp")
    //                 .addExcludedPath("/WEB-INF/views/register.jsp")
    //                 .addExcludedPath("/WEB-INF/views/forgot-password.jsp")
    //                 .addExcludedPath("/WEB-INF/views/verify-otp.jsp")
    //                 .addExcludedPath("/WEB-INF/views/reset-password.jsp")
    //                 .addExcludedPath("/WEB-INF/views/admin/*")
    //                 .addExcludedPath("/WEB-INF/decorators/*");
    //         }
    //     };
    //     
    //     registration.setFilter(filter);
    //     registration.addUrlPatterns("/*");
    //     registration.setOrder(Ordered.HIGHEST_PRECEDENCE);
    //     registration.setName("siteMeshFilter");
    //     return registration;
    // }
}