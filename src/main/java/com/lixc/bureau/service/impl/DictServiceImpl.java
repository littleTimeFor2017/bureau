package com.lixc.bureau.service.impl;

import com.lixc.bureau.dao.DictMapper;
import com.lixc.bureau.entity.Dict;
import com.lixc.bureau.service.DictService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @className: DictServiceImpl
 * @description: TODO
 * @Author: Wilson
 * @createTime 2020/9/23 23:03
 */
@Service
public class DictServiceImpl implements DictService {

    @Autowired
    private DictMapper dictMapper;

    @Override
    public List<Dict> getDictByType(Integer type) {
        return dictMapper.getDictByType(type);
    }
}
