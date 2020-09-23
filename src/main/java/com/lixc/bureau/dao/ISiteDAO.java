package com.lixc.bureau.dao;

import com.lixc.bureau.entity.SysSite;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

/**
 * @className: ISiteDAO
 * @description: 网站专栏
 * @Author: Wilson
 * @createTime 2020/9/22 11:05
 */
@Mapper
public interface ISiteDAO {
    int insert(SysSite site);

    int insertSelective(SysSite site);

    int deleteById(Integer id);

    int updateSelective(SysSite record);

    List<SysSite> selectForList(SysSite sysSite);
    int selectForListCount(SysSite sysSite);

    SysSite selectOne(Integer id);


}
