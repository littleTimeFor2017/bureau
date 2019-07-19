package com.lixc.bureau.service;

import com.lixc.bureau.entity.DueEntity;

import java.util.List;

public interface IDueService {

    int addDue(List<DueEntity> list);

    int editDue(List<DueEntity> list);

    List<DueEntity> getDueList(String type);
}
