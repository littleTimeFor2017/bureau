package com.lixc.bureau.controller;

import com.alibaba.fastjson.JSON;
import com.lixc.bureau.constants.BureauConstants;
import com.lixc.bureau.entity.*;
import com.lixc.bureau.enums.DictTypeEnum;
import com.lixc.bureau.service.*;
import com.lixc.bureau.util.EduResult;
import lombok.extern.slf4j.Slf4j;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.net.URLEncoder;
import java.nio.ByteBuffer;
import java.nio.channels.FileChannel;
import java.util.*;

@Slf4j
@Controller
@RequestMapping("/manager")
public class ManagerController extends BaseController {

    public static final Logger logger = LoggerFactory.getLogger(ManagerController.class);

    @Value("")
    private String downloadPath;

    //文件保存路径
    @Value("${bureau.path.savePath}")
    private String savePath;

    @Autowired
    private IManagerService managerService;

    @Autowired
    private IIndexService indexService;

    @Autowired
    private IThumbnailService thumbnailService;

    @RequestMapping("/index")
    public String index() {
        return "manager/index";
    }

    //获取分组
    @RequestMapping("/getAllCategorys")
    @ResponseBody
    public Map<String, Object> getAllCategorys() {
        logger.info("insert  into  getAllCategorys");
        Map<String, Object> map = new HashMap<>();
        try {
            List<CategoryEntity> allCategorise = managerService.getAllCategorise();
            if (allCategorise != null && allCategorise.size() > 0) {
                map.put("list", allCategorise);
                map.put("success", true);
            }
        } catch (Exception e) {
            log.error(e.getLocalizedMessage());
            map.put("success", false);

        }
        return map;
    }

    //    跳转到工作动态列表页
    @RequestMapping("/gzdtForward")
    public String gzdtForward(@RequestParam("id") int id) {
        CategoryEntity categoryEntityById = managerService.getCategoryEntityById(id);
        request.setAttribute("categoryEntity", categoryEntityById);
        return "manager/gzdt";
    }




    /**
     * 获取工作动态列表数据json
     * 获取
     */
    @RequestMapping(value = "/gzdtListJson", method = RequestMethod.POST)
    @ResponseBody
    public String gzdtListJson(@RequestBody Article article) {
        Map<String, Object> map = new HashMap<>();
        try {
            List<Article> list = managerService.getArticleListByCID(article);
            map.put("success", true);
            map.put("list", list);
            map.put("obj", article);
        } catch (Exception e) {
            log.error(e.getLocalizedMessage());
            map.put("success", false);
            map.put("message", "获取工作动态数据列表异常");
        }
        return JSON.toJSONStringWithDateFormat(map, "yyyy-MM-dd");
    }

    /**
     * 添加跳转
     */
    @RequestMapping("/addArticleForward")
    public String addArticleForward(ModelMap modelMap, @RequestParam("c_id") int c_id) {
        request.getSession().setAttribute("c_id", c_id);
        modelMap.put("c_id", c_id);
        return "manager/gzdt_add";
    }

    @RequestMapping(value = "/addArticle/{ids}", method = RequestMethod.POST)
    @ResponseBody
    public EduResult addArticle(HttpServletRequest request,
                                @RequestBody Article article,
                                @PathVariable("ids") String ids
    ) {
        EduResult eduResult = new EduResult();
        User ut = (User) request.getSession().getAttribute(BureauConstants.USER_TOKEN);
        if (ut == null) {
            eduResult.put("success", false);
            eduResult.put("msg", "您无权查看！");
            return eduResult;
        }
        article.setIs_site("N");
        eduResult = managerService.addArticle(article, ut.getId(), ids);
        return eduResult;

    }

    /**
     * 上传文件方法
     *
     * @param request
     * @param file
     * @return
     */
    public String uploadImage(HttpServletRequest request, MultipartFile file) {
        return null;
    }


