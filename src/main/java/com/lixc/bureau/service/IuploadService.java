package com.lixc.bureau.service;

import org.springframework.web.multipart.MultipartFile;

import java.util.List;

public interface IuploadService {

     String multiUpload(List<MultipartFile> files);
}
