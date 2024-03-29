package com.lixc.bureau.controller;

import com.alibaba.fastjson.JSON;
import com.lixc.bureau.constants.BureauConstants;
import com.lixc.bureau.entity.*;
import com.lixc.bureau.enums.DictTypeEnum;
import com.lixc.bureau.service.*;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 处理页面加载前的数据
 * @author 11930
 */
@Slf4j
@Controller
@RequestMapping("/")
public class IndexController extends BaseController {

    @Autowired
    private IIndexService service;
    @Autowired
    private DictService dictService;
    @Autowired
    private IDepartmentService departmentService;

    @Autowired
    private IUserService userService;

    @Autowired
    private IDueService dueService;

    @Autowired
    private IManagerService managerService;


    @Autowired
    private ISiteService siteService;

    /**
     * 按照分组查询首页跳转
     */
    @RequestMapping("/index")
    public String index() {
        List<Article> gzdtList = service.getArticleList("7", 1);
        request.setAttribute("gzdtList", gzdtList);
        List<Article> tztbList = service.getArticleList("7", 2);
        request.setAttribute("tztbList", tztbList);
        List<Article> zxtbList = service.getArticleList("7", 3);
        request.setAttribute("zxtbList", zxtbList);
        List<Article> zgdjList = service.getArticleList("7", 4);
        request.setAttribute("zgdjList", zgdjList);
        //政工党建的集合  查询下面所有的子菜单

        List<Article> mtyqList = service.getArticleList("7", 5);
        request.setAttribute("mtyqList", mtyqList);
        List<Article> zxzzList = service.getArticleList("7", 6);
        request.setAttribute("zxzzList", zxzzList);
        List<Article> bmgzList = service.getArticleList("7", 7);
        request.setAttribute("bmgzList", bmgzList);
        List<DueEntity> dueList = dueService.getDueList("D");
        request.setAttribute("dueList", dueList);
        List<Article> careList = service.getCareList("7", 10);
        request.setAttribute("careList", careList);
        List<ImageEntity> sylbtList = service.getImageList(1);
        List<ImageEntity> wzzlList = service.getImageList(2);
        List<ImageEntity> pcList = service.getImageList(3);
        request.setAttribute("sylbtList", sylbtList);
        request.setAttribute("wzzlList", wzzlList);
        request.setAttribute("pcList", pcList);
        return "index";
    }

    /**
     * 除了index以外的导航栏 参数传递l
     *
     * @param type
     * @return
     */
    @RequestMapping("/other")
    public String other(@RequestParam("type") String type) {
        //根据type查出对应的category
        CategoryEntity categoryEntity = managerService.getCategoryEntityByType(type);
        if(!StringUtils.isEmpty(type)){
            //包含zgdj_的为政工党建的子分类，原来一级菜单展示的内容去掉，
            if(type.contains("zgdj")){
                //获取政工党建分类下面的所有的子菜单
                List<CategoryEntity> dictByType = managerService.getCategoryListByType(type);
                request.getSession().setAttribute("list", dictByType);
                return "advice_zgdj";
            }
        }
        request.setAttribute("entity", categoryEntity);
        return "advice";
    }

    @RequestMapping("/getArticleListByTypeJSon/{type}")
    @ResponseBody
    public String getArticleListByTypeJSon(@PathVariable("type") int c_id,
                                           @RequestBody Article article) {
        map = new HashMap<String, Object>();
        try {
            //分页、
            List<Article> list = service.getAllArticles(article, c_id);
            map.put("list", list);
            map.put("success", true);
            map.put("obj", article);
        } catch (Exception e) {
            log.error(e.getLocalizedMessage());
            map.put("success", true);
        }
        return JSON.toJSONStringWithDateFormat(map, "yyyy-MM-dd");
    }


    /**
     * 通知通报详情
     */
    @RequestMapping("/articleDetail")
    public String articleDetail(@RequestParam("id") String idStr,
                                @RequestParam(value = "type", required = false) String type,
                                @RequestParam(value = "fromSite", required = false) boolean fromSite,
                                @RequestParam(value = "siteId", required = false) Integer siteId) {
//    public String articleDetail() {
        int id = StringUtils.isEmpty(idStr) ? 0 : Integer.parseInt(idStr);
        Article article = service.getArticleById(id);
        Annex annexById = new Annex();
        if (!StringUtils.isEmpty(article)) {
            annexById = service.getAnnexById(article.getA_id());
        }
        article.setAnnex(annexById);
        request.setAttribute("entity", article);
        User user = (User) request.getSession().getAttribute(BureauConstants.USER_TOKEN);
        boolean is_super = false;
        if (user != null) {
            int user_id = user.getId();
            is_super = service.validateIsSuper(user_id);
        }
        request.setAttribute("is_super", is_super);
        request.setAttribute("type", type);
        request.setAttribute("fromSite", fromSite);
        request.setAttribute("siteId", siteId);
        return "article-detail";
    }

