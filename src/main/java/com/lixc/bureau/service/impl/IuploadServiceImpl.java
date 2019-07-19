package com.lixc.bureau.service.impl;

import com.lixc.bureau.service.IuploadService;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.util.List;

@Service
public class IuploadServiceImpl implements IuploadService {

    @Override
    public String multiUpload(List<MultipartFile> files) {
        for(MultipartFile file:files){
            String fileName = file.getOriginalFilename();
            int size = (int) file.getSize();
            System.out.println(fileName + "-->" + size);

            if(file.isEmpty()){
                return "false";
            }else{/*
                File dest = new File(filePath + "/" + fileName);
                if(!dest.getParentFile().exists()){ //判断文件父目录是否存在
                    dest.getParentFile().mkdir();
                }
                try {
                    file.transferTo(dest);
                }catch (Exception e) {
                    e.printStackTrace();
                    return "false";
                }*/
            }
        }
        return "true";
    }
}
