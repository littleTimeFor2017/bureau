package com.lixc.bureau.service;

import org.springframework.web.multipart.MultipartFile;


/**
 * @author 11930
 */
public interface IThumbnailService {
    /**
     * 生成文件缩略图方法
     *
     * @param file     上传文件类
     * @param savePath 缩略图的保存路径
     * @return
     */
    String thumbnail(MultipartFile file, String savePath);
}
