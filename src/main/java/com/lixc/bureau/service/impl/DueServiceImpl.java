package com.lixc.bureau.service.impl;

import com.lixc.bureau.dao.IDueDao;
import com.lixc.bureau.entity.DueEntity;
import com.lixc.bureau.service.IDueService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@Service
public class DueServiceImpl implements IDueService {

    @Autowired
    private IDueDao dao;

    @Override
    @Transactional
    public int addDue(List<DueEntity> list) {
        if (list != null && list.size() > 0) {
            for (DueEntity due : list) {
                dao.addDue(due);
            }
        }
        return 1;
    }

    @Override
    public int editDue(List<DueEntity> list) {
        if (list != null && list.size() > 0) {
            for (DueEntity due : list) {
                dao.editDue(due);
            }
        }
        return 1;
    }

    @Override
    public List<DueEntity> getDueList(String type) {
        long time = System.currentTimeMillis();
        Date date = new Date(time);
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        String format = sdf.format(date);
        String start = format + " 00:00:00";
        String end = format + " 23:59:59";
//        //D 今天 H历史
//        if ("D".equals(type)) {
//            return dao.getTodayDueList(start, end);
//        } else if ("H".equals(type)) {
//            return dao.getHisDueList(start);
//        }
        return dao.getDueList();
    }
}
