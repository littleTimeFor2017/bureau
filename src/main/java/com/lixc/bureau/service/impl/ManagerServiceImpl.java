package com.lixc.bureau.service.impl;

import cn.hutool.core.lang.Assert;
import com.lixc.bureau.dao.IArticleDAO;
import com.lixc.bureau.dao.IDepDAO;
import com.lixc.bureau.dao.IUserDao;
import com.lixc.bureau.entity.*;
import com.lixc.bureau.service.IManagerService;
import com.lixc.bureau.util.EduResult;
import org.apache.tomcat.util.http.fileupload.disk.DiskFileItem;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import java.io.*;
import java.util.List;

@Service
public class ManagerServiceImpl implements IManagerService {

    private static final Logger log = LoggerFactory.getLogger(ManagerServiceImpl.class);

    @Autowired
    private IArticleDAO dao;

    @Autowired
    private IUserDao userDao;

    @Autowired
    private IDepDAO depDAO;

    @Override
    public List<CategoryEntity> getAllCategorise() {
        return dao.getAllCategorise();
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
        return dao.getArticleListByCID(article);
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
        //上栓
        return EduResult.ok();
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
        System.out.println(dao.addAnnex(annex));
       return  dao.addAnnex(annex);
    }



}
