package com.lixc.bureau.controller;

import com.alibaba.fastjson.JSON;
import com.lixc.bureau.constants.BureauConstants;
import com.lixc.bureau.entity.*;
import com.lixc.bureau.service.IIndexService;
import com.lixc.bureau.service.IManagerService;
import com.lixc.bureau.util.EduResult;
import org.apache.tomcat.util.http.fileupload.ProgressListener;
import org.apache.tomcat.util.http.fileupload.disk.DiskFileItemFactory;
import org.apache.tomcat.util.http.fileupload.servlet.ServletFileUpload;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.ResponseEntity;
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

@Controller
@RequestMapping("/manager")
public class ManagerController extends BaseController {

    public static final Logger logger = LoggerFactory.getLogger(ManagerController.class);

    @Value("")
    private String downloadPath;

//    //文件保存路径
//    @Value("${bureau.path.savePath}")
//    private String savePath;
//    //临时文件存储目录
//    @Value("${bureau.path.tempPath}")
//    private String tempPath;

    @Autowired
    private IManagerService managerService;

    @Autowired
    private IIndexService indexService;

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
            e.printStackTrace();
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
            e.printStackTrace();
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
        eduResult = managerService.addArticle(article, ut.getId(), ids);
        return eduResult;

    }


    @RequestMapping("/uploadFile")
    @ResponseBody
    public String uploadFile(HttpServletRequest request, MultipartFile file) {
        this.map = new HashMap<>();
        String savePath = request.getServletContext().getRealPath("/WEB-INF/upload");
        logger.info("存储路径:" + savePath);
        //上传时生成的临时文件保存目录
        String tempPath = request.getServletContext().getRealPath("/WEB-INF/temp");
        File toFile = new File(tempPath);
        if (!toFile.exists() && !toFile.isDirectory()) {
            logger.error("目录或文件不存在！");
            toFile.mkdir();
        }
        //消息提示
        String message = "";
        try {
            //使用Apache文件上传组件处理文件上传步骤：
            //1、创建一个DiskFileItemFactory工厂
            DiskFileItemFactory diskFileItemFactory = new DiskFileItemFactory();
            //设置工厂的缓冲区的大小，当上传的文件大小超过缓冲区的大小时，就会生成一个临时文件存放到指定的临时目录当中。
            diskFileItemFactory.setSizeThreshold(1024 * 100);
            //设置上传时生成的临时文件的保存目录
            diskFileItemFactory.setRepository(toFile);
            //2、创建一个文件上传解析器
            ServletFileUpload fileUpload = new ServletFileUpload(diskFileItemFactory);
            //解决上传文件名的中文乱码
            fileUpload.setHeaderEncoding("UTF-8");
            //监听文件上传进度
            fileUpload.setProgressListener(new ProgressListener() {
                public void update(long pBytesRead, long pContentLength, int arg2) {
                    logger.info("文件大小为：" + pContentLength + ",当前已处理：" + pBytesRead);
                }
            });
            //3、判断提交上来的数据是否是上传表单的数据
//            if(!fileUpload.isMultipartContent(request)){
//                //按照传统方式获取数据
//                return;
//            }
            //设置上传单个文件的大小的最大值，目前是设置为1024*1024字节，也就是1MB
//            fileUpload.setFileSizeMax(1024 * 1024);
            //设置上传文件总量的最大值，最大值=同时上传的多个文件的大小的最大值的和，目前设置为10MB
//            fileUpload.setSizeMax(1024 * 1024 * 10);
            //4、使用ServletFileUpload解析器解析上传数据，解析结果返回的是一个List<FileItem>集合，每一个FileItem对应一个Form表单的输入项
            //如果fileitem中封装的是普通输入项的数据
            //如果fileitem中封装的是上传文件，得到上传的文件名称，
            String fileName = file.getOriginalFilename();
            String originName = file.getOriginalFilename();
            logger.info(fileName);
            //注意：不同的浏览器提交的文件名是不一样的，有些浏览器提交上来的文件名是带有路径的，如：  c:\a\b\1.txt，而有些只是单纯的文件名，如：1.txt
            //处理获取到的上传文件的文件名的路径部分，只保留文件名部分
            fileName = fileName.substring(fileName.lastIndexOf(File.separator) + 1);
            //得到上传文件的扩展名
//                    String fileExtName = fileName.substring(fileName.lastIndexOf(".")+1);
//                    if("zip".equals(fileExtName)||"rar".equals(fileExtName)||"tar".equals(fileExtName)||"jar".equals(fileExtName)){
//                        request.setAttribute("message", "上传文件的类型不符合！！！");
//                        request.getRequestDispatcher("/message.jsp").forward(request, response);
//                        return;
//                    }
//                    //如果需要限制上传的文件类型，那么可以通过文件的扩展名来判断上传的文件类型是否合法
//                    System.out.println("上传文件的扩展名为:"+fileExtName);
            //获取item中的上传文件的输入流
            outPutToDestFile(file, savePath, fileName,"1");
//            InputStream fis = file.getInputStream();
//            //得到文件保存的名称
//            fileName = mkFileName(fileName);
//            //得到文件保存的路径
            String savePathStr = mkFilePath(savePath, fileName);
//            logger.info("保存路径为:" + savePathStr);
//            //创建一个文件输出流
//            FileOutputStream fos = new FileOutputStream(savePathStr + File.separator + fileName);
//            //获取读通道
//            FileChannel readChannel = ((FileInputStream) fis).getChannel();
//            //获取读通道
//            FileChannel writeChannel = fos.getChannel();
//            //创建一个缓冲区
//            ByteBuffer buffer = ByteBuffer.allocate(1024);
//            //判断输入流中的数据是否已经读完的标识
//            int length = 0;
//            //循环将输入流读入到缓冲区当中，(len=in.read(buffer))>0就表示in里面还有数据
//            while (true) {
//                buffer.clear();
//                int len = readChannel.read(buffer);//读入数据
//                if (len < 0) {
//                    break;//读取完毕
//                }
//                buffer.flip();
//                writeChannel.write(buffer);//写入数据
//            }
//            //关闭输入流
//            fis.close();
//            //关闭输出流
//            fos.close();
            Annex annex = new Annex();
            annex.setFileName(originName);
            annex.setSaveName(fileName);
            annex.setUrl(savePathStr);
            int i = managerService.addAnnex(annex);
            map.put("result", annex.getId());
            map.put("success", true);
        } catch (Exception e) {
            e.printStackTrace();
            map.put("msg", "异常！");
            map.put("success", false);

        }
        return JSON.toJSONString(map);
    }

    //生成上传文件的文件名，文件名以：uuid+"_"+文件的原始名称
    public String mkFileName(String fileName) {
        return UUID.randomUUID().toString() + "_" + fileName;
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

//            saveName = new String(saveName.getBytes("iso8859-1"),"UTF-8");
            //上传的文件都是保存在/WEB-INF/upload目录下的子目录当中
            String fileSaveRootPath = request.getServletContext().getRealPath("/WEB-INF/upload");
            //        处理文件名
            String fileName = saveName.substring(saveName.indexOf("_") + 1);
//            fileName = new String(fileName.getBytes("iso8859-1"),"UTF-8");
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
                os.write(bytes);
            }
            //关闭输入流
            in.close();
            //关闭输出流
            os.close();
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
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
    public String editArticleForward(ModelMap modelMap, @RequestParam("id") int id) {
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
            e.printStackTrace();
            map.put("success", false);
            map.put("message", "获取图片列表异常");
        }
        return JSON.toJSONStringWithDateFormat(map, "yyyy-MM-dd");
    }

    @RequestMapping("/addImageForward")
    public String addImageForward() {
        return "manager/image_add";
    }

    // 添加图片
    @RequestMapping("/addImage")
    @ResponseBody
    public String addImage(HttpServletRequest request, MultipartFile file) {
        this.map = new HashMap<>();
        //记录提示信息
        String message = "";
        try {
            long size = file.getSize();
            String name = file.getOriginalFilename();
            //从文件中读取输入流 输入到指定目录中
            String fileName = System.currentTimeMillis() + file.getOriginalFilename();
            //存储到文件表中，列表展示时，只展示前四个，根据时间倒叙排序
            String savePath = request.getServletContext().getRealPath("/images");
            String url = savePath + File.separator + fileName;
            File destFile = new File(url);
            if (!destFile.exists()) {
                destFile.mkdirs();
            }
            outPutToDestFile(file, savePath, fileName,"2");
//            file.transferTo(destFile);
            ImageEntity entity = new ImageEntity();
            entity.setName(mkFileName(fileName));
            entity.setUrl(url);
            entity.setChecked("N");
            managerService.addImage(entity);
            message = "上传成功";
            map.put("success", true);
            map.put("message", message);
            map.put("url", url);

        } catch (Exception e) {
            e.printStackTrace();
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
    private String outPutToDestFile(MultipartFile file, String savePathStr, String fileName,String flag) {
        try {
            InputStream fis = file.getInputStream();
             fileName =  "1".equalsIgnoreCase(flag) ? mkFileName(fileName):fileName ;
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
        return mkFileName(fileName);
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
            } else {
                map.put("success", false);
                map.put("message", "删除图片失败");
            }

        } catch (Exception e) {
            e.printStackTrace();
            map.put("success", false);
            map.put("message", "删除图片异常");
        }
        return JSON.toJSONStringWithDateFormat(map, "yyyy-MM-dd");
    }
}
