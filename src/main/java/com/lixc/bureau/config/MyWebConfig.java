package com.lixc.bureau.config;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.*;

/**
 * 配置虚拟路径发生的不生效问题
 * 1.带有contextPath的路径 需不需要加入到虚拟路径中去
 * 2.绝对路径 的格式
 */
@Configuration
@EnableWebMvc
public class MyWebConfig extends WebMvcConfigurationSupport {
    private static final Logger logger = LoggerFactory.getLogger(MyWebConfig.class);

    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        logger.info("before  虚拟路径映射之前");
        registry.addResourceHandler("/bureau/images/**").addResourceLocations("file:/E:/git/bureau/src/main/webapp/WEB-INF/images/");
        logger.info("after  虚拟路径映射之后");
//        registry.addResourceHandler("/**").addResourceLocations("classpath:/resources/")
//        .addResourceLocations("classpath:/static/")
//        .addResourceLocations("classpath:/public/");
//        registry.addResourceHandler("/bureau/css/**").addResourceLocations("classpath:/resources/")
//                .addResourceLocations("classpath:/static/")
//                .addResourceLocations("classpath:/public/");
        super.addResourceHandlers(registry);
    }
//        registry.addResourceHandler("/uefile/**").addResourceLocations("file:D:/uefile/");
}
