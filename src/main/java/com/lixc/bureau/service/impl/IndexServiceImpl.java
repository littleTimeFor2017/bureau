package com.lixc.bureau.service.impl;

import com.lixc.bureau.controller.IndexController;
import com.lixc.bureau.dao.IArticleDAO;
import com.lixc.bureau.dao.IDepDAO;
import com.lixc.bureau.dao.IUserDao;
import com.lixc.bureau.entity.*;
import com.lixc.bureau.service.IIndexService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class IndexServiceImpl extends PaginatorBean implements IIndexService {

    private static final Logger logger = LoggerFactory.getLogger(IndexController.class);

    @Autowired
    private IArticleDAO dao;
    @Autowired
    private IDepDAO depDAO;
    @Autowired
    private IUserDao userDao;

    @Override
    public List<Article> getArticleList(String mod, int c_id) {
        List<Article> list = dao.getArticals(mod, c_id);
        SimpleDateFormat sdf = new SimpleDateFormat("MM-dd");
        for (Article a : list) {
            a.setCreateTimeStr((sdf.format(a.getCreateTime())));
        }
        return list;
    }

    @Override
    public List<Article> getCareList(String mod, int c_id) {
        List<Article> list = dao.getCareList(mod, c_id);
        SimpleDateFormat sdf = new SimpleDateFormat("MM-dd");
        return list;
    }

    @Override
    public List<Article> getAllArticles(Article article, int c_id) {
        int count = dao.getAllArticleCountByCid(c_id);
        List<Article> list = new ArrayList<>();
        if (count > 0) {
            this.initPaginator(article, count);
            article.setC_id(c_id);
            list = dao.getAllArticlesByCid(article);
        }
        return list;
    }

    @Override
    public List<ImageEntity> getImageList() {
        ImageEntity imageEntity = new ImageEntity();
        return dao.selectImageList(imageEntity);
    }


    @Override
    public Article getArticleById(int id) {
        return dao.getArticleById(id);
    }

    @Override
    public Annex getAnnexById(int id) {
        return dao.getAnnexById(id);
    }

    @Override
    @Transactional
    public Map<String, Object> sign(User user, int dep_id, int article_id, String type) {
        //检查用户是否登录  如果登录查询到属于的部门Id 存入签收关系表 展示是否已经签收
        Map<String, Object> map = new HashMap<>();
        if (!StringUtils.isEmpty(user)) {
            //如果是超级管理员，不验证部门，
            if (!validateIsSuper(user.getId())) {
                //根据登陆用户 查询所属部门
                int depId = user.getDepId();
                //验证部门id是否合适
                if (dep_id != depId) {
                    map.put("success", false);
                    map.put("message", "对不起 您不是此部门人员 无权操作");
                    return map;
                }
            }
            if ("all".equals(type)) {
                List<Department> list = depDAO.getAllDepartmentsWithNoParam();
                if (list != null) {
                    depDAO.delRelByArticleID(article_id);
                    for (Department department : list) {
                        Article_dep_real realEntity = new Article_dep_real();
                        realEntity.setArticle_id(article_id);
                        realEntity.setDeparment_id(department.getId());
                        depDAO.insertRel(realEntity);
                    }
                    map.put("success", true);
                    map.put("message", "签收成功");
                }
            }
            //插入到关联表
            Article_dep_real realEntity = new Article_dep_real();
            realEntity.setArticle_id(article_id);
            realEntity.setDeparment_id(dep_id);
            try {
                int result = depDAO.insertRel(realEntity);
            } catch (Exception e) {
                logger.info("签收异常", e);
                e.printStackTrace();
            }
            map.put("success", true);
            map.put("message", "签收成功");
        } else {
            map.put("success", false);
            map.put("message", "用户为空，请登录");
        }
        return map;
    }

    @Override
    public boolean validateIsSuper(int user_id) {
        int count = userDao.getUserById(user_id);
        return count > 0;
    }
}