    @RequestMapping("/uploadFile")
    @ResponseBody
    public String uploadFile(HttpServletRequest request, MultipartFile file) {
        this.map = new HashMap<>();
        String savePath = request.getServletContext().getRealPath("/WEB-INF/upload");
        logger.info("存储路径:" + savePath);
        //消息提示
        String message = "";
        try {
            String fileName = file.getOriginalFilename();
            String originName = file.getOriginalFilename();
            logger.info(fileName);
            //注意：不同的浏览器提交的文件名是不一样的，有些浏览器提交上来的文件名是带有路径的，如：  c:\a\b\1.txt，而有些只是单纯的文件名，如：1.txt
            //处理获取到的上传文件的文件名的路径部分，只保留文件名部分
            fileName = fileName.substring(fileName.lastIndexOf(File.separator) + 1);
            //确定文件上传的具体路径   /1/12
            String savePathStr = mkFilePath(savePath, fileName);
            //获取item中的上传文件的输入流
            outPutToDestFile(file, savePathStr, fileName, "1");
            Annex annex = new Annex();
            annex.setFileName(originName);
            annex.setSaveName(fileName);
            annex.setUrl(savePathStr);
            int i = managerService.addAnnex(annex);
            map.put("result", annex.getId());
            map.put("success", true);
        } catch (Exception e) {
            log.error(e.getLocalizedMessage());
            map.put("msg", "异常！");
            map.put("success", false);
        }
        return JSON.toJSONString(map);
    }

    public String mkFilePath(String savePath, String fileName) {
        //得到文件名的hashCode的值，得到的就是filename这个字符串对象在内存中的地址
        int hashcode = fileName.hashCode();
        int dir1 = hashcode & 0xf;
        int dir2 = (hashcode & 0xf0) >> 4;
        //构造新的保存目录
        String dir = savePath + "\\" + dir1 + "\\" + dir2;
        //File既可以代表文件也可以代表目录
        File file = new File(dir);
        if (!file.exists()) {
            file.mkdirs();
        }
        return dir;
    }

    @RequestMapping("/download")
    public String download(HttpServletRequest request, HttpServletResponse response, @RequestParam("id") int id) {
        try {
            Annex annex = indexService.getAnnexById(id);
            //获取id，通过id获取各种参数  fileName,saveName,url;
            String saveName = annex.getSaveName();

            String fileSaveRootPath = request.getServletContext().getRealPath("/WEB-INF/upload");
            //        处理文件名
            String fileName = saveName.substring(saveName.indexOf("_") + 1);
            //通过文件名找出文件的所在目录
            String path = findFileSavePathByFileName(saveName, fileSaveRootPath);
            //得到要下载的文件
            File file = new File(path + File.separator + saveName);
            //如果文件不存在
            if (!file.exists()) {
                //文件不存在处理
            }
            //设置响应头，控制浏览器下载该文件
            response.setHeader("content-disposition", "attachment;filename=" + URLEncoder.encode(fileName, "UTF-8"));
            //读取要下载的文件，保存到文件输入流
            FileInputStream in = new FileInputStream(path + File.separator + saveName);
            //创建输出流
            OutputStream os = response.getOutputStream();
            //设置缓存区
            byte[] bytes = new byte[1024];
            int len = 0;
            while ((len = in.read(bytes)) > 0) {
                os.write(bytes, 0, len);
            }
            //关闭输入流
            in.close();
            //关闭输出流
            os.close();
        } catch (UnsupportedEncodingException e) {
            log.error(e.getLocalizedMessage());
        } catch (FileNotFoundException e) {
            log.error(e.getLocalizedMessage());
        } catch (IOException e) {
            log.error(e.getLocalizedMessage());
        }
        return null;

    }

    public String findFileSavePathByFileName(String fileName, String fileSaveRootPath) {
        int hashcode = fileName.hashCode();
        int dir1 = hashcode & 0xf;
        int dir2 = (hashcode & 0xf0) >> 4;
        String dir = fileSaveRootPath + "\\" + dir1 + "\\" + dir2;
        File file = new File(dir);
        if (!file.exists()) {
            file.mkdirs();
        }
        return dir;
    }

    /**
     * 编辑跳转
     */
    @RequestMapping("/editArticleForward")
    public String editArticleForward(@RequestParam("id") int id) {
        Article articleById = indexService.getArticleById(id);
        Annex annexById = indexService.getAnnexById(articleById.getA_id());
        articleById.setAnnex(annexById);
        request.getSession().setAttribute("article", articleById);
        return "manager/gzdt_edit";
    }

    @PostMapping("/editArticle/{ids}")
    @ResponseBody
    public EduResult editArticle(@RequestBody Article article, @PathVariable("ids") String ids) {
        EduResult eduResult = new EduResult();
        User ut = (User) request.getSession().getAttribute(BureauConstants.USER_TOKEN);
        if (ut == null) {
            eduResult.put("success", false);
            eduResult.put("msg", "登录信息已经失效，请退出后重新登录！");
            return eduResult;
        }
        eduResult = managerService.editArticle(article, ut.getId(), ids);
        return eduResult;
    }

