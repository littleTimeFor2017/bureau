package com.lixc.bureau.dao;

import com.lixc.bureau.entity.Annex;
import com.lixc.bureau.entity.Article;
import com.lixc.bureau.entity.CategoryEntity;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.dao.DataAccessException;

import java.sql.Blob;
import java.util.List;

@Mapper
public interface IArticleDAO {


    CategoryEntity getCategoryEntityById(int id);
    CategoryEntity getCategoryEntityByType(String type);


    List<Article> getArticals(@Param("mod") String mod,@Param("c_id") int c_id) throws DataAccessException;
    List<Article> getCareList(@Param("mod") String mod,@Param("c_id") int c_id) throws DataAccessException;
    List<Article> getAllArticlesByCid(Article article) throws DataAccessException;
    int getAllArticleCountByCid(@Param("c_id") int c_id) throws DataAccessException;

    Article getArticleById(int id) throws DataAccessException;
    Annex getAnnexById(int id) throws DataAccessException;

    List<CategoryEntity> getAllCategorise() throws DataAccessException;

    List<Article> getArticleListByCID(Article article);

    int addArticle(Article article);

    int editArticle(@Param("article") Article article,
                    @Param("user_id") int user_id);

    int updateArticle(@Param("article") Article article,
                      @Param("user_id") int user_id);



    int addAnnex(Annex annex);
}
