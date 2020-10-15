package com.lixc.bureau.service.impl;

import cn.hutool.core.lang.Assert;
import com.lixc.bureau.dao.*;
import com.lixc.bureau.entity.*;
import com.lixc.bureau.service.IManagerService;
import com.lixc.bureau.util.EduResult;
import org.apache.tomcat.util.http.fileupload.disk.DiskFileItem;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.CollectionUtils;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import java.io.*;
import java.util.ArrayList;
import java.util.List;

@Service
public class ManagerServiceImpl extends PaginatorBean implements IManagerService {

    private static final Logger log = LoggerFactory.getLogger(ManagerServiceImpl.class);

    @Autowired
    private IArticleDAO dao;

    @Autowired
    private IUserDao userDao;

    @Autowired
    private IDepDAO depDAO;


    @Autowired
    private ISiteDAO siteDAO;

    @Autowired
    private SiteArticleMapper siteArticleMapper;


    @Override
    public List<CategoryEntity> getAllCategorise() {
        return dao.getAllCategorise();
    }

    @Override
    public List<CategoryEntity> getCategoryListByType(String type) {
        return dao.getCategoryListByType(type);
    }

    @Override
    public CategoryEntity getCategoryEntityById(int id) {
        return dao.getCategoryEntityById(id);
    }

    @Override
    public CategoryEntity getCategoryEntityByType(String type) {
        return dao.getCategoryEntityByType(type);
    }

    @Override
    public List<Article> getArticleListByCID(Article article) {
        List<Article> list = new ArrayList<>();
        int count = dao.getArticleListCountByCID(article);
        this.initPaginator(article, count);
        if (count > 0) {
            list = dao.getArticleListByCID(article);
        }
        return list;
    }

    @Override
    @Transactional
    public EduResult addArticle(Article article, int user_id, String ids) {
        User user = userDao.getUser(user_id);
        if (user != null) {
            article.setCreateBy(user.getUserName());
        }
        dao.addArticle(article);
        int article_id = article.getId();
        if (ids != null && ids.length() > 0) {
            String[] s = ids.split("_");
            for (int i = 0; i < s.length; i++) {
                Article_dep_publish article_dep_publish = new Article_dep_publish();
                article_dep_publish.setArticle_id(article_id);
                article_dep_publish.setDep_id(Integer.parseInt(s[i]));
                depDAO.addArticle_dep_publish(article_dep_publish);
            }
        }
        return EduResult.ok();
    }

    @Override
    public void addArticleOnly(Article article) {
        dao.addArticle(article);
    }

    @Override
    @Transactional
    public EduResult editArticle(Article article, int user_id, String ids) {
        String message = "";
        if (StringUtils.isEmpty(article)) {
            message = "传入参数为空";
            return EduResult.error(message);
        }
        if (StringUtils.isEmpty(ids)) {
            message = "选择部门为空";
            return EduResult.error(message);
        }
        int article_id = article.getId();
        Article articleById = dao.getArticleById(article_id);
        if (articleById == null) {
            message = "数据库表不存在";
            return EduResult.error(message);
        }
        articleById.setTitle(article.getTitle());
        articleById.setContent(article.getContent());
        dao.editArticle(articleById, user_id);
        //删除文章指定的部门
        depDAO.delPublishByArticleId(article_id);
        //重新插入到关联表
        String[] s = ids.split("_");
        for (int i = 0; i < s.length; i++) {
            Article_dep_publish article_dep_publish = new Article_dep_publish();
            article_dep_publish.setArticle_id(article_id);
            article_dep_publish.setDep_id(Integer.parseInt(s[i]));
            depDAO.addArticle_dep_publish(article_dep_publish);
        }
        return EduResult.ok();
    }


    @Override
    public EduResult delArticle(Article article, int user_id) {
        String message = "删除成功";
        if (article == null) {
            message = "传入参数为null";
            return EduResult.error(message);
        }
        Article articleById = dao.getArticleById(article.getId());
        if (articleById == null) {
            message = "数据库表不存在";
            return EduResult.error(message);
        }
        dao.updateArticle(article, user_id);
        return EduResult.ok(message);
    }

    @Override
    public int addAnnex(Annex annex) {
        return dao.addAnnex(annex);
    }

    @Override
    public List<ImageEntity> getImageList(ImageEntity imageEntity) {
        List<ImageEntity> list = new ArrayList<>();
        int count = dao.selectImageCount(imageEntity);
        this.initPaginator(imageEntity, count);
        if (count > 0) {
            list = dao.selectImageList(imageEntity);
        }
        return list;
    }

    @Override
    public ImageEntity editImageForward(int id) {
        return dao.selectImageByID(id);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public int delImage(int id) {
        ImageEntity imageEntity = dao.selectImageByID(id);
        if (imageEntity.getUse_position() == 2) {
            //专栏表，文章表，关联表 都删除
            List<Site> sites = siteDAO.selectByImageId(id);
            if(!CollectionUtils.isEmpty(sites)){
                Site site = sites.get(0);
                siteDAO.deleteById(site.getId());
                SiteArticle siteArticle = new SiteArticle();
                siteArticle.setSiteId(site.getId());
                List<Article> articles = siteArticleMapper.selectAllArticleBySiteId(siteArticle);
                if(!CollectionUtils.isEmpty(articles)){
                    dao.deleteByBatch(articles);
                }
                siteArticleMapper.deleteBySiteId(site.getId());
            }
        }
        return dao.deleteImage(id);
    }


    @Override
    public int addImage(ImageEntity imageEntity) {
        dao.addImage(imageEntity);
        return imageEntity.getId();
    }

}
