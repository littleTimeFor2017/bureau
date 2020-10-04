package com.lixc.bureau.dao;


import com.lixc.bureau.entity.Dict;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface DictMapper {
    List<Dict> getDictByType(@Param("type")Integer type);
}