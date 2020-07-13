/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50720
Source Host           : localhost:3306
Source Database       : tp_admin

Target Server Type    : MYSQL
Target Server Version : 50720
File Encoding         : 65001

Date: 2020-07-11 17:56:15
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for os_admin_user
-- ----------------------------
DROP TABLE IF EXISTS `os_admin_user`;
CREATE TABLE `os_admin_user` (
  `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(20) NOT NULL DEFAULT '' COMMENT '管理员用户名',
  `password` varchar(50) NOT NULL DEFAULT '' COMMENT '管理员密码',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '状态 1 启用 0 禁用',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `last_login_time` datetime DEFAULT NULL COMMENT '最后登录时间',
  `last_login_ip` varchar(20) DEFAULT NULL COMMENT '最后登录IP',
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=16 DEFAULT CHARSET=utf8 COMMENT='管理员表';

-- ----------------------------
-- Records of os_admin_user
-- ----------------------------
INSERT INTO `os_admin_user` VALUES ('1', 'admin', 'e10adc3949ba59abbe56e057f20f883e', '1', '2020-01-27 12:58:50', '2020-07-08 09:59:28', '2020-07-11 17:32:18', '127.0.0.1');
INSERT INTO `os_admin_user` VALUES ('15', 'test', 'e10adc3949ba59abbe56e057f20f883e', '1', '2020-07-10 17:45:04', '2020-07-10 17:45:04', null, null);

-- ----------------------------
-- Table structure for os_auth_group
-- ----------------------------
DROP TABLE IF EXISTS `os_auth_group`;
CREATE TABLE `os_auth_group` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `title` char(100) NOT NULL DEFAULT '',
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `rules` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of os_auth_group
-- ----------------------------
INSERT INTO `os_auth_group` VALUES ('1', '超级管理员', '1', '1,2,5,6,7,3,8,9,10,4,11,12,13');
INSERT INTO `os_auth_group` VALUES ('9', '编辑', '1', '1,2,5,6,7,14,15,26,3,8,9,10,16,17,18,19,20,4,11,12,13,21,22,23,24,25');

-- ----------------------------
-- Table structure for os_auth_group_access
-- ----------------------------
DROP TABLE IF EXISTS `os_auth_group_access`;
CREATE TABLE `os_auth_group_access` (
  `uid` mediumint(8) unsigned NOT NULL,
  `group_id` mediumint(8) unsigned NOT NULL,
  UNIQUE KEY `uid_group_id` (`uid`,`group_id`),
  KEY `uid` (`uid`),
  KEY `group_id` (`group_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of os_auth_group_access
-- ----------------------------
INSERT INTO `os_auth_group_access` VALUES ('1', '1');
INSERT INTO `os_auth_group_access` VALUES ('15', '9');

-- ----------------------------
-- Table structure for os_auth_rule
-- ----------------------------
DROP TABLE IF EXISTS `os_auth_rule`;
CREATE TABLE `os_auth_rule` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(80) NOT NULL DEFAULT '' COMMENT '规则名称',
  `title` varchar(20) NOT NULL,
  `type` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态',
  `pid` smallint(5) unsigned NOT NULL COMMENT '父级ID',
  `icon` varchar(50) DEFAULT '' COMMENT '图标',
  `sort` tinyint(4) unsigned NOT NULL COMMENT '排序',
  `condition` char(100) DEFAULT '',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=30 DEFAULT CHARSET=utf8 COMMENT='规则表';

-- ----------------------------
-- Records of os_auth_rule
-- ----------------------------
INSERT INTO `os_auth_rule` VALUES ('1', 'admin/System/index', '系统管理', '1', '1', '0', 'layui-icon-util', '0', '');
INSERT INTO `os_auth_rule` VALUES ('2', 'admin/AdminUser/index', '管理员', '1', '1', '1', '', '0', '');
INSERT INTO `os_auth_rule` VALUES ('3', 'admin/AuthGroup/index', '权限组', '1', '1', '1', '', '0', '');
INSERT INTO `os_auth_rule` VALUES ('4', 'admin/Menu/index', '菜单管理', '1', '1', '1', '', '0', '');
INSERT INTO `os_auth_rule` VALUES ('5', 'admin/AdminUser/add', '添加管理员', '1', '1', '2', '', '0', '');
INSERT INTO `os_auth_rule` VALUES ('6', 'admin/AdminUser/edit', '编辑管理员', '1', '1', '2', '', '0', '');
INSERT INTO `os_auth_rule` VALUES ('7', 'admin/AdminUser/destory', '删除管理员', '1', '1', '2', '', '0', '');
INSERT INTO `os_auth_rule` VALUES ('8', 'admin/AuthGroup/add', '添加权限', '1', '1', '3', '', '0', '');
INSERT INTO `os_auth_rule` VALUES ('9', 'admin/AuthGroup/edit', '编辑权限组', '1', '1', '3', '', '0', '');
INSERT INTO `os_auth_rule` VALUES ('10', 'admin/AuthGroup/destory', '删除权限组', '1', '1', '3', '', '0', '');
INSERT INTO `os_auth_rule` VALUES ('11', 'admin/Menu/add', '添加菜单', '1', '1', '4', '', '0', '');
INSERT INTO `os_auth_rule` VALUES ('12', 'admin/Menu/edit', '编辑菜单', '1', '1', '4', '', '0', '');
INSERT INTO `os_auth_rule` VALUES ('13', 'admin/Menu/destory', '删除菜单', '1', '1', '4', '', '0', '');
INSERT INTO `os_auth_rule` VALUES ('14', 'admin/AdminUser/update', '更新管理员', '1', '1', '2', '', '0', '');
INSERT INTO `os_auth_rule` VALUES ('15', 'admin/AdminUser/data', '数据列表', '1', '1', '2', '', '0', '');
INSERT INTO `os_auth_rule` VALUES ('16', 'admin/AuthGroup/data', '数据列表', '1', '1', '3', '', '0', '');
INSERT INTO `os_auth_rule` VALUES ('17', 'admin/AuthGroup/update', '更新权限组', '1', '1', '3', '', '0', '');
INSERT INTO `os_auth_rule` VALUES ('18', 'admin/AuthGroup/auth', '权限列表', '1', '1', '3', '', '0', '');
INSERT INTO `os_auth_rule` VALUES ('19', 'admin/AuthGroup/getAuthData', '获取权限数据', '1', '1', '3', '', '0', '');
INSERT INTO `os_auth_rule` VALUES ('20', 'admin/AuthGroup/authSave', '权限保存', '1', '1', '3', '', '0', '');
INSERT INTO `os_auth_rule` VALUES ('21', 'admin/Menu/data', '数据列表', '1', '1', '4', '', '0', '');
INSERT INTO `os_auth_rule` VALUES ('22', 'admin/Menu/getTreeSelect', '获取下拉树', '1', '1', '4', '', '0', '');
INSERT INTO `os_auth_rule` VALUES ('23', 'admin/Menu/icon', '所有icon图标', '1', '1', '4', '', '0', '');
INSERT INTO `os_auth_rule` VALUES ('24', 'admin/Menu/save', '保存菜单', '1', '1', '4', '', '0', '');
INSERT INTO `os_auth_rule` VALUES ('25', 'admin/Menu/update', '更新菜单', '1', '1', '4', '', '0', '');
INSERT INTO `os_auth_rule` VALUES ('26', 'admin/AdminUser/save', '保存管理员', '1', '1', '2', '', '0', '');
INSERT INTO `os_auth_rule` VALUES ('27', 'admin/Setup/index', '设置', '1', '1', '0', 'layui-icon-set', '0', '');
INSERT INTO `os_auth_rule` VALUES ('28', 'admin/AdminUser/info', '基本资料', '1', '1', '27', '', '0', '');
INSERT INTO `os_auth_rule` VALUES ('29', 'admin/AdminUser/updatePwd', '修改密码', '1', '1', '27', '', '0', '');

-- ----------------------------
-- Table structure for os_icons
-- ----------------------------
DROP TABLE IF EXISTS `os_icons`;
CREATE TABLE `os_icons` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `unicode` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'unicode 字符',
  `class` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '类名',
  `name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '名称',
  `sort` int(11) NOT NULL DEFAULT '0' COMMENT '排序',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=141 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of os_icons
-- ----------------------------
INSERT INTO `os_icons` VALUES ('1', '&#xe6c9;', 'layui-icon-rate-half', '半星', '0', '2018-12-03 13:57:59', '2018-12-03 13:57:59');
INSERT INTO `os_icons` VALUES ('2', '&#xe67b;', 'layui-icon-rate', '星星-空心', '0', '2018-12-03 13:57:59', '2018-12-03 13:57:59');
INSERT INTO `os_icons` VALUES ('3', '&#xe67a;', 'layui-icon-rate-solid', '星星-实心', '0', '2018-12-03 13:57:59', '2018-12-03 13:57:59');
INSERT INTO `os_icons` VALUES ('4', '&#xe678;', 'layui-icon-cellphone', '手机', '0', '2018-12-03 13:57:59', '2018-12-03 13:57:59');
INSERT INTO `os_icons` VALUES ('5', '&#xe679;', 'layui-icon-vercode', '验证码', '0', '2018-12-03 13:57:59', '2018-12-03 13:57:59');
INSERT INTO `os_icons` VALUES ('6', '&#xe677;', 'layui-icon-login-wechat', '微信', '0', '2018-12-03 13:57:59', '2018-12-03 13:57:59');
INSERT INTO `os_icons` VALUES ('7', '&#xe676;', 'layui-icon-login-qq', 'QQ', '0', '2018-12-03 13:57:59', '2018-12-03 13:57:59');
INSERT INTO `os_icons` VALUES ('8', '&#xe675;', 'layui-icon-login-weibo', '微博', '0', '2018-12-03 13:57:59', '2018-12-03 13:57:59');
INSERT INTO `os_icons` VALUES ('9', '&#xe673;', 'layui-icon-password', '密码', '0', '2018-12-03 13:57:59', '2018-12-03 13:57:59');
INSERT INTO `os_icons` VALUES ('10', '&#xe66f;', 'layui-icon-username', '用户名', '0', '2018-12-03 13:58:00', '2018-12-03 13:58:00');
INSERT INTO `os_icons` VALUES ('11', '&#xe9aa;', 'layui-icon-refresh-3', '刷新-粗', '0', '2018-12-03 13:58:00', '2018-12-03 13:58:00');
INSERT INTO `os_icons` VALUES ('12', '&#xe672;', 'layui-icon-auz', '授权', '0', '2018-12-03 13:58:00', '2018-12-03 13:58:00');
INSERT INTO `os_icons` VALUES ('13', '&#xe66b;', 'layui-icon-spread-left', '左向右伸缩菜单', '0', '2018-12-03 13:58:00', '2018-12-03 13:58:00');
INSERT INTO `os_icons` VALUES ('14', '&#xe668;', 'layui-icon-shrink-right', '右向左伸缩菜单', '0', '2018-12-03 13:58:00', '2018-12-03 13:58:00');
INSERT INTO `os_icons` VALUES ('15', '&#xe6b1;', 'layui-icon-snowflake', '雪花', '0', '2018-12-03 13:58:00', '2018-12-03 13:58:00');
INSERT INTO `os_icons` VALUES ('16', '&#xe702;', 'layui-icon-tips', '提示说明', '0', '2018-12-03 13:58:00', '2018-12-03 13:58:00');
INSERT INTO `os_icons` VALUES ('17', '&#xe66e;', 'layui-icon-note', '便签', '0', '2018-12-03 13:58:00', '2018-12-03 13:58:00');
INSERT INTO `os_icons` VALUES ('18', '&#xe68e;', 'layui-icon-home', '主页', '0', '2018-12-03 13:58:00', '2018-12-03 13:58:00');
INSERT INTO `os_icons` VALUES ('19', '&#xe674;', 'layui-icon-senior', '高级', '0', '2018-12-03 13:58:00', '2018-12-03 13:58:00');
INSERT INTO `os_icons` VALUES ('20', '&#xe669;', 'layui-icon-refresh', '刷新', '0', '2018-12-03 13:58:00', '2018-12-03 13:58:00');
INSERT INTO `os_icons` VALUES ('21', '&#xe666;', 'layui-icon-refresh-1', '刷新', '0', '2018-12-03 13:58:00', '2018-12-03 13:58:00');
INSERT INTO `os_icons` VALUES ('22', '&#xe66c;', 'layui-icon-flag', '旗帜', '0', '2018-12-03 13:58:00', '2018-12-03 13:58:00');
INSERT INTO `os_icons` VALUES ('23', '&#xe66a;', 'layui-icon-theme', '主题', '0', '2018-12-03 13:58:00', '2018-12-03 13:58:00');
INSERT INTO `os_icons` VALUES ('24', '&#xe667;', 'layui-icon-notice', '消息-通知', '0', '2018-12-03 13:58:00', '2018-12-03 13:58:00');
INSERT INTO `os_icons` VALUES ('25', '&#xe7ae;', 'layui-icon-website', '网站', '0', '2018-12-03 13:58:00', '2018-12-03 13:58:00');
INSERT INTO `os_icons` VALUES ('26', '&#xe665;', 'layui-icon-console', '控制台', '0', '2018-12-03 13:58:00', '2018-12-03 13:58:00');
INSERT INTO `os_icons` VALUES ('27', '&#xe664;', 'layui-icon-face-surprised', '表情-惊讶', '0', '2018-12-03 13:58:00', '2018-12-03 13:58:00');
INSERT INTO `os_icons` VALUES ('28', '&#xe716;', 'layui-icon-set', '设置-空心', '0', '2018-12-03 13:58:00', '2018-12-03 13:58:00');
INSERT INTO `os_icons` VALUES ('29', '&#xe656;', 'layui-icon-template-1', '模板', '0', '2018-12-03 13:58:00', '2018-12-03 13:58:00');
INSERT INTO `os_icons` VALUES ('30', '&#xe653;', 'layui-icon-app', '应用', '0', '2018-12-03 13:58:00', '2018-12-03 13:58:00');
INSERT INTO `os_icons` VALUES ('31', '&#xe663;', 'layui-icon-template', '模板', '0', '2018-12-03 13:58:00', '2018-12-03 13:58:00');
INSERT INTO `os_icons` VALUES ('32', '&#xe6c6;', 'layui-icon-praise', '赞', '0', '2018-12-03 13:58:00', '2018-12-03 13:58:00');
INSERT INTO `os_icons` VALUES ('33', '&#xe6c5;', 'layui-icon-tread', '踩', '0', '2018-12-03 13:58:00', '2018-12-03 13:58:00');
INSERT INTO `os_icons` VALUES ('34', '&#xe662;', 'layui-icon-male', '男', '0', '2018-12-03 13:58:00', '2018-12-03 13:58:00');
INSERT INTO `os_icons` VALUES ('35', '&#xe661;', 'layui-icon-female', '女', '0', '2018-12-03 13:58:00', '2018-12-03 13:58:00');
INSERT INTO `os_icons` VALUES ('36', '&#xe660;', 'layui-icon-camera', '相机-空心', '0', '2018-12-03 13:58:00', '2018-12-03 13:58:00');
INSERT INTO `os_icons` VALUES ('37', '&#xe65d;', 'layui-icon-camera-fill', '相机-实心', '0', '2018-12-03 13:58:00', '2018-12-03 13:58:00');
INSERT INTO `os_icons` VALUES ('38', '&#xe65f;', 'layui-icon-more', '菜单-水平', '0', '2018-12-03 13:58:00', '2018-12-03 13:58:00');
INSERT INTO `os_icons` VALUES ('39', '&#xe671;', 'layui-icon-more-vertical', '菜单-垂直', '0', '2018-12-03 13:58:00', '2018-12-03 13:58:00');
INSERT INTO `os_icons` VALUES ('40', '&#xe65e;', 'layui-icon-rmb', '金额-人民币', '0', '2018-12-03 13:58:01', '2018-12-03 13:58:01');
INSERT INTO `os_icons` VALUES ('41', '&#xe659;', 'layui-icon-dollar', '金额-美元', '0', '2018-12-03 13:58:01', '2018-12-03 13:58:01');
INSERT INTO `os_icons` VALUES ('42', '&#xe735;', 'layui-icon-diamond', '钻石-等级', '0', '2018-12-03 13:58:01', '2018-12-03 13:58:01');
INSERT INTO `os_icons` VALUES ('43', '&#xe756;', 'layui-icon-fire', '火', '0', '2018-12-03 13:58:01', '2018-12-03 13:58:01');
INSERT INTO `os_icons` VALUES ('44', '&#xe65c;', 'layui-icon-return', '返回', '0', '2018-12-03 13:58:01', '2018-12-03 13:58:01');
INSERT INTO `os_icons` VALUES ('45', '&#xe715;', 'layui-icon-location', '位置-地图', '0', '2018-12-03 13:58:01', '2018-12-03 13:58:01');
INSERT INTO `os_icons` VALUES ('46', '&#xe705;', 'layui-icon-read', '办公-阅读', '0', '2018-12-03 13:58:01', '2018-12-03 13:58:01');
INSERT INTO `os_icons` VALUES ('47', '&#xe6b2;', 'layui-icon-survey', '调查', '0', '2018-12-03 13:58:01', '2018-12-03 13:58:01');
INSERT INTO `os_icons` VALUES ('48', '&#xe6af;', 'layui-icon-face-smile', '表情-微笑', '0', '2018-12-03 13:58:01', '2018-12-03 13:58:01');
INSERT INTO `os_icons` VALUES ('49', '&#xe69c;', 'layui-icon-face-cry', '表情-哭泣', '0', '2018-12-03 13:58:01', '2018-12-03 13:58:01');
INSERT INTO `os_icons` VALUES ('50', '&#xe698;', 'layui-icon-cart-simple', '购物车', '0', '2018-12-03 13:58:01', '2018-12-03 13:58:01');
INSERT INTO `os_icons` VALUES ('51', '&#xe657;', 'layui-icon-cart', '购物车', '0', '2018-12-03 13:58:01', '2018-12-03 13:58:01');
INSERT INTO `os_icons` VALUES ('52', '&#xe65b;', 'layui-icon-next', '下一页', '0', '2018-12-03 13:58:01', '2018-12-03 13:58:01');
INSERT INTO `os_icons` VALUES ('53', '&#xe65a;', 'layui-icon-prev', '上一页', '0', '2018-12-03 13:58:01', '2018-12-03 13:58:01');
INSERT INTO `os_icons` VALUES ('54', '&#xe681;', 'layui-icon-upload-drag', '上传-空心-拖拽', '0', '2018-12-03 13:58:01', '2018-12-03 13:58:01');
INSERT INTO `os_icons` VALUES ('55', '&#xe67c;', 'layui-icon-upload', '上传-实心', '0', '2018-12-03 13:58:01', '2018-12-03 13:58:01');
INSERT INTO `os_icons` VALUES ('56', '&#xe601;', 'layui-icon-download-circle', '下载-圆圈', '0', '2018-12-03 13:58:01', '2018-12-03 13:58:01');
INSERT INTO `os_icons` VALUES ('57', '&#xe857;', 'layui-icon-component', '组件', '0', '2018-12-03 13:58:01', '2018-12-03 13:58:01');
INSERT INTO `os_icons` VALUES ('58', '&#xe655;', 'layui-icon-file-b', '文件-粗', '0', '2018-12-03 13:58:01', '2018-12-03 13:58:01');
INSERT INTO `os_icons` VALUES ('59', '&#xe770;', 'layui-icon-user', '用户', '0', '2018-12-03 13:58:01', '2018-12-03 13:58:01');
INSERT INTO `os_icons` VALUES ('60', '&#xe670;', 'layui-icon-find-fill', '发现-实心', '0', '2018-12-03 13:58:01', '2018-12-03 13:58:01');
INSERT INTO `os_icons` VALUES ('61', '&#xe63d;', 'layui-icon-loading', 'loading', '0', '2018-12-03 13:58:01', '2018-12-03 13:58:01');
INSERT INTO `os_icons` VALUES ('62', '&#xe63e;', 'layui-icon-loading-1', 'loading', '0', '2018-12-03 13:58:01', '2018-12-03 13:58:01');
INSERT INTO `os_icons` VALUES ('63', '&#xe654;', 'layui-icon-add-1', '添加', '0', '2018-12-03 13:58:01', '2018-12-03 13:58:01');
INSERT INTO `os_icons` VALUES ('64', '&#xe652;', 'layui-icon-play', '播放', '0', '2018-12-03 13:58:01', '2018-12-03 13:58:01');
INSERT INTO `os_icons` VALUES ('65', '&#xe651;', 'layui-icon-pause', '暂停', '0', '2018-12-03 13:58:01', '2018-12-03 13:58:01');
INSERT INTO `os_icons` VALUES ('66', '&#xe6fc;', 'layui-icon-headset', '音频-耳机', '0', '2018-12-03 13:58:01', '2018-12-03 13:58:01');
INSERT INTO `os_icons` VALUES ('67', '&#xe6ed;', 'layui-icon-video', '视频', '0', '2018-12-03 13:58:01', '2018-12-03 13:58:01');
INSERT INTO `os_icons` VALUES ('68', '&#xe688;', 'layui-icon-voice', '语音-声音', '0', '2018-12-03 13:58:01', '2018-12-03 13:58:01');
INSERT INTO `os_icons` VALUES ('69', '&#xe645;', 'layui-icon-speaker', '消息-通知-喇叭', '0', '2018-12-03 13:58:01', '2018-12-03 13:58:01');
INSERT INTO `os_icons` VALUES ('70', '&#xe64f;', 'layui-icon-fonts-del', '删除线', '0', '2018-12-03 13:58:01', '2018-12-03 13:58:01');
INSERT INTO `os_icons` VALUES ('71', '&#xe64e;', 'layui-icon-fonts-code', '代码', '0', '2018-12-03 13:58:01', '2018-12-03 13:58:01');
INSERT INTO `os_icons` VALUES ('72', '&#xe64b;', 'layui-icon-fonts-html', 'HTML', '0', '2018-12-03 13:58:01', '2018-12-03 13:58:01');
INSERT INTO `os_icons` VALUES ('73', '&#xe62b;', 'layui-icon-fonts-strong', '字体加粗', '0', '2018-12-03 13:58:01', '2018-12-03 13:58:01');
INSERT INTO `os_icons` VALUES ('74', '&#xe64d;', 'layui-icon-unlink', '删除链接', '0', '2018-12-03 13:58:01', '2018-12-03 13:58:01');
INSERT INTO `os_icons` VALUES ('75', '&#xe64a;', 'layui-icon-picture', '图片', '0', '2018-12-03 13:58:02', '2018-12-03 13:58:02');
INSERT INTO `os_icons` VALUES ('76', '&#xe64c;', 'layui-icon-link', '链接', '0', '2018-12-03 13:58:02', '2018-12-03 13:58:02');
INSERT INTO `os_icons` VALUES ('77', '&#xe650;', 'layui-icon-face-smile-b', '表情-笑-粗', '0', '2018-12-03 13:58:02', '2018-12-03 13:58:02');
INSERT INTO `os_icons` VALUES ('78', '&#xe649;', 'layui-icon-align-left', '左对齐', '0', '2018-12-03 13:58:02', '2018-12-03 13:58:02');
INSERT INTO `os_icons` VALUES ('79', '&#xe648;', 'layui-icon-align-right', '右对齐', '0', '2018-12-03 13:58:02', '2018-12-03 13:58:02');
INSERT INTO `os_icons` VALUES ('80', '&#xe647;', 'layui-icon-align-center', '居中对齐', '0', '2018-12-03 13:58:02', '2018-12-03 13:58:02');
INSERT INTO `os_icons` VALUES ('81', '&#xe646;', 'layui-icon-fonts-u', '字体-下划线', '0', '2018-12-03 13:58:02', '2018-12-03 13:58:02');
INSERT INTO `os_icons` VALUES ('82', '&#xe644;', 'layui-icon-fonts-i', '字体-斜体', '0', '2018-12-03 13:58:02', '2018-12-03 13:58:02');
INSERT INTO `os_icons` VALUES ('83', '&#xe62a;', 'layui-icon-tabs', 'Tabs 选项卡', '0', '2018-12-03 13:58:02', '2018-12-03 13:58:02');
INSERT INTO `os_icons` VALUES ('84', '&#xe643;', 'layui-icon-radio', '单选框-选中', '0', '2018-12-03 13:58:02', '2018-12-03 13:58:02');
INSERT INTO `os_icons` VALUES ('85', '&#xe63f;', 'layui-icon-circle', '单选框-候选', '0', '2018-12-03 13:58:02', '2018-12-03 13:58:02');
INSERT INTO `os_icons` VALUES ('86', '&#xe642;', 'layui-icon-edit', '编辑', '0', '2018-12-03 13:58:02', '2018-12-03 13:58:02');
INSERT INTO `os_icons` VALUES ('87', '&#xe641;', 'layui-icon-share', '分享', '0', '2018-12-03 13:58:02', '2018-12-03 13:58:02');
INSERT INTO `os_icons` VALUES ('88', '&#xe640;', 'layui-icon-delete', '删除', '0', '2018-12-03 13:58:02', '2018-12-03 13:58:02');
INSERT INTO `os_icons` VALUES ('89', '&#xe63c;', 'layui-icon-form', '表单', '0', '2018-12-03 13:58:02', '2018-12-03 13:58:02');
INSERT INTO `os_icons` VALUES ('90', '&#xe63b;', 'layui-icon-cellphone-fine', '手机-细体', '0', '2018-12-03 13:58:02', '2018-12-03 13:58:02');
INSERT INTO `os_icons` VALUES ('91', '&#xe63a;', 'layui-icon-dialogue', '聊天 对话 沟通', '0', '2018-12-03 13:58:02', '2018-12-03 13:58:02');
INSERT INTO `os_icons` VALUES ('92', '&#xe639;', 'layui-icon-fonts-clear', '文字格式化', '0', '2018-12-03 13:58:02', '2018-12-03 13:58:02');
INSERT INTO `os_icons` VALUES ('93', '&#xe638;', 'layui-icon-layer', '窗口', '0', '2018-12-03 13:58:02', '2018-12-03 13:58:02');
INSERT INTO `os_icons` VALUES ('94', '&#xe637;', 'layui-icon-date', '日期', '0', '2018-12-03 13:58:02', '2018-12-03 13:58:02');
INSERT INTO `os_icons` VALUES ('95', '&#xe636;', 'layui-icon-water', '水 下雨', '0', '2018-12-03 13:58:02', '2018-12-03 13:58:02');
INSERT INTO `os_icons` VALUES ('96', '&#xe635;', 'layui-icon-code-circle', '代码-圆圈', '0', '2018-12-03 13:58:02', '2018-12-03 13:58:02');
INSERT INTO `os_icons` VALUES ('97', '&#xe634;', 'layui-icon-carousel', '轮播组图', '0', '2018-12-03 13:58:02', '2018-12-03 13:58:02');
INSERT INTO `os_icons` VALUES ('98', '&#xe633;', 'layui-icon-prev-circle', '翻页', '0', '2018-12-03 13:58:02', '2018-12-03 13:58:02');
INSERT INTO `os_icons` VALUES ('99', '&#xe632;', 'layui-icon-layouts', '布局', '0', '2018-12-03 13:58:02', '2018-12-03 13:58:02');
INSERT INTO `os_icons` VALUES ('100', '&#xe631;', 'layui-icon-util', '工具', '0', '2018-12-03 13:58:02', '2018-12-03 13:58:02');
INSERT INTO `os_icons` VALUES ('101', '&#xe630;', 'layui-icon-templeate-1', '选择模板', '0', '2018-12-03 13:58:02', '2018-12-03 13:58:02');
INSERT INTO `os_icons` VALUES ('102', '&#xe62f;', 'layui-icon-upload-circle', '上传-圆圈', '0', '2018-12-03 13:58:02', '2018-12-03 13:58:02');
INSERT INTO `os_icons` VALUES ('103', '&#xe62e;', 'layui-icon-tree', '树', '0', '2018-12-03 13:58:02', '2018-12-03 13:58:02');
INSERT INTO `os_icons` VALUES ('104', '&#xe62d;', 'layui-icon-table', '表格', '0', '2018-12-03 13:58:02', '2018-12-03 13:58:02');
INSERT INTO `os_icons` VALUES ('105', '&#xe62c;', 'layui-icon-chart', '图表', '0', '2018-12-03 13:58:03', '2018-12-03 13:58:03');
INSERT INTO `os_icons` VALUES ('106', '&#xe629;', 'layui-icon-chart-screen', '图标 报表 屏幕', '0', '2018-12-03 13:58:03', '2018-12-03 13:58:03');
INSERT INTO `os_icons` VALUES ('107', '&#xe628;', 'layui-icon-engine', '引擎', '0', '2018-12-03 13:58:03', '2018-12-03 13:58:03');
INSERT INTO `os_icons` VALUES ('108', '&#xe625;', 'layui-icon-triangle-d', '下三角', '0', '2018-12-03 13:58:03', '2018-12-03 13:58:03');
INSERT INTO `os_icons` VALUES ('109', '&#xe623;', 'layui-icon-triangle-r', '右三角', '0', '2018-12-03 13:58:03', '2018-12-03 13:58:03');
INSERT INTO `os_icons` VALUES ('110', '&#xe621;', 'layui-icon-file', '文件', '0', '2018-12-03 13:58:03', '2018-12-03 13:58:03');
INSERT INTO `os_icons` VALUES ('111', '&#xe620;', 'layui-icon-set-sm', '设置-小型', '0', '2018-12-03 13:58:03', '2018-12-03 13:58:03');
INSERT INTO `os_icons` VALUES ('112', '&#xe61f;', 'layui-icon-add-circle', '添加-圆圈', '0', '2018-12-03 13:58:03', '2018-12-03 13:58:03');
INSERT INTO `os_icons` VALUES ('113', '&#xe61c;', 'layui-icon-404', '404', '0', '2018-12-03 13:58:03', '2018-12-03 13:58:03');
INSERT INTO `os_icons` VALUES ('114', '&#xe60b;', 'layui-icon-about', '关于', '0', '2018-12-03 13:58:03', '2018-12-03 13:58:03');
INSERT INTO `os_icons` VALUES ('115', '&#xe619;', 'layui-icon-up', '箭头 向上', '0', '2018-12-03 13:58:03', '2018-12-03 13:58:03');
INSERT INTO `os_icons` VALUES ('116', '&#xe61a;', 'layui-icon-down', '箭头 向下', '0', '2018-12-03 13:58:03', '2018-12-03 13:58:03');
INSERT INTO `os_icons` VALUES ('117', '&#xe603;', 'layui-icon-left', '箭头 向左', '0', '2018-12-03 13:58:03', '2018-12-03 13:58:03');
INSERT INTO `os_icons` VALUES ('118', '&#xe602;', 'layui-icon-right', '箭头 向右', '0', '2018-12-03 13:58:03', '2018-12-03 13:58:03');
INSERT INTO `os_icons` VALUES ('119', '&#xe617;', 'layui-icon-circle-dot', '圆点', '0', '2018-12-03 13:58:03', '2018-12-03 13:58:03');
INSERT INTO `os_icons` VALUES ('120', '&#xe615;', 'layui-icon-search', '搜索', '0', '2018-12-03 13:58:03', '2018-12-03 13:58:03');
INSERT INTO `os_icons` VALUES ('121', '&#xe614;', 'layui-icon-set-fill', '设置-实心', '0', '2018-12-03 13:58:03', '2018-12-03 13:58:03');
INSERT INTO `os_icons` VALUES ('122', '&#xe613;', 'layui-icon-group', '群组', '0', '2018-12-03 13:58:03', '2018-12-03 13:58:03');
INSERT INTO `os_icons` VALUES ('123', '&#xe612;', 'layui-icon-friends', '好友', '0', '2018-12-03 13:58:03', '2018-12-03 13:58:03');
INSERT INTO `os_icons` VALUES ('124', '&#xe611;', 'layui-icon-reply-fill', '回复 评论 实心', '0', '2018-12-03 13:58:03', '2018-12-03 13:58:03');
INSERT INTO `os_icons` VALUES ('125', '&#xe60f;', 'layui-icon-menu-fill', '菜单 隐身 实心', '0', '2018-12-03 13:58:03', '2018-12-03 13:58:03');
INSERT INTO `os_icons` VALUES ('126', '&#xe60e;', 'layui-icon-log', '记录', '0', '2018-12-03 13:58:03', '2018-12-03 13:58:03');
INSERT INTO `os_icons` VALUES ('127', '&#xe60d;', 'layui-icon-picture-fine', '图片-细体', '0', '2018-12-03 13:58:03', '2018-12-03 13:58:03');
INSERT INTO `os_icons` VALUES ('128', '&#xe60c;', 'layui-icon-face-smile-fine', '表情-笑-细体', '0', '2018-12-03 13:58:03', '2018-12-03 13:58:03');
INSERT INTO `os_icons` VALUES ('129', '&#xe60a;', 'layui-icon-list', '列表', '0', '2018-12-03 13:58:03', '2018-12-03 13:58:03');
INSERT INTO `os_icons` VALUES ('130', '&#xe609;', 'layui-icon-release', '发布 纸飞机', '0', '2018-12-03 13:58:03', '2018-12-03 13:58:03');
INSERT INTO `os_icons` VALUES ('131', '&#xe605;', 'layui-icon-ok', '对 OK', '0', '2018-12-03 13:58:03', '2018-12-03 13:58:03');
INSERT INTO `os_icons` VALUES ('132', '&#xe607;', 'layui-icon-help', '帮助', '0', '2018-12-03 13:58:03', '2018-12-03 13:58:03');
INSERT INTO `os_icons` VALUES ('133', '&#xe606;', 'layui-icon-chat', '客服', '0', '2018-12-03 13:58:03', '2018-12-03 13:58:03');
INSERT INTO `os_icons` VALUES ('134', '&#xe604;', 'layui-icon-top', 'top 置顶', '0', '2018-12-03 13:58:03', '2018-12-03 13:58:03');
INSERT INTO `os_icons` VALUES ('135', '&#xe600;', 'layui-icon-star', '收藏-空心', '0', '2018-12-03 13:58:04', '2018-12-03 13:58:04');
INSERT INTO `os_icons` VALUES ('136', '&#xe658;', 'layui-icon-star-fill', '收藏-实心', '0', '2018-12-03 13:58:04', '2018-12-03 13:58:04');
INSERT INTO `os_icons` VALUES ('137', '&#x1007;', 'layui-icon-close-fill', '关闭-实心', '0', '2018-12-03 13:58:04', '2018-12-03 13:58:04');
INSERT INTO `os_icons` VALUES ('138', '&#x1006;', 'layui-icon-close', '关闭-空心', '0', '2018-12-03 13:58:04', '2018-12-03 13:58:04');
INSERT INTO `os_icons` VALUES ('139', '&#x1005;', 'layui-icon-ok-circle', '正确', '0', '2018-12-03 13:58:04', '2018-12-03 13:58:04');
INSERT INTO `os_icons` VALUES ('140', '&#xe608;', 'layui-icon-add-circle-fine', '添加-圆圈-细体', '0', '2018-12-03 13:58:04', '2018-12-03 13:58:04');
