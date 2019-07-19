package com.lixc.bureau.entity;

import com.alibaba.fastjson.annotation.JSONField;
import lombok.Data;

import java.util.Date;

/**
 * 值班表
 */
@Data
public class DueEntity {

    private int id;

    private String key;

    private String value;

    @JSONField
    private Date create_time;
}
