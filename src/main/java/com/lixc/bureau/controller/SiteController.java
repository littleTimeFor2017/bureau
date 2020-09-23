package com.lixc.bureau.controller;

import com.alibaba.fastjson.JSON;
import com.lixc.bureau.back.SiteBack;
import com.lixc.bureau.constants.BureauConstants;
import com.lixc.bureau.entity.SysSite;
import com.lixc.bureau.entity.User;
import com.lixc.bureau.query.SiteQuery;
import com.lixc.bureau.service.IManagerService;
import com.lixc.bureau.service.ISiteService;
import com.lixc.bureau.service.IThumbnailService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.nio.ByteBuffer;
import java.nio.channels.FileChannel;
import java.util.HashMap;
import java.util.List;

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
    private IThumbnailService thumbnailService;


    @Autowired
    private IManagerService managerService;

    /**
     * 查询专栏列表
     *
     * @return
     */
    @RequestMapping("/list")
    public String list(@RequestBody SysSite site) {
        List<SysSite> list = siteService.list(site);
        return JSON.toJSONString(list);
    }

    /**
     * 添加网站专栏设置
     *
     * @return
     */
    @RequestMapping("/addForward")
    public String addForward() {
        return "manager/site_add";
    }

    /**
     * 添加网站专栏设置
     *
     * @return
     */
    @RequestMapping("/add")
    @ResponseBody
    public String add(@RequestBody SysSite siteQuery, @RequestParam("file") MultipartFile file) {
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
            //从文件中读取输入流 输入到指定目录中
            String fileName = System.currentTimeMillis() + file.getOriginalFilename();
            String url = savePath + File.separator + fileName;
            //生成图片
            outPutToDestFile(file, savePath, fileName, "2");
            //生成缩略图 路径
            String thumURL = thumbnailService.thumbnail(file, savePath);
            siteQuery.setUrl(url);
            siteQuery.setThumbUrl(thumURL);
            siteService.add(siteQuery, ut.getId());
            map.put("success", true);
        } catch (Exception e) {
            log.error("网站专栏添加异常：" + e.getLocalizedMessage());
            map.put("success", false);
            map.put("message", "网站专栏添加异常!");
        }
        return JSON.toJSONString(map);
    }

    /**
     * @param file        需要上传的文件对象
     * @param savePathStr 保存路径地址
     * @param fileName    文件名称
     */
    private String outPutToDestFile(MultipartFile file, String savePathStr, String fileName, String flag) {
        try {
            InputStream fis = file.getInputStream();
//             fileName =  "1".equalsIgnoreCase(flag) ? mkFileName(fileName):fileName ;
            //得到文件保存的名称
            FileOutputStream fos = new FileOutputStream(savePathStr + File.separator + fileName);
            //获取读通道
            FileChannel readChannel = ((FileInputStream) fis).getChannel();
            //获取读通道
            FileChannel writeChannel = fos.getChannel();
            //创建一个缓冲区
            ByteBuffer buffer = ByteBuffer.allocate(1024);
            //判断输入流中的数据是否已经读完的标识
            int length = 0;
            //循环将输入流读入到缓冲区当中，(len=in.read(buffer))>0就表示in里面还有数据
            while (true) {
                buffer.clear();
                int len = readChannel.read(buffer);//读入数据
                if (len < 0) {
                    break;//读取完毕
                }
                buffer.flip();
                writeChannel.write(buffer);//写入数据
            }
            //关闭输入流
            fis.close();
            //关闭输出流
            fos.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return fileName;
    }

    /**
     * 添加网站专栏设置
     *
     * @return
     */
    @RequestMapping("/updateForward")
    public String updateForward(@RequestParam("id") int id) {
        SysSite detail = siteService.detail(id);
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
    public String update(@RequestBody SysSite site) {
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
