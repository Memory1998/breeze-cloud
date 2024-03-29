DROP
DATABASE IF EXISTS `breeze`;
CREATE
DATABASE  `breeze` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

USE `breeze`

-- ----------------------------
-- Table structure for sys_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_dept`;
CREATE TABLE `sys_dept`  (
                           `id` bigint(22) NOT NULL DEFAULT 1111111111111111111 COMMENT '主键ID',
                           `parent_id` bigint(22) NULL DEFAULT 0 COMMENT '上级部门ID',
                           `dept_code` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '部门编码',
                           `dept_name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '部门名称',
                           `create_by` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建人编码',
                           `create_name` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建人姓名',
                           `create_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                           `update_by` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '修改人编码',
                           `update_name` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '修改人姓名',
                           `update_time` datetime(0) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '修改时间',
                           `is_delete` tinyint(1) NULL DEFAULT 0 COMMENT '是否删除 0 未删除 1 已删除',
                           `delete_by` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '删除人编码',
                           `tenant_id` bigint(22) NOT NULL COMMENT '租户ID',
                           PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '部门' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_dept
-- ----------------------------
INSERT INTO `sys_dept` VALUES (1565314987957145600, 1111111111111111111, 'GS', '总公司', NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_dept` VALUES (1565314987957145609, 1565314987957145600, 'DSB', '董事办', NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_dept` VALUES (1581851971500371970, 1565314987957145600, 'IT', 'IT研发部门', NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_dept` VALUES (1601579918477983745, 1581851971500371970, 'Java1', '研发组1', NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_dept` VALUES (1601579970948726786, 1581851971500371970, 'Java2', 'Java2', NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);

-- ----------------------------
-- Table structure for sys_dict
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict`;
CREATE TABLE `sys_dict`  (
                           `id` bigint(22) NOT NULL COMMENT '主键ID',
                           `dict_name` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '字典名称',
                           `dict_code` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '字典编码',
                           `is_open` tinyint(1) NULL DEFAULT 0 COMMENT '是否启用 0 关闭 1 启用',
                           `create_by` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建人编码',
                           `create_name` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建人姓名',
                           `create_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                           `update_by` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '修改人编码',
                           `update_name` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '修改人姓名',
                           `update_time` datetime(0) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '修改时间',
                           `is_delete` tinyint(1) NULL DEFAULT 0 COMMENT '是否删除 0 未删除 1 已删除',
                           `delete_by` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '删除人编码',
                           `tenant_id` bigint(22) NOT NULL COMMENT '租户ID',
                           PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '字典' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_dict
-- ----------------------------
INSERT INTO `sys_dict` VALUES (1599032827285213185, '性别', 'SEX', 1, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_dict` VALUES (1599033063277727745, '菜单类型', 'MENU_TYPE', 1, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_dict` VALUES (1599034133752188930, '日志类型', 'LOG_TYPE', 1, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_dict` VALUES (1599034233434017794, '操作类型', 'DO_TYPE', 1, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_dict` VALUES (1599035056616509442, '日志结果', 'LOG_RESULT', 1, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_dict` VALUES (1599035447399813121, '消息级别', 'MSG_LEVEL', 1, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_dict` VALUES (1599035906529300481, '消息类型', 'MSG_TYPE', 1, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_dict` VALUES (1599036245466812417, '开关', 'OPEN', 1, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_dict` VALUES (1599036494331645953, '缓存', 'KEEPALIVE', 1, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_dict` VALUES (1599036771814215681, '显示隐藏', 'HIDDEN', 1, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_dict` VALUES (1599037134667649025, '路由外链', 'HREF', 1, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_dict` VALUES (1599037528810590209, '存储方式', 'OSS_STYLE', 1, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_dict` VALUES (1599218032822394881, '结果', 'RESULT', 1, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_dict` VALUES (1599288041217064962, '锁定', 'IS_LOCK', 1, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_dict` VALUES (1599292998100058114, '读取状态', 'MARK_READ', 1, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_dict` VALUES (1601793691449020417, '数据权限固定编码', 'PERMISSION_CODE', 1, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_dict` VALUES (1637619982970351618, '任务策略', 'MISFIRE_POLICY', 1, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_dict` VALUES (1637621879726895105, '并发', 'CONCURRENT', 1, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_dict` VALUES (1637622109440536577, '任务状态', 'JOB_STATUS', 1, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_dict` VALUES (1639508202175832066, '任务组', 'JOB_GROUP', 1, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_dict` VALUES (1658030824311799809, '身份验证方法', 'CLIENT_AUTHENTICATION_METHODS', 1, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_dict` VALUES (1658030901172420609, '授权许可类型', 'AUTHORIZATION_GRANT_TYPES', 1, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_dict` VALUES (1658031007506415617, '权限范围', 'SCOPES', 1, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_dict` VALUES (1658031278974353410, 'JWT签名算法', 'TOKEN_ENDPOINT_AUTHENTICATION_SIGNING_ALGORITHM', 1, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_dict` VALUES (1658031392233144321, 'ID-TOKEN签名算法', 'ID_TOKEN_SIGNATURE_ALGORITHM', 1, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_dict` VALUES (1658031447681843201, '访问令牌格式', 'ACCESS_TOKEN_FORMAT', 1, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_dict` VALUES (1658303277953040385, '重定向Uris', 'REDIRECT_URIS', 1, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);

-- ----------------------------
-- Table structure for sys_dict_item
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_item`;
CREATE TABLE `sys_dict_item`  (
                                `id` bigint(22) NOT NULL COMMENT '主键ID',
                                `dict_id` bigint(22) NULL DEFAULT NULL COMMENT '字典ID',
                                `key` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '字典项的值',
                                `value` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '字典项的名称',
                                `sort` tinyint(1) NULL DEFAULT NULL COMMENT '排序',
                                `create_by` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建人编码',
                                `create_name` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建人姓名',
                                `create_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                                `update_by` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '修改人编码',
                                `update_name` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '修改人姓名',
                                `update_time` datetime(0) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '修改时间',
                                `is_delete` tinyint(1) NULL DEFAULT 0 COMMENT '是否删除 0 未删除 1 已删除',
                                `delete_by` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '删除人编码',
                                `tenant_id` bigint(22) NOT NULL COMMENT '租户ID',
                                PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '字典项' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_dict_item
-- ----------------------------
INSERT INTO `sys_dict_item` VALUES (1599033180131037186, 1599033063277727745, '0', '文件夹', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_dict_item` VALUES (1599033573409951745, 1599033063277727745, '1', '菜单', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_dict_item` VALUES (1599033675105046530, 1599033063277727745, '2', '按钮', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_dict_item` VALUES (1599033861437001729, 1599032827285213185, '1', '男', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_dict_item` VALUES (1599033925890871297, 1599032827285213185, '0', '女', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_dict_item` VALUES (1599034388589711362, 1599034133752188930, '0', ' 普通日志', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_dict_item` VALUES (1599034442968862721, 1599034133752188930, '1', ' 登录日志', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_dict_item` VALUES (1599034596094513154, 1599034233434017794, '0', '添加', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_dict_item` VALUES (1599034610313203714, 1599034233434017794, '1', '删除', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_dict_item` VALUES (1599034627035893761, 1599034233434017794, '2', '修改', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_dict_item` VALUES (1599034642189914113, 1599034233434017794, '3', '查询', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_dict_item` VALUES (1599035133351301122, 1599035056616509442, '0', '失败', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_dict_item` VALUES (1599035172446408705, 1599035056616509442, '1', ' 成功', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_dict_item` VALUES (1599035472632745985, 1599035447399813121, 'success', '正常消息', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_dict_item` VALUES (1599035484666204161, 1599035447399813121, 'warning', '警示消息', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_dict_item` VALUES (1599035496510918657, 1599035447399813121, 'info', '一般消息', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_dict_item` VALUES (1599035508733120513, 1599035447399813121, 'danger', '紧急消息', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_dict_item` VALUES (1599036005007364098, 1599035906529300481, '0', ' 通知', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_dict_item` VALUES (1599036025513316353, 1599035906529300481, '1', '公告', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_dict_item` VALUES (1599036294716329985, 1599036245466812417, '1', '开启', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_dict_item` VALUES (1599036318925852674, 1599036245466812417, '0 ', '关闭', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_dict_item` VALUES (1599036529471524866, 1599036494331645953, '0', '不缓存 ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_dict_item` VALUES (1599036549079896065, 1599036494331645953, '1', '缓存', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_dict_item` VALUES (1599036842584707074, 1599036771814215681, '0', '显示', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_dict_item` VALUES (1599036909861343234, 1599036771814215681, '1', '隐藏', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_dict_item` VALUES (1599037293560467457, 1599037134667649025, '1', '外链', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_dict_item` VALUES (1599037318663376897, 1599037134667649025, '0', '路由', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_dict_item` VALUES (1599037823330422786, 1599037528810590209, '0', '本地', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_dict_item` VALUES (1599037849897144321, 1599037528810590209, '1', 'MINIO', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_dict_item` VALUES (1599218200087044097, 1599218032822394881, '1', '成功', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_dict_item` VALUES (1599218217967362049, 1599218032822394881, '0', '失败', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_dict_item` VALUES (1599288066458386434, 1599288041217064962, '0', '正常', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_dict_item` VALUES (1599288094061101058, 1599288041217064962, '1', '锁定', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_dict_item` VALUES (1599293037463601154, 1599292998100058114, '1', '已读', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_dict_item` VALUES (1599293192749318145, 1599292998100058114, '0', '未读', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_dict_item` VALUES (1601793891890614273, 1601793691449020417, 'ALL', '全部', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_dict_item` VALUES (1601793991845072897, 1601793691449020417, 'OWN', '自己', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_dict_item` VALUES (1601794253766774785, 1601793691449020417, 'DEPT_LEVEL', '部门范围权限', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_dict_item` VALUES (1637620045218017282, 1637619982970351618, '1', ' 执行一次（默认）', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_dict_item` VALUES (1637620093146329089, 1637619982970351618, '-1', '立刻执行', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_dict_item` VALUES (1637620131188666370, 1637619982970351618, '2', '放弃执行', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_dict_item` VALUES (1637621918473875458, 1637621879726895105, '1', '并发', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_dict_item` VALUES (1637621961926864897, 1637621879726895105, '0', '串行', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_dict_item` VALUES (1637622141858312194, 1637622109440536577, '1', '开启', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_dict_item` VALUES (1637622196887580673, 1637622109440536577, '0', '暂停', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_dict_item` VALUES (1639508998309257217, 1639508202175832066, 'DEFAULT', '默认', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_dict_item` VALUES (1639510731953512449, 1639508202175832066, 'SYSTEM', '系统', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_dict_item` VALUES (1658273848363065345, 1658030901172420609, 'refresh_token', 'refresh_token', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_dict_item` VALUES (1658273881355460610, 1658030901172420609, 'client_credentials', 'client_credentials', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_dict_item` VALUES (1658273913035038722, 1658030901172420609, 'authorization_code', 'authorization_code', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_dict_item` VALUES (1658273946912432130, 1658030901172420609, 'password', 'password', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_dict_item` VALUES (1658273985827184642, 1658030901172420609, 'sms_code', 'sms_code', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_dict_item` VALUES (1658274057008717825, 1658030901172420609, 'email_code', 'email_code', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_dict_item` VALUES (1658274486081822721, 1658030824311799809, 'client_secret_post', 'client_secret_post', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_dict_item` VALUES (1658274530675662850, 1658030824311799809, 'client_secret_jwt', 'client_secret_jwt', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_dict_item` VALUES (1658274569879822338, 1658030824311799809, 'private_key_jwt', 'private_key_jwt', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_dict_item` VALUES (1658274604130508801, 1658030824311799809, 'client_secret_basic', 'client_secret_basic', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_dict_item` VALUES (1658274676369006593, 1658030824311799809, 'none', 'none', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_dict_item` VALUES (1658274708270882817, 1658030824311799809, 'basic', 'basic', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_dict_item` VALUES (1658274853272166402, 1658030824311799809, 'post', 'post', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_dict_item` VALUES (1658274975850700801, 1658031007506415617, 'openid', 'openid', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_dict_item` VALUES (1658275001364652033, 1658031007506415617, 'profile', 'profile', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_dict_item` VALUES (1658275025167327233, 1658031007506415617, 'email', 'email', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_dict_item` VALUES (1658275048814813185, 1658031007506415617, 'address', 'address', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_dict_item` VALUES (1658275076136509441, 1658031007506415617, 'phone', 'phone', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_dict_item` VALUES (1658275140422606849, 1658031007506415617, 'user_info', 'user_info', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_dict_item` VALUES (1658275179521908738, 1658031007506415617, 'read', 'read', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_dict_item` VALUES (1658275224136720385, 1658031007506415617, 'write', 'write', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_dict_item` VALUES (1658275335071866882, 1658031392233144321, 'RS256', 'RS256', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_dict_item` VALUES (1658275360300605442, 1658031392233144321, 'RS384', 'RS384', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_dict_item` VALUES (1658275382203260930, 1658031392233144321, 'RS512', 'RS512', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_dict_item` VALUES (1658275403925561345, 1658031392233144321, 'ES256', 'ES256', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_dict_item` VALUES (1658275430785884162, 1658031392233144321, 'ES384', 'ES384', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_dict_item` VALUES (1658275451379916802, 1658031392233144321, 'ES512', 'ES512', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_dict_item` VALUES (1658275473043496962, 1658031392233144321, 'PS256', 'PS256', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_dict_item` VALUES (1658275489254481922, 1658031392233144321, 'PS384', 'PS384', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_dict_item` VALUES (1658275510104367106, 1658031392233144321, 'PS512', 'PS512', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_dict_item` VALUES (1658275743236366338, 1658031447681843201, 'self-contained', 'JWT', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_dict_item` VALUES (1658275781895266306, 1658031447681843201, 'reference', '字符串', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_dict_item` VALUES (1658276043741470721, 1658031278974353410, 'RS256', 'RS256', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_dict_item` VALUES (1658276067271516162, 1658031278974353410, 'RS384', 'RS384', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_dict_item` VALUES (1658276093951483906, 1658031278974353410, 'RS512', 'RS512', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_dict_item` VALUES (1658276120979578882, 1658031278974353410, 'ES256', 'ES256', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_dict_item` VALUES (1658276146409644033, 1658031278974353410, 'ES384', 'ES384', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_dict_item` VALUES (1658276164621312002, 1658031278974353410, 'ES512', 'ES512', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_dict_item` VALUES (1658276184783331330, 1658031278974353410, 'PS256', 'PS256', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_dict_item` VALUES (1658276208971882498, 1658031278974353410, 'PS384', 'PS384', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_dict_item` VALUES (1658276255755149313, 1658031278974353410, 'PS512', 'PS512', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_dict_item` VALUES (1658303476360396801, 1658303277953040385, 'http://www.baidu.com', 'http://www.baidu.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_dict_item` VALUES (1658303552222773249, 1658303277953040385, 'http://127.0.0.1:8080/authorized', 'http://127.0.0.1:8080/authorized', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_dict_item` VALUES (1658303639636262913, 1658303277953040385, 'http://127.0.0.1:8080/login/oauth2/code/breeze-oidc', 'http://127.0.0.1:8080/login/oauth2/code/breeze-oidc', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_dict_item` VALUES (1659034973417574401, 1658303277953040385, 'http://127.0.0.1:8070/login/oauth2/code/breeze-pkce', 'http://127.0.0.1:8070/login/oauth2/code/breeze-pkce', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);

-- ----------------------------
-- Table structure for sys_file
-- ----------------------------
DROP TABLE IF EXISTS `sys_file`;
CREATE TABLE `sys_file`  (
                           `id` bigint(22) NOT NULL COMMENT '主键ID',
                           `title` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '文件标题',
                           `original_file_name` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '原文件名称',
                           `content_type` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '格式',
                           `new_file_name` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '新文件名字',
                           `path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '文件存放路径',
                           `oss_style` tinyint(1) NOT NULL COMMENT '存储方式 0 本地 1 minio',
                           `create_by` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建人编码',
                           `create_name` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建人姓名',
                           `create_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                           `update_by` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '修改人编码',
                           `update_name` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '修改人姓名',
                           `update_time` datetime(0) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '修改时间',
                           `is_delete` tinyint(1) NULL DEFAULT 0 COMMENT '是否删除 0 未删除 1 已删除',
                           `delete_by` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '删除人编码',
                           `tenant_id` bigint(22) NOT NULL COMMENT '租户ID',
                           PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '文件' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for sys_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_log`;
CREATE TABLE `sys_log`  (
                          `id` bigint(22) NOT NULL COMMENT '主键ID',
                          `system_module` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '系统模块',
                          `log_title` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '日志标题',
                          `log_type` tinyint(1) NULL DEFAULT 0 COMMENT '日志类型 0 普通日志 1 登录日志',
                          `request_type` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '请求类型  GET  POST  PUT DELETE ',
                          `ip` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'IP',
                          `do_type` tinyint(1) NULL DEFAULT 3 COMMENT '操作类型 0 添加 1 删除 2 修改 3 查询 4 doLogin',
                          `browser` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '浏览器名称',
                          `system` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '操作系统类型',
                          `param_content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '入参',
                          `result` tinyint(1) NULL DEFAULT 0 COMMENT '结果 0 失败 1 成功',
                          `result_msg` varchar(10000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '结果信息',
                          `time` varchar(12) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '用时',
                          `create_by` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建人编码',
                          `create_name` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建人姓名',
                          `create_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                          `tenant_id` bigint(22) NOT NULL COMMENT '租户ID',
                          PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '日志' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for sys_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_menu`;
CREATE TABLE `sys_menu`  (
                           `id` bigint(22) NOT NULL DEFAULT 1111111111111111111 COMMENT '主键ID',
                           `platform_id` bigint(22) NULL DEFAULT NULL COMMENT '平台ID',
                           `parent_id` bigint(22) NULL DEFAULT 0 COMMENT '上一级的菜单ID',
                           `title` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '标题',
                           `name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '组件名称',
                           `type` tinyint(1) NULL DEFAULT 0 COMMENT '类型 0 文件夹 1 菜单 2 按钮',
                           `icon` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '图标',
                           `path` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '菜单路径',
                           `component` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '组件路径',
                           `permission` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '权限标识',
                           `href` tinyint(1) NULL DEFAULT 0 COMMENT '是否外链 0 路由 1 外链',
                           `keep_alive` tinyint(1) NULL DEFAULT 0 COMMENT '是否缓存 0 不缓存 1 缓存',
                           `hidden` tinyint(1) NULL DEFAULT 1 COMMENT '是否隐藏 1 隐藏 0 显示',
                           `sort` int(11) NULL DEFAULT NULL COMMENT '顺序',
                           `create_by` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建人编码',
                           `create_name` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建人姓名',
                           `create_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                           `update_by` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '修改人编码',
                           `update_name` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '修改人名称',
                           `update_time` datetime(0) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '修改时间',
                           `is_delete` tinyint(1) NULL DEFAULT 0 COMMENT '是否删除 0 未删除 1 已删除',
                           `delete_by` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '删除人编码',
                           `tenant_id` bigint(22) NOT NULL COMMENT '租户ID',
                           PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '菜单' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_menu
-- ----------------------------
INSERT INTO `sys_menu` VALUES (1578702340612321378, 1111111111111111111, 1594135789623184129, '任务日志', 'jLog', 1, 'el-icon-s-comment', '/jLog', '/quartz/jlog/index', 'sys:jLog:list', 0, 0, 1, 6, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_menu` VALUES (1578702340612325378, 1111111111111111111, 1578702340666851329, '日志管理', 'log', 1, 'icon-rizhiguanli', '/log', '/system/log/index', 'sys:log:list', 0, 0, 0, 7, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_menu` VALUES (1578702340620713986, 1111111111111111111, 1580357263003439106, '设计器', 'designer', 1, 'icon-shejishi', '/designer', '/flow/designer/index', 'flow:designer', 0, 0, 0, 3, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_menu` VALUES (1578702340620713987, 1111111111111111111, 1578702340683628545, '修改', NULL, 2, NULL, NULL, NULL, 'sys:user:modify', 0, 0, 0, 5, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_menu` VALUES (1578702340620713988, 1111111111111111111, 1578702340683628545, '删除', NULL, 2, NULL, NULL, NULL, 'sys:user:delete', 0, 0, 0, 3, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_menu` VALUES (1578702340624908290, 1111111111111111111, 1578702340683628545, '添加', NULL, 2, NULL, NULL, NULL, 'sys:user:create', 0, 0, 0, 2, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_menu` VALUES (1578702340624908291, 1111111111111111111, 1578702340683628546, '修改', NULL, 2, NULL, NULL, NULL, 'sys:menu:modify', 0, 0, 0, 2, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_menu` VALUES (1578702340624908292, 1111111111111111111, 1578702340683628546, '删除', NULL, 2, NULL, NULL, NULL, 'sys:menu:delete', 0, 0, 0, 3, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_menu` VALUES (1578702340624908293, 1111111111111111111, 1578702340683628546, '添加', NULL, 2, NULL, NULL, NULL, 'sys:menu:create', 0, 0, 0, 1, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_menu` VALUES (1578702340633296898, 1111111111111111111, 1578702340662657026, '删除', NULL, 2, NULL, NULL, NULL, 'sys:dept:delete', 0, 0, 0, 3, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_menu` VALUES (1578702340633296899, 1111111111111111111, 1578702340662657026, '添加', NULL, 2, NULL, NULL, NULL, 'sys:dept:create', 0, 0, 0, 2, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_menu` VALUES (1578702340641685505, 1111111111111111111, 1578702340654268418, '修改', NULL, 2, NULL, NULL, NULL, 'sys:role:modify', 0, 0, 0, 2, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_menu` VALUES (1578702340641685506, 1111111111111111111, 1578702340654268418, '删除', NULL, 2, NULL, NULL, NULL, 'sys:role:delete', 0, 0, 0, 3, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_menu` VALUES (1578702340650074114, 1111111111111111111, 1578702340654268418, '添加', NULL, 2, NULL, NULL, NULL, 'sys:role:create', 0, 0, 0, 1, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_menu` VALUES (1578702340650074115, 1111111111111111111, 1578702340662657027, '修改', NULL, 2, NULL, NULL, NULL, 'sys:dict:modify', 0, 0, 0, 1, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_menu` VALUES (1578702340650074116, 1111111111111111111, 1578702340662657027, '删除', NULL, 2, NULL, NULL, NULL, 'sys:dict:delete', 0, 0, 0, 2, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_menu` VALUES (1578702340650074117, 1111111111111111111, 1578702340662657027, '添加', NULL, 2, NULL, NULL, NULL, 'sys:dict:create', 0, 0, 0, 3, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_menu` VALUES (1578702340654268411, 1111111111111111111, 1578702340612325378, '清空表', NULL, 2, NULL, NULL, NULL, 'sys:log:truncate', 0, 0, 0, 1, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_menu` VALUES (1578702340654268412, 1111111111111111111, 1578702340666851329, '租户管理', 'tenant', 1, 'icon-zuhuguanli', '/tenant', '/system/tenant/index', 'sys:tenant:list', 0, 0, 0, 10, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_menu` VALUES (1578702340654268416, 1111111111111111111, 1578702340666851329, '岗位管理', 'post', 1, 'icon-gangweizu', '/post', '/system/post/index', 'sys:post:list', 0, 0, 0, 4, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_menu` VALUES (1578702340654268417, 1111111111111111111, 1578702340612325378, '删除', NULL, 2, NULL, NULL, NULL, 'sys:log:delete', 0, 0, 0, 2, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_menu` VALUES (1578702340654268418, 1111111111111111111, 1578702340666851329, '角色管理', 'role', 1, 'icon-jiaoseguanli', '/role', '/system/role/index', 'sys:role:list', 0, 0, 0, 5, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_menu` VALUES (1578702340662657026, 1111111111111111111, 1578702340666851329, '部门管理', 'dept', 1, 'icon-bumenguanli', '/dept', '/system/dept/index', 'sys:dept:list', 0, 0, 0, 9, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_menu` VALUES (1578702340662657027, 1111111111111111111, 1578702340666851329, '字典管理', 'dict', 1, 'icon-menu_zdgl', '/dict', '/system/dict/index', 'sys:dict:list', 0, 0, 0, 6, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_menu` VALUES (1578702340666851329, 1111111111111111111, 1111111111111111111, '权限管理', '', 0, 'icon-quanxianguanli', '/upms', '', '', 0, 0, 0, 1, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_menu` VALUES (1578702340671045634, 1111111111111111111, 1578702340666851329, '平台管理', 'platform', 1, 'icon-pingtaiguanli', '/platform', '/system/platform/index', 'sys:platform:list', 0, 0, 0, 1, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_menu` VALUES (1578702340671045635, 1111111111111111111, 1578702340671045634, '添加', NULL, 2, NULL, NULL, NULL, 'sys:platform:create', 0, 0, 0, 1, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_menu` VALUES (1578702340679434241, 1111111111111111111, 1578702340671045634, '修改', NULL, 2, NULL, NULL, NULL, 'sys:platform:modify', 0, 0, 0, 2, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_menu` VALUES (1578702340679434243, 1111111111111111111, 1578702340671045634, '删除', NULL, 2, NULL, NULL, NULL, 'sys:platform:delete', 0, 0, 0, 3, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_menu` VALUES (1578702340683628545, 1111111111111111111, 1578702340666851329, '用户管理', 'user', 1, 'icon-yonghuguanli', '/user', '/system/user/index', 'sys:user:list', 0, 0, 0, 2, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_menu` VALUES (1578702340683628546, 1111111111111111111, 1578702340666851329, '菜单管理', 'menu', 1, 'icon-caidanguanli', '/menu', '/system/menu/index', 'sys:menu:list', 0, 0, 0, 3, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_menu` VALUES (1580357263003439106, 1111111111111111111, 1111111111111111111, '流程管理', NULL, 0, 'icon-bumenguanli', '/flow', NULL, NULL, 0, 0, 0, 4, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_menu` VALUES (1580357773622202370, 1111111111111111111, 1580357263003439106, '流程分类', 'category', 1, 'icon-fenlei', '/category', '/flow/category/index', 'flow:category:list', 0, 0, 0, 1, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_menu` VALUES (1581843318345035778, 1111111111111111111, 1578702340662657026, '修改', NULL, 2, NULL, NULL, NULL, 'sys:dept:modify', 0, 0, 0, 1, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_menu` VALUES (1581965904601088001, 1111111111111111111, 1581966349440581634, '测试KeepAive', 'testKeep', 1, 'icon-test', '/testKeep', '/test/testKeep/TestKeepView', 'keep:create', 0, 1, 0, 2, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_menu` VALUES (1581965904601088002, 1111111111111111111, 1581966349440581634, '测试外部链接', NULL, 1, 'icon-test', 'http://ww.baidu.com', NULL, NULL, 1, 0, 0, 3, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_menu` VALUES (1581966349440581634, 1111111111111111111, 1111111111111111111, '相关测试', NULL, 0, 'icon-test', '/test', NULL, NULL, 0, 0, 0, 5, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_menu` VALUES (1582554585967800321, 1111111111111111111, 1111111111111111111, '监控平台', NULL, 0, 'icon-jurassic_monitor', '/monitor', NULL, NULL, 0, 0, 0, 3, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_menu` VALUES (1582555155344568321, 1111111111111111111, 1582554585967800321, 'swagger', NULL, 1, 'icon-swagger', 'http://localhost:9000/swagger-ui/index.html', NULL, NULL, 1, 0, 0, 1, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_menu` VALUES (1582558188828790785, 1111111111111111111, 1582554585967800321, '德鲁伊', NULL, 1, 'icon-druid', 'http://localhost:9000/druid/login.html', NULL, NULL, 1, 0, 0, 2, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_menu` VALUES (1582607135668621314, 1111111111111111111, 1581966349440581634, '掘金', NULL, 1, 'icon-test', 'https://juejin.cn/', NULL, NULL, 1, 0, 0, 1, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_menu` VALUES (1582688861908611074, 1111111111111111111, 1581965904601088002, 'elementUI', NULL, 1, 'svg-abc12312312', 'https://element.eleme.cn', NULL, NULL, 1, 0, 0, 1, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_menu` VALUES (1586717542633123841, 1111111111111111111, 1578702340683628545, '角色分配', 'userRole', 1, NULL, '/userRole', '/system/user/role/index', 'sys:role:list', 0, 1, 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_menu` VALUES (1586717542633123843, 1111111111111111111, 1578702340662657027, '字典项', 'dictItem', 1, NULL, '/dictItem', '/system/dict/item/index', 'sys:item:list', 0, 0, 1, 4, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_menu` VALUES (1587692336744742913, 1111111111111111111, 1578702340683628545, '详情', NULL, 2, NULL, NULL, NULL, 'sys:user:info', 0, 0, 0, 4, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_menu` VALUES (1589181822230018781, 1111111111111111111, 9223372036854775119, '修改', NULL, 2, NULL, NULL, NULL, 'sys:msg:modify', 0, 0, 0, 2, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_menu` VALUES (1589181822230018782, 1111111111111111111, 9223372036854775120, '修改', NULL, 2, NULL, NULL, NULL, 'sys:msgUser:modify', 0, 0, 0, 1, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_menu` VALUES (1589181822230048172, 1111111111111111111, 9223372036854775119, '删除', NULL, 2, NULL, NULL, NULL, 'sys:msg:delete', 0, 0, 0, 3, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_menu` VALUES (1589181822230048178, 1111111111111111111, 9223372036854775120, '删除', NULL, 2, NULL, NULL, NULL, 'sys:msgUser:delete', 0, 0, 0, 2, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_menu` VALUES (1589181822230048770, 1111111111111111111, 1578702340654268416, '添加', NULL, 2, NULL, NULL, NULL, 'sys:post:create', 0, 0, 0, 1, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_menu` VALUES (1589181822230048771, 1111111111111111111, 1578702340654268416, '修改', NULL, 2, NULL, NULL, NULL, 'sys:post:modify', 0, 0, 0, 2, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_menu` VALUES (1589181822230048772, 1111111111111111111, 1578702340654268416, '删除', NULL, 2, NULL, NULL, NULL, 'sys:post:delete', 0, 0, 0, 3, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_menu` VALUES (1589181822230048778, 1111111111111111111, 1594135789623984129, '删除', NULL, 2, NULL, NULL, NULL, 'sys:file:delete', 0, 0, 0, 4, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_menu` VALUES (1589181822230048781, 1111111111111111111, 1578702340654268412, '添加', NULL, 2, NULL, NULL, NULL, 'sys:tenant:create', 0, 0, 0, 1, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_menu` VALUES (1589181822230048782, 1111111111111111111, 1578702340654268412, '修改', NULL, 2, NULL, NULL, NULL, 'sys:tenant:modify', 0, 0, 0, 2, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_menu` VALUES (1589181822230048783, 1111111111111111111, 1578702340654268412, '删除', NULL, 2, NULL, NULL, NULL, 'sys:tenant:delete', 0, 0, 0, 3, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_menu` VALUES (1589181822230049781, 1111111111111111111, 9223372036854775119, '添加', NULL, 2, NULL, NULL, NULL, 'sys:msg:create', 0, 0, 0, 1, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_menu` VALUES (1589789746153263106, 1111111111111111111, 9223372036854775807, '添加', NULL, 2, NULL, NULL, NULL, 'sys:permission:create', 0, 0, 0, 1, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_menu` VALUES (1594135789623184129, 1111111111111111111, 1637297406628823041, '任务管理', 'job', 1, 'icon-renwu', '/job', '/quartz/job/index', 'sys:job:list', 0, 0, 0, 5, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_menu` VALUES (1594135789623984129, 1111111111111111111, 1637297406628823041, '文件管理', 'file', 1, 'icon-wenjianguanli', '/file', '/system/file/index', 'sys:file:list', 0, 0, 0, 4, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_menu` VALUES (1594531945449451666, 1111111111111111111, 1594135789623984129, '预览', NULL, 2, NULL, NULL, NULL, 'sys:file:preview', 0, 0, 0, 3, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_menu` VALUES (1594532038764326666, 1111111111111111111, 1594135789623984129, '文件上传', NULL, 2, NULL, NULL, NULL, 'sys:file:upload', 0, 0, 0, 1, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_menu` VALUES (1594532038764326913, 1111111111111111111, 1594135789623984129, '下载', NULL, 2, NULL, NULL, NULL, 'sys:file:download', 0, 0, 0, 2, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_menu` VALUES (1598222373868695553, 1111111111111111111, 9223372036854775807, '删除', NULL, 2, NULL, NULL, NULL, 'sys:permission:delete', 0, 0, 0, 3, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_menu` VALUES (1598222575933485057, 1111111111111111111, 9223372036854775807, '修改', NULL, 2, NULL, NULL, NULL, 'sys:permission:modify', 0, 0, 0, 2, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_menu` VALUES (1599935876379897858, 1111111111111111111, 1586717542633123841, '用户增加角色', NULL, 2, NULL, NULL, NULL, 'sys:user:userSetRole', 0, 0, 0, 1, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_menu` VALUES (1599935889646481409, 1111111111111111111, 1, '用户增加角色', NULL, 2, NULL, NULL, NULL, 'sys:user:userSetRole', 0, 0, 0, 1, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_menu` VALUES (1599935894306353153, 1111111111111111111, 1, '用户增加角色', NULL, 2, NULL, NULL, NULL, 'sys:user:userSetRole', 0, 0, 0, 1, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_menu` VALUES (1599936079744921601, 1111111111111111111, 1, '用户增加角色', NULL, 2, NULL, NULL, NULL, 'sys:user:userSetRole', 0, 0, 0, 1, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_menu` VALUES (1599936405688479746, 1111111111111111111, 1586717542633123841, '重置密码', NULL, 2, NULL, NULL, NULL, 'sys:user:resetPass', 0, 0, 0, 1, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_menu` VALUES (1601081152259891202, 1111111111111111111, 1578702340683628545, '导出', NULL, 2, NULL, NULL, NULL, 'sys:user:export', 0, 0, 0, 6, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_menu` VALUES (1601858203636092929, 1111111111111111111, 1578702340654268418, '数据权限', NULL, 2, NULL, NULL, NULL, 'sys:permission:edit', 0, 0, 0, 4, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_menu` VALUES (1632642093459915239, 1111111111111111111, 1578702340612321378, '删除', NULL, 2, NULL, NULL, NULL, 'sys:jLog:delete', 0, 0, 0, 1, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_menu` VALUES (1632642093459935231, 1111111111111111111, 1594135789623184129, '添加', NULL, 2, NULL, NULL, NULL, 'sys:job:create', 0, 0, 0, 1, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_menu` VALUES (1632642093459935232, 1111111111111111111, 1594135789623184129, '删除', NULL, 2, NULL, NULL, NULL, 'sys:job:delete', 0, 0, 0, 3, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_menu` VALUES (1632642093459935233, 1111111111111111111, 1578702340620713986, '流程部署', NULL, 2, NULL, NULL, NULL, 'flow:definition:deploy', 0, 0, 0, 1, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_menu` VALUES (1632642093459935234, 1111111111111111111, 1580357773622202370, '添加', NULL, 2, NULL, NULL, NULL, 'flow:category:create', 0, 0, 0, 1, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_menu` VALUES (1632642093459935235, 1111111111111111111, 1580357773622202370, '删除', NULL, 2, NULL, NULL, NULL, 'flow:category:delete', 0, 0, 0, 2, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_menu` VALUES (1632642093459935236, 1111111111111111111, 1578702340612321378, '清空', NULL, 2, NULL, NULL, NULL, 'sys:jLog:truncate', 0, 0, 0, 2, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_menu` VALUES (1632642093459935239, 1111111111111111111, 1594135789623184129, '修改', NULL, 2, NULL, NULL, NULL, 'sys:job:modify', 0, 0, 0, 4, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_menu` VALUES (1632642093459935256, 1111111111111111111, 1580357773622202370, '修改', NULL, 2, NULL, NULL, NULL, 'flow:category:modify', 0, 0, 0, 3, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_menu` VALUES (1632925687029903361, 1111111111111111111, 9223372036854775121, '查看', NULL, 2, NULL, NULL, NULL, 'flow:definition:info', 0, 0, 0, 1, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_menu` VALUES (1632925792583757826, 1111111111111111111, 9223372036854775121, '删除', NULL, 2, NULL, NULL, NULL, 'flow:definition:delete', 0, 0, 0, 1, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_menu` VALUES (1632950163226464257, 1111111111111111111, 9223372036854775121, '启动', NULL, 2, NULL, NULL, NULL, 'flow:instance:start', 0, 0, 0, 1, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_menu` VALUES (1632950317358747649, 1111111111111111111, 9223372036854775121, '设计', NULL, 2, NULL, NULL, NULL, 'flow:designer', 0, 0, 0, 1, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_menu` VALUES (1632979037821743106, 1111111111111111111, 9223372036854775121, '新建', NULL, 2, NULL, NULL, NULL, 'flow:definition:create', 0, 0, 0, 1, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_menu` VALUES (1633285580421271553, 1111111111111111111, 1580357263003439106, '流程实例', 'instance', 1, 'icon-liuchengshiliguanli', '/instance', '/flow/instance/index', 'flow:instance:list', 0, 0, 0, 5, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_menu` VALUES (1633338860669214722, 1111111111111111111, 9223372036854775121, '流程挂起', NULL, 2, NULL, NULL, NULL, 'flow:definition:suspended', 0, 0, 0, 1, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_menu` VALUES (1633349367631314945, 1111111111111111111, 9223372036854775121, '发布', NULL, 2, NULL, NULL, NULL, 'flow:instance:publish', 0, 0, 0, 1, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_menu` VALUES (1635920329879056385, 1111111111111111111, 1580357263003439106, 'flowUI', NULL, 1, 'icon-renwuliucheng', 'http://localhost:8989/flow-ui/idm/#/user-mgmt', NULL, NULL, 1, 0, 0, 15, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_menu` VALUES (1637297406628823041, 1111111111111111111, 1111111111111111111, '系统管理', NULL, 0, 'icon-xitongguanli', '/system', NULL, NULL, 0, 0, 0, 2, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_menu` VALUES (1637647486464438273, 1111111111111111111, 1594135789623184129, '运行一次', NULL, 2, NULL, NULL, NULL, 'sys:job:run', 0, 0, 0, 2, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_menu` VALUES (1648569698801393666, 1111111111111111111, 1637297406628823041, '客户端管理', 'client', 1, NULL, '/client', '/system/client/index', 'sys:client:list', 0, 0, 0, 1, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_menu` VALUES (1657464120406532098, 1111111111111111111, 1648569698801393666, '添加', NULL, 2, NULL, NULL, NULL, 'sys:client:create', 0, 0, 0, 1, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_menu` VALUES (1657464313466150914, 1111111111111111111, 1648569698801393666, '修改', NULL, 2, NULL, NULL, NULL, 'sys:client:modify', 0, 0, 0, 2, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_menu` VALUES (1657464432802488321, 1111111111111111111, 1648569698801393666, '删除', NULL, 2, NULL, NULL, NULL, 'sys:client:delete', 0, 0, 0, 3, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_menu` VALUES (1658346521789206529, 1111111111111111111, 1648569698801393666, '重置密钥', NULL, 2, NULL, NULL, NULL, 'sys:client:resetClientSecret', 0, 0, 0, 1, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_menu` VALUES (9223372036854775119, 1111111111111111111, 1637297406628823041, '消息公告', 'msg', 1, 'icon-sey-gonggao-b', '/msg', '/system/msg/index', 'sys:msg:list', 0, 0, 0, 3, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_menu` VALUES (9223372036854775120, 1111111111111111111, 1637297406628823041, '用户消息', 'userMsg', 1, 'icon-xiaoxi', '/msgUser', '/system/msgUser/index', 'sys:msgUser:list', 0, 0, 0, 2, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_menu` VALUES (9223372036854775121, 1111111111111111111, 1580357263003439106, '流程定义', 'definition', 1, 'icon-renwuliucheng', '/definition', '/flow/definition/index', 'flow:definition:list', 0, 0, 0, 2, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_menu` VALUES (9223372036854775807, 1111111111111111111, 1578702340666851329, '数据权限', 'permission', 1, 'icon-quanxianguanli', '/permission', '/system/permission/index', 'sys:permission:list', 0, 0, 0, 8, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);

-- ----------------------------
-- Table structure for sys_msg
-- ----------------------------
DROP TABLE IF EXISTS `sys_msg`;
CREATE TABLE `sys_msg`  (
                          `id` bigint(22) NOT NULL COMMENT '主键ID',
                          `dept_id` bigint(22) NULL DEFAULT NULL COMMENT '数据权限使用',
                          `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '消息标题',
                          `code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '消息编码',
                          `type` tinyint(1) NULL DEFAULT NULL COMMENT '消息类型 0 通知 1 公告',
                          `level` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '消息级别 error 紧急消息 info 一般消息 warning 警示消息 success 正常消息',
                          `user_id` bigint(22) NULL DEFAULT NULL COMMENT '消息发送人',
                          `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '消息内容',
                          `create_by` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建人编码',
                          `create_name` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建人姓名',
                          `create_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                          `update_by` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '修改人编码',
                          `update_name` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '修改人姓名',
                          `update_time` datetime(0) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '修改时间',
                          `is_delete` tinyint(1) NULL DEFAULT 0 COMMENT '是否删除 0 未删除 1 已删除',
                          `delete_by` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '删除人编码',
                          `tenant_id` bigint(22) NOT NULL COMMENT '租户ID',
                          PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '消息' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_msg
-- ----------------------------
INSERT INTO `sys_msg` VALUES (1594154596111454210, NULL, '你好世界', 'Halo3', 1, 'warning', NULL, '你好', NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_msg` VALUES (1594154596111454211, NULL, '你好世界', 'Halo2', 1, 'warning', NULL, '你好', NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_msg` VALUES (1594154596111454212, NULL, '你好世界', 'Halo1', 1, 'danger', NULL, '你好', NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_msg` VALUES (1595966082236538882, NULL, '你好世界', 'Halo', 1, 'info', NULL, '你好', NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);

-- ----------------------------
-- Table structure for sys_msg_channal
-- ----------------------------
DROP TABLE IF EXISTS `sys_msg_channal`;
CREATE TABLE `sys_msg_channal`  (
                                  `id` bigint(22) NOT NULL COMMENT '主键ID',
                                  `msg_id` bigint(22) NULL DEFAULT NULL COMMENT '消息ID',
                                  `type` tinyint(1) NULL DEFAULT NULL COMMENT '渠道类型 1 邮件 2 系统通知 3 小程序通知 4 公众号通知',
                                  `create_by` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建人编码',
                                  `create_name` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建人姓名',
                                  `create_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                                  `update_by` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '修改人编码',
                                  `update_name` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '修改人姓名',
                                  `update_time` datetime(0) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '修改时间',
                                  `is_delete` tinyint(1) NULL DEFAULT 0 COMMENT '是否删除 0 未删除 1 已删除',
                                  `delete_by` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '删除人编码',
                                  `tenant_id` bigint(22) NOT NULL COMMENT '租户ID',
                                  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '消息' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for sys_msg_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_msg_user`;
CREATE TABLE `sys_msg_user`  (
                               `id` bigint(22) NOT NULL COMMENT '主键ID',
                               `msg_id` bigint(22) NULL DEFAULT NULL COMMENT '消息ID',
                               `is_read` tinyint(1) NULL DEFAULT 0 COMMENT '标记已读 0 未读 1 已读',
                               `is_close` tinyint(1) NULL DEFAULT 0 COMMENT '标记关闭 0 未关闭 1 已关闭',
                               `dept_id` bigint(20) NULL DEFAULT NULL COMMENT '信息所属部门ID（数据权限使用）',
                               `user_id` bigint(22) NULL DEFAULT NULL COMMENT '接收消息的用户ID （数据权限使用）',
                               `create_by` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建人编码',
                               `create_name` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建人姓名',
                               `create_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                               `update_by` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '修改人编码',
                               `update_name` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '修改人姓名',
                               `update_time` datetime(0) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '修改时间',
                               `is_delete` tinyint(1) NULL DEFAULT 0 COMMENT '是否删除 0 未删除 1 已删除',
                               `delete_by` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '删除人编码',
                               `tenant_id` bigint(22) NOT NULL COMMENT '租户ID',
                               PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户消息' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for sys_permission
-- ----------------------------
DROP TABLE IF EXISTS `sys_permission`;
CREATE TABLE `sys_permission`  (
                                 `id` bigint(22) NOT NULL,
                                 `permission_name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '权限名称',
                                 `permission_code` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '权限标识 ALL 全部 DEPT_LEVEL 部门 DEPT_AND_LOWER_LEVEL 部门和子部门 OWN 自己 DIY_DEPT 自定义部门 DIY 自定义',
                                 `permissions` varchar(10000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '权限',
                                 `create_by` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建人编码',
                                 `create_name` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建人姓名',
                                 `create_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '创建时间',
                                 `update_by` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '修改人编码',
                                 `update_name` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '修改人名称',
                                 `update_time` datetime(0) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '修改时间',
                                 `is_delete` tinyint(1) NULL DEFAULT 0 COMMENT '是否删除 0 未删除 1 已删除',
                                 `delete_by` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '删除人编码',
                                 `tenant_id` bigint(22) NOT NULL COMMENT '租户ID',
                                 PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '数据权限规则' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_permission
-- ----------------------------
INSERT INTO `sys_permission` VALUES (1, '全部', 'ALL', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_permission` VALUES (2, '部门范围权限', 'DEPT_LEVEL', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_permission` VALUES (3, '个人', 'OWN', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_permission` VALUES (1648242663730073602, '测试', 'DEPT_LEVEL', '1565314987957145600,1565314987957145609,1581851971500371970', NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);

-- ----------------------------
-- Table structure for sys_platform
-- ----------------------------
DROP TABLE IF EXISTS `sys_platform`;
CREATE TABLE `sys_platform`  (
                               `id` bigint(22) NOT NULL COMMENT '主键ID',
                               `platform_name` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '平台名称',
                               `platform_code` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '平台编码',
                               `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '描述',
                               `create_by` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建人编码',
                               `create_name` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建人姓名',
                               `create_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                               `update_by` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '修改人编码',
                               `update_name` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '修改人名称',
                               `update_time` datetime(0) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '修改时间',
                               `is_delete` int(1) NULL DEFAULT 0 COMMENT '是否删除 0 未删除 1 已删除',
                               `delete_by` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '删除人编码',
                               `tenant_id` bigint(22) NOT NULL COMMENT '租户ID',
                               PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '平台' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_platform
-- ----------------------------
INSERT INTO `sys_platform` VALUES (1111111111111111111, '后台管理中心', 'managementCenter', '后台管理中心', NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_platform` VALUES (1580099387022348289, '微信小程序', 'mini', '微信小程序', NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);

-- ----------------------------
-- Table structure for sys_post
-- ----------------------------
DROP TABLE IF EXISTS `sys_post`;
CREATE TABLE `sys_post`  (
                           `id` bigint(22) NOT NULL COMMENT '主键ID',
                           `post_code` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '岗位名称',
                           `post_name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '岗位编码',
                           `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '描述',
                           `create_by` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建人编码',
                           `create_name` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建人姓名',
                           `create_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                           `update_by` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '修改人编码',
                           `update_name` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '修改人名称',
                           `update_time` datetime(0) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '修改时间',
                           `is_delete` int(1) NULL DEFAULT 0 COMMENT '是否删除 0 未删除 1 已删除',
                           `delete_by` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '删除人编码',
                           `tenant_id` bigint(22) NOT NULL COMMENT '租户ID',
                           PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '岗位' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_post
-- ----------------------------
INSERT INTO `sys_post` VALUES (1591377257933819906, 'CEO', '首席执行官', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_post` VALUES (1630094545759137794, 'BZ', '搬砖', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_post` VALUES (1637420262796746753, 'HR', '人力总监', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);

-- ----------------------------
-- Table structure for sys_registered_client
-- ----------------------------
DROP TABLE IF EXISTS `sys_registered_client`;
CREATE TABLE `sys_registered_client`  (
                                        `id` bigint(22) NOT NULL COMMENT '主键',
                                        `client_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '客户端ID',
                                        `client_id_issued_at` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '客户端发布日期',
                                        `client_secret` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '客户端访问密钥',
                                        `client_secret_expires_at` datetime(0) NULL DEFAULT NULL COMMENT '客户端加密到期时间',
                                        `client_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '客户端名称',
                                        `client_authentication_methods` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '客户端使用的身份验证方法；[client_secret_basic, client_secret_post, private_key_jwt, client_secret_jwt, none]',
                                        `authorization_grant_types` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '客户端支持的授权许可类型(grant_type)，可选值包括authorization_code,password,refresh_token,client_credentials,注意：password在auth2.1弃用了，我们自定义了【password】【sms_code】，若支持多个授权许可类型用逗号,分隔',
                                        `redirect_uris` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '客户端重定向URI，当grant_type为authorization_code时, 在Oauth2.0流程中会使用并检查，不在此列将被拒绝，使用IP或者域名，不能使用localhost',
                                        `scopes` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '客户端申请的权限范围，若有多个权限范围用逗号【,】分隔',
                                        `json_client_settings` json NOT NULL COMMENT '客户端自定义设置，包括验证密钥或者是否需要授权页面',
                                        `json_token_settings` json NOT NULL COMMENT '发布给客户端的 OAuth2 令牌的自定义设置',
                                        `create_by` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建人编码',
                                        `create_name` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建人姓名',
                                        `create_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                                        `update_by` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '修改人编码',
                                        `update_name` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '修改人姓名',
                                        `update_time` datetime(0) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '修改时间',
                                        `is_delete` tinyint(1) NULL DEFAULT 0 COMMENT '是否删除 0 未删除 1 已删除',
                                        `delete_by` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '删除人编码',
                                        PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_registered_client
-- ----------------------------
INSERT INTO `sys_registered_client` VALUES (1657300982050701313, 'breeze-pkce', '2023-05-13 10:25:00', '{bcrypt}$2a$10$nEey4sGLDrp5oAOOJBY9GOlyuHt/30emUvRbBeiOHOUkNLTtGIJUi', NULL, 'breeze-pkce', 'none', 'authorization_code', 'http://127.0.0.1:8070/login/oauth2/code/breeze-pkce,http://www.baidu.com', 'read,openid,profile,write', '{\"settings.client.jwk-set-url\": null, \"settings.client.require-proof-key\": true, \"settings.client.require-authorization-consent\": true, \"settings.client.token-endpoint-authentication-signing-algorithm\": null}', '{\"settings.token.access-token-format\": \"self-contained\", \"settings.token.reuse-refresh-tokens\": true, \"settings.token.access-token-time-to-live\": 60, \"settings.token.refresh-token-time-to-live\": 120, \"settings.token.id-token-signature-algorithm\": \"RS256\", \"settings.token.authorization-code-time-to-live\": 1}', NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL);
INSERT INTO `sys_registered_client` VALUES (1657300993757003778, 'breeze', '2023-05-13 10:25:00', '{bcrypt}$2a$10$9J/nj7YRmFFhUXJgQtlV5e7qsIS7wqts.zracnPv47FthwAb95G2y', '2023-12-30 00:00:00', 'breeze', 'client_secret_post,client_secret_basic', 'refresh_token,email_code,password,client_credentials,sms_code,authorization_code', 'http://127.0.0.1:8080/authorized,http://www.baidu.com,http://127.0.0.1:9000/swagger-ui/oauth2-redirect.html,http://127.0.0.1:8080/login/oauth2/code/breeze-oidc,http://127.0.0.1:9000/webjars/oauth/oauth2.html', 'read,address,user_info,phone,openid,profile,write,email', '{\"settings.client.jwk-set-url\": null, \"settings.client.require-proof-key\": false, \"settings.client.require-authorization-consent\": true, \"settings.client.token-endpoint-authentication-signing-algorithm\": \"RS256\"}', '{\"settings.token.access-token-format\": \"self-contained\", \"settings.token.reuse-refresh-tokens\": true, \"settings.token.access-token-time-to-live\": 60, \"settings.token.refresh-token-time-to-live\": 120, \"settings.token.id-token-signature-algorithm\": \"RS256\", \"settings.token.authorization-code-time-to-live\": 1}', NULL, NULL, NULL, NULL, NULL, '2023-05-30 10:01:01', 0, NULL);
INSERT INTO `sys_registered_client` VALUES (1657300993757003779, 'breeze-opaque', '2023-05-13 10:25:00', '{bcrypt}$2a$10$3D0xLRPAKSehDMMI.FobI.IQwOmUFYKwJJu6vjieQ26N5NVVCpdjm', NULL, 'breeze-opaque', 'client_secret_post,client_secret_basic', 'refresh_token,client_credentials,authorization_code', 'http://www.baidu.com,http://127.0.0.1:8050/login/oauth2/code/breeze-oidc,http://127.0.0.1:8050/authorized', 'address,read,user_info,phone,openid,profile,write,email', '{\"settings.client.jwk-set-url\": null, \"settings.client.require-proof-key\": false, \"settings.client.require-authorization-consent\": true, \"settings.client.token-endpoint-authentication-signing-algorithm\": null}', '{\"settings.token.access-token-format\": \"reference\", \"settings.token.reuse-refresh-tokens\": false, \"settings.token.access-token-time-to-live\": 60, \"settings.token.refresh-token-time-to-live\": 120, \"settings.token.id-token-signature-algorithm\": null, \"settings.token.authorization-code-time-to-live\": 10}', NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL);

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role`  (
                           `id` bigint(22) NOT NULL COMMENT '主键ID',
                           `role_code` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '角色编码',
                           `role_name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '角色名称',
                           `create_by` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建人编码',
                           `create_name` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建人姓名',
                           `create_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                           `update_by` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '修改人编码',
                           `update_name` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '修改人名称',
                           `update_time` datetime(0) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '修改时间',
                           `is_delete` tinyint(1) NULL DEFAULT 0 COMMENT '是否删除 0 未删除 1 已删除',
                           `delete_by` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '删除人编码',
                           `tenant_id` bigint(22) NOT NULL COMMENT '租户ID',
                           PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '角色' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES (1565322827518140417, 'ROLE_ADMIN', '超级管理员', NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_role` VALUES (1589074115103707138, 'ROLE_SIMPLE', '普通用户', NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_role` VALUES (1591282373843464193, 'ROLE_MINI', '小程序游客登录用户', NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_role` VALUES (1644533464768704514, 'ROLE_AUTH', 'Auth登录用户', NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);

-- ----------------------------
-- Table structure for sys_role_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_menu`;
CREATE TABLE `sys_role_menu`  (
                                `id` bigint(22) NOT NULL COMMENT '主键ID',
                                `menu_id` bigint(22) NULL DEFAULT NULL COMMENT '菜单ID',
                                `role_id` bigint(22) NULL DEFAULT NULL COMMENT '角色ID',
                                `create_by` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建人编码',
                                `create_name` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建人姓名',
                                `create_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                                PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '角色菜单' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role_menu
-- ----------------------------
INSERT INTO `sys_role_menu` VALUES (1657626308970659842, 1578702340654268411, 1589074115103707138, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1657626309230706690, 1578702340654268417, 1589074115103707138, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1657626309234900994, 9223372036854775807, 1589074115103707138, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1657626309239095297, 1582554585967800321, 1589074115103707138, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1657626309239095298, 1582555155344568321, 1589074115103707138, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1657626309239095299, 1582558188828790785, 1589074115103707138, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1657626309239095300, 1580357263003439106, 1589074115103707138, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1657626309243289601, 1578702340620713986, 1589074115103707138, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1657626309243289602, 1581966349440581634, 1589074115103707138, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1657626309247483906, 1582607135668621314, 1589074115103707138, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1657626309247483907, 1581965904601088001, 1589074115103707138, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1657626309247483908, 1581965904601088002, 1589074115103707138, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1657626309247483909, 1582688861908611074, 1589074115103707138, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1657626380521291777, 1578702340666851329, 1644533464768704514, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1657626380533874690, 1578702340671045634, 1644533464768704514, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1657626380538068993, 1578702340683628545, 1644533464768704514, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1657626380538068994, 1587692336744742913, 1644533464768704514, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1657626380542263297, 1578702340683628546, 1644533464768704514, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1657626380542263298, 1578702340654268416, 1644533464768704514, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1657626380542263299, 1578702340654268418, 1644533464768704514, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1657626380546457602, 1578702340662657027, 1644533464768704514, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1657626380546457603, 1578702340612325378, 1644533464768704514, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1657626380546457604, 9223372036854775807, 1644533464768704514, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1657626380546457605, 1578702340662657026, 1644533464768704514, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1657626380550651905, 1578702340654268412, 1644533464768704514, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1657626380550651906, 1637297406628823041, 1644533464768704514, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1657626380554846210, 9223372036854775120, 1644533464768704514, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1657626380554846211, 9223372036854775119, 1644533464768704514, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1657626380554846212, 1594135789623984129, 1644533464768704514, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1657626380554846213, 1594531945449451666, 1644533464768704514, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1657626380559040514, 1594135789623184129, 1644533464768704514, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1657626380559040515, 1637647486464438273, 1644533464768704514, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1657626380559040516, 1578702340612321378, 1644533464768704514, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1657626380563234817, 1582554585967800321, 1644533464768704514, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1657626380563234818, 1582555155344568321, 1644533464768704514, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1657626380563234819, 1582558188828790785, 1644533464768704514, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1657626380563234820, 1580357263003439106, 1644533464768704514, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1657626380563234821, 1580357773622202370, 1644533464768704514, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1657626380567429122, 9223372036854775121, 1644533464768704514, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1657626380567429123, 1578702340620713986, 1644533464768704514, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1657626380567429124, 1633285580421271553, 1644533464768704514, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1657626380567429125, 1581966349440581634, 1644533464768704514, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1657626380567429126, 1582607135668621314, 1644533464768704514, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1657626380571623426, 1581965904601088001, 1644533464768704514, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1657626380571623427, 1581965904601088002, 1644533464768704514, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1657626380571623428, 1582688861908611074, 1644533464768704514, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1658346555377192961, 1578702340666851329, 1565322827518140417, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1658346555377192962, 1578702340671045634, 1565322827518140417, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1658346555377192963, 1578702340671045635, 1565322827518140417, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1658346555377192964, 1578702340679434241, 1565322827518140417, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1658346555377192965, 1578702340679434243, 1565322827518140417, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1658346555440107521, 1578702340683628545, 1565322827518140417, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1658346555440107522, 1586717542633123841, 1565322827518140417, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1658346555440107523, 1599935876379897858, 1565322827518140417, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1658346555440107524, 1599936405688479746, 1565322827518140417, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1658346555440107525, 1578702340624908290, 1565322827518140417, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1658346555440107526, 1578702340620713988, 1565322827518140417, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1658346555440107527, 1587692336744742913, 1565322827518140417, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1658346555440107528, 1578702340620713987, 1565322827518140417, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1658346555440107529, 1601081152259891202, 1565322827518140417, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1658346555440107530, 1578702340683628546, 1565322827518140417, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1658346555440107531, 1578702340624908293, 1565322827518140417, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1658346555440107532, 1578702340624908291, 1565322827518140417, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1658346555440107533, 1578702340624908292, 1565322827518140417, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1658346555440107534, 1578702340654268416, 1565322827518140417, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1658346555440107535, 1589181822230048770, 1565322827518140417, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1658346555440107536, 1589181822230048771, 1565322827518140417, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1658346555440107537, 1589181822230048772, 1565322827518140417, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1658346555440107538, 1578702340654268418, 1565322827518140417, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1658346555440107539, 1578702340650074114, 1565322827518140417, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1658346555440107540, 1578702340641685505, 1565322827518140417, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1658346555440107541, 1578702340641685506, 1565322827518140417, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1658346555465273346, 1601858203636092929, 1565322827518140417, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1658346555465273347, 1578702340662657027, 1565322827518140417, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1658346555465273348, 1578702340650074115, 1565322827518140417, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1658346555465273349, 1578702340650074116, 1565322827518140417, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1658346555465273350, 1578702340650074117, 1565322827518140417, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1658346555465273351, 1586717542633123843, 1565322827518140417, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1658346555465273352, 1578702340612325378, 1565322827518140417, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1658346555465273353, 1578702340654268411, 1565322827518140417, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1658346555465273354, 1578702340654268417, 1565322827518140417, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1658346555465273355, 9223372036854775807, 1565322827518140417, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1658346555465273356, 1589789746153263106, 1565322827518140417, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1658346555465273357, 1598222575933485057, 1565322827518140417, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1658346555465273358, 1598222373868695553, 1565322827518140417, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1658346555465273359, 1578702340662657026, 1565322827518140417, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1658346555465273360, 1581843318345035778, 1565322827518140417, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1658346555465273361, 1578702340633296899, 1565322827518140417, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1658346555465273362, 1578702340633296898, 1565322827518140417, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1658346555465273363, 1578702340654268412, 1565322827518140417, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1658346555465273364, 1589181822230048781, 1565322827518140417, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1658346555465273365, 1589181822230048782, 1565322827518140417, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1658346555465273366, 1589181822230048783, 1565322827518140417, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1658346555465273367, 1637297406628823041, 1565322827518140417, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1658346555465273368, 1648569698801393666, 1565322827518140417, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1658346555465273369, 1657464120406532098, 1565322827518140417, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1658346555465273370, 1658346521789206529, 1565322827518140417, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1658346555465273371, 1657464313466150914, 1565322827518140417, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1658346555465273372, 1657464432802488321, 1565322827518140417, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1658346555465273373, 9223372036854775120, 1565322827518140417, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1658346555465273374, 1589181822230018782, 1565322827518140417, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1658346555465273375, 1589181822230048178, 1565322827518140417, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1658346555465273376, 9223372036854775119, 1565322827518140417, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1658346555465273377, 1589181822230049781, 1565322827518140417, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1658346555465273378, 1589181822230018781, 1565322827518140417, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1658346555465273379, 1589181822230048172, 1565322827518140417, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1658346555465273380, 1594135789623984129, 1565322827518140417, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1658346555465273381, 1594532038764326666, 1565322827518140417, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1658346555465273382, 1594532038764326913, 1565322827518140417, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1658346555465273383, 1594531945449451666, 1565322827518140417, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1658346555465273384, 1589181822230048778, 1565322827518140417, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1658346555465273385, 1594135789623184129, 1565322827518140417, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1658346555465273386, 1632642093459935231, 1565322827518140417, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1658346555465273387, 1637647486464438273, 1565322827518140417, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1658346555465273388, 1632642093459935232, 1565322827518140417, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1658346555465273389, 1632642093459935239, 1565322827518140417, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1658346555465273390, 1578702340612321378, 1565322827518140417, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1658346555465273391, 1632642093459915239, 1565322827518140417, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1658346555465273392, 1632642093459935236, 1565322827518140417, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1658346555465273393, 1582554585967800321, 1565322827518140417, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1658346555465273394, 1582555155344568321, 1565322827518140417, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1658346555465273395, 1582558188828790785, 1565322827518140417, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1658346555465273396, 1580357263003439106, 1565322827518140417, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1658346555465273397, 1580357773622202370, 1565322827518140417, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1658346555465273398, 1632642093459935234, 1565322827518140417, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1658346555465273399, 1632642093459935235, 1565322827518140417, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1658346555465273400, 1632642093459935256, 1565322827518140417, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1658346555465273401, 9223372036854775121, 1565322827518140417, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1658346555465273402, 1632925687029903361, 1565322827518140417, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1658346555465273403, 1632925792583757826, 1565322827518140417, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1658346555465273404, 1632950163226464257, 1565322827518140417, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1658346555465273405, 1632950317358747649, 1565322827518140417, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1658346555465273406, 1632979037821743106, 1565322827518140417, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1658346555465273407, 1633338860669214722, 1565322827518140417, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1658346555465273408, 1633349367631314945, 1565322827518140417, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1658346555465273409, 1578702340620713986, 1565322827518140417, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1658346555465273410, 1632642093459935233, 1565322827518140417, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1658346555465273411, 1633285580421271553, 1565322827518140417, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1658346555465273412, 1635920329879056385, 1565322827518140417, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1658346555465273413, 1581966349440581634, 1565322827518140417, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1658346555465273414, 1582607135668621314, 1565322827518140417, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1658346555465273415, 1581965904601088001, 1565322827518140417, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1658346555465273416, 1581965904601088002, 1565322827518140417, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1658346555465273417, 1582688861908611074, 1565322827518140417, NULL, NULL, NULL);

-- ----------------------------
-- Table structure for sys_role_permission
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_permission`;
CREATE TABLE `sys_role_permission`  (
                                      `id` bigint(22) NOT NULL COMMENT '主键ID',
                                      `permission_id` bigint(22) NULL DEFAULT NULL COMMENT '规则权限ID',
                                      `role_id` bigint(22) NULL DEFAULT NULL COMMENT '角色ID',
                                      `create_by` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建人编码',
                                      `create_name` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建人姓名',
                                      `create_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                                      PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '角色权限' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role_permission
-- ----------------------------
INSERT INTO `sys_role_permission` VALUES (1630037573185720322, 1, 1565322827518140417, NULL, NULL, NULL);
INSERT INTO `sys_role_permission` VALUES (1630038128528400385, 4, 1589074115103707138, NULL, NULL, NULL);
INSERT INTO `sys_role_permission` VALUES (1630038150712074241, 4, 1591282373843464193, NULL, NULL, NULL);
INSERT INTO `sys_role_permission` VALUES (1648238004454006785, 1, 1644533464768704514, NULL, NULL, NULL);

-- ----------------------------
-- Table structure for sys_tenant
-- ----------------------------
DROP TABLE IF EXISTS `sys_tenant`;
CREATE TABLE `sys_tenant`  (
                             `id` bigint(22) NOT NULL COMMENT '主键ID',
                             `tenant_code` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '租户编码',
                             `tenant_name` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '租户名称',
                             `create_by` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建人编码',
                             `create_name` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建人姓名',
                             `create_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                             `update_by` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '修改人编码',
                             `update_name` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '修改人名称',
                             `update_time` datetime(0) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '修改时间',
                             `is_delete` tinyint(1) NULL DEFAULT 0 COMMENT '是否删除 0 未删除 1 已删除',
                             `delete_by` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '删除人编码',
                             PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '租户' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_tenant
-- ----------------------------
INSERT INTO `sys_tenant` VALUES (1, 'GS', '公司', NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL);
INSERT INTO `sys_tenant` VALUES (1643796095560044546, 'FDS', '分公司', NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL);

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user`  (
                           `id` bigint(22) NOT NULL DEFAULT 0 COMMENT '主键ID',
                           `username` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '用户姓名',
                           `user_code` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '用户编码',
                           `amount_name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '登录账户名称',
                           `avatar` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '头像地址',
                           `avatar_file_id` bigint(22) NULL DEFAULT NULL COMMENT '头像文件ID',
                           `password` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '登录密码',
                           `post_id` bigint(22) NULL DEFAULT NULL COMMENT '岗位ID',
                           `dept_id` bigint(22) NULL DEFAULT NULL COMMENT '部门ID',
                           `sex` int(1) NULL DEFAULT NULL COMMENT '性别 0 女性 1 男性',
                           `id_card` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '身份证号',
                           `phone` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '手机号',
                           `open_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '微信OpenID',
                           `email` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '邮件',
                           `is_lock` int(1) NULL DEFAULT 0 COMMENT '锁定',
                           `create_by` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建人编码',
                           `create_name` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建人姓名',
                           `create_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                           `update_by` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '修改人编码',
                           `update_name` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '修改人名称',
                           `update_time` datetime(0) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '修改时间',
                           `is_delete` tinyint(1) NULL DEFAULT 0 COMMENT '是否删除 0 未删除 1 已删除',
                           `delete_by` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '删除人编码',
                           `tenant_id` bigint(22) NOT NULL COMMENT '租户ID',
                           PRIMARY KEY (`id`) USING BTREE,
                           UNIQUE INDEX `uni_username`(`username`, `tenant_id`) USING BTREE COMMENT '同一个租户下，用户名唯一索引'
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES (2, 'user', 'user', '普通用户', NULL, NULL, '{bcrypt}$2a$10$svQ43gxB5GM/bz6LC9VlyuaSWx9MRLrdhJv47.R5ou2JXryT8W12W', 1630094545759137794, 1601579970948726786, 1, '371521123456789', '17812345671', '1231231', 'breeze-cloud@foxmail.com', 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);
INSERT INTO `sys_user` VALUES (1111111111111111111, 'admin', 'admin', '超级管理员', NULL, NULL, '{bcrypt}$2a$10$AkMUjgbJz49CWNF6Vhj69ewLywcMvk48cLOevM0L7uOn7qzDuNrDm', 1591377257933819906, 1581851971500371970, 0, '371521123456781', '17812345678', '123123', 'breeze-cloud1@foxmail.com', 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);

-- ----------------------------
-- Table structure for sys_user_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_role`;
CREATE TABLE `sys_user_role`  (
                                `id` bigint(22) NOT NULL COMMENT '主键ID',
                                `user_id` bigint(22) NULL DEFAULT NULL COMMENT '用户ID',
                                `role_id` bigint(22) NULL DEFAULT NULL COMMENT '角色ID',
                                `create_by` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建人编码',
                                `create_name` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建人姓名',
                                `create_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                                PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户角色' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user_role
-- ----------------------------
INSERT INTO `sys_user_role` VALUES (1637419916733112321, 1111111111111111111, 1565322827518140417, NULL, NULL, NULL);
INSERT INTO `sys_user_role` VALUES (1637419916745695234, 1111111111111111111, 1589074115103707138, NULL, NULL, NULL);
INSERT INTO `sys_user_role` VALUES (1648248028307894273, 2, 1644533464768704514, NULL, NULL, NULL);
INSERT INTO `sys_user_role` VALUES (1648248028307894274, 2, 1589074115103707138, NULL, NULL, NULL);
INSERT INTO `sys_user_role` VALUES (1648248028307894275, 2, 1565322827518140417, NULL, NULL, NULL);
INSERT INTO `sys_user_role` VALUES (1648248028307894276, 2, 1591282373843464193, NULL, NULL, NULL);

SET FOREIGN_KEY_CHECKS = 1;
