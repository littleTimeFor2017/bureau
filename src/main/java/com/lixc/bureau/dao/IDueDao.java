package com.lixc.bureau.dao;

import com.lixc.bureau.entity.DueEntity;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface IDueDao {

    int addDueList(List<DueEntity> list);

    int editDueList(List<DueEntity> list);

    List<DueEntity> getTodayDueList(@Param("start") String start,
                                    @Param("end") String end);

    List<DueEntity> getHisDueList(String start);
    List<DueEntity> getDueList();

    int addDue(DueEntity due);

    int editDue(DueEntity due);
}
