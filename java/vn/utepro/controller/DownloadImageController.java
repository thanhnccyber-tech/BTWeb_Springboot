package vn.utepro.controller;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.io.File;

@Controller
public class DownloadImageController {

    @Value("${upload.dir:D:/upload}")
    private String uploadDir;

    @GetMapping("/image")
    public ResponseEntity<Resource> getImage(@RequestParam("fname") String fileName) {
        if (fileName == null || fileName.isEmpty()) {
            return ResponseEntity.badRequest().build();
        }

        File file = new File(uploadDir + File.separator + fileName);
        if (!file.exists()) {
            return ResponseEntity.notFound().build();
        }

        Resource resource = new FileSystemResource(file);
        return ResponseEntity.ok()
                .contentType(MediaType.IMAGE_JPEG)
                .header(HttpHeaders.CONTENT_DISPOSITION, "inline; filename=\"" + fileName + "\"")
                .body(resource);
    }
}