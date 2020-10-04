package com.lixc.bureau.entity;

import com.alibaba.fastjson.annotation.JSONField;
import lombok.Data;
import org.springframework.web.multipart.MultipartFile;

import java.util.Date;

/**
 * 文章实体类
 */
@Data
public class Article extends Paginator {

    private int id;

    private int c_id;

    private String title;

    private String is_deleted;

    private String content;
    @JSONField
    private Date createTime;

    private String createBy;
    @JSONField
    private Date updateTime;

    private String updateBy;

    private String createTimeStr;

    private int a_id;

    /**
     * 增加是否是网站专栏文章标志
     */
    private String is_site;

    private Annex annex;

    private int module_id;

}
