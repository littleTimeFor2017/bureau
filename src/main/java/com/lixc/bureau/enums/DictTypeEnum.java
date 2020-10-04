package com.lixc.bureau.enums;

/**
 * @className: DictTypeEnum
 * @description: TODO
 * @Author: Wilson
 * @createTime 2020/9/23 23:08
 */
public enum DictTypeEnum {
    /**
     * 图片子分类
     */
    DICT_TYPE_ENUM_IMAGE(0),
    /**
     * 菜单子分类
     */
    DICT_TYPE_ENUM_CHILDCATEGORY(1);

    private int code;

    DictTypeEnum(int code) {
        this.code = code;
    }

    public int getCode() {
        return code;
    }
}
