package com.lixc.bureau.query;

import lombok.Data;
import org.springframework.web.multipart.MultipartFile;

/**
 * @className: SiteQuery
 * @description: 网站专栏查询对象
 * @Author: Wilson
 * @createTime 2020/9/22 11:14
 */
@Data
public class SiteQuery {
    private Integer id;
    private Integer userId;
    private String userName;
    private String title;
    private String content;
    private String isShow;
    private Integer siteId;
    private Integer moduleId;
    private Integer articleId;
    /**
     * 附件id
     */
    private Integer annId;
}
