package com.lixc.bureau.back;

import lombok.Data;

import java.util.Date;

/**
 * @className: SiteBack
 * @description: 网站专栏返回实体类
 * @Author: Wilson
 * @createTime 2020/9/22 11:25
 */
@Data
public class SiteBack {
    private Integer    id;
    private String title;
    private String content;
    private String isShow;
    private Date createTime;
    private Integer createBy;
    private Date updateTime;
    private Integer updateBy;
    private String url;

}