    @RequestMapping(value = "/getLoadData/{article_id}", method = RequestMethod.POST)
    @ResponseBody
    public String getLoadData(@PathVariable("article_id") int article_id,
                              @RequestBody Department department) {
        Map<String, Object> map = new HashMap<>();
        //获取所有部门，已经签收status为1  未签收为0
        List<Department> signDeps = departmentService.getSignDeps(article_id, department);
        map.put("list", signDeps);
        map.put("success", true);
        map.put("obj", department);
        return JSON.toJSONString(map);
    }

    /**
     * 签收功能
     * id  文章id
     *
     * @return
     */
    @RequestMapping("/sign")
    @ResponseBody
    public Map<String, Object> sign(@RequestParam("dep_id") int dep_id,
                                    @RequestParam("article_id") int article_id,
                                    @RequestParam("type") String type) {
        //检查用户是否登录  如果登录查询到属于的部门Id 存入签收关系表
        Map<String, Object> map = new HashMap<>();
        User user = (User) request.getSession().getAttribute(BureauConstants.USER_TOKEN);
        map = service.sign(user, dep_id, article_id, type);
        return map;
    }

    @RequestMapping("/signForward")
    public String signForward(@RequestParam(value = "article_id", required = false) int article_id) {
        return "sigin_login";
    }

    @RequestMapping("/signLogin")
    @ResponseBody
    public Map<String, Object> signLogin(@RequestParam("userName") String userName,
                                         @RequestParam("password") String password) {
        Map<String, Object> map = new HashMap<>();
        Object attribute = request.getSession().getAttribute(BureauConstants.USER_TOKEN);
        if (attribute != null) {
            map.put("success", true);
            return map;
        }

        User UserFromPage = new User();
        /**
         * 用户名和密码加密  Base64
         */
        UserFromPage.setUserName(userName);
        User user = userService.getUserByName(UserFromPage);
        if (user != null && user.getPassword().equals(password)) {
            //如果用户不为空  存session 否则跳转到注册页面或者去首页（非登录状态）
            request.getSession().setAttribute(BureauConstants.USER_TOKEN, user);
            map.put("success", true);
            return map;
        }
        map.put("success", false);
        map.put("message", "用户名或者密码错误，请重试");
        return map;
    }

    /**
     * 工作动态
     *
     * @return
     */
    @RequestMapping("/work")
    public String work() {
        return "list_pic";
    }

    /**
     * 工作动态
     *
     * @return
     */
    @RequestMapping("/zzdj")
    public String zzdj() {
        return "advice";
    }

    /**
     * 工作动态
     *
     * @return
     */
    @RequestMapping("/hyjy")
    public String hyjy() {
        System.out.println("insert into work");
        return "list_pic";
    }

    /**
     * 工作动态
     *
     * @return
     */
    @RequestMapping("/mtyq")
    public String mtyq() {
        System.out.println("insert into work");
        return "advice";
    }

    /**
     * 工作动态
     *
     * @return
     */
    @RequestMapping("/bmgz")
    public String bmgz() {
        System.out.println("insert into work");
        return "list_pic";
    }

    /**
     * 工作动态
     *
     * @return
     */
    @RequestMapping("/jjfc")
    public String jjfc() {
        System.out.println("insert into work");
        return "advice";
    }

    /**
     * 工作动态
     *
     * @return
     */
    @RequestMapping("/manager")
    public String manager() {
        String result = "login";
        User userToken = (User) request.getSession().getAttribute(BureauConstants.USER_TOKEN);
        if (userToken != null) {
            result = "manager/index";
        }
        return result;
    }

    /**
     * 工作动态
     *
     * @return
     */
    @RequestMapping("/jqkx")
    public String jqkx() {
        System.out.println("insert into work");
        return "list_pic";
    }

    /**
     * 通知通报
     *
     * @return
     */
    @RequestMapping("/advice")
    public String advice() {
        return "advice";
    }

    @RequestMapping("/test")
    public String test() {
        return "redirect:index";
    }

    /**
     * 根据首页图片id跳转到该图片对应的网站专栏的详情
     *
     * @param imageId 图片的id
     * @return
     */
    @RequestMapping("/siteDetailForward")
    public String siteDetailForward(@RequestParam("id") Integer imageId) {
        //根据图片id获取到对应的站点id
        int siteId = siteService.selectSiteIdByImageId(imageId);
        /**
         *  网站专栏站点中需要的数据
         *  1.左侧菜单栏中的模块显示，根据模块的id 查询 对应的文章列表，点击文章列表进入文章详情
         */
        List<Dict> dictByType = dictService.getDictByType(DictTypeEnum.DICT_TYPE_ENUM_CHILDCATEGORY.getCode());
        request.getSession().setAttribute("list", dictByType);
        request.getSession().setAttribute("siteId", siteId);
        return "site_detail";
    }

    @RequestMapping("/siteDetailForwardBySiteId")
    public String siteDetailForwardBySiteId(@RequestParam("id") Integer siteId) {
        List<Dict> dictByType = dictService.getDictByType(DictTypeEnum.DICT_TYPE_ENUM_CHILDCATEGORY.getCode());
        request.getSession().setAttribute("list", dictByType);
        request.getSession().setAttribute("siteId", siteId);
        return "site_detail";
    }

}
