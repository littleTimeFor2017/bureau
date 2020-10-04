package com.lixc.bureau.entity;

import lombok.Data;

/**
 * @className: SiteArtcile
 * @description: 文章专栏关联表
 * @Author: Wilson
 * @createTime 2020/9/24 9:50
 */
@Data
public class SiteArticle  extends Paginator{
    private Integer id;
    private Integer siteId;
    private Integer articleId;
    private Integer moduleId;
    private Article article;

}
