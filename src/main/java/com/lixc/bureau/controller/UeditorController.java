package com.lixc.bureau.controller;

import com.baidu.ueditor.ActionEnter;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Calendar;
import java.util.Random;
@Slf4j
@RestController
@RequestMapping("/common/ueditor/")
public class UeditorController {


    @RequestMapping("/controller")
    public void  getConfigInfo(HttpServletRequest request, HttpServletResponse response) {
//        URL resource = this.getClass().getClassLoader().getResource("/static/config.json");
//        org.springframework.core.io.Resource res = new ClassPathResource("config.json");
        response.setHeader("Content-Type", "text/html");
        try {
//            ClassPathResource classPathResource = new ClassPathResource("config.json");
//            InputStream stream = classPathResource.getStream();
//            BufferedReader br = new BufferedReader(new InputStreamReader(stream,"utf-8"));
//            StringBuffer message = new StringBuffer();
//            String line = null;
//            while ((line = br.readLine()) != null) {
//                message.append(line);
//            }
//            String result = message.toString().replaceAll("/\\*(.|[\\r\\n])*?\\*/", "");
//            JSONObject json = JSONObject.parseObject(result);
//            PrintWriter out = response.getWriter();
//            out.println(json);
            request.setCharacterEncoding("utf-8");
            String rootPath = request.getSession().getServletContext().getRealPath("/");
//            String rootPath = "G:/uefile/";
            PrintWriter out = response.getWriter();
            out.write(new ActionEnter(request, rootPath).exec());
        } catch (IOException e) {
            log.error(e.getLocalizedMessage());
            e.printStackTrace();
        }
//        return "bureau/common/editor/controller";
    }

}
