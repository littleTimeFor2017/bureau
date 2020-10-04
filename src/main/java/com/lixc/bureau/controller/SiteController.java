package com.lixc.bureau.controller;

import com.alibaba.fastjson.JSON;
import com.lixc.bureau.constants.BureauConstants;
import com.lixc.bureau.entity.*;
import com.lixc.bureau.enums.DictTypeEnum;
import com.lixc.bureau.query.SiteQuery;
import com.lixc.bureau.service.DictService;
import com.lixc.bureau.service.IIndexService;
import com.lixc.bureau.service.ISiteService;
import com.lixc.bureau.util.EduResult;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @className: SiteController
 * @description: 网站专栏controller
 * @Author: Wilson
 * @createTime 2020/9/22 9:32
 */
@Slf4j
@Controller
@RequestMapping("/site")
public class SiteController extends BaseController {

    @Autowired
    private ISiteService siteService;

    //文件保存路径
    @Value("${bureau.path.savePath}")
    private String savePath;

    @Autowired
    private DictService dictService;


    @Autowired
    private IIndexService indexService;


    /**
     * 跳转到网站专栏页面
     *
     * @return
     */
    @RequestMapping("/siteForward")
    public String siteForward() {
        return "manager/site";
    }

    /**
     * 查询专栏列表
     *
     * @return
     */
    @RequestMapping("/list")
    @ResponseBody
    public String list(@RequestBody Site site) {
        Map<String, Object> map = new HashMap<>();
        try {
            List<Site> list = siteService.list(site);
            map.put("success", true);
            map.put("list", list);
            map.put("obj", site);
        } catch (Exception e) {
            e.printStackTrace();
            map.put("success", false);
            map.put("message", "查询专栏列表数据异常");
        }
        return JSON.toJSONStringWithDateFormat(map, "yyyy-MM-dd");
    }

    /**
     * 添加网站专栏设置对应文章跳转
     *
     * @return
     */
    @RequestMapping("/addForward")
    public String addForward(@RequestParam("id") int id) {
        //查询所有属于图片条件模块
        List<Dict> dictByType = dictService.getDictByType(DictTypeEnum.DICT_TYPE_ENUM_CHILDCATEGORY.getCode());
        request.getSession().setAttribute("list", dictByType);
        request.getSession().setAttribute("id", id);
        return "manager/site_add";
    }

    /**
     * 在网站专栏模块添加文章
     *
     * @param request
     * @param siteQuery
     * @return
     */
    @RequestMapping(value = "/addArticle", method = RequestMethod.POST)
    @ResponseBody
    public EduResult addArticle(HttpServletRequest request,
                                @RequestBody SiteQuery siteQuery
    ) {
        EduResult eduResult = new EduResult();
        User ut = (User) request.getSession().getAttribute(BureauConstants.USER_TOKEN);
        if (ut == null) {
            eduResult.put("success", false);
            eduResult.put("msg", "您无权查看！");
            return eduResult;
        }
        siteQuery.setUserName(ut.getUserName());
        try {
            siteService.addArticle(siteQuery);
            log.info("添加文章成功");
        } catch (Exception e) {
            log.error("添加文章失败，请联系管理员");
            return EduResult.error("添加文章失败，请联系管理员");
        }
        return EduResult.ok();
    }

    /**
     * 修改网站专栏文章跳转
     *
     * @return
     */
    @RequestMapping("/editArticleForward")
    public String editArticleForward(@RequestParam("id") int id, @RequestParam("siteId") int siteId) {
        Article articleById = indexService.getArticleById(id);
        request.getSession().setAttribute("articleById", articleById);
        request.getSession().setAttribute("siteId", siteId);
        return "manager/site_article_update";
    }

    /**
     * 获取选中模块json
     *
     * @param id
     * @param siteId
     * @return
     */
    @RequestMapping("/getModulesJson")
    @ResponseBody
    public String getModulesJson(@RequestParam("id") int id, @RequestParam("siteId") int siteId) {
        this.map = new HashMap<>();
        try {
            List<Dict> dictByType = dictService.getDictByType(DictTypeEnum.DICT_TYPE_ENUM_CHILDCATEGORY.getCode());
            SiteArticle siteArticle = siteService.selectDetail(siteId, id);
            map.put("success", true);
            map.put("list", dictByType);
            map.put("siteArticle", siteArticle);
        } catch (Exception e) {
            map.put("success", false);
            map.put("message", "查询模块异常");
        }
        return JSON.toJSONString(map);
    }

    /**
     * 在网站专栏模块添加文章
     *
     * @param request
     * @param siteQuery
     * @return
     */
    @RequestMapping(value = "/editArticle", method = RequestMethod.POST)
    @ResponseBody
    public EduResult editArticle(HttpServletRequest request,
                                 @RequestBody SiteQuery siteQuery
    ) {
        EduResult eduResult = new EduResult();
        User ut = (User) request.getSession().getAttribute(BureauConstants.USER_TOKEN);
        if (ut == null) {
            eduResult.put("success", false);
            eduResult.put("msg", "您无权查看！");
            return eduResult;
        }
        siteQuery.setUserName(ut.getUserName());
        siteQuery.setUserId(ut.getId());
        try {
            siteService.editArticle(siteQuery);
            log.info("修改文章成功");
        } catch (Exception e) {
            log.error("修改文章失败，请联系管理员");
            return EduResult.error("修改文章失败，请联系管理员");
        }
        return EduResult.ok();
    }

