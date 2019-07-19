package com.lixc.bureau.service.impl;

import com.lixc.bureau.dao.IDepDAO;
import com.lixc.bureau.entity.Article_dep_publish;
import com.lixc.bureau.entity.Article_dep_real;
import com.lixc.bureau.entity.Department;
import com.lixc.bureau.entity.PaginatorBean;
import com.lixc.bureau.service.IDepartmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import java.util.List;

@Service
public class DepartmentServiceImpl extends PaginatorBean implements IDepartmentService {
    @Autowired
    private IDepDAO dao;

    @Override
    public List<Department> getSignDeps(int article_id, Department department) {
        List<Article_dep_publish> publishList = dao.getPublishList(article_id);
        this.initPaginator(department, publishList.size());
        //查到所有的部门列表
        List<Department> list = dao.getAllDepartmentsPublised(article_id);
        //去除掉未指定的部门
        //根据articleid 查询到所有已经签收的部门
        List<Integer> signDeps = dao.getDepsByArticleId(article_id);
        if (list != null && list.size() > 0) {
            for (Department dep : list) {
                int dep_id = dep.getId();
                if (signDeps.contains(dep_id)) {
                    dep.setStatus(1);
                } else {
                    dep.setStatus(0);
                }
            }
        }
        return list;
    }

    @Override
    public int insertRel(Article_dep_real realEntity) {
        return dao.insertRel(realEntity);
    }

    @Override
    public List<Department> getAllDeps() {
        return dao.getAllDepartmentsWithNoParam();
    }

    @Override
    public List<Department> getAllDepsWithStatus(int article_id) {
        List<Department> getAllDeps = dao.getAllDepartmentsWithNoParam();
        List<Article_dep_publish> publishList = dao.getPublishList(article_id);
        for (Department dep : getAllDeps) {
            int id = dep.getId();
            for (Article_dep_publish a : publishList) {
                if (a.getDep_id() == id) {
                    dep.setChecked("Y");
                }
            }
        }
        return getAllDeps;
    }

}
