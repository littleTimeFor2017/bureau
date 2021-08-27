/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50512
Source Host           : localhost:3306
Source Database       : jiaojingdadui

Target Server Type    : MYSQL
Target Server Version : 50512
File Encoding         : 65001

Date: 2021-01-04 11:23:56
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for article_annex
-- ----------------------------
DROP TABLE IF EXISTS `article_annex`;
CREATE TABLE `article_annex` (
  `id` int(5) NOT NULL COMMENT '主键',
  `article_id` int(5) NOT NULL,
  `name` varchar(255) DEFAULT NULL COMMENT '附件名称',
  `url` varchar(4000) DEFAULT NULL COMMENT '附件存储路径',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of article_annex
-- ----------------------------

-- ----------------------------
-- Table structure for article_dep_publish
-- ----------------------------
DROP TABLE IF EXISTS `article_dep_publish`;
CREATE TABLE `article_dep_publish` (
  `article_id` int(5) NOT NULL COMMENT '文章id',
  `dep_id` int(5) NOT NULL COMMENT '需签收部门ID',
  PRIMARY KEY (`article_id`,`dep_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of article_dep_publish
-- ----------------------------



-- ----------------------------
-- Table structure for article_dep_real
-- ----------------------------
DROP TABLE IF EXISTS `article_dep_real`;
CREATE TABLE `article_dep_real` (
  `id` int(5) NOT NULL AUTO_INCREMENT,
  `article_id` int(5) DEFAULT NULL,
  `department_id` int(5) DEFAULT NULL,
  `createTime` datetime DEFAULT NULL COMMENT '创建时间',
  `createBy` varchar(255) DEFAULT NULL COMMENT '创建人',
  `updateTime` datetime DEFAULT NULL COMMENT '更新时间',
  `updateBy` varchar(255) DEFAULT NULL COMMENT '更新人',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1824 DEFAULT CHARSET=utf8;



-- ----------------------------
-- Table structure for sys_annex
-- ----------------------------
DROP TABLE IF EXISTS `sys_annex`;
CREATE TABLE `sys_annex` (
  `id` int(5) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `saveName` varchar(255) DEFAULT NULL,
  `fileName` varchar(255) DEFAULT NULL COMMENT '附件名称',
  `url` varchar(4000) DEFAULT NULL COMMENT '附件存储路径',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=880 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sys_annex
-- ------------------------

-- ----------------------------
-- Table structure for sys_article
-- ----------------------------
DROP TABLE IF EXISTS `sys_article`;
CREATE TABLE `sys_article` (
  `id` int(5) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `c_id` int(5) DEFAULT NULL COMMENT '所属分类ID',
  `title` varchar(255) DEFAULT NULL COMMENT '标题',
  `content` text COMMENT '文章内容',
  `is_deleted` char(1) NOT NULL DEFAULT 'N' COMMENT '是否删除',
  `createTime` datetime DEFAULT NULL COMMENT '创建时间',
  `createBy` varchar(255) DEFAULT NULL COMMENT '创建人',
  `updateTime` datetime DEFAULT NULL COMMENT '更新时间',
  `updateBy` varchar(255) DEFAULT NULL COMMENT '更新人',
  `a_id` int(255) DEFAULT NULL COMMENT '附件存储ID',
  `is_site` char(1) DEFAULT 'N' COMMENT '是否是专栏文章',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1277 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sys_article
-- ----------------------------

-- ----------------------------
-- Table structure for sys_article_module
-- ----------------------------
DROP TABLE IF EXISTS `sys_article_module`;
CREATE TABLE `sys_article_module` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `article_id` int(11) NOT NULL COMMENT '文章id',
  `module_id` int(11) NOT NULL COMMENT '文章子模块id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sys_article_module
-- ----------------------------

-- ----------------------------
-- Table structure for sys_care
-- ----------------------------
DROP TABLE IF EXISTS `sys_care`;
CREATE TABLE `sys_care` (
  `id` int(5) NOT NULL,
  `content` text,
  `create_time` datetime DEFAULT NULL,
  `create_by` varchar(255) NOT NULL,
  `is_deleted` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sys_care
-- ----------------------------

-- ----------------------------
-- Table structure for sys_category
-- ----------------------------
DROP TABLE IF EXISTS `sys_category`;
CREATE TABLE `sys_category` (
  `id` int(5) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(100) DEFAULT NULL COMMENT '分组名称',
  `parent_id` int(5) DEFAULT NULL,
  `type` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sys_category
-- ----------------------------
INSERT INTO `sys_category` VALUES ('-1', '根目录', null, null);
INSERT INTO `sys_category` VALUES ('1', '工作动态', '-1', 'gzdt');
INSERT INTO `sys_category` VALUES ('2', '通知通报', '-1', 'tztb');
INSERT INTO `sys_category` VALUES ('3', '秩序通报', '-1', 'zxtb');
INSERT INTO `sys_category` VALUES ('4', '政工党建', '-1', 'zgdj');
INSERT INTO `sys_category` VALUES ('5', '宣传报道', '-1', 'mtyq');
INSERT INTO `sys_category` VALUES ('6', '专项整治', '-1', 'zxzz');
INSERT INTO `sys_category` VALUES ('7', '部门工作', '-1', 'bmgz');
INSERT INTO `sys_category` VALUES ('8', '图片新闻', '-1', 'tpxw');
INSERT INTO `sys_category` VALUES ('9', '今日值班', '-1', 'jrzb');
INSERT INTO `sys_category` VALUES ('10', '今日注意', '-1', 'jrzy');
INSERT INTO `sys_category` VALUES ('11', '图片管理', '-1', 'sylbt');
INSERT INTO `sys_category` VALUES ('12', '网站专栏', '-1', 'wzzl');
INSERT INTO `sys_category` VALUES ('13', '学习资料', '4', 'zgdj_xxzl');
INSERT INTO `sys_category` VALUES ('14', '通知通报', '4', 'zgdj_tztb');
INSERT INTO `sys_category` VALUES ('15', '支部动态', '4', 'zgdj_zbdt');
INSERT INTO `sys_category` VALUES ('16', '党建简报', '4', 'zgdj_djjb');

-- ----------------------------
-- Table structure for sys_department
-- ----------------------------
DROP TABLE IF EXISTS `sys_department`;
CREATE TABLE `sys_department` (
  `id` int(5) NOT NULL,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sys_department
-- ----------------------------
INSERT INTO `sys_department` VALUES ('1', '车管所');
INSERT INTO `sys_department` VALUES ('2', '警务保障室');
INSERT INTO `sys_department` VALUES ('3', '宣传秩序科');
INSERT INTO `sys_department` VALUES ('4', '办案中队');
INSERT INTO `sys_department` VALUES ('5', '法制科');
INSERT INTO `sys_department` VALUES ('6', '重点办');
INSERT INTO `sys_department` VALUES ('7', '违法办');
INSERT INTO `sys_department` VALUES ('8', '事故科');
INSERT INTO `sys_department` VALUES ('9', '指挥中心');
INSERT INTO `sys_department` VALUES ('10', '省道中队');
INSERT INTO `sys_department` VALUES ('11', '城区中队');
INSERT INTO `sys_department` VALUES ('12', '曲阳桥中队');
INSERT INTO `sys_department` VALUES ('13', '曹村中队');
INSERT INTO `sys_department` VALUES ('14', '机动队');

-- ----------------------------
-- Table structure for sys_dict
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict`;
CREATE TABLE `sys_dict` (
  `id` int(5) NOT NULL AUTO_INCREMENT,
  `dict_key` varchar(255) DEFAULT NULL,
  `dict_value` varchar(255) DEFAULT NULL,
  `type` int(5) DEFAULT NULL COMMENT '字典表值所属模块，0表示 图片的用途模块，1表示子菜单的类型模块',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sys_dict
-- ----------------------------
INSERT INTO `sys_dict` VALUES ('1', 'sylbt', '首页轮播图', '0');
INSERT INTO `sys_dict` VALUES ('2', 'wzzl', '网站专栏', '0');
INSERT INTO `sys_dict` VALUES ('3', 'sypc', '首页飘窗', '0');
INSERT INTO `sys_dict` VALUES ('4', 'xxzl', '学习资料', '1');
INSERT INTO `sys_dict` VALUES ('5', 'tztb', '通知通报', '1');
INSERT INTO `sys_dict` VALUES ('6', 'zbdt', '部门动态', '1');
INSERT INTO `sys_dict` VALUES ('7', 'djjb', '工作简报', '1');

-- ----------------------------
-- Table structure for sys_due
-- ----------------------------
DROP TABLE IF EXISTS `sys_due`;
CREATE TABLE `sys_due` (
  `id` int(5) NOT NULL AUTO_INCREMENT,
  `key` varchar(255) DEFAULT NULL,
  `value` varchar(255) DEFAULT NULL,
  `create_time` datetime NOT NULL COMMENT '创建时间/值班时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sys_due
-- ----------------------------
INSERT INTO `sys_due` VALUES ('3', '大队值班领导', '赵喜辉 左秀青', '2019-06-19 16:56:20');
INSERT INTO `sys_due` VALUES ('4', '城区中队领导', '靳建刚', '2019-06-19 16:56:20');
INSERT INTO `sys_due` VALUES ('5', '省道中队领导', '王志刚', '2019-06-19 16:56:20');
INSERT INTO `sys_due` VALUES ('6', '曹村中队领导', '康志勇', '2019-06-19 16:56:20');
INSERT INTO `sys_due` VALUES ('7', '机动中队领导', '张春芳', '2019-06-19 16:56:20');
INSERT INTO `sys_due` VALUES ('8', '曲阳桥中队领导', '雍清华', '2019-06-19 16:56:20');
INSERT INTO `sys_due` VALUES ('9', '大队夜间值班民警', '王志刚 张同新 段维', '2019-06-19 16:56:20');
INSERT INTO `sys_due` VALUES ('10', '事故日夜值班民警', '颜新华 王君超 梁学军', '2019-06-19 16:56:20');
INSERT INTO `sys_due` VALUES ('11', '指挥中心接警值班', '高丹丹 崔丽琴 张迪', '2019-06-19 16:56:20');
INSERT INTO `sys_due` VALUES ('12', '指挥中心监控值班', '闫雨萌', '2019-06-19 16:56:20');
INSERT INTO `sys_due` VALUES ('13', '指挥中心档案值班', '任思雨', '2019-06-19 16:56:20');

-- ----------------------------
-- Table structure for sys_image
-- ----------------------------
DROP TABLE IF EXISTS `sys_image`;
CREATE TABLE `sys_image` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL COMMENT '主键',
  `url` varchar(255) NOT NULL COMMENT '图片存储路径',
  `checked` varchar(255) DEFAULT NULL,
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `createBy` varchar(255) DEFAULT NULL COMMENT '创建人',
  `order_no` int(11) DEFAULT NULL,
  `use_position` int(11) DEFAULT NULL,
  `thumURL` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=240 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sys_image
-- ----------------------------
INSERT INTO `sys_image` VALUES ('181', '16022102656880d442ec33712125ccc3b9fcfc61c0e2.jpg', 'E:/temp(1)/temp\\16022102656880d442ec33712125ccc3b9fcfc61c0e2.jpg', null, '2020-10-09 10:24:25', '1', null, '2', 'thum_16022102656910d442ec33712125ccc3b9fcfc61c0e2.jpg');
INSERT INTO `sys_image` VALUES ('182', '160221028022107ca8155e006ce421836fa9cf5e5491.jpg', 'E:/temp(1)/temp\\160221028022107ca8155e006ce421836fa9cf5e5491.jpg', null, '2020-10-09 10:24:40', '1', null, '2', 'thum_160221028025807ca8155e006ce421836fa9cf5e5491.jpg');
INSERT INTO `sys_image` VALUES ('183', '1602210315273e4c4bb8ae3ff563f0534a1466eae879.jpg', 'E:/temp(1)/temp\\1602210315273e4c4bb8ae3ff563f0534a1466eae879.jpg', null, '2020-10-09 10:25:15', '1', null, '2', 'thum_1602210315283e4c4bb8ae3ff563f0534a1466eae879.jpg');
INSERT INTO `sys_image` VALUES ('184', '1602210331050f709639f99a56353d642a18bbaf2d96.jpg', 'E:/temp(1)/temp\\1602210331050f709639f99a56353d642a18bbaf2d96.jpg', null, '2020-10-09 10:25:31', '1', null, '2', 'thum_1602210331069f709639f99a56353d642a18bbaf2d96.jpg');
INSERT INTO `sys_image` VALUES ('237', '16083676241241.jpg', 'E:/temp(1)/temp\\16083676241241.jpg', null, '2020-12-19 16:47:04', '1', null, '1', 'thum_16083676241241.jpg');
INSERT INTO `sys_image` VALUES ('238', '16083676361672.jpg', 'E:/temp(1)/temp\\16083676361672.jpg', null, '2020-12-19 16:47:16', '1', null, '1', 'thum_16083676361832.jpg');
INSERT INTO `sys_image` VALUES ('239', '16083676469473.jpg', 'E:/temp(1)/temp\\16083676469473.jpg', null, '2020-12-19 16:47:27', '1', null, '1', 'thum_16083676469623.jpg');

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role` (
  `id` int(5) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(255) DEFAULT NULL COMMENT '''角色名称''',
  `is_super` varchar(2) DEFAULT NULL COMMENT '是否是超级管理员',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES ('1', '系统管理员', 'Y');
INSERT INTO `sys_role` VALUES ('2', '部门管理员', 'N');

-- ----------------------------
-- Table structure for sys_site
-- ----------------------------
DROP TABLE IF EXISTS `sys_site`;
CREATE TABLE `sys_site` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `is_show` char(1) NOT NULL DEFAULT 'N' COMMENT '是否显示',
  `image_id` int(11) DEFAULT NULL COMMENT '图片id',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `create_by` int(11) DEFAULT NULL COMMENT '创建人',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `update_by` int(11) DEFAULT NULL COMMENT '更新人',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of sys_site
-- ----------------------------
INSERT INTO `sys_site` VALUES ('6', 'Y', '181', '2020-10-09 10:24:25', '1', null, null);
INSERT INTO `sys_site` VALUES ('7', 'Y', '182', '2020-10-09 10:24:40', '1', null, null);
INSERT INTO `sys_site` VALUES ('8', 'Y', '183', '2020-10-09 10:25:15', '1', null, null);
INSERT INTO `sys_site` VALUES ('9', 'Y', '184', '2020-10-09 10:25:31', '1', null, null);

-- ----------------------------
-- Table structure for sys_site_article
-- ----------------------------
DROP TABLE IF EXISTS `sys_site_article`;
CREATE TABLE `sys_site_article` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `site_id` int(11) NOT NULL COMMENT '专栏id',
  `article_id` int(11) NOT NULL COMMENT '文章id',
  `module_id` int(11) NOT NULL COMMENT '专栏子模块id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sys_site_article
-- ----------------------------
INSERT INTO `sys_site_article` VALUES ('1', '1', '1084', '6');

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user` (
  `id` int(5) NOT NULL AUTO_INCREMENT,
  `password` varchar(255) DEFAULT NULL COMMENT '密码',
  `username` varchar(255) NOT NULL COMMENT '用户名',
  `depId` int(5) DEFAULT NULL COMMENT '所属部门',
  `role_id` int(5) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UQ_username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES ('1', '111111', '1', '1', '1', '');
INSERT INTO `sys_user` VALUES ('2', '111111', 'zhengzihan', '2', '2', null);
INSERT INTO `sys_user` VALUES ('3', '111111', 'lixc', '3', '2', '');
INSERT INTO `sys_user` VALUES ('4', '123456', '车管所', '1', '2', '');
INSERT INTO `sys_user` VALUES ('5', '123456', '警务保障室', '2', '2', null);
INSERT INTO `sys_user` VALUES ('6', '123456', '宣传秩序科', '3', '2', null);
INSERT INTO `sys_user` VALUES ('7', '123456', '办案中队', '4', '2', null);
INSERT INTO `sys_user` VALUES ('8', '123456', '法制科', '5', '2', null);
INSERT INTO `sys_user` VALUES ('9', '123456', '重点办', '6', '2', null);
INSERT INTO `sys_user` VALUES ('10', '123456', '违法办', '7', '2', null);
INSERT INTO `sys_user` VALUES ('11', '123456', '事故科', '8', '2', null);
INSERT INTO `sys_user` VALUES ('12', '123456', '指挥中心', '9', '2', null);
INSERT INTO `sys_user` VALUES ('13', '123456', '省道中队', '10', '2', null);
INSERT INTO `sys_user` VALUES ('14', '123456', '城区中队', '11', '2', null);
INSERT INTO `sys_user` VALUES ('15', '123456', '曲阳桥中队', '12', '2', null);
INSERT INTO `sys_user` VALUES ('16', '123456', '曹村中队', '13', '2', null);
INSERT INTO `sys_user` VALUES ('17', '123456', '机动队', '14', '2', null);

-- ----------------------------
-- Procedure structure for in_param
-- ----------------------------
DROP PROCEDURE IF EXISTS `in_param`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `in_param`(IN p_in int)
BEGIN
SELECT p_in;
set p_in = 2;
select p_in;
end
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for proc_add
-- ----------------------------
DROP PROCEDURE IF EXISTS `proc_add`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_add`(IN a INT, IN b INT, OUT sum INT)
BEGIN

IF a IS NULL THEN

SET a = 0;


END
IF;


IF b IS NULL THEN

SET b = 0;


END
IF;


SET sum = a + b;


END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for proc_out
-- ----------------------------
DROP PROCEDURE IF EXISTS `proc_out`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_out`(OUT var1 VARCHAR(100))
BEGIN

SET var1 = 'this is a test';
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for update_due
-- ----------------------------
DROP PROCEDURE IF EXISTS `update_due`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `update_due`()
BEGIN
update sys_due  sd set sd.create_time =DATE_ADD(sd.create_time,INTERVAL 1 DAY);
end
;;
DELIMITER ;

-- ----------------------------
-- Event structure for aaevent
-- ----------------------------
DROP EVENT IF EXISTS `aaevent`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` EVENT `aaevent` ON SCHEDULE EVERY 1 DAY STARTS '2018-01-01 14:00:00' ON COMPLETION NOT PRESERVE ENABLE DO CALL proc_add(0)
;;
DELIMITER ;

-- ----------------------------
-- Event structure for abevent
-- ----------------------------
DROP EVENT IF EXISTS `abevent`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` EVENT `abevent` ON SCHEDULE EVERY 1 HOUR STARTS '2018-01-01 14:00:00' ON COMPLETION NOT PRESERVE ENABLE DO CALL proc_add()
;;
DELIMITER ;

-- ----------------------------
-- Event structure for update_due_event
-- ----------------------------
DROP EVENT IF EXISTS `update_due_event`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` EVENT `update_due_event` ON SCHEDULE EVERY 1 DAY STARTS '2019-06-10 10:07:22' ON COMPLETION PRESERVE DISABLE DO call update_due
;;
DELIMITER ;
