package com.lixc.bureau.entity;

import lombok.Data;

import java.util.Date;

@Data
public class Annex {

    private int id;

    private String url;

    private String fileName;

    private String saveName;

    private Date create_time;
}
