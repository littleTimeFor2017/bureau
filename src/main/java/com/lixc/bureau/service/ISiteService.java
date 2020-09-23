package com.lixc.bureau.service;

import com.lixc.bureau.back.SiteBack;
import com.lixc.bureau.entity.SysSite;
import com.lixc.bureau.query.SiteQuery;

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
    List<SysSite> list(SysSite site);

    /**
     * 添加网站专栏设置
     *
     * @return
     */
    int add(SysSite site, Integer userId);

    /**
     * 删除网站专栏设置*

     * @return
     */
    int delete(Integer id);

    /**
     * 更新网站专栏设置
     *
     * @return
     */
    int update(SysSite site, Integer userId);

    /**
     * 查询网站专栏详情
     *
     * @param id 主键id
     * @return
     */
    SysSite detail(Integer id);

}
