package vn.utepro;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;

@SpringBootApplication
public class UteProWebBtApplication extends SpringBootServletInitializer {

    @Override
    protected SpringApplicationBuilder configure(SpringApplicationBuilder application) {
        return application.sources(UteProWebBtApplication.class);
    }

    public static void main(String[] args) {
        SpringApplication.run(UteProWebBtApplication.class, args);
        System.out.println("🚀 UteProWebBT started successfully!");
    }
}