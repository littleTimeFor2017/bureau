package com.lixc.bureau.entity;

import lombok.Data;

import java.util.Date;

@Data
public class ImageEntity {

    private int id;

    private String url;

    private Date create_date;
}
