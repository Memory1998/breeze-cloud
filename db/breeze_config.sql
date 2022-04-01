/*
 Navicat Premium Data Transfer

 Source Server         : localhost_docker
 Source Server Type    : MySQL
 Source Server Version : 50736
 Source Host           : localhost:3306
 Source Schema         : breeze_config

 Target Server Type    : MySQL
 Target Server Version : 50736
 File Encoding         : 65001

 Date: 01/04/2022 16:23:42
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for config_info
-- ----------------------------
DROP TABLE IF EXISTS `config_info`;
CREATE TABLE `config_info`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `data_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'data_id',
  `group_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `content` longtext CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'content',
  `md5` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT 'md5',
  `gmt_create` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modified` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `src_user` text CHARACTER SET utf8 COLLATE utf8_bin NULL COMMENT 'source user',
  `src_ip` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT 'source ip',
  `app_name` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `tenant_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '' COMMENT '租户字段',
  `c_desc` varchar(256) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `c_use` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `effect` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `type` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `c_schema` text CHARACTER SET utf8 COLLATE utf8_bin NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_configinfo_datagrouptenant`(`data_id`, `group_id`, `tenant_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 59 CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = 'config_info' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of config_info
-- ----------------------------
INSERT INTO `config_info` VALUES (1, 'application-dev.yml', 'DEFAULT_GROUP', '# 认证配置\nsecurity:\n  oauth2:\n    client:\n      client-id: web\n      client-secret: web\n      scope: server\n    resource:\n      loadBalanced: true\n      token-info-uri: http://breeze-oauth-server/oauth/check_token\n    ignore:\n      urls:\n        - /v2/api-docs\n        - /actuator/**\n        - /swaggger-ui.html\n        - /doc.html\n        - /v2/**\n        - /swagger-resources\n        - /swagger-resources/**\n        - /webjars/**\n        - /toError\n        - /login\n\n# feign 公共配置\nfeign:\n  sentinel:\n    enabled: true\n  okhttp:\n    enabled: true\n  httpclient:\n    enabled: false\n  client:\n    config:\n      default:\n        connectTimeout: 10000\n        readTimeout: 10000\n  compression:\n    request:\n      enabled: true\n    response:\n      enabled: true\n\n# ribbon 请求处理的超时时间\nribbon:\n  ReadTimeout: 10000\n  ConnectTimeout: 10000\n\n# 暴露监控端点\nmanagement:\n  endpoints:\n    web:\n      exposure:\n        include: \'*\'\nlogging:\n  config: \n    classpath: logback-spring.xml\n\n\nknife4j:\n  enable: true\n\nspring: \n  main: \n    allow-circular-references: true\n  mvc:\n    pathmatch:\n      matching-strategy: ANT_PATH_MATCHER', 'be86b6ee13f53a5f7a8e86933dd6d9b5', '2019-11-29 16:31:20', '2022-04-01 08:19:58', 'nacos', '172.20.0.1', '', '', '', '', '', 'yaml', '');
INSERT INTO `config_info` VALUES (41, 'breeze-admin-server-dev.yml', 'DEFAULT_GROUP', '# Spring\nspring: \n  redis:\n    host: breeze-redis\n    port: 6379\n    password: breeze\n  datasource:\n    driver-class-name: com.mysql.cj.jdbc.Driver\n    url: jdbc:mysql://breeze-mysql:3306/breeze_admin?useUnicode=true&characterEncoding=utf8&zeroDateTimeBehavior=convertToNull&useSSL=true&serverTimezone=GMT%2B8\n    username: root\n    password: root\n    # 开启sql语句自动加载，只认识名为： schema-all.sql和schema.sql和data-all.sql和data.sql的sql语句\n    # initialization-mode: always\n    # 数据源其他配置\n    initialSize: 5\n    minIdle: 5\n    maxActive: 20\n    maxWait: 60000\n    timeBetweenEvictionRunsMillis: 60000\n    minEvictableIdleTimeMillis: 300000\n    validationQuery: SELECT 1 FROM DUAL\n    testWhileIdle: true\n    testOnBorrow: false\n    testOnReturn: false\n    poolPreparedStatements: true\n    maxPoolPreparedStatementPerConnectionSize: 20\n    useGlobalDataSourceStat: true\n    connectionProperties: druid.stat.mergeSql=true;druid.stat.slowSqlMillis=500\n    # 配置监控统计拦截的filters，去掉后监控界面sql无法统计，\'wall\'用于防火墙\n    filters: stat,wall\n\n# mybatis-plus 配置\nmybatis-plus:\n  mapper-locations: classpath:/mapper/*Mapper.xml\n  global-config:\n    banner: true\n    db-config:\n      id-type: auto\n      select-strategy: not_empty\n      insert-strategy: not_empty\n      update-strategy: not_empty\n  configuration:\n    jdbc-type-for-null: null\n    # 逻辑删除\n    db-config:\n      logic-delete-field: flag  # 全局逻辑删除的实体字段名(since 3.3.0,配置后可以忽略不配置步骤2)\n      logic-delete-value: 1 # 逻辑已删除值(默认为 1)\n      logic-not-delete-value: 0 # 逻辑未删除值(默认为 0)\n    #mybatis-plus配置控制台打印完整带参数SQL语句\n    log-impl: org.apache.ibatis.logging.stdout.StdOutImpl\n  # 搜索指定包别名\n  typeAliasesPackage: com.breeze.**.entity', '9fd000357ae3028c58b1ee33463b0336', '2021-12-07 12:21:47', '2022-04-01 03:05:14', 'nacos', '172.20.0.1', '', '', '', '', '', 'yaml', '');
INSERT INTO `config_info` VALUES (47, 'breeze-oauth-server-dev.yml', 'DEFAULT_GROUP', 'spring:\n  redis:\n    host: breeze-redis\n    port: 6379\n    password: breeze', '5cf6999e9a7367637ce81afbbdc131bf', '2022-01-26 06:18:26', '2022-04-01 03:10:18', 'nacos', '172.20.0.1', '', '', '', '', '', 'yaml', '');
INSERT INTO `config_info` VALUES (48, 'breeze-gateway-server-dev.yml', 'DEFAULT_GROUP', 'spring:\n  redis:\n    host: localhost\n    port: 6379\n    password: breeze\n  cloud:\n    gateway:\n      discovery:\n        locator:\n          lowerCaseServiceId: true\n          enabled: true\n      routes:\n        # oauth2中心\n        - id: breeze-oauth-server\n          uri: lb://breeze-oauth-server\n          predicates:\n            - Path=/oauth2/**\n          filters:\n            - StripPrefix=1\n\n        # 系统模块\n        - id: breeze-admin-server\n          uri: lb://breeze-admin-server\n          predicates:\n            - Path=/admin/**\n          filters:\n            - StripPrefix=1\n\n\n# 滑动验证，底图路径，不配置将使用默认图片\n# 支持全路径\n# 支持项目路径,以classpath:开头,取resource目录下路径,例：classpath:images/jigsaw\naj:\n  captcha:\n    # jigsaw: classpath:images/jigsaw\n    # #滑动验证，底图路径，不配置将使用默认图片\n    # ##支持全路径\n    # # 支持项目路径,以classpath:开头,取resource目录下路径,例：classpath:images/pic-click\n    # pic-click: classpath:images/pic-click\n\n    # 对于分布式部署的应用，我们建议应用自己实现CaptchaCacheService，比如用Redis或者memcache，\n    # 参考CaptchaCacheServiceRedisImpl.java\n    # 如果应用是单点的，也没有使用redis，那默认使用内存。\n    # 内存缓存只适合单节点部署的应用，否则验证码生产与验证在节点之间信息不同步，导致失败。\n    # ！！！ 注意啦，如果应用有使用spring-boot-starter-data-redis，\n    # 请打开CaptchaCacheServiceRedisImpl.java注释。\n    # redis ----->  SPI： 在resources目录新建META-INF.services文件夹(两层)，参考当前服务resources。\n    # 缓存local/redis...\n    cache-type: redis\n    # local缓存的阈值,达到这个值，清除缓存\n    cache-number: 1000\n    # local定时清除过期缓存(单位秒),设置为0代表不执行\n    timing-clear: 180\n\n    # 验证码类型default两种都实例化。\n    type: default\n    # 汉字统一使用Unicode,保证程序通过@value读取到是中文，可通过这个在线转换;yml格式不需要转换\n    # https://tool.chinaz.com/tools/unicode.aspx 中文转Unicode\n    # 右下角水印文字(我的水印)\n    water-mark: \\u6211\\u7684\\u6c34\\u5370\n    # 右下角水印字体(不配置时，默认使用文泉驿正黑)\n    # 由于宋体等涉及到版权，我们jar中内置了开源字体【文泉驿正黑】\n    # 方式一：直接配置OS层的现有的字体名称，比如：宋体\n    # 方式二：自定义特定字体，请将字体放到工程resources下fonts文件夹，支持ttf\\ttc\\otf字体\n    # aj.captcha.water-font=WenQuanZhengHei.ttf\n    # 点选文字验证码的文字字体(文泉驿正黑)\n    # aj.captcha.font-type=WenQuanZhengHei.ttf\n    # 校验滑动拼图允许误差偏移量(默认5像素)\n    slip-offset: 5\n    # aes加密坐标开启或者禁用(true|false)\n    aes-status: true\n    # 滑动干扰项(0/1/2)\n    interference-options: 2\n\n    #点选字体样式 默认Font.BOLD\n    font-style: 1\n    #点选字体字体大小\n    font-size: 25\n    #点选文字个数,存在问题，暂不支持修改\n    #aj.captcha.click-word-count=4\n\n    history-data-clear-enable: false\n\n    # 接口请求次数一分钟限制是否开启 true|false\n    req-frequency-limit-enable: false\n    # 验证失败5次，get接口锁定\n    req-get-lock-limit: 5\n    # 验证失败后，锁定时间间隔,s\n    req-get-lock-seconds: 360\n    # get接口一分钟内请求数限制\n    req-get-minute-limit: 30\n    # check接口一分钟内请求数限制\n    req-check-minute-limit: 60\n    # verify接口一分钟内请求数限制\n    req-verify-minute-limit: 60', 'b55f23251047ffec8ef118af5d50455b', '2022-01-26 06:18:52', '2022-02-17 08:04:53', 'nacos', '172.20.0.1', '', '', '', '', '', 'yaml', '');

-- ----------------------------
-- Table structure for config_info_aggr
-- ----------------------------
DROP TABLE IF EXISTS `config_info_aggr`;
CREATE TABLE `config_info_aggr`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `data_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'data_id',
  `group_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'group_id',
  `datum_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'datum_id',
  `content` longtext CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '内容',
  `gmt_modified` datetime(0) NOT NULL COMMENT '修改时间',
  `app_name` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `tenant_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '' COMMENT '租户字段',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_configinfoaggr_datagrouptenantdatum`(`data_id`, `group_id`, `tenant_id`, `datum_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '增加租户字段' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for config_info_beta
-- ----------------------------
DROP TABLE IF EXISTS `config_info_beta`;
CREATE TABLE `config_info_beta`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `data_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'data_id',
  `group_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'group_id',
  `app_name` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT 'app_name',
  `content` longtext CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'content',
  `beta_ips` varchar(1024) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT 'betaIps',
  `md5` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT 'md5',
  `gmt_create` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modified` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `src_user` text CHARACTER SET utf8 COLLATE utf8_bin NULL COMMENT 'source user',
  `src_ip` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT 'source ip',
  `tenant_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '' COMMENT '租户字段',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_configinfobeta_datagrouptenant`(`data_id`, `group_id`, `tenant_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = 'config_info_beta' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for config_info_tag
-- ----------------------------
DROP TABLE IF EXISTS `config_info_tag`;
CREATE TABLE `config_info_tag`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `data_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'data_id',
  `group_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'group_id',
  `tenant_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '' COMMENT 'tenant_id',
  `tag_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'tag_id',
  `app_name` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT 'app_name',
  `content` longtext CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'content',
  `md5` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT 'md5',
  `gmt_create` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modified` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `src_user` text CHARACTER SET utf8 COLLATE utf8_bin NULL COMMENT 'source user',
  `src_ip` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT 'source ip',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_configinfotag_datagrouptenanttag`(`data_id`, `group_id`, `tenant_id`, `tag_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = 'config_info_tag' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for config_tags_relation
-- ----------------------------
DROP TABLE IF EXISTS `config_tags_relation`;
CREATE TABLE `config_tags_relation`  (
  `id` bigint(20) NOT NULL COMMENT 'id',
  `tag_name` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'tag_name',
  `tag_type` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT 'tag_type',
  `data_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'data_id',
  `group_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'group_id',
  `tenant_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '' COMMENT 'tenant_id',
  `nid` bigint(20) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`nid`) USING BTREE,
  UNIQUE INDEX `uk_configtagrelation_configidtag`(`id`, `tag_name`, `tag_type`) USING BTREE,
  INDEX `idx_tenant_id`(`tenant_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = 'config_tag_relation' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for group_capacity
-- ----------------------------
DROP TABLE IF EXISTS `group_capacity`;
CREATE TABLE `group_capacity`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `group_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT 'Group ID，空字符表示整个集群',
  `quota` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '配额，0表示使用默认值',
  `usage` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '使用量',
  `max_size` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '单个配置大小上限，单位为字节，0表示使用默认值',
  `max_aggr_count` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '聚合子配置最大个数，，0表示使用默认值',
  `max_aggr_size` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '单个聚合数据的子配置大小上限，单位为字节，0表示使用默认值',
  `max_history_count` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '最大变更历史数量',
  `gmt_create` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modified` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_group_id`(`group_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '集群、各Group容量信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for his_config_info
-- ----------------------------
DROP TABLE IF EXISTS `his_config_info`;
CREATE TABLE `his_config_info`  (
  `id` bigint(64) UNSIGNED NOT NULL,
  `nid` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `data_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `group_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `app_name` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT 'app_name',
  `content` longtext CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `md5` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `gmt_create` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `gmt_modified` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `src_user` text CHARACTER SET utf8 COLLATE utf8_bin NULL,
  `src_ip` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `op_type` char(10) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `tenant_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '' COMMENT '租户字段',
  PRIMARY KEY (`nid`) USING BTREE,
  INDEX `idx_gmt_create`(`gmt_create`) USING BTREE,
  INDEX `idx_gmt_modified`(`gmt_modified`) USING BTREE,
  INDEX `idx_did`(`data_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '多租户改造' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of his_config_info
-- ----------------------------
INSERT INTO `his_config_info` VALUES (1, 1, 'application-dev.yml', 'DEFAULT_GROUP', '', '# 认证配置\nsecurity:\n  oauth2:\n    client:\n      client-id: web\n      client-secret: web\n      scope: server\n    resource:\n      loadBalanced: true\n      token-info-uri: http://breeze-oauth-server/oauth/check_token\n    ignore:\n      urls:\n        - /v2/api-docs\n        - /actuator/**\n        - /swaggger-ui.html\n        - /doc.html\n        - /v2/**\n        - /swagger-resources\n        - /swagger-resources/**\n        - /webjars/**\n        - /toError\n        - /login\n\n# feign 公共配置\nfeign:\n  sentinel:\n    enabled: true\n  okhttp:\n    enabled: true\n  httpclient:\n    enabled: false\n  client:\n    config:\n      default:\n        connectTimeout: 10000\n        readTimeout: 10000\n  compression:\n    request:\n      enabled: true\n    response:\n      enabled: true\n\n# ribbon 请求处理的超时时间\nribbon:\n  ReadTimeout: 10000\n  ConnectTimeout: 10000\n\n# 暴露监控端点\nmanagement:\n  endpoints:\n    web:\n      exposure:\n        include: \'*\'\n\n\nlogging:\n  config: \n    classpath: logback-spring.xml', '073e3e2e0f3bb9e6308c09661da73df5', '2022-03-31 07:16:01', '2022-03-31 07:16:01', 'nacos', '172.20.0.1', 'U', '');
INSERT INTO `his_config_info` VALUES (41, 2, 'breeze-admin-server-dev.yml', 'DEFAULT_GROUP', '', '# Spring\nspring: \n  redis:\n    host: breeze-redis\n    port: 6379\n    password: breeze\n  datasource:\n    driver-class-name: com.mysql.cj.jdbc.Driver\n    url: jdbc:mysql://breeze-mysql:3306/breeze_admin?useUnicode=true&characterEncoding=utf8&zeroDateTimeBehavior=convertToNull&useSSL=true&serverTimezone=GMT%2B8\n    username: root\n    password: root\n    # 开启sql语句自动加载，只认识名为： schema-all.sql和schema.sql和data-all.sql和data.sql的sql语句\n    # initialization-mode: always\n    # 数据源其他配置\n    initialSize: 5\n    minIdle: 5\n    maxActive: 20\n    maxWait: 60000\n    timeBetweenEvictionRunsMillis: 60000\n    minEvictableIdleTimeMillis: 300000\n    validationQuery: SELECT 1 FROM DUAL\n    testWhileIdle: true\n    testOnBorrow: false\n    testOnReturn: false\n    poolPreparedStatements: true\n    maxPoolPreparedStatementPerConnectionSize: 20\n    useGlobalDataSourceStat: true\n    connectionProperties: druid.stat.mergeSql=true;druid.stat.slowSqlMillis=500\n    # 配置监控统计拦截的filters，去掉后监控界面sql无法统计，\'wall\'用于防火墙\n    filters: stat,wall\n\n# mybatis-plus 配置\nmybatis-plus:\n  mapper-locations: classpath:/mapper/*Mapper.xml\n  global-config:\n    banner: true\n    db-config:\n      id-type: auto\n      select-strategy: not_empty\n      insert-strategy: not_empty\n      update-strategy: not_empty\n  configuration:\n    jdbc-type-for-null: null\n    # 逻辑删除\n    db-config:\n      logic-delete-field: flag  # 全局逻辑删除的实体字段名(since 3.3.0,配置后可以忽略不配置步骤2)\n      logic-delete-value: 1 # 逻辑已删除值(默认为 1)\n      logic-not-delete-value: 0 # 逻辑未删除值(默认为 0)\n    #mybatis-plus配置控制台打印完整带参数SQL语句\n    log-impl: org.apache.ibatis.logging.stdout.StdOutImpl\n  # 搜索指定包别名\n  typeAliasesPackage: com.breeze.**.entity', '9fd000357ae3028c58b1ee33463b0336', '2022-03-31 07:17:27', '2022-03-31 07:17:27', 'nacos', '172.20.0.1', 'U', '');
INSERT INTO `his_config_info` VALUES (1, 3, 'application-dev.yml', 'DEFAULT_GROUP', '', '# 认证配置\nsecurity:\n  oauth2:\n    client:\n      client-id: web\n      client-secret: web\n      scope: server\n    resource:\n      loadBalanced: true\n      token-info-uri: http://breeze-oauth-server/oauth/check_token\n    ignore:\n      urls:\n        - /v2/api-docs\n        - /actuator/**\n        - /swaggger-ui.html\n        - /doc.html\n        - /v2/**\n        - /swagger-resources\n        - /swagger-resources/**\n        - /webjars/**\n        - /toError\n        - /login\n\n# feign 公共配置\nfeign:\n  sentinel:\n    enabled: true\n  okhttp:\n    enabled: true\n  httpclient:\n    enabled: false\n  client:\n    config:\n      default:\n        connectTimeout: 10000\n        readTimeout: 10000\n  compression:\n    request:\n      enabled: true\n    response:\n      enabled: true\n\n# ribbon 请求处理的超时时间\nribbon:\n  ReadTimeout: 10000\n  ConnectTimeout: 10000\n\n# 暴露监控端点\nmanagement:\n  endpoints:\n    web:\n      exposure:\n        include: \'*\'\n\n\nlogging:\n  config: \n    classpath: logback-spring.xml\n\nspring: \n  main: \n    allow-circular-references: true', '4b6726e415c09cb55afe6ed5166e6537', '2022-04-01 03:02:28', '2022-04-01 03:02:29', 'nacos', '172.20.0.1', 'U', '');
INSERT INTO `his_config_info` VALUES (41, 4, 'breeze-admin-server-dev.yml', 'DEFAULT_GROUP', '', '# Spring\nspring: \n  main: \n    allow-circular-references: true\n  redis:\n    host: breeze-redis\n    port: 6379\n    password: breeze\n  datasource:\n    driver-class-name: com.mysql.cj.jdbc.Driver\n    url: jdbc:mysql://breeze-mysql:3306/breeze_admin?useUnicode=true&characterEncoding=utf8&zeroDateTimeBehavior=convertToNull&useSSL=true&serverTimezone=GMT%2B8\n    username: root\n    password: root\n    # 开启sql语句自动加载，只认识名为： schema-all.sql和schema.sql和data-all.sql和data.sql的sql语句\n    # initialization-mode: always\n    # 数据源其他配置\n    initialSize: 5\n    minIdle: 5\n    maxActive: 20\n    maxWait: 60000\n    timeBetweenEvictionRunsMillis: 60000\n    minEvictableIdleTimeMillis: 300000\n    validationQuery: SELECT 1 FROM DUAL\n    testWhileIdle: true\n    testOnBorrow: false\n    testOnReturn: false\n    poolPreparedStatements: true\n    maxPoolPreparedStatementPerConnectionSize: 20\n    useGlobalDataSourceStat: true\n    connectionProperties: druid.stat.mergeSql=true;druid.stat.slowSqlMillis=500\n    # 配置监控统计拦截的filters，去掉后监控界面sql无法统计，\'wall\'用于防火墙\n    filters: stat,wall\n\n# mybatis-plus 配置\nmybatis-plus:\n  mapper-locations: classpath:/mapper/*Mapper.xml\n  global-config:\n    banner: true\n    db-config:\n      id-type: auto\n      select-strategy: not_empty\n      insert-strategy: not_empty\n      update-strategy: not_empty\n  configuration:\n    jdbc-type-for-null: null\n    # 逻辑删除\n    db-config:\n      logic-delete-field: flag  # 全局逻辑删除的实体字段名(since 3.3.0,配置后可以忽略不配置步骤2)\n      logic-delete-value: 1 # 逻辑已删除值(默认为 1)\n      logic-not-delete-value: 0 # 逻辑未删除值(默认为 0)\n    #mybatis-plus配置控制台打印完整带参数SQL语句\n    log-impl: org.apache.ibatis.logging.stdout.StdOutImpl\n  # 搜索指定包别名\n  typeAliasesPackage: com.breeze.**.entity', '8f3e9c44d5fc29e822a3207a5cf9c36a', '2022-04-01 03:05:14', '2022-04-01 03:05:14', 'nacos', '172.20.0.1', 'U', '');
INSERT INTO `his_config_info` VALUES (1, 5, 'application-dev.yml', 'DEFAULT_GROUP', '', '# 认证配置\nsecurity:\n  oauth2:\n    client:\n      client-id: web\n      client-secret: web\n      scope: server\n    resource:\n      loadBalanced: true\n      token-info-uri: http://breeze-oauth-server/oauth/check_token\n    ignore:\n      urls:\n        - /v2/api-docs\n        - /actuator/**\n        - /swaggger-ui.html\n        - /doc.html\n        - /v2/**\n        - /swagger-resources\n        - /swagger-resources/**\n        - /webjars/**\n        - /toError\n        - /login\n\n# feign 公共配置\nfeign:\n  sentinel:\n    enabled: true\n  okhttp:\n    enabled: true\n  httpclient:\n    enabled: false\n  client:\n    config:\n      default:\n        connectTimeout: 10000\n        readTimeout: 10000\n  compression:\n    request:\n      enabled: true\n    response:\n      enabled: true\n\n# ribbon 请求处理的超时时间\nribbon:\n  ReadTimeout: 10000\n  ConnectTimeout: 10000\n\n# 暴露监控端点\nmanagement:\n  endpoints:\n    web:\n      exposure:\n        include: \'*\'\n\n\nlogging:\n  config: \n    classpath: logback-spring.xml\n\nspring: \n  main: \n    allow-circular-references: true\n  mvc:\n    pathmatch:\n      matching-strategy: ANT_PATH_MATCHER', '9f3d791cf1e8b4df12cde26376d7ff10', '2022-04-01 03:06:50', '2022-04-01 03:06:50', 'nacos', '172.20.0.1', 'U', '');
INSERT INTO `his_config_info` VALUES (1, 6, 'application-dev.yml', 'DEFAULT_GROUP', '', '# 认证配置\nsecurity:\n  oauth2:\n    client:\n      client-id: web\n      client-secret: web\n      scope: server\n    resource:\n      loadBalanced: true\n      token-info-uri: http://breeze-oauth-server/oauth/check_token\n    ignore:\n      urls:\n        - /v2/api-docs\n        - /actuator/**\n        - /swaggger-ui.html\n        - /doc.html\n        - /v2/**\n        - /swagger-resources\n        - /swagger-resources/**\n        - /webjars/**\n        - /toError\n        - /login\n\n# feign 公共配置\nfeign:\n  sentinel:\n    enabled: true\n  okhttp:\n    enabled: true\n  httpclient:\n    enabled: false\n  client:\n    config:\n      default:\n        connectTimeout: 10000\n        readTimeout: 10000\n  compression:\n    request:\n      enabled: true\n    response:\n      enabled: true\n\n# ribbon 请求处理的超时时间\nribbon:\n  ReadTimeout: 10000\n  ConnectTimeout: 10000\n\n# 暴露监控端点\nmanagement:\n  endpoints:\n    web:\n      exposure:\n        include: \'*\'\n\n\nlogging:\n  config: \n    classpath: logback-spring.xml', '073e3e2e0f3bb9e6308c09661da73df5', '2022-04-01 03:07:41', '2022-04-01 03:07:41', 'nacos', '172.20.0.1', 'U', '');
INSERT INTO `his_config_info` VALUES (47, 7, 'breeze-oauth-server-dev.yml', 'DEFAULT_GROUP', '', 'spring:\n  redis:\n    host: breeze-redis\n    port: 6379\n    password: breeze', '5cf6999e9a7367637ce81afbbdc131bf', '2022-04-01 03:08:51', '2022-04-01 03:08:51', 'nacos', '172.20.0.1', 'U', '');
INSERT INTO `his_config_info` VALUES (47, 8, 'breeze-oauth-server-dev.yml', 'DEFAULT_GROUP', '', 'spring:\n  redis:\n    host: breeze-redis\n    port: 6379\n    password: breeze\n  main:\n    allow-circular-references: true\n  mvc:\n    pathmatch:\n      matching-strategy: ANT_PATH_MATCHER', '8f9e1811e691429e8ea5071ae1009649', '2022-04-01 03:10:17', '2022-04-01 03:10:18', 'nacos', '172.20.0.1', 'U', '');
INSERT INTO `his_config_info` VALUES (1, 9, 'application-dev.yml', 'DEFAULT_GROUP', '', '# 认证配置\nsecurity:\n  oauth2:\n    client:\n      client-id: web\n      client-secret: web\n      scope: server\n    resource:\n      loadBalanced: true\n      token-info-uri: http://breeze-oauth-server/oauth/check_token\n    ignore:\n      urls:\n        - /v2/api-docs\n        - /actuator/**\n        - /swaggger-ui.html\n        - /doc.html\n        - /v2/**\n        - /swagger-resources\n        - /swagger-resources/**\n        - /webjars/**\n        - /toError\n        - /login\n\n# feign 公共配置\nfeign:\n  sentinel:\n    enabled: true\n  okhttp:\n    enabled: true\n  httpclient:\n    enabled: false\n  client:\n    config:\n      default:\n        connectTimeout: 10000\n        readTimeout: 10000\n  compression:\n    request:\n      enabled: true\n    response:\n      enabled: true\n\n# ribbon 请求处理的超时时间\nribbon:\n  ReadTimeout: 10000\n  ConnectTimeout: 10000\n\n# 暴露监控端点\nmanagement:\n  endpoints:\n    web:\n      exposure:\n        include: \'*\'\nlogging:\n  config: \n    classpath: logback-spring.xml\n\nspring: \n  main: \n    allow-circular-references: true\n  mvc:\n    pathmatch:\n      matching-strategy: ANT_PATH_MATCHER', 'b3034e09f6cd9b75daa227a6d8e089cc', '2022-04-01 08:19:22', '2022-04-01 08:19:22', 'nacos', '172.20.0.1', 'U', '');
INSERT INTO `his_config_info` VALUES (1, 10, 'application-dev.yml', 'DEFAULT_GROUP', '', '# 认证配置\nsecurity:\n  oauth2:\n    client:\n      client-id: web\n      client-secret: web\n      scope: server\n    resource:\n      loadBalanced: true\n      token-info-uri: http://breeze-oauth-server/oauth/check_token\n    ignore:\n      urls:\n        - /v2/api-docs\n        - /actuator/**\n        - /swaggger-ui.html\n        - /doc.html\n        - /v2/**\n        - /swagger-resources\n        - /swagger-resources/**\n        - /webjars/**\n        - /toError\n        - /login\n\n# feign 公共配置\nfeign:\n  sentinel:\n    enabled: true\n  okhttp:\n    enabled: true\n  httpclient:\n    enabled: false\n  client:\n    config:\n      default:\n        connectTimeout: 10000\n        readTimeout: 10000\n  compression:\n    request:\n      enabled: true\n    response:\n      enabled: true\n\n# ribbon 请求处理的超时时间\nribbon:\n  ReadTimeout: 10000\n  ConnectTimeout: 10000\n\n# 暴露监控端点\nmanagement:\n  endpoints:\n    web:\n      exposure:\n        include: \'*\'\nlogging:\n  config: \n    classpath: logback-spring.xml\n\nspring: \n  main: \n    allow-circular-references: true\n  mvc:\n    pathmatch:\n      matching-strategy: ANT_PATH_MATCHER\nknife4j:\n  enable: true', 'b6e72f15908fc28af08d01ec1d2ee9e1', '2022-04-01 08:19:58', '2022-04-01 08:19:58', 'nacos', '172.20.0.1', 'U', '');

-- ----------------------------
-- Table structure for permissions
-- ----------------------------
DROP TABLE IF EXISTS `permissions`;
CREATE TABLE `permissions`  (
  `role` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `resource` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `action` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  UNIQUE INDEX `uk_role_permission`(`role`, `resource`, `action`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for roles
-- ----------------------------
DROP TABLE IF EXISTS `roles`;
CREATE TABLE `roles`  (
  `username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `role` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  UNIQUE INDEX `idx_user_role`(`username`, `role`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of roles
-- ----------------------------
INSERT INTO `roles` VALUES ('nacos', 'ROLE_ADMIN');

-- ----------------------------
-- Table structure for tenant_capacity
-- ----------------------------
DROP TABLE IF EXISTS `tenant_capacity`;
CREATE TABLE `tenant_capacity`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `tenant_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT 'Tenant ID',
  `quota` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '配额，0表示使用默认值',
  `usage` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '使用量',
  `max_size` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '单个配置大小上限，单位为字节，0表示使用默认值',
  `max_aggr_count` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '聚合子配置最大个数',
  `max_aggr_size` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '单个聚合数据的子配置大小上限，单位为字节，0表示使用默认值',
  `max_history_count` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '最大变更历史数量',
  `gmt_create` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modified` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_tenant_id`(`tenant_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '租户容量信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for tenant_info
-- ----------------------------
DROP TABLE IF EXISTS `tenant_info`;
CREATE TABLE `tenant_info`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `kp` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'kp',
  `tenant_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '' COMMENT 'tenant_id',
  `tenant_name` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '' COMMENT 'tenant_name',
  `tenant_desc` varchar(256) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT 'tenant_desc',
  `create_source` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT 'create_source',
  `gmt_create` bigint(20) NOT NULL COMMENT '创建时间',
  `gmt_modified` bigint(20) NOT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_tenant_info_kptenantid`(`kp`, `tenant_id`) USING BTREE,
  INDEX `idx_tenant_id`(`tenant_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = 'tenant_info' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users`  (
  `username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `password` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `enabled` tinyint(1) NOT NULL,
  PRIMARY KEY (`username`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES ('nacos', '$2a$10$EuWPZHzz32dJN7jexM34MOeYirDdFAZm2kuWj7VEOJhhZkDrxfvUu', 1);

SET FOREIGN_KEY_CHECKS = 1;