    /**
     * 修改文章状态为已删除
     *
     * @return
     */
    @RequestMapping("/delArticle")
    @ResponseBody
    public EduResult delArticle(@RequestParam("id") int id) {
        EduResult eduResult = new EduResult();
        Article article = indexService.getArticleById(id);
        if (article == null) {
            eduResult.put("success", false);
            eduResult.put("msg", "数据对象不存在！");
            return eduResult;
        }
        User ut = (User) request.getSession().getAttribute(BureauConstants.USER_TOKEN);
        if (ut == null) {
            eduResult.put("success", false);
            eduResult.put("msg", "您无权查看！");
            return eduResult;
        }
        article.setIs_deleted("Y");
        eduResult = managerService.delArticle(article, ut.getId());
        eduResult.put("success", true);
        return eduResult;
    }

    @RequestMapping("/uploadForward")
    public String uploadForward() {
        return "manager/upload_image";
    }

    /**
     * 加载图片列表
     */
    @ResponseBody
    @RequestMapping("/imageListJson")
    public String imageListJson(@RequestBody ImageEntity imageEntity) {
        List<ImageEntity> list = new ArrayList<>();
        this.map = new HashMap<>();
        try {
            list = managerService.getImageList(imageEntity);
            map.put("success", true);
            map.put("list", list);
            map.put("obj", imageEntity);
        } catch (Exception e) {
            log.error(e.getLocalizedMessage());
            map.put("success", false);
            map.put("message", "获取图片列表异常");
        }
        return JSON.toJSONStringWithDateFormat(map, "yyyy-MM-dd");
    }


    @Autowired
    private DictService dictService;

    @Autowired
    private ISiteService siteService;

    @RequestMapping("/addImageForward")
    public String addImageForward() {
        //查询所有属于图片条件模块
        List<Dict> dictByType = dictService.getDictByType(DictTypeEnum.DICT_TYPE_ENUM_IMAGE.getCode());
        request.getSession().setAttribute("list", dictByType);
        return "manager/image_add";
    }

    // 添加图片
    @RequestMapping("/addImage")
    @ResponseBody
    public String addImage(HttpServletRequest request, MultipartFile file) {
        this.map = new HashMap<>();
        //记录提示信息
        String message = "";

        String[] useModel = request.getParameterValues("useModel");
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
            //存储到文件表中，列表展示时，只展示前四个，根据时间倒叙排序
//            String savePath = request.getServletContext().getRealPath("/WEB-INF/images");
            String url = savePath + File.separator + fileName;
            outPutToDestFile(file, savePath, fileName, "2");
            String thumURL = thumbnailService.thumbnail(file, savePath);
            ImageEntity entity = new ImageEntity();
            entity.setName(fileName);
            entity.setUrl(url);
            entity.setChecked("N");
            entity.setCreateBy(ut.getUserName());
            entity.setCreate_date(new Date());
            //每个对象生成一条记录，
            entity.setThumURL(thumURL);
            for (String id : useModel) {
                entity.setUse_position(Integer.parseInt(id));
                int imageId = managerService.addImage(entity);
                if (2 == Integer.parseInt(id)) {
                    //生成专栏设置表
                    Site site = new Site();
                    site.setIsShow("Y");
                    site.setImageId(imageId);
                    site.setCreateTime(new Date());
                    site.setCreateBy(ut.getId());
                    siteService.add(site);
                }
            }
            message = "上传成功";
            map.put("success", true);
            map.put("message", message);
            map.put("url", url);
        } catch (Exception e) {
            log.error(e.getLocalizedMessage());
            message = "上传失败";
            map.put("success", false);
            map.put("message", message);
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
//            FileOutputStream fos = new FileOutputStream(savePathStr);
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
            log.error(e.getLocalizedMessage());
        }
        return fileName;
    }

    @RequestMapping("/editImageForward")
    public String editImageForward(@RequestParam("id") int id) {
        ImageEntity image = managerService.editImageForward(id);
        request.setAttribute("entity", image);
        return "manager/image_edit";
    }


    @ResponseBody
    @RequestMapping("/delImage")
    public String delImage(@RequestParam("id") int id) {
        this.map = new HashMap<>();
        try {
            int flag = managerService.delImage(id);
            if (flag > 0) {
                map.put("success", true);
                map.put("message", "删除成功");
            } else {
                map.put("success", false);
                map.put("message", "删除图片失败");
            }

        } catch (Exception e) {
            log.error(e.getLocalizedMessage());
            map.put("success", false);
            map.put("message", "删除图片异常");
        }
        return JSON.toJSONStringWithDateFormat(map, "yyyy-MM-dd");
    }
}
