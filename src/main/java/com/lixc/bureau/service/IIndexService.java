package com.lixc.bureau.service;

import com.lixc.bureau.entity.Annex;
import com.lixc.bureau.entity.Article;
import com.lixc.bureau.entity.ImageEntity;
import com.lixc.bureau.entity.User;

import java.util.List;
import java.util.Map;

/**
 * 首页service
 */
public interface IIndexService {

    /**
     * 查询所有的文章
     *
     * @param mod
     * @return
     */
    List<Article> getArticleList(String mod, int c_id);

    /**
     * 查询所有今日注意事项
     *
     * @param mod
     * @return
     */
    List<Article> getCareList(String mod, int c_id);
    /**
     * 分页查询分组下文章
     *
     * @param mod
     * @return
     */
    List<Article> getAllArticles(Article article, int c_id);

    List<ImageEntity> getImageList(int use_position);




    /**
     * 根据ID查询对象
     *
     * @param id
     * @return
     */
    Article getArticleById(int id);


    Annex getAnnexById(int id);


    //签收功能
    Map<String, Object> sign(User user, int dep_id, int article_id, String type);

    boolean validateIsSuper(int user_id);


}
