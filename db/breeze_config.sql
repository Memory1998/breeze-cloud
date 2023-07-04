DROP
DATABASE IF EXISTS `breeze_config`;
CREATE
DATABASE  `breeze_config` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

USE `breeze_config`

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
  `src_ip` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT 'source ip',
  `app_name` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `tenant_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '' COMMENT '租户字段',
  `c_desc` varchar(256) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `c_use` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `effect` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `type` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `c_schema` text CHARACTER SET utf8 COLLATE utf8_bin NULL,
  `encrypted_data_key` text CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '秘钥',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_configinfo_datagrouptenant`(`data_id`, `group_id`, `tenant_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1037 CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = 'config_info' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of config_info
-- ----------------------------
INSERT INTO `config_info` VALUES (1, 'application-dev.yml', 'DEFAULT_GROUP', 'spring:\n  # json提交时 [Date Calendar] 的全局序列化和反序列化配置\n  jackson:\n    date-format: yyyy-MM-dd HH:mm:ss\n    time-zone: GMT+8\n  #thymeleaf模板配置\n  thymeleaf:\n    # 开发配置为false，避免改了模板还要重启服务器\n    cache: false\n    # 模板文件视图前缀，默认是classpath:/templates/，可不用配置\n    prefix: classpath:/templates/\n    # 模板文件视图后缀，默认是.html，可不用配置\n    suffix: .html\n    # 检查模板位置，可不用配置\n    check-template-location: true\n    # 编码字符集，默认为utf-8，可不用配置\n    encoding: utf-8\n    # 模板的模式，默认为HTML，可不用配置\n    mode: HTML\n    servlet:\n      # 模板的内容类型，默认为text/html，可不用配置\n      content-type: text/html\n\n  # servlet相关配置\n  servlet:\n    multipart:\n      # 单文件大小限制\n      max-file-size: 10MB\n      # 总上传大小限制\n      max-request-size: 20MB\n\n  # spring-mail 相关配置\n  mail:\n    # 配置邮件服务器的地址\n    host: smtp.qq.com\n    # 配置邮件服务器的端口（465或587）\n    port: 587\n    # 配置用户的账号\n    username: 1900381390@qq.com\n    # 配置用户的密码（即上面我们申请到的授权码）\n    password: szjpgggfodojccah\n    # 配置默认编码\n    default-encoding: UTF-8\n    # SSL 连接配置\n    properties:\n      mail:\n        smtp:\n          socketFactoryClass: javax.net.ssl.SSLSocketFactory\n        # 开启 debug，这样方便开发者查看邮件发送日志\n        debug: true\n    # 自定义发送人邮箱\n    from-address: 1900381390@qq.com\n\n  ## 监控\n  boot:\n    admin:\n      client:\n        # Admin 服务端地址\n        url: ${MONITOR_HOST:http://breeze-monitor}:10000\n        instance:\n          prefer-ip: true\n        # server 用户名\n        username: admin\n        # server 密码\n        password: admin\n\n  ## sentinel全局配置\n  cloud:\n    sentinel:\n      # 关闭context整合\n      web-context-unify: false\n      transport:\n        dashboard: ${SENTINEL_HOST:breeze-sentinel}:${SENTINEL_PORT:8080}\n      #配置限流之后，响应内容\n      scg:\n        fallback:\n          # model参数：response：返回文字提示信息， redirect：重定向跳转，需要配置redirect(跳转的uri路径)\n          mode: response\n          ## 响应的状态\n          response-status: 200\n          ## 响应体\n          response-body: \'{\"code\": 200,\"message\": \"请稍后再试\"}\'\n\n# 开放端点\nmanagement:\n  endpoints:\n    enabled-by-default: true\n    web:\n      exposure:\n        include: \' *\'\n  endpoint:\n    health:\n      show-details: always\n      enabled: true\n    info:\n      enabled: false\n    metrics:\n      enabled: true\n\n# feign 公共配置\nfeign:\n  sentinel: # 开启 sentinel\n    enabled: true\n  okhttp: # 开启 okHttp\n    enabled: false\n  httpclient: # 开启 HttpClient\n    enabled: true\n  client:\n    config:\n      default: # 设置的全局超时时间\n        # 请求连接的超时时间\n        connectTimeout: 2000\n        # 请求处理的超时时间\n        readTimeout: 5000\n  compression:\n    request:\n      enabled: true\n    response:\n      enabled: true\n\n# ribbon配置\nribbon:\n  # 请求连接的超时时间\n  ReadTimeout: 5000\n  # 请求处理的超时时间\n  ConnectionTimeout: 10000\n\n# 全局的日志xml配置文件路径\nlogging:\n  file:\n    config: classpath:logback-spring.xml\n\nbreeze:\n  # 前端传入的密码AES加解密密钥\n  aesSecret: 1234567890123456\n  # 权限过滤路径\n  security:\n    ignore-urls:\n      # SpringDoc\n      - \"/v3/api-docs/**\"\n      - \"/swagger-ui/**\"\n      - \"/swagger-ui.html\"\n      ## Knife4j\n      - \"/doc.html\"\n      - \"/v2/api-docs-ext\"\n      - \"/swagger-resources\"\n      - \"/v2/api-docs\"\n      - \"/swagger-ui.html\"\n      - \"/swagger-resources/configuration/security\"\n      # websocket\n      - \"/ws/**\"\n      # monitor\n      - \"/actuator/**\"\n      # 验证码\n      - \"/captcha/**\"\n      # 本地文件存储\n      - \"/img/**\"\n      # 静态资源\n      - \"/**/*.js\"\n      - \"/**/*.css\"\n      - \"/**/*.png\"\n      - \"/*.html\"\n      - \"/**/*.html\"\n      - \"/*.ico\"\n      - \"/**/*.ico\"\n      # 数据源\n      - \"/druid/**\"\n\n  # xss过滤路径\n  xss:\n    ignore-urls:\n\n  # 租户配置\n  tenant:\n    tables:\n      - \"sys_permission\"\n      - \"sys_platform\"\n      - \"sys_user\"\n      - \"sys_dept\"\n      - \"sys_role\"\n      - \"sys_dict\"\n      - \"sys_dict_item\"\n      - \"sys_post\"\n      - \"sys_file\"\n      - \"sys_log\"\n      - \"sys_menu\"\n      - \"sys_msg\"\n      - \"sys_msg_user\"\n      - \"sys_msg_channel\"\n\n  # 本地硬盘存储配置\n  storage:\n    local:\n      path: /usr/local/breeze/\n      nginxHost: http://localhost:9000/img/\n\n  # oss s3 配置\n  oss:\n    s3:\n      endpoint: http://localhost:9092\n      minio-root-user: admin\n      minio-root-password: 12345678\n\n  # 日志配置\n  log:\n    # 是否开启日志表记录\n    enable: true\n\nspringdoc:\n  version: 1.0.0\n  type: password\n  title: RBAC权限管理平台 API 文档\n  description: RBAC权限管理平台 API 文档\n  server-url: http://127.0.0.1:8000\n  external-Documentation-description: \"https://github.com/Memory1998/breeze-cloud.git\"\n  external-Documentation-url: \"https://github.com/Memory1998/breeze-cloud.git\"\n  swagger-ui:\n    oauth:\n      clientId: breeze\n      clientSecret: breeze\n      # Swagger UI上默认选中的scopes\n      scopes:\n        - user_info\n  # OAuth2端点（绝对路径）\n  oAuthFlow:\n    authorizationUrl: ${OAUTH2_SERVER:http://127.0.0.1:8000}/oauth2/authorize\n    tokenUrl: ${OAUTH2_SERVER:http://127.0.0.1:8000}/oauth2/token\n    # OIDC发现端点（绝对路径）\n    oidcUrl: ${OAUTH2_SERVER:http://127.0.0.1:8000}/.well-known/openid-configuration', '68a84647d0fa68392b96eb91fddc298d', '2023-04-17 18:17:38', '2023-07-04 05:31:11', 'nacos', '172.18.0.1', '', 'dev', '', '', '', 'yaml', '', '');
INSERT INTO `config_info` VALUES (2, 'breeze-gateway-server-dev.yml', 'DEFAULT_GROUP', 'spring:\n  cloud:\n    gateway: \n      # 启动服务注册发现，通过id访问服务\n      enabled: true\n      discovery:\n        locator:\n          # 服务名称小写\n          lower-case-service-id: true\n      default-filters:\n        - Default\n        # 添加名为 fromIn 的请求头，值为gateway\n        - AddRequestHeader=fromIn,gateway\n      routes:\n        # 系统模块\n        - id: breeze-system-server\n          uri: lb://breeze-system-server\n          predicates:\n            - Path=/system/**\n          filters:\n            - StripPrefix=1\n\n        # auth 认证中心\n        - id: breeze-auth-server\n          uri: lb://breeze-auth-server\n          predicates:\n            - Path=/auth/**\n          filters:\n            - StripPrefix=1\n            - PasswordDecryption=password\n            # 若有多个 用 | 分隔，eg： password|sms_code\n\n        # 工作流模块\n        - id: breeze-flow-server\n          uri: lb://breeze-flow-server\n          predicates:\n            - Path=/flow/**\n          filters:\n            - StripPrefix=1\n\n        # 定时任务模块\n        - id: breeze-quartz-server\n          uri: lb://breeze-quartz-server\n          predicates:\n            - Path=/quartz/**\n          filters:\n            - StripPrefix=1\n\n        # 系统模块的 websocket\n        - id: breeze-system-ws-server\n          uri: lb://breeze-system-server\n          predicates:\n            - Path=/websocket/**\n          filters:\n            - StripPrefix=1\n\n# 滑动验证，底图路径，不配置将使用默认图片\n# 支持全路径\n# 支持项目路径,以classpath:开头,取resource目录下路径,例：classpath:images/jigsaw\naj:\n  captcha:\n    # jigsaw: classpath:images/jigsaw\n    # #滑动验证，底图路径，不配置将使用默认图片\n    # ##支持全路径\n    # # 支持项目路径,以classpath:开头,取resource目录下路径,例：classpath:images/pic-click\n    # pic-click: classpath:images/pic-click\n\n    # 对于分布式部署的应用，我们建议应用自己实现CaptchaCacheService，比如用Redis或者memcache，\n    # 参考CaptchaCacheServiceRedisImpl.java\n    # 如果应用是单点的，也没有使用redis，那默认使用内存。\n    # 内存缓存只适合单节点部署的应用，否则验证码生产与验证在节点之间信息不同步，导致失败。\n    # ！！！ 注意啦，如果应用有使用spring-boot-starter-data-redis，\n    # 请打开CaptchaCacheServiceRedisImpl.java注释。\n    # redis ----->  SPI： 在resources目录新建META-INF.services文件夹(两层)，参考当前服务resources。\n    # 缓存local/redis...\n    cache-type: redis\n    # local缓存的阈值,达到这个值，清除缓存\n    cache-number: 1000\n    # local定时清除过期缓存(单位秒),设置为0代表不执行\n    timing-clear: 180\n\n    # 验证码类型default两种都实例化。\n    type: default\n    # 汉字统一使用Unicode,保证程序通过@value读取到是中文，可通过这个在线转换;yml格式不需要转换\n    # https://tool.chinaz.com/tools/unicode.aspx 中文转Unicode\n    # 右下角水印文字(我的水印)\n    water-mark: breeze\n    # 右下角水印字体(不配置时，默认使用文泉驿正黑)\n    # 由于宋体等涉及到版权，我们jar中内置了开源字体【文泉驿正黑】\n    # 方式一：直接配置OS层的现有的字体名称，比如：宋体\n    # 方式二：自定义特定字体，请将字体放到工程resources下fonts文件夹，支持ttf\\ttc\\otf字体\n    # aj.captcha.water-font=WenQuanZhengHei.ttf\n    # 点选文字验证码的文字字体(文泉驿正黑)\n    # aj.captcha.font-type=WenQuanZhengHei.ttf\n    # 校验滑动拼图允许误差偏移量(默认5像素)\n    slip-offset: 5\n    # aes加密坐标开启或者禁用(true|false)\n    aes-status: true\n    # 滑动干扰项(0/1/2)\n    interference-options: 2\n\n    #点选字体样式 默认Font.BOLD\n    font-style: 1\n    #点选字体字体大小\n    font-size: 25\n    #点选文字个数,存在问题，暂不支持修改\n    #aj.captcha.click-word-count=4\n\n    history-data-clear-enable: false\n\n    # 接口请求次数一分钟限制是否开启 true|false\n    req-frequency-limit-enable: false\n    # 验证失败5次，get接口锁定\n    req-get-lock-limit: 5\n    # 验证失败后，锁定时间间隔,s\n    req-get-lock-seconds: 360\n    # get接口一分钟内请求数限制\n    req-get-minute-limit: 30\n    # check接口一分钟内请求数限制\n    req-check-minute-limit: 60\n    # verify接口一分钟内请求数限制\n    req-verify-minute-limit: 60\n', '7eb42784378e5dcf7fbcf3aa124d75a0', '2023-04-17 18:17:38', '2023-05-30 01:54:36', 'nacos', '172.18.0.1', '', 'dev', '', '', '', 'yaml', '', '');
INSERT INTO `config_info` VALUES (3, 'breeze-system-server-dev.yml', 'DEFAULT_GROUP', 'spring:\n  security:\n    oauth2:\n      resourceserver:\n        jwt:\n          issuer-uri: http://localhost:8000\n          jwk-set-uri: http://localhost:8000/oauth2/jwks\n  # 数据源配置\n  datasource:\n    url: jdbc:mysql://${BREEZE_MYSQL_HOST:breeze-mysql}:${BREEZE_MYSQL_PORT:3306}/${BREEZE_MYSQL_DB_NAME:breeze}?useUnicode=true&characterEncoding=utf8&zeroDateTimeBehavior=convertToNull&useSSL=true&serverTimezone=GMT%2B8\n    driver-class-name: com.mysql.cj.jdbc.Driver\n    username: ${BREEZE_MYSQL_USERNAME:root}\n    password: ${BREEZE_MYSQL_PASSWORD:root}\n    type: com.alibaba.druid.pool.DruidDataSource\n    druid:\n      initial-size: 5\n      min-idle: 10\n      max-active: 20\n      # 配置默认获取连接的等待超时时间\n      max-wait: 60000\n      # 连接在连接池中的最小生存时间      \n      min-evictable-idle-time-millis: 300000\n      # 检测需要关闭的空闲连接的间隔时间\n      time-between-eviction-runs-millis: 50000\n      # 检测连接是否有效的 SQL语句，为空时以下三个配置均无效\n      validation-query: SELECT 1\n      # 申请连接时执行validationQuery检测连接是否有效，默认true，开启后会降低性能\n      test-on-borrow: false\n      # 归还连接时执行validationQuery检测连接是否有效，默认false，开启后会降低性能\n      test-on-return: false\n      # 申请连接时如果空闲时间大于timeBetweenEvictionRunsMillis，执行validationQuery检测连接是否有效，默认false，建议开启，不影响性能\n      test-while-idle: true\n      # 打开PreparedStatementsCache，指定每个连接上PreparedStatementsCache的大小\n      poolPreparedStatements: true\n      # 配置插件：stat-监控统计，日志，wall-防火墙(防止SQL注入)\n      filters: config,stat,slf4j\n      maxPoolPreparedStatementPerConnectionSize: 20\n      # 过滤慢sql\n      filter:\n        stat:\n          db-type: mysql\n          # 开启 FilterStat，默认true\n          enabled: true\n          # 开启 慢SQL 记录，默认false\n          log-slow-sql: true\n          # 是否是慢SQL，默认 3000ms\n          slow-sql-millis: 5000\n          # 合并多个连接池的监控数据，默认false\n          merge-sql: false\n        wall:\n          db-type: mysql\n          config:\n            multi-statement-allow: true\n      # 开启StatViewServlet\n      stat-view-servlet:\n        enabled: true\n        reset-enable: false\n        allow: 127.0.0.1\n        url-pattern: /druid/*\n        login-username: ${BREEZE-DRUID-USERNAME:admin}\n        login-password: ${BREEZE-DRUID-PASSWORD:admin}\n        deny:\n      # 配置WebStatFilter，用于采集web关联监控的数据\n      web-stat-filter:\n        # 开启监控\n        enabled: true\n        url-pattern: /*\n        exclusions: \"*.js,*.gif,*.jpg,*.png,*.css,*.ico,/druid/*\"\n        session-stat-enable: true\n        session-stat-max-count: 1000\n\n# mybatis-plus 配置\nmybatis-plus:\n  mapper-locations: classpath*:mapper/**/*Mapper.xml\n  global-config:\n    banner: true\n    db-config:\n      id-type: auto\n      select-strategy: not_empty\n      insert-strategy: not_empty\n      update-strategy: not_empty\n  configuration:\n    jdbc-type-for-null: null\n    # 逻辑删除\n    db-config:\n      logic-delete-field: flag  # 全局逻辑删除的实体字段名(since 3.3.0,配置后可以忽略不配置步骤2)\n      logic-delete-value: 1 # 逻辑已删除值(默认为 1)\n      logic-not-delete-value: 0 # 逻辑未删除值(默认为 0)\n    # mybatis-plus配置控制台打印完整带参数SQL语句\n    # log-impl: org.apache.ibatis.logging.stdout.StdOutImpl\n  # 搜索指定包别名\n  typeAliasesPackage: com.breeze.**.entity\n', '25be0071b0f1402549a9eedb513071f3', '2023-04-17 18:17:38', '2023-05-30 07:16:01', 'nacos', '172.18.0.1', '', 'dev', '', '', '', 'yaml', '', '');
INSERT INTO `config_info` VALUES (4, 'breeze-auth-server-dev.yml', 'DEFAULT_GROUP', 'logging:\n  level:\n    root: INFO\n    org.springframework.web: INFO\n    org.springframework.security: INFO\n    org.springframework.security.oauth2: INFO\n    # org.springframework.boot.autoconfigure: DEBUG\n', '9fb8fbb36a58560d7d9c713025390927', '2023-04-17 18:17:38', '2023-05-22 05:27:17', 'nacos', '172.18.0.1', '', 'dev', '', '', '', 'yaml', '', '');
INSERT INTO `config_info` VALUES (5, 'breeze-flow-server-dev.yml', 'DEFAULT_GROUP', 'spring:\n  security:\n    oauth2:\n      resourceserver:\n        jwt:\n          issuer-uri: http://localhost:8000\n          jwk-set-uri: http://localhost:8000/oauth2/jwks\n  # 数据源配置\n  datasource:\n    url: jdbc:mysql://${BREEZE_MYSQL_HOST:breeze-mysql}:${BREEZE_MYSQL_PORT:3306}/${BREEZE_MYSQL_DB_NAME:breeze_flowable}?useUnicode=true&characterEncoding=utf8&zeroDateTimeBehavior=convertToNull&useSSL=true&serverTimezone=GMT%2B8\n    driver-class-name: com.mysql.cj.jdbc.Driver\n    username: ${BREEZE_MYSQL_USERNAME:root}\n    password: ${BREEZE_MYSQL_PASSWORD:root}\n    type: com.alibaba.druid.pool.DruidDataSource\n    druid:\n      initial-size: 5\n      min-idle: 10\n      max-active: 20\n      # 配置默认获取连接的等待超时时间\n      max-wait: 60000\n      # 连接在连接池中的最小生存时间      \n      min-evictable-idle-time-millis: 300000\n      # 检测需要关闭的空闲连接的间隔时间\n      time-between-eviction-runs-millis: 50000\n      # 检测连接是否有效的 SQL语句，为空时以下三个配置均无效\n      validation-query: SELECT 1\n      # 申请连接时执行validationQuery检测连接是否有效，默认true，开启后会降低性能\n      test-on-borrow: false\n      # 归还连接时执行validationQuery检测连接是否有效，默认false，开启后会降低性能\n      test-on-return: false\n      # 申请连接时如果空闲时间大于timeBetweenEvictionRunsMillis，执行validationQuery检测连接是否有效，默认false，建议开启，不影响性能\n      test-while-idle: true\n      # 打开PreparedStatementsCache，指定每个连接上PreparedStatementsCache的大小\n      poolPreparedStatements: true\n      # 配置插件：stat-监控统计，日志，wall-防火墙(防止SQL注入)\n      filters: config,stat,slf4j\n      maxPoolPreparedStatementPerConnectionSize: 20\n      # 过滤慢sql\n      filter:\n        stat:\n          db-type: mysql\n          # 开启 FilterStat，默认true\n          enabled: true\n          # 开启 慢SQL 记录，默认false\n          log-slow-sql: true\n          # 是否是慢SQL，默认 3000ms\n          slow-sql-millis: 5000\n          # 合并多个连接池的监控数据，默认false\n          merge-sql: false\n        wall:\n          db-type: mysql\n          config:\n            multi-statement-allow: true\n      # 开启StatViewServlet\n      stat-view-servlet:\n        enabled: true\n        reset-enable: false\n        allow: 127.0.0.1\n        url-pattern: /druid/*\n        login-username: ${BREEZE-DRUID-USERNAME:admin}\n        login-password: ${BREEZE-DRUID-PASSWORD:admin}\n        deny:\n      # 配置WebStatFilter，用于采集web关联监控的数据\n      web-stat-filter:\n        # 开启监控\n        enabled: true\n        url-pattern: /*\n        exclusions: \"*.js,*.gif,*.jpg,*.png,*.css,*.ico,/druid/*\"\n        session-stat-enable: true\n        session-stat-max-count: 1000\n\n# mybatis-plus 配置\nmybatis-plus:\n  mapper-locations: classpath*:mapper/**/*Mapper.xml\n  global-config:\n    banner: true\n    db-config:\n      id-type: auto\n      select-strategy: not_empty\n      insert-strategy: not_empty\n      update-strategy: not_empty\n  configuration:\n    jdbc-type-for-null: null\n    # 逻辑删除\n    db-config:\n      logic-delete-field: flag  # 全局逻辑删除的实体字段名(since 3.3.0,配置后可以忽略不配置步骤2)\n      logic-delete-value: 1 # 逻辑已删除值(默认为 1)\n      logic-not-delete-value: 0 # 逻辑未删除值(默认为 0)\n    # mybatis-plus配置控制台打印完整带参数SQL语句\n    # log-impl: org.apache.ibatis.logging.stdout.StdOutImpl\n  # 搜索指定包别名\n  typeAliasesPackage: com.breeze.**.entity\n\nflowable:\n  async-executor-activate: false # 关闭定时任务JOB\n  database-schema-update: true   # 将databaseSchemaUpdate设置为true。当Flowable发现库与数据库表结构不一致时，会自动将数据库表结构升级至新版本。\n\nlogging:\n  level:\n    org:\n      flowable: debug\n', 'a9856110715e93d7b5fc6eb8a8b34f98', '2023-04-17 18:17:38', '2023-05-30 07:16:25', 'nacos', '172.18.0.1', '', 'dev', '', '', '', 'yaml', '', '');
INSERT INTO `config_info` VALUES (6, 'breeze-quartz-server-dev.yml', 'DEFAULT_GROUP', 'spring:\n  security:\n    oauth2:\n      resourceserver:\n        jwt:\n          issuer-uri: http://localhost:8000\n          jwk-set-uri: http://localhost:8000/oauth2/jwks\n  # 数据源配置\n  datasource:\n    url: jdbc:mysql://${BREEZE_MYSQL_HOST:breeze-mysql}:${BREEZE_MYSQL_PORT:3306}/${BREEZE_MYSQL_DB_NAME:breeze_quartz}?useUnicode=true&characterEncoding=utf8&zeroDateTimeBehavior=convertToNull&useSSL=true&serverTimezone=GMT%2B8\n    driver-class-name: com.mysql.cj.jdbc.Driver\n    username: ${BREEZE_MYSQL_USERNAME:root}\n    password: ${BREEZE_MYSQL_PASSWORD:root}\n    type: com.alibaba.druid.pool.DruidDataSource\n    druid:\n      initial-size: 5\n      min-idle: 10\n      max-active: 20\n      # 配置默认获取连接的等待超时时间\n      max-wait: 60000\n      # 连接在连接池中的最小生存时间      \n      min-evictable-idle-time-millis: 300000\n      # 检测需要关闭的空闲连接的间隔时间\n      time-between-eviction-runs-millis: 50000\n      # 检测连接是否有效的 SQL语句，为空时以下三个配置均无效\n      validation-query: SELECT 1\n      # 申请连接时执行validationQuery检测连接是否有效，默认true，开启后会降低性能\n      test-on-borrow: false\n      # 归还连接时执行validationQuery检测连接是否有效，默认false，开启后会降低性能\n      test-on-return: false\n      # 申请连接时如果空闲时间大于timeBetweenEvictionRunsMillis，执行validationQuery检测连接是否有效，默认false，建议开启，不影响性能\n      test-while-idle: true\n      # 打开PreparedStatementsCache，指定每个连接上PreparedStatementsCache的大小\n      poolPreparedStatements: true\n      # 配置插件：stat-监控统计，日志，wall-防火墙(防止SQL注入)\n      filters: config,stat,slf4j\n      maxPoolPreparedStatementPerConnectionSize: 20\n      # 过滤慢sql\n      filter:\n        stat:\n          db-type: mysql\n          # 开启 FilterStat，默认true\n          enabled: true\n          # 开启 慢SQL 记录，默认false\n          log-slow-sql: true\n          # 是否是慢SQL，默认 3000ms\n          slow-sql-millis: 5000\n          # 合并多个连接池的监控数据，默认false\n          merge-sql: false\n        wall:\n          db-type: mysql\n          config:\n            multi-statement-allow: true\n      # 开启StatViewServlet\n      stat-view-servlet:\n        enabled: true\n        reset-enable: false\n        allow: 127.0.0.1\n        url-pattern: /druid/*\n        login-username: ${BREEZE-DRUID-USERNAME:admin}\n        login-password: ${BREEZE-DRUID-PASSWORD:admin}\n        deny:\n      # 配置WebStatFilter，用于采集web关联监控的数据\n      web-stat-filter:\n        # 开启监控\n        enabled: true\n        url-pattern: /*\n        exclusions: \"*.js,*.gif,*.jpg,*.png,*.css,*.ico,/druid/*\"\n        session-stat-enable: true\n        session-stat-max-count: 1000\n\n  quartz:\n    properties:\n      org:\n        quartz:\n          scheduler:\n            #调度器实例名称\n            instanceName: clusteredScheduler\n            #调度器实例编号自动生成\n            instanceId: AUTO\n          jobStore:\n            #持久化方式配置\n            class: org.springframework.scheduling.quartz.LocalDataSourceJobStore\n            #持久化方式配置数据驱动，MySQL数据库\n            driverDelegateClass: org.quartz.impl.jdbcjobstore.StdJDBCDelegate\n            #quartz相关数据表前缀名\n            tablePrefix: QRTZ_\n            #配置是否使用\n            isClustered: true\n            #分布式节点有效性检查时间间隔，单位：毫秒\n            clusterCheckinInterval: 10000\n            #配置是否使用\n            useProperties: false\n            #激活失败容忍度，只有超过这个容忍度才会判定位misfire\n            misfireThreshold: 60000\n          threadPool:\n            #线程池实现类\n            class: org.quartz.simpl.SimpleThreadPool\n            #执行最大并发线程数量\n            threadCount: 10\n            #线程优先级\n            threadPriority: 5\n            #配置是否启动自动加载数据库内的定时任务，默认true\n            threadsInheritContextClassLoaderOfInitializingThread: true\n    #数据库方式\n    job-store-type: jdbc\n\n# mybatis-plus 配置\nmybatis-plus:\n  mapper-locations: classpath*:mapper/**/*Mapper.xml\n  global-config:\n    banner: true\n    db-config:\n      id-type: auto\n      select-strategy: not_empty\n      insert-strategy: not_empty\n      update-strategy: not_empty\n  configuration:\n    jdbc-type-for-null: null\n    # 逻辑删除\n    db-config:\n      logic-delete-field: flag  # 全局逻辑删除的实体字段名(since 3.3.0,配置后可以忽略不配置步骤2)\n      logic-delete-value: 1 # 逻辑已删除值(默认为 1)\n      logic-not-delete-value: 0 # 逻辑未删除值(默认为 0)\n    # mybatis-plus配置控制台打印完整带参数SQL语句\n    # log-impl: org.apache.ibatis.logging.stdout.StdOutImpl\n  # 搜索指定包别名\n  typeAliasesPackage: com.breeze.**.entity', '2503394108de169e552061312be25ec8', '2023-04-17 18:17:38', '2023-05-30 07:16:36', 'nacos', '172.18.0.1', '', 'dev', '', '', '', 'yaml', '', '');
INSERT INTO `config_info` VALUES (7, 'breeze-monitor-server-dev.yml', 'DEFAULT_GROUP', '# security\nspring:\n  boot:\n    admin:\n      context-path: /\n  security:\n    user:\n      name: admin\n      password: admin\n', '737c9d141d60e14ad6db98fd3295de63', '2023-04-17 18:17:38', '2023-04-17 18:17:38', 'nacos', '172.22.0.1', '', 'dev', '', NULL, NULL, 'yaml', NULL, '');
INSERT INTO `config_info` VALUES (8, 'breeze-redis-standalone-dev.yml', 'DEFAULT_GROUP', 'spring:\n  redis:\n    host: ${BREEZE_REDIS_HOST:breeze-redis}\n    port: ${BREEZE_REDIS_PORT:6379}\n    password: ${BREEZE_REDIS_PASSWORD:breeze}\n    timeout: 10000ms  # 连接超时时间（毫秒）\n    lettuce:\n      pool:\n        max-active: 8 #连接池最大连接数（使用负值表示没有限制）\n        max-wait: -1ms  #连接池最大阻塞等待时间（使用负值表示没有限制）\n        max-idle: 8 #连接池中的最大空闲连接\n        min-idle: 0 #连接池中的最小空闲连接', '1df9c07d65c2b3cbcfe5af5ae1fb0594', '2023-04-17 18:17:38', '2023-05-30 07:16:53', 'nacos', '172.18.0.1', '', 'dev', '', '', '', 'yaml', '', '');
INSERT INTO `config_info` VALUES (9, 'breeze-rabbitmq-standalone-dev.yml', 'DEFAULT_GROUP', '# TODO', '320cc1c91ed6dfd8b10e81dfdff70ef3', '2023-04-17 18:17:38', '2023-04-17 18:17:38', 'nacos', '172.22.0.1', '', 'dev', '', NULL, NULL, 'yaml', NULL, '');
INSERT INTO `config_info` VALUES (10, 'breeze-xxljob-dev.yml', 'DEFAULT_GROUP', 'xxl:\n  job:\n    admin:\n      ### 调度中心部署根地址 [选填]：如调度中心集群部署存在多个地址则用逗号分隔。执行器将会使用该地址进行\"执行器心跳注册\"和\"任务结果回调\"；为空则关闭自动注册；\n      addresses: http://127.0.0.1:8080/xxl-job-admin\n    ### 调度中心通讯TOKEN [选填]：非空时启用；\n    accessToken:\n    executor:\n      ### 执行器AppName [选填]：执行器心跳注册分组依据；为空则关闭自动注册\n      appname: BREEZE-JOB-APP\n      ### 执行器注册 [选填]：优先使用该配置作为注册地址，为空时使用内嵌服务 ”IP:PORT“ 作为注册地址。从而更灵活的支持容器类型执行器动态IP和动态映射端口问题。\n      address:\n      ### 执行器IP [选填]：默认为空表示自动获取IP，多网卡时可手动设置指定IP，该IP不会绑定Host仅作为通讯实用；地址信息用于 \"执行器注册\" 和 \"调度中心请求并触发任务\"；\n      ip:\n      ### 执行器端口号 [选填]：小于等于0则自动获取；默认端口为9999，单机部署多个执行器时，注意要配置不同执行器端口；\n      port: 9999\n      ### 执行器运行日志文件存储磁盘路径 [选填] ：需要对该路径拥有读写权限；为空则使用默认路径；\n      logPath: ./xxl-job-log/jobhandler\n      ### 执行器日志文件保存天数 [选填] ： 过期日志自动清理, 限制值大于等于3时生效; 否则, 如-1, 关闭自动清理功能；\n      logRetentionDays: 15\n', '4019a383c0ec6e549a89d957f9c6e659', '2023-04-17 18:17:38', '2023-04-17 18:17:38', 'nacos', '172.22.0.1', '', 'dev', '', NULL, NULL, 'yaml', NULL, '');
INSERT INTO `config_info` VALUES (1000, 'breeze-gateway-doc-dev.yml', 'DEFAULT_GROUP', 'knife4j:\n  gateway:\n    enabled: true\n    # 指定服务发现的模式聚合微服务文档\n    strategy: manual\n    discover:\n      enabled: false\n      # 指定版本号(Swagger2|OpenAPI3)\n      version : openapi3\n      # 需要排除的微服务(eg:网关服务)\n      excluded-services:\n        - gateway-service\n    # 个性化定制的部分子服务分组情况\n    routes:\n      - name: 系统服务\n        service-name: system-service\n        url: /system/v3/api-docs\n        order: 1\n      - name: 定时任务服务\n        service-name: quartz-service\n        url: /quartz/v3/api-docs\n        order: 2\n      - name: 工作流服务\n        service-name: flow-service\n        url: /flow/v3/api-docs\n        order: 3', '786da79b90d5157d4c85d345e75ff205', '2023-05-29 09:51:44', '2023-05-30 01:58:55', 'nacos', '172.18.0.1', '', 'dev', '', '', '', 'yaml', '', '');

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
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '增加租户字段' ROW_FORMAT = Dynamic;

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
  `src_ip` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT 'source ip',
  `tenant_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '' COMMENT '租户字段',
  `encrypted_data_key` text CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '秘钥',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_configinfobeta_datagrouptenant`(`data_id`, `group_id`, `tenant_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = 'config_info_beta' ROW_FORMAT = Dynamic;

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
  `src_ip` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT 'source ip',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_configinfotag_datagrouptenanttag`(`data_id`, `group_id`, `tenant_id`, `tag_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = 'config_info_tag' ROW_FORMAT = Dynamic;

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
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = 'config_tag_relation' ROW_FORMAT = Dynamic;

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
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '集群、各Group容量信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for his_config_info
-- ----------------------------
DROP TABLE IF EXISTS `his_config_info`;
CREATE TABLE `his_config_info`  (
  `id` bigint(20) UNSIGNED NOT NULL,
  `nid` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `data_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `group_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `app_name` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT 'app_name',
  `content` longtext CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `md5` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `gmt_create` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `gmt_modified` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `src_user` text CHARACTER SET utf8 COLLATE utf8_bin NULL,
  `src_ip` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `op_type` char(10) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `tenant_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '' COMMENT '租户字段',
  `encrypted_data_key` text CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '秘钥',
  PRIMARY KEY (`nid`) USING BTREE,
  INDEX `idx_gmt_create`(`gmt_create`) USING BTREE,
  INDEX `idx_gmt_modified`(`gmt_modified`) USING BTREE,
  INDEX `idx_did`(`data_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 270 CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '多租户改造' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for permissions
-- ----------------------------
DROP TABLE IF EXISTS `permissions`;
CREATE TABLE `permissions`  (
  `role` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `resource` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
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
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '租户容量信息表' ROW_FORMAT = Dynamic;

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
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = 'tenant_info' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tenant_info
-- ----------------------------
INSERT INTO `tenant_info` VALUES (1, '1', 'dev', 'dev', '开发环境', 'nacos', 1681755426002, 1681755426002);
INSERT INTO `tenant_info` VALUES (2, '1', 'sentinel', 'sentinel', 'sentinel', 'nacos', 1684727656129, 1684727656129);

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
INSERT INTO `users` VALUES ('breeze', '$2a$10$wcimeG/FIstf3/Wk.Z03VOnObGef3cw9yCxn2QKS8KSLa0bhNrZY6', 1);
INSERT INTO `users` VALUES ('nacos', '$2a$10$l3VKdw5MToPr9wmvp8zrueEcnf3Z937J2mO5gC27Gef3vOigydUnK', 1);

SET FOREIGN_KEY_CHECKS = 1;
