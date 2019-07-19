package com.lixc.bureau.service;

import com.lixc.bureau.entity.Article_dep_real;
import com.lixc.bureau.entity.Department;

import java.util.List;

public interface IDepartmentService {
    //获取签收情况列表
    List<Department> getSignDeps(int article_id,Department department);


    int insertRel(Article_dep_real realEntity);


    List<Department> getAllDeps();

    List<Department> getAllDepsWithStatus(int article_id);

}
