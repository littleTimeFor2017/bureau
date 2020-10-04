package com.lixc.bureau.dao;

import com.lixc.bureau.entity.Site;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * @className: ISiteDAO
 * @description: 网站专栏
 * @Author: Wilson
 * @createTime 2020/9/22 11:05
 */
@Mapper
public interface ISiteDAO {
    int insert(Site site);

    int insertSelective(Site site);

    int deleteById(Integer id);

    int updateSelective(Site record);

    List<Site> selectForList(Site site);
    int selectForListCount(Site site);

    Site selectOne(Integer id);

    List<Site> selectByImageId(Integer id);


    int selectSiteIdByImageId(@Param("imageId")int imageId);
}
