package com.lixc.bureau.entity;

import lombok.Data;

/**
 * @className: Dict
 * @description: TODO
 * @Author: Wilson
 * @createTime 2020/9/23 23:03
 */
@Data
public class Dict {
    private Integer id;
    private String dictKey;
    private String dictValue;
    private Integer type;
}
