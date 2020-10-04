package com.lixc.bureau.entity;

import lombok.Data;

import java.util.Date;

/**
 * @author 11930
 * 网站专栏设置表
 */
@Data
public class Site extends Paginator {
    private Integer id;
    private Integer imageId;
    private String isShow;
    private Date createTime;
    private Integer createBy;
    private Date updateTime;
    private Integer updateBy;
    private ImageEntity imageEntity;


}