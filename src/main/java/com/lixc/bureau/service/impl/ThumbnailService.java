package com.lixc.bureau.service.impl;

import com.lixc.bureau.service.IThumbnailService;
import net.coobird.thumbnailator.Thumbnails;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;

/**
 * 使用Thumbanil生成缩略图并返回缩略图路径
 */
@Service
public class ThumbnailService implements IThumbnailService {
    @Override
    public String thumbnail(MultipartFile file, String savePath) {
        String fileName = System.currentTimeMillis() + file.getOriginalFilename();
        String des = savePath + File.separator+"thum_" + fileName;
        try {
           Thumbnails.of(file.getInputStream()).size(100,60).toFile(des);
        }catch (Exception e){
            e.printStackTrace();
        }
        return "thum_" + fileName;
    }
}
