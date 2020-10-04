package com.lixc.bureau.service;

import com.lixc.bureau.entity.Dict;

import java.util.List;

/**
 * @className: DictService
 * @description: TODO
 * @Author: Wilson
 * @createTime 2020/9/23 23:02
 */
public interface DictService {
    /**
     * 根据类型获取 对应的字典集合
     *
     * @param type
     * @return
     */
    List<Dict> getDictByType(Integer type);
}
