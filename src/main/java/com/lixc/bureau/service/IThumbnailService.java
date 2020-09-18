package com.lixc.bureau.service;

import org.springframework.web.multipart.MultipartFile;


public interface IThumbnailService {
    /**
     *
     * @param file 上传文件类
     * @param savePath 缩略图的保存路径
     * @return
     */
    String thumbnail(MultipartFile file,String savePath);
}
