package com.lixc.bureau.service;

import com.lixc.bureau.entity.Annex;
import com.lixc.bureau.entity.Article;
import com.lixc.bureau.entity.CategoryEntity;
import com.lixc.bureau.entity.ImageEntity;
import com.lixc.bureau.util.EduResult;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

public interface IManagerService {

    List<CategoryEntity> getAllCategorise();

    /**
     * 根据type获取二级菜单
     * @param type  当前菜单类型
     * @return
     */
    List<CategoryEntity> getCategoryListByType(String type);

    CategoryEntity getCategoryEntityById(int id);

    CategoryEntity getCategoryEntityByType(String type);

    List<Article> getArticleListByCID(Article article);

    EduResult addArticle(Article article, int user_id, String ids);

    void addArticleOnly(Article article);

    EduResult editArticle(Article article, int user_id, String ids);

    EduResult delArticle(Article article, int user_id);

    int addAnnex(Annex annex);

    List<ImageEntity> getImageList(ImageEntity imageEntity);

    ImageEntity editImageForward(int id);

    int delImage(int id);

    int addImage(ImageEntity imageEntity);
}
