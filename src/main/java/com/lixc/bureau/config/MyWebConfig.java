package com.lixc.bureau.config;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.*;

import java.io.File;

/**
 * 配置虚拟路径发生的不生效问题
 * 1.带有contextPath的路径 需不需要加入到虚拟路径中去
 * 2.绝对路径 的格式
 */
@Configuration
public class MyWebConfig implements WebMvcConfigurer {
    private static final Logger logger = LoggerFactory.getLogger(MyWebConfig.class);

    //文件保存路径
    @Value("${bureau.path.savePath}")
    private String savePath;

    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {

        logger.info("before  虚拟路径映射之前  >>>>>>>>>>>>." +"file:///"+savePath );
        registry.addResourceHandler("/images/**").addResourceLocations("file:///"+savePath+ File.separator);
        logger.info("after  虚拟路径映射之后");
        registry.addResourceHandler("/uefile/**").addResourceLocations("file:///D:/uefile/");
//        registry.addResourceHandler("/**").addResourceLocations("classpath:/resources/")
//        .addResourceLocations("classpath:/static/")
//        .addResourceLocations("classpath:/public/");
//        registry.addResourceHandler("/bureau/css/**").addResourceLocations("classpath:/resources/")
//                .addResourceLocations("classpath:/static/")
//                .addResourceLocations("classpath:/public/");
//        super.addResourceHandlers(registry);
    }
//        registry.addResourceHandler("/uefile/**").addResourceLocations("file:D:/uefile/");
}
