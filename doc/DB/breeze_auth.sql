/*
 Navicat Premium Data Transfer

 Source Server         : breeze_mysql
 Source Server Type    : MySQL
 Source Server Version : 80016
 Source Host           : localhost:3366
 Source Schema         : breeze_auth

 Target Server Type    : MySQL
 Target Server Version : 80016
 File Encoding         : 65001

 Date: 09/05/2023 19:55:54
*/

SET NAMES utf8mb4;
SET
FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for auth_registered_client
-- ----------------------------
DROP TABLE IF EXISTS `auth_registered_client`;
CREATE TABLE `auth_registered_client`
(
    `id`                            varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci  NOT NULL COMMENT '主键',
    `client_id`                     varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci  NOT NULL COMMENT '客户端ID',
    `client_id_issued_at`           timestamp(0)                                                   NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '客户端发布日期',
    `client_secret`                 varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '客户端访问密匙',
    `client_secret_expires_at`      timestamp(0) NULL DEFAULT NULL COMMENT '客户端加密到期时间',
    `client_name`                   varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci  NOT NULL COMMENT '客户端名称',
    `client_authentication_methods` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '客户端使用的身份验证方法；[client_secret_basic, client_secret_post, private_key_jwt, client_secret_jwt, none]',
    `authorization_grant_types`     varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '客户端支持的授权许可类型(grant_type)，可选值包括authorization_code,password,refresh_token,client_credentials,注意：passsword在auth2.1弃用了，我们自定义了【password】【sms_code】，若支持多个授权许可类型用逗号,分隔',
    `redirect_uris`                 varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '客户端重定向URI，当grant_type为authorization_code时, 在Oauth2.0流程中会使用并检查，不在此列将被拒绝，使用IP或者域名，不能使用localhost',
    `scopes`                        varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '客户端申请的权限范围，若有多个权限范围用逗号,分隔',
    `client_settings`               varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '客户端自定义设置，包括验证密钥或者是否需要授权页面',
    `token_settings`                varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '发布给客户端的 OAuth2 令牌的自定义设置',
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

SET
FOREIGN_KEY_CHECKS = 1;
