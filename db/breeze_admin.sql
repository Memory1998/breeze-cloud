/*
 Navicat Premium Data Transfer

 Source Server         : breeze_mysql
 Source Server Type    : MySQL
 Source Server Version : 50733
 Source Host           : localhost:3306
 Source Schema         : breeze_admin

 Target Server Type    : MySQL
 Target Server Version : 50733
 File Encoding         : 65001

 Date: 08/03/2022 10:46:24
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for sys_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_dept`;
CREATE TABLE `sys_dept` (
  `id` bigint(22) NOT NULL AUTO_INCREMENT,
  `dept_name` varchar(32) DEFAULT NULL COMMENT '部门名称',
  `parent_id` bigint(22) DEFAULT '0',
  `create_by` varchar(16) DEFAULT NULL,
  `create_name` varchar(16) DEFAULT NULL,
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `update_by` varchar(16) DEFAULT NULL,
  `update_name` varchar(16) DEFAULT NULL,
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `is_delete` int(1) DEFAULT '0',
  `delete_by` varchar(16) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC COMMENT='部门';

-- ----------------------------
-- Records of sys_dept
-- ----------------------------
BEGIN;
INSERT INTO `sys_dept` VALUES (1, 'CTO/CEO', 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL);
INSERT INTO `sys_dept` VALUES (2, '2', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL);
INSERT INTO `sys_dept` VALUES (3, '3', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL);
INSERT INTO `sys_dept` VALUES (4, '4', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL);
INSERT INTO `sys_dept` VALUES (5, '5', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL);
INSERT INTO `sys_dept` VALUES (6, '6', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL);
INSERT INTO `sys_dept` VALUES (7, '7', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL);
INSERT INTO `sys_dept` VALUES (8, '8', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL);
INSERT INTO `sys_dept` VALUES (9, '9', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL);
INSERT INTO `sys_dept` VALUES (10, '10', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL);
COMMIT;

-- ----------------------------
-- Table structure for sys_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_menu`;
CREATE TABLE `sys_menu` (
  `id` bigint(22) NOT NULL AUTO_INCREMENT,
  `platform_id` bigint(11) DEFAULT NULL,
  `title` varchar(32) DEFAULT NULL,
  `name` varchar(32) DEFAULT NULL,
  `sort` int(1) DEFAULT NULL COMMENT '顺序',
  `icon` varchar(255) DEFAULT NULL,
  `parent_id` bigint(22) DEFAULT '0' COMMENT '上一级的菜单ID',
  `permission` varchar(255) DEFAULT NULL COMMENT '权限',
  `path` varchar(32) DEFAULT NULL,
  `url` varchar(32) DEFAULT NULL COMMENT '路径',
  `keep_alive` int(1) DEFAULT '0' COMMENT '保活',
  `visible` int(1) DEFAULT '0' COMMENT '隐藏',
  `create_by` varchar(16) DEFAULT NULL,
  `create_name` varchar(16) DEFAULT NULL,
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `update_by` varchar(16) DEFAULT NULL,
  `update_name` varchar(16) DEFAULT NULL,
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `is_delete` int(1) DEFAULT '0',
  `delete_by` varchar(16) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of sys_menu
-- ----------------------------
BEGIN;
INSERT INTO `sys_menu` VALUES (1, 1, '系统设置', 'System', 1, NULL, 0, '', '/', '', 0, 0, NULL, NULL, '2022-01-28 02:49:34', NULL, NULL, '2022-03-07 14:56:56', 0, NULL);
INSERT INTO `sys_menu` VALUES (2, 1, '平台管理', 'Platform', 1, NULL, 1, 'sys:platform:list', '/platform', '/admin/platform/Platform', 0, 0, NULL, NULL, '2022-02-26 17:31:51', NULL, NULL, '2022-03-07 15:01:36', 0, NULL);
INSERT INTO `sys_menu` VALUES (3, 1, '用户管理', 'User', 2, NULL, 1, 'sys:user:list', '/user', '/admin/user/User', 0, 0, NULL, NULL, '2022-02-27 00:06:55', NULL, NULL, '2022-03-07 15:01:40', 0, NULL);
INSERT INTO `sys_menu` VALUES (4, 1, '菜单管理', 'Menu', 3, NULL, 1, 'sys:menu:list', '/menu', '/admin/menu/Menu', 0, 0, NULL, NULL, '2022-02-27 00:08:30', NULL, NULL, '2022-03-07 15:01:43', 0, NULL);
COMMIT;

-- ----------------------------
-- Table structure for sys_menu_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_menu_role`;
CREATE TABLE `sys_menu_role` (
  `id` bigint(22) NOT NULL AUTO_INCREMENT,
  `menu_id` bigint(22) DEFAULT NULL,
  `role_id` bigint(22) DEFAULT NULL,
  `create_by` varchar(16) DEFAULT NULL,
  `create_name` varchar(16) DEFAULT NULL,
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `update_by` varchar(16) DEFAULT NULL,
  `update_name` varchar(16) DEFAULT NULL,
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `is_delete` int(1) DEFAULT '0',
  `delete_by` varchar(16) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of sys_menu_role
-- ----------------------------
BEGIN;
INSERT INTO `sys_menu_role` VALUES (1, 1, 1, NULL, NULL, '2022-01-28 02:50:24', NULL, NULL, NULL, 0, NULL);
INSERT INTO `sys_menu_role` VALUES (2, 2, 1, NULL, NULL, '2022-02-26 17:33:04', NULL, NULL, NULL, 0, NULL);
INSERT INTO `sys_menu_role` VALUES (3, 3, 1, NULL, NULL, '2022-02-27 00:27:54', NULL, NULL, '2022-02-27 00:27:58', 0, NULL);
INSERT INTO `sys_menu_role` VALUES (4, 4, 1, NULL, NULL, '2022-02-27 00:28:03', NULL, NULL, NULL, 0, NULL);
COMMIT;

-- ----------------------------
-- Table structure for sys_oauth_client_details
-- ----------------------------
DROP TABLE IF EXISTS `sys_oauth_client_details`;
CREATE TABLE `sys_oauth_client_details` (
  `client_id` varchar(255) NOT NULL,
  `resource_ids` varchar(255) DEFAULT NULL,
  `client_secret` varchar(255) DEFAULT NULL,
  `scope` varchar(255) DEFAULT NULL,
  `authorized_grant_types` varchar(255) DEFAULT NULL,
  `web_server_redirect_uri` varchar(255) DEFAULT NULL,
  `authorities` varchar(255) DEFAULT NULL,
  `access_token_validity` int(11) DEFAULT NULL,
  `refresh_token_validity` int(11) DEFAULT NULL,
  `additional_information` text,
  `autoapprove` varchar(255) DEFAULT 'false',
  PRIMARY KEY (`client_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of sys_oauth_client_details
-- ----------------------------
BEGIN;
INSERT INTO `sys_oauth_client_details` VALUES ('web', '', '$2a$10$/K38M0QMcCatM/hB.4WOeulye64ycoUj9LkvMVAfb5vPeggNuJ4hK', 'server', 'password,refresh_token,authorization_code,client_credentials', 'http://localhost:7788/sso/login', NULL, 3600, 7200, NULL, 'true');
COMMIT;

-- ----------------------------
-- Table structure for sys_platform
-- ----------------------------
DROP TABLE IF EXISTS `sys_platform`;
CREATE TABLE `sys_platform` (
  `id` bigint(20) NOT NULL,
  `platform_name` varchar(36) DEFAULT NULL COMMENT '平台名称',
  `platform_code` varchar(16) DEFAULT NULL COMMENT '平台CODE',
  `create_by` varchar(16) DEFAULT NULL,
  `create_name` varchar(16) DEFAULT NULL,
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `update_by` varchar(16) DEFAULT NULL,
  `update_name` varchar(16) DEFAULT NULL,
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `is_delete` int(1) DEFAULT '0',
  `delete_by` varchar(16) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC COMMENT='平台';

-- ----------------------------
-- Records of sys_platform
-- ----------------------------
BEGIN;
INSERT INTO `sys_platform` VALUES (1, '后台管理中心', 'managementCenter', NULL, NULL, '2022-02-27 00:04:17', NULL, NULL, NULL, 0, NULL);
COMMIT;

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role` (
  `id` bigint(22) NOT NULL AUTO_INCREMENT,
  `role_code` varchar(32) DEFAULT NULL,
  `role_name` varchar(32) DEFAULT NULL,
  `create_by` varchar(16) DEFAULT NULL,
  `create_name` varchar(16) DEFAULT NULL,
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `update_by` varchar(16) DEFAULT NULL,
  `update_name` varchar(16) DEFAULT NULL,
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `is_delete` int(1) DEFAULT '0',
  `delete_by` varchar(16) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of sys_role
-- ----------------------------
BEGIN;
INSERT INTO `sys_role` VALUES (1, 'ROLE_ADMIN', '超级管理员', NULL, NULL, '2022-01-28 02:54:10', NULL, NULL, '2022-01-28 02:50:33', 0, NULL);
COMMIT;

-- ----------------------------
-- Table structure for sys_role_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_user`;
CREATE TABLE `sys_role_user` (
  `id` bigint(22) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(22) DEFAULT NULL,
  `role_id` bigint(22) DEFAULT NULL,
  `create_by` varchar(16) DEFAULT NULL,
  `create_name` varchar(16) DEFAULT NULL,
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `update_by` varchar(16) DEFAULT NULL,
  `update_name` varchar(16) DEFAULT NULL,
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `is_delete` int(1) DEFAULT '0',
  `delete_by` varchar(16) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of sys_role_user
-- ----------------------------
BEGIN;
INSERT INTO `sys_role_user` VALUES (1, 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL);
COMMIT;

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user` (
  `id` bigint(22) NOT NULL AUTO_INCREMENT,
  `dept_id` bigint(22) DEFAULT NULL COMMENT '部门ID',
  `amount_name` varchar(32) DEFAULT NULL COMMENT '登录账户',
  `user_code` varchar(32) DEFAULT NULL,
  `username` varchar(32) DEFAULT NULL,
  `password` varchar(128) DEFAULT NULL COMMENT '登录密码',
  `avatar` varchar(128) DEFAULT NULL COMMENT '头像地址',
  `phone` varchar(11) DEFAULT NULL COMMENT '手机号',
  `sex` int(1) DEFAULT NULL COMMENT '性别',
  `id_card` varchar(32) DEFAULT NULL COMMENT '身份证号 备用',
  `amount_type` int(1) DEFAULT NULL COMMENT '类型',
  `is_lock` int(1) DEFAULT NULL COMMENT '锁定',
  `open_id` int(11) DEFAULT NULL COMMENT '微信ID',
  `email` varchar(16) DEFAULT NULL COMMENT '邮件',
  `create_by` varchar(16) DEFAULT NULL,
  `create_name` varchar(16) DEFAULT NULL,
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `update_by` varchar(16) DEFAULT NULL,
  `update_name` varchar(16) DEFAULT NULL,
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `is_delete` int(1) DEFAULT '0',
  `delete_by` varchar(16) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of sys_user
-- ----------------------------
BEGIN;
INSERT INTO `sys_user` VALUES (1, 1, '超级管理员', 'admin', 'admin', '$2a$10$5iXoXrfBV20wzOM1gaMggOrb1TDJIiv6TojbyLc91k.FavfHuMaUW', NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2022-02-16 04:58:22', 0, NULL);
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
