package com.lixc.bureau;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.web.servlet.MultipartConfigFactory;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;
import org.springframework.context.annotation.Bean;
import org.springframework.web.servlet.view.InternalResourceViewResolver;

import javax.servlet.MultipartConfigElement;

@SpringBootApplication
public class BureauApplication extends SpringBootServletInitializer {
    //外部tomcat启动
    @Override
    protected SpringApplicationBuilder configure(SpringApplicationBuilder application) {
        return application.sources(BureauApplication.class);
    }


    public static void main(String[] args) {
        SpringApplication.run(BureauApplication.class, args);
    }

    /**
     * 文件上传配置
     * @return
     */
    @Bean
    public MultipartConfigElement multipartConfigElement() {
        MultipartConfigFactory factory = new MultipartConfigFactory();
        //单个文件最大
        factory.setMaxFileSize("502400KB"); //KB,MB
        /// 设置总上传数据总大小
        factory.setMaxRequestSize("1024000KB");
        return factory.createMultipartConfig();
    }

//    @Bean
//    MultipartConfigElement multipartConfigElement(){
//        MultipartConfigFactory factory = new MultipartConfigFactory();
//        factory.setLocation("D:/uefile");
//        return factory.createMultipartConfig();
//    }

//    @Bean
//    public InternalResourceViewResolver setupViewResolver() {
//        InternalResourceViewResolver resolver = new InternalResourceViewResolver();
//        resolver.setPrefix("/WEB-INF/jsp/");
//        resolver.setSuffix(".jsp");
//        return resolver;
//    }

}
