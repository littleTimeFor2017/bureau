package com.lixc.bureau.controller;

import com.alibaba.fastjson.JSON;
import com.lixc.bureau.service.IDepartmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;

@Controller
@RequestMapping("/dep")
public class DepController extends BaseController {

    @Autowired
    private IDepartmentService departmentService;

    //获取所有的部门  显示在添加公告页面
    @RequestMapping("/getAllDeps")
    @ResponseBody
    public String getAllDeps(){
        map = new HashMap<>();
        try{
            map.put("success",true);
            map.put("list",departmentService.getAllDeps());
        }catch (Exception e){
            map.put("success",false);
            map.put("mesasge","未知异常");
        }
        return JSON.toJSONString(map);
    }


    @RequestMapping("/getAllDepsWithStatus")
    @ResponseBody
    public String  getAllDepsWithStatus(@RequestParam("article_id")int article_id){
        map = new HashMap<>();
        try{
            map.put("success",true);
            map.put("list",departmentService.getAllDepsWithStatus(article_id));
        }catch (Exception e){
            map.put("success",false);
            map.put("mesasge","未知异常");
        }
        return JSON.toJSONString(map);
    }




}