    /**
     * 修改文章状态为已删除
     *
     * @return
     */
    @RequestMapping("/delArticle")
    @ResponseBody
    public EduResult delArticle(@RequestParam("id") int id,
                                @RequestParam("siteId") int siteId) {
        EduResult eduResult = new EduResult();
        Article article = indexService.getArticleById(id);
        if (article == null) {
            eduResult.put("success", false);
            eduResult.put("message", "数据对象不存在！");
            return eduResult;
        }
        User ut = (User) request.getSession().getAttribute(BureauConstants.USER_TOKEN);
        if (ut == null) {
            eduResult.put("success", false);
            eduResult.put("message", "您无权查看！");
            return eduResult;
        }
        article.setIs_deleted("Y");
        siteService.delArticle(id, siteId);
        eduResult.put("success", true);
        eduResult.put("message", "删除成功");
        return eduResult;
    }

    /**
     * 网站专栏对应的文章列表跳转
     *
     * @param siteId
     * @return
     */
    @RequestMapping("/articleManage")
    public String articleManage(@RequestParam("id") int siteId) {
        request.getSession().setAttribute("siteId", siteId);
        List<Dict> dictByType = dictService.getDictByType(DictTypeEnum.DICT_TYPE_ENUM_CHILDCATEGORY.getCode());
        request.getSession().setAttribute("list", dictByType);
        return "manager/site_article";
    }


    /**
     * 查询网站专栏对应的文章列表
     *
     * @param site
     * @return
     */
    @RequestMapping("/articleList")
    @ResponseBody
    public String articleList(@RequestBody SiteArticle site) {
        Map<String, Object> map = new HashMap();
        try {
            List<Article> articles = siteService.articleList(site);
            map.put("success", true);
            map.put("list", articles);
            map.put("obj", site.getArticle());
        } catch (Exception e) {
            log.error(e.getLocalizedMessage());
            map.put("success", false);
            map.put("message", "查询文章列表失败");
        }
        return JSON.toJSONStringWithDateFormat(map, "yyyy-MM-dd");
    }

    /**
     * 添加网站专栏设置
     *
     * @return
     */
    @RequestMapping("/add")
    @ResponseBody
    public String add(@RequestBody Site siteQuery) {
        this.map = new HashMap<>();
        //记录提示信息
        String message = "";
        try {
            User ut = (User) request.getSession().getAttribute(BureauConstants.USER_TOKEN);
            if (ut == null) {
                message = "上传失败,请重新登录";
                map.put("success", false);
                map.put("message", message);
                return JSON.toJSONString(map);
            }
            siteQuery.setCreateBy(ut.getId());
            siteQuery.setCreateTime(new Date());
            siteService.add(siteQuery);
            map.put("success", true);
        } catch (Exception e) {
            log.error("网站专栏添加异常：" + e.getLocalizedMessage());
            map.put("success", false);
            map.put("message", "网站专栏添加异常!");
        }
        return JSON.toJSONString(map);
    }


    /**
     * 更新网站专栏设置跳转
     *
     * @return
     */
    @RequestMapping("/updateForward")
    public String updateForward(@RequestParam("id") int id) {
        Site detail = siteService.detail(id);
        request.getSession().setAttribute("site", detail);
        return "manager/site_edit";
    }

    /**
     * 更新网站专栏设置
     *
     * @return
     */
    @RequestMapping("/update")
    @ResponseBody
    public String update(@RequestBody Site site) {
        this.map = new HashMap<>();
        User ut = (User) request.getSession().getAttribute(BureauConstants.USER_TOKEN);
        if (ut == null) {
            map.put("success", false);
            map.put("msg", "您无权查看！");
            return JSON.toJSONString(map);
        }
        try {
            siteService.update(site, ut.getId());
            map.put("success", true);
        } catch (Exception e) {
            log.error("更新网站专栏异常：{}", e.getLocalizedMessage());
            map.put("success", false);
            map.put("message", "更新网站专栏异常!");
        }

        return JSON.toJSONString(map);
    }

    /**
     * 删除网站专栏设置
     *
     * @return
     */
    @RequestMapping("/delete")
    @ResponseBody
    public String delete(@RequestParam("id") int id) {
        this.map = new HashMap<>();
        try {
            siteService.delete(id);
            map.put("success", true);
        } catch (Exception e) {
            log.error("删除网站专栏异常：{}", e.getLocalizedMessage());
            map.put("success", false);
            map.put("message", "删除网站专栏异常!");
        }
        return JSON.toJSONString(map);
    }
}
