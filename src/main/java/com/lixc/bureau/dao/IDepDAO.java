package com.lixc.bureau.dao;

import com.lixc.bureau.entity.Article_dep_publish;
import com.lixc.bureau.entity.Article_dep_real;
import com.lixc.bureau.entity.Department;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface IDepDAO {

    int getAllDepartmentsCount();
    //    查询所有的部门列表
    List<Department> getAllDepartments(Department department);
    //查询可以签收的部门列表
    List<Department> getAllDepartmentsPublised(int article_id);
    List<Department> getAllDepartmentsWithNoParam();
    // 根据article_id查询所有已经签收的部门
    List<Integer> getDepsByArticleId(int article_id);

    int delRelByArticleID(int article_id);

    //插入关联表
    int insertRel(Article_dep_real realEntity);

    //插入到指定部门表
    int addArticle_dep_publish(Article_dep_publish article_dep_publish);

    //根据article_id删除指定的部门
    void delPublishByArticleId(int article_id);

    //获取指定部门
    List<Article_dep_publish> getPublishList(int article_id);


    List<Department> getPublishDepart(int article_id);
}
