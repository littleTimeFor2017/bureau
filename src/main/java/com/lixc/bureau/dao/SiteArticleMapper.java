package com.lixc.bureau.dao;


import com.lixc.bureau.entity.Article;
import com.lixc.bureau.entity.SiteArticle;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * @author 11930
 */
@Mapper
public interface SiteArticleMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(SiteArticle record);

    int insertSelective(SiteArticle record);

    SiteArticle selectByPrimaryKey(Integer id);

    SiteArticle selectDetail(@Param("siteId") Integer siteId, @Param("articleId") Integer articleId);

    int updateByPrimaryKeySelective(SiteArticle record);

    int updateByPrimaryKey(SiteArticle record);


    List<Article> selectArticleNyReal(SiteArticle siteArticle);
    List<Article> selectAllArticleBySiteId(SiteArticle siteArticle);

    int selectArticleNyRealCount(SiteArticle siteArticle);

    int deleteBySiteId(@Param("siteId") Integer id);


}