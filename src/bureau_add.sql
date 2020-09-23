DROP TABLE IF EXISTS `sys_site`;
CREATE TABLE `sys_site`  (
                             `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
                             `title` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '标题',
                             `content` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '内容',
                             `is_show` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'N' COMMENT '是否显示',
                             `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
                             `create_by` int(11) NULL DEFAULT NULL COMMENT '创建人',
                             `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
                             `update_by` int(11) NULL DEFAULT NULL COMMENT '更新人',
                             `url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '图片url',
                             `thumb_url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '缩略图图片url',
                             PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;