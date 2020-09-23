package com.lixc.bureau.service.impl;

import com.lixc.bureau.back.SiteBack;
import com.lixc.bureau.dao.IArticleDAO;
import com.lixc.bureau.dao.ISiteDAO;
import com.lixc.bureau.entity.PaginatorBean;
import com.lixc.bureau.entity.SysSite;
import com.lixc.bureau.query.SiteQuery;
import com.lixc.bureau.service.IManagerService;
import com.lixc.bureau.service.ISiteService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

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
    private IArticleDAO articleDAO;

    @Autowired
    private IManagerService managerService;

    @Override
    public List<SysSite> list(SysSite site) {
        List<SysSite> list = new ArrayList<>();
        int count = siteDAO.selectForListCount(site);
        this.initPaginator(site, count);
        if (count > 0) {
            list = siteDAO.selectForList(site);
        }
        return list;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public int add(SysSite siteQuery, Integer userId) {
        siteQuery.setCreateBy(userId);
        siteQuery.setCreateTime(new Date());
        siteQuery.setIsShow("Y");
        return siteDAO.insertSelective(siteQuery);
    }


    @Override
    public int delete(Integer id) {
        return siteDAO.deleteById(id);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public int update(SysSite siteQuery, Integer userId) {
        SysSite site = siteDAO.selectOne(siteQuery.getId());
        if (site == null) {
            log.error("该对象不存在或者已经被删除>>>>>>id:{}", siteQuery.getId());
        }
        siteQuery.setUpdateBy(userId);
        siteQuery.setUpdateTime(new Date());
        return siteDAO.updateSelective(siteQuery);
    }

    @Override
    public SysSite detail(Integer id) {
        return siteDAO.selectOne(id);
    }
}
