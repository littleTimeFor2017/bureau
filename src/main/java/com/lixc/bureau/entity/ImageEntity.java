package com.lixc.bureau.entity;

import lombok.Data;

import java.util.Date;

@Data
public class ImageEntity extends Paginator {

    private int id;

    private String url;

    private Date create_date;

    private String name;

    private String createBy;

    private String checked;

    //使用场景
    private int use_position;

    private int order_no;
    //缩略图路径(保存名称)
    private String thumURL;


}
