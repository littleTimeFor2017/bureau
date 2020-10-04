package com.lixc.bureau.service;

import com.lixc.bureau.entity.Article;
import com.lixc.bureau.entity.Site;
import com.lixc.bureau.entity.SiteArticle;
import com.lixc.bureau.query.SiteQuery;
import com.lixc.bureau.util.EduResult;

import java.util.List;

/**
 * @className: ISiteService
 * @description: 网站专栏service
 * @Author: Wilson
 * @createTime 2020/9/22 10:20
 */
public interface ISiteService {
    /**
     * 查询专栏列表
     *
     * @return
     */
    List<Site> list(Site site);

    /**
     * 添加网站专栏设置
     *
     * @return
     */
    int add(Site site);

    /**
     * 删除网站专栏设置*
     *
     * @return
     */
    int delete(Integer id);

    /**
     * 更新网站专栏设置
     *
     * @return
     */
    int update(Site site, Integer userId);

    /**
     * 查询网站专栏详情
     *
     * @param id 主键id
     * @return
     */
    Site detail(Integer id);

    int addArticle(SiteQuery siteQuery);


    List<Article> articleList(SiteArticle site);

    SiteArticle selectDetail(Integer siteId, Integer articleId);

    void editArticle(SiteQuery siteQuery);

    void delArticle(int id,int siteId);

    int selectSiteIdByImageId(int siteId);
}
