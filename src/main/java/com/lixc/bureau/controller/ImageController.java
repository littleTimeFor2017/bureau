package com.lixc.bureau.controller;

import com.alibaba.fastjson.JSON;
import com.lixc.bureau.entity.Annex;
import com.lixc.bureau.entity.ImageEntity;
import org.apache.tomcat.util.http.fileupload.ProgressListener;
import org.apache.tomcat.util.http.fileupload.disk.DiskFileItemFactory;
import org.apache.tomcat.util.http.fileupload.servlet.ServletFileUpload;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.*;
import java.nio.ByteBuffer;
import java.nio.channels.FileChannel;
import java.util.HashMap;
import java.util.UUID;

/**
 * 图片上传处理类
 */
@Controller
public class ImageController extends BaseController {
    public static final Logger logger = LoggerFactory.getLogger(ManagerController.class);
    //文件保存路径
    @Value("bureau.path.savePath")
    private String savePath;
    //临时文件存储目录
    @Value("bureau.path.tempPath")
    private String tempPath;

    /**
     * 将图片上传到本地，增加路径映射
     */
    @RequestMapping(name = "uploadImage", method = RequestMethod.POST)
    public String uploadImage(HttpServletRequest request, MultipartFile file) {
        this.map = new HashMap<>();
        //记录提示信息
        String message = "";
        //获取到文件  file,解析文件的后缀，如果不是png、jpg svg 等拒绝
        // 上传时的文件名 file.getOriginalFilename()
        //获取到文件名 ？
        try {
            //校验文件大小
            long size = file.getSize();
            //从文件中读取输入流 输入到指定目录中
            InputStream ins = file.getInputStream();
            String fileName = System.currentTimeMillis() + file.getOriginalFilename();
//            FileOutputStream fos = new FileOutputStream(savePath + File.separator + fileName);
//            FileChannel fileChannel = ((FileInputStream) ins).getChannel();
//            FileChannel writeChannel = fos.getChannel();
//            ByteBuffer buffer = ByteBuffer.allocate(1024);
//            int len = 0;
//            while (true) {
//                buffer.clear();
//                int length = fileChannel.read(buffer);
//                if (length < 0) {
//                    break;
//                }
//                buffer.flip();
//                writeChannel.write(buffer);
//            }
//            //关闭输入流
//            ins.close();
//            //关闭输出流
//            fos.close();
            String url = savePath+File.separator+fileName;
            //存储到文件表中，列表展示时，只展示前四个，根据时间倒叙排序
            File destFile = new File(url);
            if(!destFile.exists()){
                logger.error("文件不存在");
                destFile.mkdirs();
            }
            file.transferTo(destFile);
            ImageEntity entity = new ImageEntity();
            entity.setUrl(url);
            //添加图片
//            imageService.addIMage();
        } catch (Exception e) {
            e.printStackTrace();
            message="上传失败";
        }
        return JSON.toJSONString(map);
    }
}
