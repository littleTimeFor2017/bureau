package com.lixc.bureau.controller;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.lixc.bureau.entity.DueEntity;
import com.lixc.bureau.service.IDueService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

@Controller
@RequestMapping("/due")
public class DueController extends BaseController {

    @Autowired
    private IDueService dueService;

    @RequestMapping("/getDueList")
    @ResponseBody
    public String getDueList(@RequestParam("type") String type) {
        map = new HashMap<>();
       try{
           List list = new ArrayList();
           list = dueService.getDueList(type);
           map.put("success",true);
           map.put("list",list);
       }catch (Exception e){
           e.printStackTrace();
           map.put("success",false);
           map.put("message","获取值班记录失败");
       }
        return JSON.toJSONStringWithDateFormat(map, "yyyy-MM-dd");
    }

    @RequestMapping("/dueForward")
    public String dueForward() {
        return "manager/due";
    }

    @RequestMapping("/addDueForward")
    public String addDueForward() {
        return "manager/due_add";
    }

    @RequestMapping(value = "/addDue", method = RequestMethod.POST)
    @ResponseBody
    public String addDue(@RequestParam("jsonStr") String jsonStr) {
        try {
            map = new HashMap<>();
            List<DueEntity> list = (List) JSONObject.parseArray(jsonStr);
            dueService.addDue(list);
            map.put("success", true);
            map.put("message", "添加值班成功");
        } catch (Exception e) {
            e.printStackTrace();
            map.put("success", false);
            map.put("message", "添加值班失败");
        }
        return JSON.toJSONString(map);
    }

    @RequestMapping("/editDueForward")
    public String editDueForward() {
        return "manager/due_add";
    }

    @RequestMapping(value = "/editDue", method = RequestMethod.POST)
    @ResponseBody
    public String editDue(@RequestBody  List<DueEntity> list) {
//    public String editDue(@RequestParam ("data") String jsonStr) {
        System.out.println(list);
        try {
            map = new HashMap<>();
            dueService.editDue(list);
            map.put("success", true);
            map.put("message", "保存成功");
        } catch (Exception e) {
            e.printStackTrace();
            map.put("success", false);
            map.put("message", "保存失败");
        }
        return JSON.toJSONString(map);
    }
}
