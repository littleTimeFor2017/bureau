package com.lixc.bureau.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.*;

//@Configuration
//@EnableWebMvc
public class MyWebConfig implements WebMvcConfigurer {
    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
//        registry.addResourceHandler("/uefile/**").addResourceLocations("file:D:/uefile/");
//        registry.addResourceHandler("/**").addResourceLocations("classpath:/resources/")
//        .addResourceLocations("classpath:/static/")
//        .addResourceLocations("classpath:/public/");
//        registry.addResourceHandler("/bureau/css/**").addResourceLocations("classpath:/resources/")
//                .addResourceLocations("classpath:/static/")
//                .addResourceLocations("classpath:/public/");
//        super.addResourceHandlers(registry);
    }
}
