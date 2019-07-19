package com.lixc.bureau.entity;

import com.alibaba.fastjson.annotation.JSONField;
import lombok.Data;

import java.util.Date;

@Data
public class Article_dep_real {

    private int id ;

    private int article_id;

    private int deparment_id;
    @JSONField
    private Date createTime;

    private String createBy;
    @JSONField
    private Date updateTime;

    private String updateBy;

    @Override
    public String toString() {
        return "Article_dep_real{" +
                "id=" + id +
                ", article_id=" + article_id +
                ", deparment_id=" + deparment_id +
                ", createTime=" + createTime +
                ", createBy='" + createBy + '\'' +
                ", updateTime=" + updateTime +
                ", updateBy='" + updateBy + '\'' +
                '}';
    }
}
