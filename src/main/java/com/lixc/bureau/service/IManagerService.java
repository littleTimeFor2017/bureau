package com.lixc.bureau.service;

import com.lixc.bureau.entity.Annex;
import com.lixc.bureau.entity.Article;
import com.lixc.bureau.entity.CategoryEntity;
import com.lixc.bureau.util.EduResult;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

public interface IManagerService {

    List<CategoryEntity> getAllCategorise();

    CategoryEntity getCategoryEntityById(int id);

    CategoryEntity getCategoryEntityByType(String type);

    List<Article> getArticleListByCID(Article article);

    EduResult addArticle(Article article, int user_id, String ids);

    EduResult editArticle(Article article, int user_id, String ids);

    EduResult delArticle(Article article, int user_id);

    int addAnnex(Annex annex);
}
