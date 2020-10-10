#增加专栏设置表
DROP TABLE IF EXISTS `sys_site`;
CREATE TABLE `sys_site`  (
                             `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
                             `is_show` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'N' COMMENT '是否显示',
                             `image_id` int(11) NULL DEFAULT NULL COMMENT '图片id',
                             `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
                             `create_by` int(11) NULL DEFAULT NULL COMMENT '创建人',
                             `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
                             `update_by` int(11) NULL DEFAULT NULL COMMENT '更新人',
                             PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;
##  更新菜单名称
update sys_category set name = '图片管理' where id = 11;


##文章表增加字段，是否是专栏文章，专栏文章不显示再普通文章内部
alter table  sys_article add column `is_site` char(1) default 'N' comment '是否是专栏文章';

## 增加文章专栏关联表
DROP TABLE IF EXISTS `sys_site_article`;
create table `sys_site_article`(
                                   `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
                                   `site_id` int(11) NOT NULL  COMMENT '专栏id',
                                   `article_id` int(11) NOT NULL  COMMENT '文章id',
                                   `module_id`int(11) NOT NULL  COMMENT '专栏子模块id',
                                   PRIMARY KEY (`id`) USING BTREE

)ENGINE = InnoDB;
## 增加字典表
DROP TABLE IF EXISTS `sys_dict`;
CREATE TABLE `sys_dict`  (
                             `id` int(5) NOT NULL AUTO_INCREMENT,
                             `dict_key` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
                             `dict_value` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
                             `type` int(5) NULL DEFAULT NULL COMMENT '字典表值所属模块，0表示 图片的用途模块，1表示子菜单的类型模块',
                             PRIMARY KEY (`id`) USING BTREE
);

INSERT INTO `sys_dict`(`id`, `dict_key`, `dict_value`, `type`) VALUES (1, 'sylbt', '首页轮播图', 0);
INSERT INTO `sys_dict`(`id`, `dict_key`, `dict_value`, `type`) VALUES (2, 'wzzl', '网站专栏', 0);
INSERT INTO `sys_dict`(`id`, `dict_key`, `dict_value`, `type`) VALUES (3, 'sypc', '首页飘窗', 0);
INSERT INTO `sys_dict`(`id`, `dict_key`, `dict_value`, `type`) VALUES (4, 'xxzl', '学习资料', 1);
INSERT INTO `sys_dict`(`id`, `dict_key`, `dict_value`, `type`) VALUES (5, 'tztb', '通知通报', 1);
INSERT INTO `sys_dict`(`id`, `dict_key`, `dict_value`, `type`) VALUES (6, 'zbdt', '支部动态', 1);
INSERT INTO `sys_dict`(`id`, `dict_key`, `dict_value`, `type`) VALUES (7, 'djjb', '党建简报', 1);

## 文章模块关联表
DROP TABLE IF EXISTS `sys_article_module`;
create table `sys_article_module`(
                                   `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
                                   `article_id` int(11) NOT NULL  COMMENT '文章id',
                                   `module_id`int(11) NOT NULL  COMMENT '文章子模块id',
                                   PRIMARY KEY (`id`) USING BTREE

)ENGINE = InnoDB;


UPDATE `sys_category` SET `name` = '今日注意', `parent_id` = -1, `type` = 'jrzy' WHERE `id` = 10;
