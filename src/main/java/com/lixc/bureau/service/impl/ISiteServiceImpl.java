package com.lixc.bureau.service.impl;

import com.lixc.bureau.dao.IArticleDAO;
import com.lixc.bureau.dao.ISiteDAO;
import com.lixc.bureau.dao.SiteArticleMapper;
import com.lixc.bureau.entity.Article;
import com.lixc.bureau.entity.PaginatorBean;
import com.lixc.bureau.entity.Site;
import com.lixc.bureau.entity.SiteArticle;
import com.lixc.bureau.query.SiteQuery;
import com.lixc.bureau.service.IManagerService;
import com.lixc.bureau.service.ISiteService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.CollectionUtils;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * @className: ISiteServiceImpl
 * @description: TODO
 * @Author: Wilson
 * @createTime 2020/9/22 10:26
 */
@Slf4j
@Service
public class ISiteServiceImpl extends PaginatorBean implements ISiteService {

    @Autowired
    private ISiteDAO siteDAO;


    @Autowired
    private SiteArticleMapper siteArticleMapper;

    @Autowired
    private IArticleDAO articleDAO;

    @Override
    public List<Site> list(Site site) {
        List<Site> list = new ArrayList<>();
        int count = siteDAO.selectForListCount(site);
        this.initPaginator(site, count);
        if (count > 0) {
            list = siteDAO.selectForList(site);
            if (!CollectionUtils.isEmpty(list)) {
                for (Site site1 : list) {
                    Integer imageId = site1.getImageId();
                    site1.setImageEntity(articleDAO.selectImageByID(imageId));
                }
            }
        }
        return list;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public int add(Site siteQuery) {
        return siteDAO.insertSelective(siteQuery);
    }


    @Override
    public int delete(Integer id) {
        return siteDAO.deleteById(id);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public int update(Site siteQuery, Integer userId) {
        Site site = siteDAO.selectOne(siteQuery.getId());
        if (site == null) {
            log.error("该对象不存在或者已经被删除>>>>>>id:{}", siteQuery.getId());
        }
        siteQuery.setUpdateBy(userId);
        siteQuery.setUpdateTime(new Date());
        return siteDAO.updateSelective(siteQuery);
    }

    @Override
    public Site detail(Integer id) {
        return siteDAO.selectOne(id);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public int addArticle(SiteQuery siteQuery) {
        //添加文章表
        Article article = new Article();
        article.setIs_deleted("N");
        article.setTitle(siteQuery.getTitle());
        article.setContent(siteQuery.getContent());
        article.setCreateBy(siteQuery.getUserName());
        article.setIs_site("Y");
        article.setCreateTime(new Date());
        articleDAO.addArticle(article);
        //添加文章专栏关联
        SiteArticle siteArticle = new SiteArticle();
        siteArticle.setArticleId(article.getId());
        siteArticle.setModuleId(siteQuery.getModuleId());
        siteArticle.setSiteId(siteQuery.getSiteId());
        siteArticleMapper.insertSelective(siteArticle);
        return 1;
    }

    @Override
    public List<Article> articleList(SiteArticle siteArticle) {
        //根据site 查询所有的文章列表
        List<Article> articles = new ArrayList<>();
        int count = siteArticleMapper.selectArticleNyRealCount(siteArticle);
        Article article = new Article();
        article.setPageSize(siteArticle.getPageSize());
        article.setCurPage(siteArticle.getCurPage());
        article.setTotPage(siteArticle.getTotPage());
        this.initPaginator(siteArticle, count);
        this.initPaginator(article, count);
        siteArticle.setArticle(article);
        if (count > 0) {
            articles = siteArticleMapper.selectArticleNyReal(siteArticle);
        }
        return articles;
    }

    @Override
    public SiteArticle selectDetail(Integer siteId, Integer articleId) {
        return siteArticleMapper.selectDetail(siteId, articleId);
    }


    @Override
    @Transactional(rollbackFor = Exception.class)
    public void editArticle(SiteQuery siteQuery) {
        //更新文章基本信息
        Article articleById = articleDAO.getArticleById(siteQuery.getArticleId());
        articleById.setUpdateTime(new Date());
        articleById.setTitle(siteQuery.getTitle());
        articleById.setContent(siteQuery.getContent());
        articleDAO.editArticle(articleById, siteQuery.getUserId());
        //添加文章专栏关联
        SiteArticle siteArticle = siteArticleMapper.selectDetail(siteQuery.getSiteId(), siteQuery.getArticleId());
        siteArticle.setModuleId(siteQuery.getModuleId());
        siteArticleMapper.updateByPrimaryKeySelective(siteArticle);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void delArticle(int id, int siteId) {
        articleDAO.deleteArticlePhy(id);
        //删除文章 专栏关联
        SiteArticle siteArticle = siteArticleMapper.selectDetail(siteId, id);
        siteArticleMapper.deleteByPrimaryKey(siteArticle.getId());
    }


    @Override
    public int selectSiteIdByImageId(int imageId) {
        return  siteDAO.selectSiteIdByImageId(imageId);
    }
}
