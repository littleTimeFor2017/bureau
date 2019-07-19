package com.lixc.bureau.entity;

import lombok.Data;

/**
 * 分组实体类
 */
@Data
public class CategoryEntity {
    private int id;
    private String name;
    private int parentId;
    private String type;
}
