package com.lixc.bureau.entity;

import lombok.Data;

import java.util.Date;

/**
 * @author 11930
 */
@Data
public class SysSite extends Paginator {
    private Integer id;

    private String title;

    private String isShow;

    private Date createTime;

    private Integer createBy;

    private Date updateTime;

    private Integer updateBy;

    private String url;

    private String thumbUrl;

    private String content;

}