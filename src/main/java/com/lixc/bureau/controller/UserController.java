package com.lixc.bureau.controller;

import com.alibaba.fastjson.JSON;
import com.lixc.bureau.constants.BureauConstants;
import com.lixc.bureau.entity.User;
import com.lixc.bureau.service.IUserService;
import org.slf4j.LoggerFactory;
import org.slf4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.List;


@Controller
@RequestMapping("/user")
public class UserController extends BaseController {

    private static final Logger logger = LoggerFactory.getLogger(UserController.class);

    @Autowired
    private IUserService userService;

    @RequestMapping("/login")
    @ResponseBody
    public String login(@RequestParam("userName") String userName,
                        @RequestParam("password") String password) {
        map = new HashMap<>();
        User UserFromPage = new User();
        /**
         * 用户名和密码加密  Base64
         */
        UserFromPage.setUserName(userName);
        User user = userService.getUserByName(UserFromPage);
        if (user != null && user.getPassword().equals(password)) {
            //如果用户不为空  存session 否则跳转到注册页面或者去首页（非登录状态）
            request.getSession().setAttribute(BureauConstants.USER_TOKEN, user);
            map.put("success",true);
        }else{
            map.put("success",false);
            map.put("msg","用户名或者密码错误，请重试");
        }
        return JSON.toJSONString(map);
    }

//    @RequestMapping("/register")
//    public String register(@RequestParam("user") User user) {
//        logger.info(">>>>>>>>>>>>  register start");
//        try {
//            User user1 = userService.getUserByName(user);
//            if (StringUtils.isEmpty(user1)) {
//                throw new Exception("此用户已经注册过了；用户名：" + user.getUserName());
//            }
//        } catch (Exception e) {
//            e.printStackTrace();
//            logger.info(e.getMessage());
//        }
//        logger.info(">>>>>>>>>>>>  register start");
//        return "success";
//    }

    @RequestMapping("/loginforward")
    public String loginforward() {
        return "login";
    }

    /**
     *
     * @return
     */
    @RequestMapping("/logout")
    public String logout() {
        request.getSession().removeAttribute(BureauConstants.USER_TOKEN);
        request.getSession().invalidate();
        return "redirect:/index";
    }

    @RequestMapping("/getAllUsers")
    public String getAllUsers(@RequestBody User user) {
        map = new HashMap<>();
        try {
            List<User> allUsers = userService.getAllUsers(user);
            map.put("success", true);
            map.put("list", allUsers);
        } catch (Exception e) {
            map.put("success", true);
            map.put("message", "获取用户列表失败");
        }
        return JSON.toJSONString(map);
    }
    @RequestMapping("/addUser")
    public String addUser(@RequestBody User user){
        map = new HashMap<>();
        try {
           int result = userService.addUsers(user);
            map.put("success", true);
            map.put("message", "添加成功");
        } catch (Exception e) {
            map.put("success", true);
            map.put("message", "添加用户失败");
        }
        return JSON.toJSONString(map);
    }
}

