DROP
DATABASE IF EXISTS `breeze_flowable`;
CREATE
DATABASE  `breeze_flowable` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;

SET NAMES utf8mb4;
SET
FOREIGN_KEY_CHECKS = 0;

USE `breeze_flowable`;

-- ----------------------------
-- Table structure for act_adm_databasechangelog
-- ----------------------------
DROP TABLE IF EXISTS `act_adm_databasechangelog`;
CREATE TABLE `act_adm_databasechangelog`
(
    `ID`            varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
    `AUTHOR`        varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
    `FILENAME`      varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
    `DATEEXECUTED`  datetime(0) NULL,
    `ORDEREXECUTED` int(11) NOT NULL,
    `EXECTYPE`      varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci  NOT NULL,
    `MD5SUM`        varchar(35) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `DESCRIPTION`   varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `COMMENTS`      varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `TAG`           varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `LIQUIBASE`     varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `CONTEXTS`      varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `LABELS`        varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `DEPLOYMENT_ID` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of act_adm_databasechangelog
-- ----------------------------
INSERT INTO `act_adm_databasechangelog`
VALUES ('1', 'flowable', 'META-INF/liquibase/flowable-admin-app-db-changelog.xml', '2023-03-09 02:24:58', 1, 'EXECUTED',
        '8:655e3bb142f7d051dfc2d641ee0eeebd', 'createTable tableName=ACT_ADM_SERVER_CONFIG', '', NULL, '4.9.1', NULL,
        NULL, '8933846585');

-- ----------------------------
-- Table structure for act_adm_databasechangeloglock
-- ----------------------------
DROP TABLE IF EXISTS `act_adm_databasechangeloglock`;
CREATE TABLE `act_adm_databasechangeloglock`
(
    `ID`          int(11) NOT NULL,
    `LOCKED`      bit(1) NOT NULL,
    `LOCKGRANTED` datetime(0) NULL DEFAULT NULL,
    `LOCKEDBY`    varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    PRIMARY KEY (`ID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of act_adm_databasechangeloglock
-- ----------------------------
INSERT INTO `act_adm_databasechangeloglock`
VALUES (1, b'0', NULL, NULL);

-- ----------------------------
-- Table structure for act_adm_server_config
-- ----------------------------
DROP TABLE IF EXISTS `act_adm_server_config`;
CREATE TABLE `act_adm_server_config`
(
    `ID_`             varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
    `NAME_`           varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `DESCRIPTION_`    varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `SERVER_ADDRESS_` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `PORT_`           int(11) NULL DEFAULT NULL,
    `CONTEXT_ROOT_`   varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `REST_ROOT_`      varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `USER_NAME_`      varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `PASSWORD_`       varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `ENDPOINT_TYPE_`  int(11) NULL DEFAULT NULL,
    `TENANT_ID_`      varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    PRIMARY KEY (`ID_`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of act_adm_server_config
-- ----------------------------
INSERT INTO `act_adm_server_config`
VALUES ('8fd2abe3-c3a2-11ed-890e-e4a8dfaec50c', 'Flowable Process app', 'Flowable Process REST config',
        'http://localhost', 8989, '/flowable-ui', 'process-api', 'admin', 'wf088DItMLLPiQIoM5rajQ==', 1, NULL);
INSERT INTO `act_adm_server_config`
VALUES ('8fd2fa04-c3a2-11ed-890e-e4a8dfaec50c', 'Flowable CMMN app', 'Flowable CMMN REST config', 'http://localhost',
        8989, '/flowable-ui', 'cmmn-api', 'admin', 'wf088DItMLLPiQIoM5rajQ==', 5, NULL);
INSERT INTO `act_adm_server_config`
VALUES ('8fd36f35-c3a2-11ed-890e-e4a8dfaec50c', 'Flowable App app', 'Flowable App REST config', 'http://localhost',
        8989, '/flowable-ui', 'app-api', 'admin', 'wf088DItMLLPiQIoM5rajQ==', 6, NULL);
INSERT INTO `act_adm_server_config`
VALUES ('8fd3bd56-c3a2-11ed-890e-e4a8dfaec50c', 'Flowable DMN app', 'Flowable DMN REST config', 'http://localhost',
        8989, '/flowable-ui', 'dmn-api', 'admin', 'wf088DItMLLPiQIoM5rajQ==', 2, NULL);
INSERT INTO `act_adm_server_config`
VALUES ('8fd43287-c3a2-11ed-890e-e4a8dfaec50c', 'Flowable Form app', 'Flowable Form REST config', 'http://localhost',
        8989, '/flowable-ui', 'form-api', 'admin', 'wf088DItMLLPiQIoM5rajQ==', 3, NULL);
INSERT INTO `act_adm_server_config`
VALUES ('8fd4cec8-c3a2-11ed-890e-e4a8dfaec50c', 'Flowable Content app', 'Flowable Content REST config',
        'http://localhost', 8989, '/flowable-ui', 'content-api', 'admin', 'wf088DItMLLPiQIoM5rajQ==', 4, NULL);

-- ----------------------------
-- Table structure for act_app_appdef
-- ----------------------------
DROP TABLE IF EXISTS `act_app_appdef`;
CREATE TABLE `act_app_appdef`
(
    `ID_`            varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
    `REV_`           int(11) NOT NULL,
    `NAME_`          varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `KEY_`           varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
    `VERSION_`       int(11) NOT NULL,
    `CATEGORY_`      varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `DEPLOYMENT_ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `RESOURCE_NAME_` varchar(4000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `DESCRIPTION_`   varchar(4000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `TENANT_ID_`     varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '',
    PRIMARY KEY (`ID_`) USING BTREE,
    UNIQUE INDEX `ACT_IDX_APP_DEF_UNIQ`(`KEY_`, `VERSION_`, `TENANT_ID_`) USING BTREE,
    INDEX            `ACT_IDX_APP_DEF_DPLY`(`DEPLOYMENT_ID_`) USING BTREE,
    CONSTRAINT `ACT_FK_APP_DEF_DPLY` FOREIGN KEY (`DEPLOYMENT_ID_`) REFERENCES `act_app_deployment` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for act_app_databasechangelog
-- ----------------------------
DROP TABLE IF EXISTS `act_app_databasechangelog`;
CREATE TABLE `act_app_databasechangelog`
(
    `ID`            varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
    `AUTHOR`        varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
    `FILENAME`      varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
    `DATEEXECUTED`  datetime(0) NULL,
    `ORDEREXECUTED` int(11) NOT NULL,
    `EXECTYPE`      varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci  NOT NULL,
    `MD5SUM`        varchar(35) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `DESCRIPTION`   varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `COMMENTS`      varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `TAG`           varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `LIQUIBASE`     varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `CONTEXTS`      varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `LABELS`        varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `DEPLOYMENT_ID` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of act_app_databasechangelog
-- ----------------------------
INSERT INTO `act_app_databasechangelog`
VALUES ('1', 'flowable', 'org/flowable/app/db/liquibase/flowable-app-db-changelog.xml', '2023-03-09 02:24:56', 1,
        'EXECUTED', '8:496fc778bdf2ab13f2e1926d0e63e0a2',
        'createTable tableName=ACT_APP_DEPLOYMENT; createTable tableName=ACT_APP_DEPLOYMENT_RESOURCE; addForeignKeyConstraint baseTableName=ACT_APP_DEPLOYMENT_RESOURCE, constraintName=ACT_FK_APP_RSRC_DPL, referencedTableName=ACT_APP_DEPLOYMENT; createIndex...',
        '', NULL, '4.9.1', NULL, NULL, '8933845173');
INSERT INTO `act_app_databasechangelog`
VALUES ('2', 'flowable', 'org/flowable/app/db/liquibase/flowable-app-db-changelog.xml', '2023-03-09 02:24:56', 2,
        'EXECUTED', '8:ccea9ebfb6c1f8367ca4dd473fcbb7db',
        'modifyDataType columnName=DEPLOY_TIME_, tableName=ACT_APP_DEPLOYMENT', '', NULL, '4.9.1', NULL, NULL,
        '8933845173');
INSERT INTO `act_app_databasechangelog`
VALUES ('3', 'flowable', 'org/flowable/app/db/liquibase/flowable-app-db-changelog.xml', '2023-03-09 02:24:57', 3,
        'EXECUTED', '8:f1f8aff320aade831944ebad24355f3d',
        'createIndex indexName=ACT_IDX_APP_DEF_UNIQ, tableName=ACT_APP_APPDEF', '', NULL, '4.9.1', NULL, NULL,
        '8933845173');

-- ----------------------------
-- Table structure for act_app_databasechangeloglock
-- ----------------------------
DROP TABLE IF EXISTS `act_app_databasechangeloglock`;
CREATE TABLE `act_app_databasechangeloglock`
(
    `ID`          int(11) NOT NULL,
    `LOCKED`      bit(1) NOT NULL,
    `LOCKGRANTED` datetime(0) NULL DEFAULT NULL,
    `LOCKEDBY`    varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    PRIMARY KEY (`ID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of act_app_databasechangeloglock
-- ----------------------------
INSERT INTO `act_app_databasechangeloglock`
VALUES (1, b'0', NULL, NULL);

-- ----------------------------
-- Table structure for act_app_deployment
-- ----------------------------
DROP TABLE IF EXISTS `act_app_deployment`;
CREATE TABLE `act_app_deployment`
(
    `ID_`          varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
    `NAME_`        varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `CATEGORY_`    varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `KEY_`         varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `DEPLOY_TIME_` datetime(3) NULL DEFAULT NULL,
    `TENANT_ID_`   varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '',
    PRIMARY KEY (`ID_`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for act_app_deployment_resource
-- ----------------------------
DROP TABLE IF EXISTS `act_app_deployment_resource`;
CREATE TABLE `act_app_deployment_resource`
(
    `ID_`             varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
    `NAME_`           varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `DEPLOYMENT_ID_`  varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `RESOURCE_BYTES_` longblob NULL,
    PRIMARY KEY (`ID_`) USING BTREE,
    INDEX             `ACT_IDX_APP_RSRC_DPL`(`DEPLOYMENT_ID_`) USING BTREE,
    CONSTRAINT `ACT_FK_APP_RSRC_DPL` FOREIGN KEY (`DEPLOYMENT_ID_`) REFERENCES `act_app_deployment` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for act_cmmn_casedef
-- ----------------------------
DROP TABLE IF EXISTS `act_cmmn_casedef`;
CREATE TABLE `act_cmmn_casedef`
(
    `ID_`                     varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
    `REV_`                    int(11) NOT NULL,
    `NAME_`                   varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `KEY_`                    varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
    `VERSION_`                int(11) NOT NULL,
    `CATEGORY_`               varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `DEPLOYMENT_ID_`          varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `RESOURCE_NAME_`          varchar(4000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `DESCRIPTION_`            varchar(4000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `HAS_GRAPHICAL_NOTATION_` bit(1) NULL DEFAULT NULL,
    `TENANT_ID_`              varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '',
    `DGRM_RESOURCE_NAME_`     varchar(4000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `HAS_START_FORM_KEY_`     bit(1) NULL DEFAULT NULL,
    PRIMARY KEY (`ID_`) USING BTREE,
    UNIQUE INDEX `ACT_IDX_CASE_DEF_UNIQ`(`KEY_`, `VERSION_`, `TENANT_ID_`) USING BTREE,
    INDEX                     `ACT_IDX_CASE_DEF_DPLY`(`DEPLOYMENT_ID_`) USING BTREE,
    CONSTRAINT `ACT_FK_CASE_DEF_DPLY` FOREIGN KEY (`DEPLOYMENT_ID_`) REFERENCES `act_cmmn_deployment` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for act_cmmn_databasechangelog
-- ----------------------------
DROP TABLE IF EXISTS `act_cmmn_databasechangelog`;
CREATE TABLE `act_cmmn_databasechangelog`
(
    `ID`            varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
    `AUTHOR`        varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
    `FILENAME`      varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
    `DATEEXECUTED`  datetime(0) NULL,
    `ORDEREXECUTED` int(11) NOT NULL,
    `EXECTYPE`      varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci  NOT NULL,
    `MD5SUM`        varchar(35) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `DESCRIPTION`   varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `COMMENTS`      varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `TAG`           varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `LIQUIBASE`     varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `CONTEXTS`      varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `LABELS`        varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `DEPLOYMENT_ID` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of act_cmmn_databasechangelog
-- ----------------------------
INSERT INTO `act_cmmn_databasechangelog`
VALUES ('1', 'flowable', 'org/flowable/cmmn/db/liquibase/flowable-cmmn-db-changelog.xml', '2023-03-09 02:24:55', 1,
        'EXECUTED', '8:8b4b922d90b05ff27483abefc9597aa6',
        'createTable tableName=ACT_CMMN_DEPLOYMENT; createTable tableName=ACT_CMMN_DEPLOYMENT_RESOURCE; addForeignKeyConstraint baseTableName=ACT_CMMN_DEPLOYMENT_RESOURCE, constraintName=ACT_FK_CMMN_RSRC_DPL, referencedTableName=ACT_CMMN_DEPLOYMENT; create...',
        '', NULL, '4.9.1', NULL, NULL, '8933842524');
INSERT INTO `act_cmmn_databasechangelog`
VALUES ('2', 'flowable', 'org/flowable/cmmn/db/liquibase/flowable-cmmn-db-changelog.xml', '2023-03-09 02:24:55', 2,
        'EXECUTED', '8:65e39b3d385706bb261cbeffe7533cbe',
        'addColumn tableName=ACT_CMMN_CASEDEF; addColumn tableName=ACT_CMMN_DEPLOYMENT_RESOURCE; addColumn tableName=ACT_CMMN_RU_CASE_INST; addColumn tableName=ACT_CMMN_RU_PLAN_ITEM_INST',
        '', NULL, '4.9.1', NULL, NULL, '8933842524');
INSERT INTO `act_cmmn_databasechangelog`
VALUES ('3', 'flowable', 'org/flowable/cmmn/db/liquibase/flowable-cmmn-db-changelog.xml', '2023-03-09 02:24:55', 3,
        'EXECUTED', '8:c01f6e802b49436b4489040da3012359',
        'addColumn tableName=ACT_CMMN_RU_PLAN_ITEM_INST; addColumn tableName=ACT_CMMN_RU_CASE_INST; createIndex indexName=ACT_IDX_PLAN_ITEM_STAGE_INST, tableName=ACT_CMMN_RU_PLAN_ITEM_INST; addColumn tableName=ACT_CMMN_RU_PLAN_ITEM_INST; addColumn tableNam...',
        '', NULL, '4.9.1', NULL, NULL, '8933842524');
INSERT INTO `act_cmmn_databasechangelog`
VALUES ('4', 'flowable', 'org/flowable/cmmn/db/liquibase/flowable-cmmn-db-changelog.xml', '2023-03-09 02:24:55', 4,
        'EXECUTED', '8:e40d29cb79345b7fb5afd38a7f0ba8fc',
        'createTable tableName=ACT_CMMN_HI_PLAN_ITEM_INST; addColumn tableName=ACT_CMMN_RU_MIL_INST; addColumn tableName=ACT_CMMN_HI_MIL_INST',
        '', NULL, '4.9.1', NULL, NULL, '8933842524');
INSERT INTO `act_cmmn_databasechangelog`
VALUES ('5', 'flowable', 'org/flowable/cmmn/db/liquibase/flowable-cmmn-db-changelog.xml', '2023-03-09 02:24:56', 5,
        'EXECUTED', '8:70349de472f87368dcdec971a10311a0',
        'modifyDataType columnName=DEPLOY_TIME_, tableName=ACT_CMMN_DEPLOYMENT; modifyDataType columnName=START_TIME_, tableName=ACT_CMMN_RU_CASE_INST; modifyDataType columnName=START_TIME_, tableName=ACT_CMMN_RU_PLAN_ITEM_INST; modifyDataType columnName=T...',
        '', NULL, '4.9.1', NULL, NULL, '8933842524');
INSERT INTO `act_cmmn_databasechangelog`
VALUES ('6', 'flowable', 'org/flowable/cmmn/db/liquibase/flowable-cmmn-db-changelog.xml', '2023-03-09 02:24:56', 6,
        'EXECUTED', '8:10e82e26a7fee94c32a92099c059c18c',
        'createIndex indexName=ACT_IDX_CASE_DEF_UNIQ, tableName=ACT_CMMN_CASEDEF', '', NULL, '4.9.1', NULL, NULL,
        '8933842524');
INSERT INTO `act_cmmn_databasechangelog`
VALUES ('7', 'flowable', 'org/flowable/cmmn/db/liquibase/flowable-cmmn-db-changelog.xml', '2023-03-09 02:24:56', 7,
        'EXECUTED', '8:530bc81a1e30618ccf4a2da1f7c6c043',
        'renameColumn newColumnName=CREATE_TIME_, oldColumnName=START_TIME_, tableName=ACT_CMMN_RU_PLAN_ITEM_INST; renameColumn newColumnName=CREATE_TIME_, oldColumnName=CREATED_TIME_, tableName=ACT_CMMN_HI_PLAN_ITEM_INST; addColumn tableName=ACT_CMMN_RU_P...',
        '', NULL, '4.9.1', NULL, NULL, '8933842524');
INSERT INTO `act_cmmn_databasechangelog`
VALUES ('8', 'flowable', 'org/flowable/cmmn/db/liquibase/flowable-cmmn-db-changelog.xml', '2023-03-09 02:24:56', 8,
        'EXECUTED', '8:e8c2eb1ce28bc301efe07e0e29757781', 'addColumn tableName=ACT_CMMN_HI_PLAN_ITEM_INST', '', NULL,
        '4.9.1', NULL, NULL, '8933842524');
INSERT INTO `act_cmmn_databasechangelog`
VALUES ('9', 'flowable', 'org/flowable/cmmn/db/liquibase/flowable-cmmn-db-changelog.xml', '2023-03-09 02:24:56', 9,
        'EXECUTED', '8:4cb4782b9bdec5ced2a64c525aa7b3a0',
        'addColumn tableName=ACT_CMMN_RU_PLAN_ITEM_INST; addColumn tableName=ACT_CMMN_HI_PLAN_ITEM_INST', '', NULL,
        '4.9.1', NULL, NULL, '8933842524');
INSERT INTO `act_cmmn_databasechangelog`
VALUES ('10', 'flowable', 'org/flowable/cmmn/db/liquibase/flowable-cmmn-db-changelog.xml', '2023-03-09 02:24:56', 10,
        'EXECUTED', '8:341c16be247f5d17badc9809da8691f9',
        'addColumn tableName=ACT_CMMN_RU_CASE_INST; addColumn tableName=ACT_CMMN_RU_CASE_INST; createIndex indexName=ACT_IDX_CASE_INST_REF_ID_, tableName=ACT_CMMN_RU_CASE_INST; addColumn tableName=ACT_CMMN_HI_CASE_INST; addColumn tableName=ACT_CMMN_HI_CASE...',
        '', NULL, '4.9.1', NULL, NULL, '8933842524');
INSERT INTO `act_cmmn_databasechangelog`
VALUES ('11', 'flowable', 'org/flowable/cmmn/db/liquibase/flowable-cmmn-db-changelog.xml', '2023-03-09 02:24:56', 11,
        'EXECUTED', '8:d7c4da9276bcfffbfb0ebfb25e3f7b05',
        'addColumn tableName=ACT_CMMN_RU_PLAN_ITEM_INST; addColumn tableName=ACT_CMMN_HI_PLAN_ITEM_INST', '', NULL,
        '4.9.1', NULL, NULL, '8933842524');
INSERT INTO `act_cmmn_databasechangelog`
VALUES ('12', 'flowable', 'org/flowable/cmmn/db/liquibase/flowable-cmmn-db-changelog.xml', '2023-03-09 02:24:56', 12,
        'EXECUTED', '8:adf4ecc45f2aa9a44a5626b02e1d6f98', 'addColumn tableName=ACT_CMMN_RU_CASE_INST', '', NULL,
        '4.9.1', NULL, NULL, '8933842524');
INSERT INTO `act_cmmn_databasechangelog`
VALUES ('13', 'flowable', 'org/flowable/cmmn/db/liquibase/flowable-cmmn-db-changelog.xml', '2023-03-09 02:24:56', 13,
        'EXECUTED', '8:7550626f964ab5518464709408333ec1',
        'addColumn tableName=ACT_CMMN_RU_PLAN_ITEM_INST; addColumn tableName=ACT_CMMN_HI_PLAN_ITEM_INST', '', NULL,
        '4.9.1', NULL, NULL, '8933842524');
INSERT INTO `act_cmmn_databasechangelog`
VALUES ('14', 'flowable', 'org/flowable/cmmn/db/liquibase/flowable-cmmn-db-changelog.xml', '2023-03-09 02:24:56', 14,
        'EXECUTED', '8:086b40b3a05596dcc8a8d7479922d494',
        'addColumn tableName=ACT_CMMN_RU_CASE_INST; addColumn tableName=ACT_CMMN_HI_CASE_INST', '', NULL, '4.9.1', NULL,
        NULL, '8933842524');
INSERT INTO `act_cmmn_databasechangelog`
VALUES ('16', 'flowable', 'org/flowable/cmmn/db/liquibase/flowable-cmmn-db-changelog.xml', '2023-03-09 02:24:56', 15,
        'EXECUTED', '8:a697a222ddd99dd15b36516a252f1c63',
        'addColumn tableName=ACT_CMMN_RU_CASE_INST; addColumn tableName=ACT_CMMN_HI_CASE_INST', '', NULL, '4.9.1', NULL,
        NULL, '8933842524');

-- ----------------------------
-- Table structure for act_cmmn_databasechangeloglock
-- ----------------------------
DROP TABLE IF EXISTS `act_cmmn_databasechangeloglock`;
CREATE TABLE `act_cmmn_databasechangeloglock`
(
    `ID`          int(11) NOT NULL,
    `LOCKED`      bit(1) NOT NULL,
    `LOCKGRANTED` datetime(0) NULL DEFAULT NULL,
    `LOCKEDBY`    varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    PRIMARY KEY (`ID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of act_cmmn_databasechangeloglock
-- ----------------------------
INSERT INTO `act_cmmn_databasechangeloglock`
VALUES (1, b'0', NULL, NULL);

-- ----------------------------
-- Table structure for act_cmmn_deployment
-- ----------------------------
DROP TABLE IF EXISTS `act_cmmn_deployment`;
CREATE TABLE `act_cmmn_deployment`
(
    `ID_`                   varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
    `NAME_`                 varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `CATEGORY_`             varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `KEY_`                  varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `DEPLOY_TIME_`          datetime(3) NULL DEFAULT NULL,
    `PARENT_DEPLOYMENT_ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `TENANT_ID_`            varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '',
    PRIMARY KEY (`ID_`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for act_cmmn_deployment_resource
-- ----------------------------
DROP TABLE IF EXISTS `act_cmmn_deployment_resource`;
CREATE TABLE `act_cmmn_deployment_resource`
(
    `ID_`             varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
    `NAME_`           varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `DEPLOYMENT_ID_`  varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `RESOURCE_BYTES_` longblob NULL,
    `GENERATED_`      bit(1) NULL DEFAULT NULL,
    PRIMARY KEY (`ID_`) USING BTREE,
    INDEX             `ACT_IDX_CMMN_RSRC_DPL`(`DEPLOYMENT_ID_`) USING BTREE,
    CONSTRAINT `ACT_FK_CMMN_RSRC_DPL` FOREIGN KEY (`DEPLOYMENT_ID_`) REFERENCES `act_cmmn_deployment` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for act_cmmn_hi_case_inst
-- ----------------------------
DROP TABLE IF EXISTS `act_cmmn_hi_case_inst`;
CREATE TABLE `act_cmmn_hi_case_inst`
(
    `ID_`                        varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
    `REV_`                       int(11) NOT NULL,
    `BUSINESS_KEY_`              varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `NAME_`                      varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `PARENT_ID_`                 varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `CASE_DEF_ID_`               varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `STATE_`                     varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `START_TIME_`                datetime(3) NULL DEFAULT NULL,
    `END_TIME_`                  datetime(3) NULL DEFAULT NULL,
    `START_USER_ID_`             varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `CALLBACK_ID_`               varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `CALLBACK_TYPE_`             varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `TENANT_ID_`                 varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '',
    `REFERENCE_ID_`              varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `REFERENCE_TYPE_`            varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `LAST_REACTIVATION_TIME_`    datetime(3) NULL DEFAULT NULL,
    `LAST_REACTIVATION_USER_ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `BUSINESS_STATUS_`           varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    PRIMARY KEY (`ID_`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for act_cmmn_hi_mil_inst
-- ----------------------------
DROP TABLE IF EXISTS `act_cmmn_hi_mil_inst`;
CREATE TABLE `act_cmmn_hi_mil_inst`
(
    `ID_`           varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
    `REV_`          int(11) NOT NULL,
    `NAME_`         varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
    `TIME_STAMP_`   datetime(3) NULL DEFAULT NULL,
    `CASE_INST_ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
    `CASE_DEF_ID_`  varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
    `ELEMENT_ID_`   varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
    `TENANT_ID_`    varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '',
    PRIMARY KEY (`ID_`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for act_cmmn_hi_plan_item_inst
-- ----------------------------
DROP TABLE IF EXISTS `act_cmmn_hi_plan_item_inst`;
CREATE TABLE `act_cmmn_hi_plan_item_inst`
(
    `ID_`                    varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
    `REV_`                   int(11) NOT NULL,
    `NAME_`                  varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `STATE_`                 varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `CASE_DEF_ID_`           varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `CASE_INST_ID_`          varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `STAGE_INST_ID_`         varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `IS_STAGE_`              bit(1) NULL DEFAULT NULL,
    `ELEMENT_ID_`            varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `ITEM_DEFINITION_ID_`    varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `ITEM_DEFINITION_TYPE_`  varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `CREATE_TIME_`           datetime(3) NULL DEFAULT NULL,
    `LAST_AVAILABLE_TIME_`   datetime(3) NULL DEFAULT NULL,
    `LAST_ENABLED_TIME_`     datetime(3) NULL DEFAULT NULL,
    `LAST_DISABLED_TIME_`    datetime(3) NULL DEFAULT NULL,
    `LAST_STARTED_TIME_`     datetime(3) NULL DEFAULT NULL,
    `LAST_SUSPENDED_TIME_`   datetime(3) NULL DEFAULT NULL,
    `COMPLETED_TIME_`        datetime(3) NULL DEFAULT NULL,
    `OCCURRED_TIME_`         datetime(3) NULL DEFAULT NULL,
    `TERMINATED_TIME_`       datetime(3) NULL DEFAULT NULL,
    `EXIT_TIME_`             datetime(3) NULL DEFAULT NULL,
    `ENDED_TIME_`            datetime(3) NULL DEFAULT NULL,
    `LAST_UPDATED_TIME_`     datetime(3) NULL DEFAULT NULL,
    `START_USER_ID_`         varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `REFERENCE_ID_`          varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `REFERENCE_TYPE_`        varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `TENANT_ID_`             varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '',
    `ENTRY_CRITERION_ID_`    varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `EXIT_CRITERION_ID_`     varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `SHOW_IN_OVERVIEW_`      bit(1) NULL DEFAULT NULL,
    `EXTRA_VALUE_`           varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `DERIVED_CASE_DEF_ID_`   varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `LAST_UNAVAILABLE_TIME_` datetime(3) NULL DEFAULT NULL,
    PRIMARY KEY (`ID_`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for act_cmmn_ru_case_inst
-- ----------------------------
DROP TABLE IF EXISTS `act_cmmn_ru_case_inst`;
CREATE TABLE `act_cmmn_ru_case_inst`
(
    `ID_`                        varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
    `REV_`                       int(11) NOT NULL,
    `BUSINESS_KEY_`              varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `NAME_`                      varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `PARENT_ID_`                 varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `CASE_DEF_ID_`               varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `STATE_`                     varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `START_TIME_`                datetime(3) NULL DEFAULT NULL,
    `START_USER_ID_`             varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `CALLBACK_ID_`               varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `CALLBACK_TYPE_`             varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `TENANT_ID_`                 varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '',
    `LOCK_TIME_`                 datetime(3) NULL DEFAULT NULL,
    `IS_COMPLETEABLE_`           bit(1) NULL DEFAULT NULL,
    `REFERENCE_ID_`              varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `REFERENCE_TYPE_`            varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `LOCK_OWNER_`                varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `LAST_REACTIVATION_TIME_`    datetime(3) NULL DEFAULT NULL,
    `LAST_REACTIVATION_USER_ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `BUSINESS_STATUS_`           varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    PRIMARY KEY (`ID_`) USING BTREE,
    INDEX                        `ACT_IDX_CASE_INST_CASE_DEF`(`CASE_DEF_ID_`) USING BTREE,
    INDEX                        `ACT_IDX_CASE_INST_PARENT`(`PARENT_ID_`) USING BTREE,
    INDEX                        `ACT_IDX_CASE_INST_REF_ID_`(`REFERENCE_ID_`) USING BTREE,
    CONSTRAINT `ACT_FK_CASE_INST_CASE_DEF` FOREIGN KEY (`CASE_DEF_ID_`) REFERENCES `act_cmmn_casedef` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for act_cmmn_ru_mil_inst
-- ----------------------------
DROP TABLE IF EXISTS `act_cmmn_ru_mil_inst`;
CREATE TABLE `act_cmmn_ru_mil_inst`
(
    `ID_`           varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
    `NAME_`         varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
    `TIME_STAMP_`   datetime(3) NULL DEFAULT NULL,
    `CASE_INST_ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
    `CASE_DEF_ID_`  varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
    `ELEMENT_ID_`   varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
    `TENANT_ID_`    varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '',
    PRIMARY KEY (`ID_`) USING BTREE,
    INDEX           `ACT_IDX_MIL_CASE_DEF`(`CASE_DEF_ID_`) USING BTREE,
    INDEX           `ACT_IDX_MIL_CASE_INST`(`CASE_INST_ID_`) USING BTREE,
    CONSTRAINT `ACT_FK_MIL_CASE_DEF` FOREIGN KEY (`CASE_DEF_ID_`) REFERENCES `act_cmmn_casedef` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT,
    CONSTRAINT `ACT_FK_MIL_CASE_INST` FOREIGN KEY (`CASE_INST_ID_`) REFERENCES `act_cmmn_ru_case_inst` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for act_cmmn_ru_plan_item_inst
-- ----------------------------
DROP TABLE IF EXISTS `act_cmmn_ru_plan_item_inst`;
CREATE TABLE `act_cmmn_ru_plan_item_inst`
(
    `ID_`                     varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
    `REV_`                    int(11) NOT NULL,
    `CASE_DEF_ID_`            varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `CASE_INST_ID_`           varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `STAGE_INST_ID_`          varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `IS_STAGE_`               bit(1) NULL DEFAULT NULL,
    `ELEMENT_ID_`             varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `NAME_`                   varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `STATE_`                  varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `CREATE_TIME_`            datetime(3) NULL DEFAULT NULL,
    `START_USER_ID_`          varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `REFERENCE_ID_`           varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `REFERENCE_TYPE_`         varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `TENANT_ID_`              varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '',
    `ITEM_DEFINITION_ID_`     varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `ITEM_DEFINITION_TYPE_`   varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `IS_COMPLETEABLE_`        bit(1) NULL DEFAULT NULL,
    `IS_COUNT_ENABLED_`       bit(1) NULL DEFAULT NULL,
    `VAR_COUNT_`              int(11) NULL DEFAULT NULL,
    `SENTRY_PART_INST_COUNT_` int(11) NULL DEFAULT NULL,
    `LAST_AVAILABLE_TIME_`    datetime(3) NULL DEFAULT NULL,
    `LAST_ENABLED_TIME_`      datetime(3) NULL DEFAULT NULL,
    `LAST_DISABLED_TIME_`     datetime(3) NULL DEFAULT NULL,
    `LAST_STARTED_TIME_`      datetime(3) NULL DEFAULT NULL,
    `LAST_SUSPENDED_TIME_`    datetime(3) NULL DEFAULT NULL,
    `COMPLETED_TIME_`         datetime(3) NULL DEFAULT NULL,
    `OCCURRED_TIME_`          datetime(3) NULL DEFAULT NULL,
    `TERMINATED_TIME_`        datetime(3) NULL DEFAULT NULL,
    `EXIT_TIME_`              datetime(3) NULL DEFAULT NULL,
    `ENDED_TIME_`             datetime(3) NULL DEFAULT NULL,
    `ENTRY_CRITERION_ID_`     varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `EXIT_CRITERION_ID_`      varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `EXTRA_VALUE_`            varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `DERIVED_CASE_DEF_ID_`    varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `LAST_UNAVAILABLE_TIME_`  datetime(3) NULL DEFAULT NULL,
    PRIMARY KEY (`ID_`) USING BTREE,
    INDEX                     `ACT_IDX_PLAN_ITEM_CASE_DEF`(`CASE_DEF_ID_`) USING BTREE,
    INDEX                     `ACT_IDX_PLAN_ITEM_CASE_INST`(`CASE_INST_ID_`) USING BTREE,
    INDEX                     `ACT_IDX_PLAN_ITEM_STAGE_INST`(`STAGE_INST_ID_`) USING BTREE,
    CONSTRAINT `ACT_FK_PLAN_ITEM_CASE_DEF` FOREIGN KEY (`CASE_DEF_ID_`) REFERENCES `act_cmmn_casedef` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT,
    CONSTRAINT `ACT_FK_PLAN_ITEM_CASE_INST` FOREIGN KEY (`CASE_INST_ID_`) REFERENCES `act_cmmn_ru_case_inst` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for act_cmmn_ru_sentry_part_inst
-- ----------------------------
DROP TABLE IF EXISTS `act_cmmn_ru_sentry_part_inst`;
CREATE TABLE `act_cmmn_ru_sentry_part_inst`
(
    `ID_`                varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
    `REV_`               int(11) NOT NULL,
    `CASE_DEF_ID_`       varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `CASE_INST_ID_`      varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `PLAN_ITEM_INST_ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `ON_PART_ID_`        varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `IF_PART_ID_`        varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `TIME_STAMP_`        datetime(3) NULL DEFAULT NULL,
    PRIMARY KEY (`ID_`) USING BTREE,
    INDEX                `ACT_IDX_SENTRY_CASE_DEF`(`CASE_DEF_ID_`) USING BTREE,
    INDEX                `ACT_IDX_SENTRY_CASE_INST`(`CASE_INST_ID_`) USING BTREE,
    INDEX                `ACT_IDX_SENTRY_PLAN_ITEM`(`PLAN_ITEM_INST_ID_`) USING BTREE,
    CONSTRAINT `ACT_FK_SENTRY_CASE_DEF` FOREIGN KEY (`CASE_DEF_ID_`) REFERENCES `act_cmmn_casedef` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT,
    CONSTRAINT `ACT_FK_SENTRY_CASE_INST` FOREIGN KEY (`CASE_INST_ID_`) REFERENCES `act_cmmn_ru_case_inst` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT,
    CONSTRAINT `ACT_FK_SENTRY_PLAN_ITEM` FOREIGN KEY (`PLAN_ITEM_INST_ID_`) REFERENCES `act_cmmn_ru_plan_item_inst` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for act_co_content_item
-- ----------------------------
DROP TABLE IF EXISTS `act_co_content_item`;
CREATE TABLE `act_co_content_item`
(
    `ID_`                 varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
    `NAME_`               varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
    `MIME_TYPE_`          varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `TASK_ID_`            varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `PROC_INST_ID_`       varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `CONTENT_STORE_ID_`   varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `CONTENT_STORE_NAME_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `FIELD_`              varchar(400) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `CONTENT_AVAILABLE_`  bit(1) NULL DEFAULT b'0',
    `CREATED_`            timestamp(6) NULL DEFAULT NULL,
    `CREATED_BY_`         varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `LAST_MODIFIED_`      timestamp(6) NULL DEFAULT NULL,
    `LAST_MODIFIED_BY_`   varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `CONTENT_SIZE_`       bigint(20) NULL DEFAULT 0,
    `TENANT_ID_`          varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `SCOPE_ID_`           varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `SCOPE_TYPE_`         varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    PRIMARY KEY (`ID_`) USING BTREE,
    INDEX                 `idx_contitem_taskid`(`TASK_ID_`) USING BTREE,
    INDEX                 `idx_contitem_procid`(`PROC_INST_ID_`) USING BTREE,
    INDEX                 `idx_contitem_scope`(`SCOPE_ID_`, `SCOPE_TYPE_`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for act_co_databasechangelog
-- ----------------------------
DROP TABLE IF EXISTS `act_co_databasechangelog`;
CREATE TABLE `act_co_databasechangelog`
(
    `ID`            varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
    `AUTHOR`        varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
    `FILENAME`      varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
    `DATEEXECUTED`  datetime(0) NULL,
    `ORDEREXECUTED` int(11) NOT NULL,
    `EXECTYPE`      varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci  NOT NULL,
    `MD5SUM`        varchar(35) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `DESCRIPTION`   varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `COMMENTS`      varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `TAG`           varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `LIQUIBASE`     varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `CONTEXTS`      varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `LABELS`        varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `DEPLOYMENT_ID` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of act_co_databasechangelog
-- ----------------------------
INSERT INTO `act_co_databasechangelog`
VALUES ('1', 'activiti', 'org/flowable/content/db/liquibase/flowable-content-db-changelog.xml', '2023-03-09 02:24:53',
        1, 'EXECUTED', '8:7644d7165cfe799200a2abdd3419e8b6',
        'createTable tableName=ACT_CO_CONTENT_ITEM; createIndex indexName=idx_contitem_taskid, tableName=ACT_CO_CONTENT_ITEM; createIndex indexName=idx_contitem_procid, tableName=ACT_CO_CONTENT_ITEM',
        '', NULL, '4.9.1', NULL, NULL, '8933842222');
INSERT INTO `act_co_databasechangelog`
VALUES ('2', 'flowable', 'org/flowable/content/db/liquibase/flowable-content-db-changelog.xml', '2023-03-09 02:24:53',
        2, 'EXECUTED', '8:fe7b11ac7dbbf9c43006b23bbab60bab',
        'addColumn tableName=ACT_CO_CONTENT_ITEM; createIndex indexName=idx_contitem_scope, tableName=ACT_CO_CONTENT_ITEM',
        '', NULL, '4.9.1', NULL, NULL, '8933842222');

-- ----------------------------
-- Table structure for act_co_databasechangeloglock
-- ----------------------------
DROP TABLE IF EXISTS `act_co_databasechangeloglock`;
CREATE TABLE `act_co_databasechangeloglock`
(
    `ID`          int(11) NOT NULL,
    `LOCKED`      bit(1) NOT NULL,
    `LOCKGRANTED` datetime(0) NULL DEFAULT NULL,
    `LOCKEDBY`    varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    PRIMARY KEY (`ID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of act_co_databasechangeloglock
-- ----------------------------
INSERT INTO `act_co_databasechangeloglock`
VALUES (1, b'0', NULL, NULL);

-- ----------------------------
-- Table structure for act_de_databasechangelog
-- ----------------------------
DROP TABLE IF EXISTS `act_de_databasechangelog`;
CREATE TABLE `act_de_databasechangelog`
(
    `ID`            varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
    `AUTHOR`        varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
    `FILENAME`      varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
    `DATEEXECUTED`  datetime(0) NULL,
    `ORDEREXECUTED` int(11) NOT NULL,
    `EXECTYPE`      varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci  NOT NULL,
    `MD5SUM`        varchar(35) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `DESCRIPTION`   varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `COMMENTS`      varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `TAG`           varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `LIQUIBASE`     varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `CONTEXTS`      varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `LABELS`        varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `DEPLOYMENT_ID` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of act_de_databasechangelog
-- ----------------------------
INSERT INTO `act_de_databasechangelog`
VALUES ('1', 'flowable', 'META-INF/liquibase/flowable-modeler-app-db-changelog.xml', '2023-03-09 02:24:58', 1,
        'EXECUTED', '8:e70d1d9d3899a734296b2514ccc71501',
        'createTable tableName=ACT_DE_MODEL; createIndex indexName=idx_proc_mod_created, tableName=ACT_DE_MODEL; createTable tableName=ACT_DE_MODEL_HISTORY; createIndex indexName=idx_proc_mod_history_proc, tableName=ACT_DE_MODEL_HISTORY; createTable tableN...',
        '', NULL, '4.9.1', NULL, NULL, '8933846893');
INSERT INTO `act_de_databasechangelog`
VALUES ('3', 'flowable', 'META-INF/liquibase/flowable-modeler-app-db-changelog.xml', '2023-03-09 02:24:58', 2,
        'EXECUTED', '8:3a9143bef2e45f2316231cc1369138b6',
        'addColumn tableName=ACT_DE_MODEL; addColumn tableName=ACT_DE_MODEL_HISTORY', '', NULL, '4.9.1', NULL, NULL,
        '8933846893');

-- ----------------------------
-- Table structure for act_de_databasechangeloglock
-- ----------------------------
DROP TABLE IF EXISTS `act_de_databasechangeloglock`;
CREATE TABLE `act_de_databasechangeloglock`
(
    `ID`          int(11) NOT NULL,
    `LOCKED`      bit(1) NOT NULL,
    `LOCKGRANTED` datetime(0) NULL DEFAULT NULL,
    `LOCKEDBY`    varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    PRIMARY KEY (`ID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of act_de_databasechangeloglock
-- ----------------------------
INSERT INTO `act_de_databasechangeloglock`
VALUES (1, b'0', NULL, NULL);

-- ----------------------------
-- Table structure for act_de_model
-- ----------------------------
DROP TABLE IF EXISTS `act_de_model`;
CREATE TABLE `act_de_model`
(
    `id`                varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
    `name`              varchar(400) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
    `model_key`         varchar(400) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
    `description`       varchar(4000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `model_comment`     varchar(4000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `created`           datetime(6) NULL DEFAULT NULL,
    `created_by`        varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `last_updated`      datetime(6) NULL DEFAULT NULL,
    `last_updated_by`   varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `version`           int(11) NULL DEFAULT NULL,
    `model_editor_json` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
    `thumbnail`         longblob NULL,
    `model_type`        int(11) NULL DEFAULT NULL,
    `tenant_id`         varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    PRIMARY KEY (`id`) USING BTREE,
    INDEX               `idx_proc_mod_created`(`created_by`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of act_de_model
-- ----------------------------
INSERT INTO `act_de_model`
VALUES ('05a2ba61-d284-11ed-b1f0-e4a8dfaec50c', 'test', 'test', '', NULL, '2023-04-04 08:59:58.790000', 'admin',
        '2023-04-04 09:08:43.138000', 'admin', 1,
        '{\"modelId\":\"05a2ba61-d284-11ed-b1f0-e4a8dfaec50c\",\"bounds\":{\"lowerRight\":{\"x\":1200,\"y\":1050},\"upperLeft\":{\"x\":0,\"y\":0}},\"properties\":{\"process_id\":\"test\",\"name\":\"test\",\"documentation\":\"\",\"process_author\":\"\",\"process_version\":\"\",\"process_namespace\":\"http://www.flowable.org/processdef\",\"process_historylevel\":\"\",\"isexecutable\":true,\"dataproperties\":\"\",\"executionlisteners\":\"\",\"eventlisteners\":\"\",\"signaldefinitions\":\"\",\"messagedefinitions\":\"\",\"escalationdefinitions\":\"\",\"process_potentialstarteruser\":\"\",\"process_potentialstartergroup\":\"\",\"iseagerexecutionfetch\":\"false\"},\"childShapes\":[{\"resourceId\":\"startEvent1\",\"properties\":{\"overrideid\":\"\",\"name\":\"\",\"documentation\":\"\",\"executionlisteners\":\"\",\"initiator\":\"\",\"formkeydefinition\":\"\",\"formreference\":\"\",\"formfieldvalidation\":true,\"formproperties\":\"\"},\"stencil\":{\"id\":\"StartNoneEvent\"},\"childShapes\":[],\"outgoing\":[{\"resourceId\":\"sid-F43EF97D-84B1-4B01-BBF5-8EBA4BF9A27E\"}],\"bounds\":{\"lowerRight\":{\"x\":120,\"y\":180},\"upperLeft\":{\"x\":90,\"y\":150}},\"dockers\":[]},{\"resourceId\":\"sid-50CFC1D3-2ECC-4A2A-80CD-0080468D3691\",\"properties\":{\"overrideid\":\"\",\"name\":\"\",\"documentation\":\"\",\"asynchronousdefinition\":false,\"exclusivedefinition\":\"false\",\"sequencefloworder\":\"\"},\"stencil\":{\"id\":\"ExclusiveGateway\"},\"childShapes\":[],\"outgoing\":[{\"resourceId\":\"sid-C1B3CC47-3EF3-453B-85E5-4CC85BEF694F\"},{\"resourceId\":\"sid-95D344D3-AF98-42FC-ABE0-1DD7F0F0622D\"}],\"bounds\":{\"lowerRight\":{\"x\":491.5,\"y\":185},\"upperLeft\":{\"x\":451.5,\"y\":145}},\"dockers\":[]},{\"resourceId\":\"sid-4E37ED4E-8B91-4B11-B6B3-887ABC6902EB\",\"properties\":{\"overrideid\":\"\",\"name\":\"\",\"documentation\":\"\",\"asynchronousdefinition\":\"false\",\"exclusivedefinition\":\"false\",\"executionlisteners\":\"\",\"multiinstance_type\":\"None\",\"multiinstance_variableaggregations\":\"\",\"multiinstance_cardinality\":\"\",\"multiinstance_collection\":\"\",\"multiinstance_variable\":\"\",\"multiinstance_condition\":\"\",\"isforcompensation\":\"false\",\"usertaskassignment\":\"\",\"formkeydefinition\":\"\",\"formreference\":\"\",\"formfieldvalidation\":true,\"duedatedefinition\":\"\",\"prioritydefinition\":\"\",\"formproperties\":\"\",\"tasklisteners\":\"\",\"skipexpression\":\"\",\"categorydefinition\":\"\",\"taskidvariablename\":\"\"},\"stencil\":{\"id\":\"UserTask\"},\"childShapes\":[],\"outgoing\":[{\"resourceId\":\"sid-A95AE2C6-B131-4CB6-B70E-91DACBE40911\"}],\"bounds\":{\"lowerRight\":{\"x\":340,\"y\":205},\"upperLeft\":{\"x\":240,\"y\":125}},\"dockers\":[]},{\"resourceId\":\"sid-F43EF97D-84B1-4B01-BBF5-8EBA4BF9A27E\",\"properties\":{\"overrideid\":\"\",\"name\":\"\",\"documentation\":\"\",\"conditionsequenceflow\":\"\",\"executionlisteners\":\"\",\"defaultflow\":\"false\",\"skipexpression\":\"\"},\"stencil\":{\"id\":\"SequenceFlow\"},\"childShapes\":[],\"outgoing\":[{\"resourceId\":\"sid-4E37ED4E-8B91-4B11-B6B3-887ABC6902EB\"}],\"bounds\":{\"lowerRight\":{\"x\":239.859375,\"y\":165},\"upperLeft\":{\"x\":120.453125,\"y\":165}},\"dockers\":[{\"x\":15,\"y\":15},{\"x\":50,\"y\":40}],\"target\":{\"resourceId\":\"sid-4E37ED4E-8B91-4B11-B6B3-887ABC6902EB\"}},{\"resourceId\":\"sid-A95AE2C6-B131-4CB6-B70E-91DACBE40911\",\"properties\":{\"overrideid\":\"\",\"name\":\"\",\"documentation\":\"\",\"conditionsequenceflow\":\"\",\"executionlisteners\":\"\",\"defaultflow\":\"false\",\"skipexpression\":\"\"},\"stencil\":{\"id\":\"SequenceFlow\"},\"childShapes\":[],\"outgoing\":[{\"resourceId\":\"sid-50CFC1D3-2ECC-4A2A-80CD-0080468D3691\"}],\"bounds\":{\"lowerRight\":{\"x\":451.357421875,\"y\":165},\"upperLeft\":{\"x\":340.62890625,\"y\":165}},\"dockers\":[{\"x\":50,\"y\":40},{\"x\":20,\"y\":20}],\"target\":{\"resourceId\":\"sid-50CFC1D3-2ECC-4A2A-80CD-0080468D3691\"}},{\"resourceId\":\"sid-928EF3EE-063D-4E83-B737-5F4DF477FAD9\",\"properties\":{\"overrideid\":\"\",\"name\":\"\",\"documentation\":\"\",\"asynchronousdefinition\":\"false\",\"exclusivedefinition\":\"false\",\"executionlisteners\":\"\",\"multiinstance_type\":\"None\",\"multiinstance_variableaggregations\":\"\",\"multiinstance_cardinality\":\"\",\"multiinstance_collection\":\"\",\"multiinstance_variable\":\"\",\"multiinstance_condition\":\"\",\"isforcompensation\":\"false\",\"usertaskassignment\":\"\",\"formkeydefinition\":\"\",\"formreference\":\"\",\"formfieldvalidation\":true,\"duedatedefinition\":\"\",\"prioritydefinition\":\"\",\"formproperties\":\"\",\"tasklisteners\":\"\",\"skipexpression\":\"\",\"categorydefinition\":\"\",\"taskidvariablename\":\"\"},\"stencil\":{\"id\":\"UserTask\"},\"childShapes\":[],\"outgoing\":[{\"resourceId\":\"sid-76CFD15C-A952-4475-9BCE-1B7AD38C1D12\"}],\"bounds\":{\"lowerRight\":{\"x\":636.5,\"y\":205},\"upperLeft\":{\"x\":536.5,\"y\":125}},\"dockers\":[]},{\"resourceId\":\"sid-C1B3CC47-3EF3-453B-85E5-4CC85BEF694F\",\"properties\":{\"overrideid\":\"\",\"name\":\"\",\"documentation\":\"\",\"conditionsequenceflow\":\"\",\"executionlisteners\":\"\",\"defaultflow\":\"false\",\"skipexpression\":\"\"},\"stencil\":{\"id\":\"SequenceFlow\"},\"childShapes\":[],\"outgoing\":[{\"resourceId\":\"sid-928EF3EE-063D-4E83-B737-5F4DF477FAD9\"}],\"bounds\":{\"lowerRight\":{\"x\":536.3007907843881,\"y\":165.41360197940782},\"upperLeft\":{\"x\":491.78514671561186,\"y\":165.21921052059218}},\"dockers\":[{\"x\":20.5,\"y\":20.5},{\"x\":50,\"y\":40}],\"target\":{\"resourceId\":\"sid-928EF3EE-063D-4E83-B737-5F4DF477FAD9\"}},{\"resourceId\":\"sid-485FC642-A5B1-424E-83A2-7A7C441DA8F2\",\"properties\":{\"overrideid\":\"\",\"name\":\"\",\"documentation\":\"\",\"asynchronousdefinition\":\"false\",\"exclusivedefinition\":\"false\",\"executionlisteners\":\"\",\"multiinstance_type\":\"None\",\"multiinstance_variableaggregations\":\"\",\"multiinstance_cardinality\":\"\",\"multiinstance_collection\":\"\",\"multiinstance_variable\":\"\",\"multiinstance_condition\":\"\",\"isforcompensation\":\"false\",\"usertaskassignment\":\"\",\"formkeydefinition\":\"\",\"formreference\":\"\",\"formfieldvalidation\":true,\"duedatedefinition\":\"\",\"prioritydefinition\":\"\",\"formproperties\":\"\",\"tasklisteners\":\"\",\"skipexpression\":\"\",\"categorydefinition\":\"\",\"taskidvariablename\":\"\"},\"stencil\":{\"id\":\"UserTask\"},\"childShapes\":[],\"outgoing\":[{\"resourceId\":\"sid-67D30288-F81A-4DEB-BBEC-2DDBCF688FF6\"}],\"bounds\":{\"lowerRight\":{\"x\":636.5,\"y\":350},\"upperLeft\":{\"x\":536.5,\"y\":270}},\"dockers\":[]},{\"resourceId\":\"sid-95D344D3-AF98-42FC-ABE0-1DD7F0F0622D\",\"properties\":{\"overrideid\":\"\",\"name\":\"\",\"documentation\":\"\",\"conditionsequenceflow\":\"\",\"executionlisteners\":\"\",\"defaultflow\":\"false\",\"skipexpression\":\"\"},\"stencil\":{\"id\":\"SequenceFlow\"},\"childShapes\":[],\"outgoing\":[{\"resourceId\":\"sid-485FC642-A5B1-424E-83A2-7A7C441DA8F2\"}],\"bounds\":{\"lowerRight\":{\"x\":536.30078125,\"y\":310},\"upperLeft\":{\"x\":472,\"y\":185.69140625}},\"dockers\":[{\"x\":20.5,\"y\":20.5},{\"x\":472,\"y\":310},{\"x\":50,\"y\":40}],\"target\":{\"resourceId\":\"sid-485FC642-A5B1-424E-83A2-7A7C441DA8F2\"}},{\"resourceId\":\"sid-A762BC5E-1F45-4830-BE4C-F9711E94A2A7\",\"properties\":{\"overrideid\":\"\",\"name\":\"\",\"documentation\":\"\",\"executionlisteners\":\"\"},\"stencil\":{\"id\":\"EndNoneEvent\"},\"childShapes\":[],\"outgoing\":[],\"bounds\":{\"lowerRight\":{\"x\":709.5,\"y\":179},\"upperLeft\":{\"x\":681.5,\"y\":151}},\"dockers\":[]},{\"resourceId\":\"sid-76CFD15C-A952-4475-9BCE-1B7AD38C1D12\",\"properties\":{\"overrideid\":\"\",\"name\":\"\",\"documentation\":\"\",\"conditionsequenceflow\":\"\",\"executionlisteners\":\"\",\"defaultflow\":\"false\",\"skipexpression\":\"\"},\"stencil\":{\"id\":\"SequenceFlow\"},\"childShapes\":[],\"outgoing\":[{\"resourceId\":\"sid-A762BC5E-1F45-4830-BE4C-F9711E94A2A7\"}],\"bounds\":{\"lowerRight\":{\"x\":680.875,\"y\":165},\"upperLeft\":{\"x\":636.890625,\"y\":165}},\"dockers\":[{\"x\":50,\"y\":40},{\"x\":14,\"y\":14}],\"target\":{\"resourceId\":\"sid-A762BC5E-1F45-4830-BE4C-F9711E94A2A7\"}},{\"resourceId\":\"sid-6B4C0881-3AE4-439A-AC3F-9D02EA0AB7CE\",\"properties\":{\"overrideid\":\"\",\"name\":\"\",\"documentation\":\"\",\"executionlisteners\":\"\"},\"stencil\":{\"id\":\"EndNoneEvent\"},\"childShapes\":[],\"outgoing\":[],\"bounds\":{\"lowerRight\":{\"x\":709.5,\"y\":324},\"upperLeft\":{\"x\":681.5,\"y\":296}},\"dockers\":[]},{\"resourceId\":\"sid-67D30288-F81A-4DEB-BBEC-2DDBCF688FF6\",\"properties\":{\"overrideid\":\"\",\"name\":\"\",\"documentation\":\"\",\"conditionsequenceflow\":\"\",\"executionlisteners\":\"\",\"defaultflow\":\"false\",\"skipexpression\":\"\"},\"stencil\":{\"id\":\"SequenceFlow\"},\"childShapes\":[],\"outgoing\":[{\"resourceId\":\"sid-6B4C0881-3AE4-439A-AC3F-9D02EA0AB7CE\"}],\"bounds\":{\"lowerRight\":{\"x\":680.875,\"y\":310},\"upperLeft\":{\"x\":636.890625,\"y\":310}},\"dockers\":[{\"x\":50,\"y\":40},{\"x\":14,\"y\":14}],\"target\":{\"resourceId\":\"sid-6B4C0881-3AE4-439A-AC3F-9D02EA0AB7CE\"}}],\"stencil\":{\"id\":\"BPMNDiagram\"},\"stencilset\":{\"namespace\":\"http://b3mn.org/stencilset/bpmn2.0#\",\"url\":\"../editor/stencilsets/bpmn2.0/bpmn2.0.json\"}}',
        0x89504E470D0A1A0A0000000D49484452000001140000006E0806000000E6BEEC6A000008774944415478DAED9D4D4C5B57168059B0984517A3681659CCA28B59CCB28B2EB2C822BB5974D145E4716C0336212130284221418E12254455B2A8AA11928B8450A58992A6C3488312454D3B123FB62CD1549E16A51542E64748088BD2460527D8C818C8DC39C7B5199700310FEC790F7F9F742427B179CFEF9CFBF9DC7B9F494D0D00000000000000000000C0FF0B634CEDECECEC67B1582C158944CCD0D0906D221C0EAF47A3D1983C3E41A6C8393880C9C9C94F2481460ACCA4D36993CD666D137A3ED3D3D366646424458191737000A3A3A399F9F9F9AD847EFF45672E52C905DB14593C1E5F94E2FA9C6C9173B039DA66663299D78A2B1EF9D0569F5A729E49B245CEC101C5559CC842714D0C7F60AB5658CF936C9173706871D9A9B0282E720E0E2C2E9D43178A6BFAAB8F292E724ECEC15A71158A6A7B505CE49C9C83E5F6D7AE71C48BAB969C23148442711D0627256624FE48CE110A42A1B80E2A9345892E8944A5A442CE7FE1CC99336F4BB83D1E8F5FE2B4CBE53A5E8E839C6A6969B97FE1C2857853535352E287B367CFFEDDED769F402808A50C323999FFF3E94A49A5DA73EEF57ADF91711E9130DB43C6F92315CD810F22767A4B2472AFB9B9796D7878D82C2C2C98E7CF9F9BF1F171F3F8F163D3D0D090F5FBFD7F3B75EA542D424128872C939A4A4AA59A73AE9D880823A3F290F1FCEAE6CD9BAF7A7B7B4D3018CC8A6836F25249CAF34E1EE840D2957C130A8536F40EC29D58595931B76EDD4A0702813B0805A194412615934AB5E65C64F1AE444E1A32D6CDEAEAEAAFC6F8D2D2928EF1D582542C772A1D1D1D17DADBDB5FADAFAF9BBD50A9885032DA3221148452069954442A552C94EF54167D7D7D7B8EF31B376EBC284C7F2C1DE8CA952B734F9F3E35A5F0E4C913D3D6D6761FA1209432C9A4EC52A9C69CEB1AA84A42662266B7594871A7224DC3BA3EDFD2426D5D5DDD7F1617174B128A7E4B53BA9949A756B55AB7B8C3422815B9CEFB95C9A14BA5F87CAA25E7C5EFD9E3F15C56417477779734CE2F5DBAB4ACCFD735172BAD902915B557535353DAA942295ECDD68B8D50CA7B9DE513EEC9B163C756E4AFFC167F946E29EB7D2AB58795F76AC9F9B69D9B5E7D3C303050D2380F8542C9FCEB9B2C1D787373B3A403E92F7F696E6E4EEDB4E5E4C470527139FD5A5BE8347ED5D990F383474F4F4F49E3FCFAF5EB99FC6BDCFB16CAE5CB97975414A5A05BCAC160F05B074F799E49BCCF94A7B2D7D9C2F4C5EA34E98DE75345539EADF7ACF797A9202E5EBCF8C6E641777FEAEBEB37F242D9FF4ECFEDDBB7FF71F7EEDD9284A2FBD6EDEDED7F615116A158A054A91CAA4CC8794D8DDE3FD6D0D0905049F4F7F7BF69BA53E86822960EA62BB9E7CE9D5BD39BD9F622168BE9FAC9722010F80D42412865924A596552CD39F77ABD7F5251F87CBE9C54B6772ABAFBA35BCA79991CECF610ED3A5A5B5BB3BA8BB3131313139B8D8D8D696D9D6A8E1008C5565229BB4CAA3DE722894B85F5149DFEE89A8A2ED4EAEE8F6E29E7FF6DC3D2EECE76FC7EFF15993B651E3E7CB83437379713C9F2F2F2CB070F1ECCD4D5D5FD7CD46482506C25958AC8849CFFD2A9C8F4677E97EFF23CD33B6A0F73314D6F80F9A7182A5D388044B74C8BFE5073044128B6908ABF523221E7FF5B53C92FD40625BAF43E95A3FA056084525DBF1B43A592AC944CC839505C47BFB87E9BBF4F859C23148442711D1C848250100AC58550C839505C08859C43D98A6B6D6DCDD685954AA5BE96F34C2114720E36271A8DBED43B84ED5C5C6363639F4A710D2114720E36271C0E774881FD9848247EB2DBA7969CCF8BA9A9A92F07070713525BEF2114720E0E4092D726C99BD156D886312E71FAA8E7A0924221E70008050000A100004201008402000805A1000042010084020008050000A1000042010084020008050000A1000042010084020080500000A1000042010084020080500000A1000042010040280080500000A1000042010040280080500000A158C218533B3B3BFB592C164B4522115BFD47E9E170783D1A8DC6E4F109AA02C00142999C9CFC4406AD11A998743A6DB2D9AC6D42CF677A7ADA8C8C8CA4900A800384323A3A9A999F9FDF1AC4DF7FD1998B5472C1366289C7E38B2294CFA90C009B0B45A716994CE635A1C4231FDAAA5391F34C5219000E104AF1E02D086562F8035B4D7FF43CA90C00870AC54E324128000E148AAE9B148432FDD5C7080500A158134A4124DB03A1002014CB531EBB0642014028080500A1549F50E49ABF2DE1F6783C7E89D32E97EB3895080805A1EC0BAFD7FB4E6363E3BFF59A6F0FB7DBFD48454345024241286FC4EFF7FF5984B2A1D73B100898AEAE2ED3DBDB6BAE5DBB66EAEBEB0B52494AC77292AA04848250F6BAC6EF8A4C5EE9B50E8542667575D514B3B4B464EEDCB9B325153A154028086557649A33A3D7B9AFAFCFEC4591541E5199805076400787AE1D5493508ADFB33C3EA1D7B8A5A525F73DA6BDD04EC5E7F36DEAF359A80584B2CBCF2F7CEA568B508ADFB3C7E3F9AB3EEEEEEE36A5D0D9D9B9AACFD7DD1FAA131C29944A85938472D8EF7D6060A024A1F4F4F4ACE45FD3447502BCDEFE3F9378BFCAA63C5BEF59EF37514188284A12CAD5AB575FE685E2A67A00F6A01A1765F337B199F3E7CFE7D648F6626E6ECE78BDDE757DBECFE7FB3D150380507692CABF5412C16030278D9D98989830ADADADD9FCFA493FD502805076C4E572BD251DC74C613D45B787EFDDBB975B57E9EFEFCFDDE456B490FB4C84F23BAA0500A1EC8A4A42A472BF7083DB0E9191F848E543A500209492C5A25BC2228F2E0DE948AEEB022E22014028008050100A004241280080500000A1000042412800552294B5B5355BCB24954A7D2DE799225B0036271A8DBE5C5858B0B550C6C6C63E15A10C912D009B130E873B442A3F2612899FECD6A9C8F9BC989A9AFA72707030213E798F6C01380019B06D32606774FA63C31897E0171B01000000000000000000000000000000000000EC97FF0232EA49AB9836FC170000000049454E44AE426082,
        0, '');

-- ----------------------------
-- Table structure for act_de_model_history
-- ----------------------------
DROP TABLE IF EXISTS `act_de_model_history`;
CREATE TABLE `act_de_model_history`
(
    `id`                varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
    `name`              varchar(400) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
    `model_key`         varchar(400) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
    `description`       varchar(4000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `model_comment`     varchar(4000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `created`           datetime(6) NULL DEFAULT NULL,
    `created_by`        varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `last_updated`      datetime(6) NULL DEFAULT NULL,
    `last_updated_by`   varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `removal_date`      datetime(6) NULL DEFAULT NULL,
    `version`           int(11) NULL DEFAULT NULL,
    `model_editor_json` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
    `model_id`          varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
    `model_type`        int(11) NULL DEFAULT NULL,
    `tenant_id`         varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    PRIMARY KEY (`id`) USING BTREE,
    INDEX               `idx_proc_mod_history_proc`(`model_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for act_de_model_relation
-- ----------------------------
DROP TABLE IF EXISTS `act_de_model_relation`;
CREATE TABLE `act_de_model_relation`
(
    `id`              varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
    `parent_model_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `model_id`        varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `relation_type`   varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    PRIMARY KEY (`id`) USING BTREE,
    INDEX             `fk_relation_parent`(`parent_model_id`) USING BTREE,
    INDEX             `fk_relation_child`(`model_id`) USING BTREE,
    CONSTRAINT `fk_relation_child` FOREIGN KEY (`model_id`) REFERENCES `act_de_model` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
    CONSTRAINT `fk_relation_parent` FOREIGN KEY (`parent_model_id`) REFERENCES `act_de_model` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for act_dmn_databasechangelog
-- ----------------------------
DROP TABLE IF EXISTS `act_dmn_databasechangelog`;
CREATE TABLE `act_dmn_databasechangelog`
(
    `ID`            varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
    `AUTHOR`        varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
    `FILENAME`      varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
    `DATEEXECUTED`  datetime(0) NULL,
    `ORDEREXECUTED` int(11) NOT NULL,
    `EXECTYPE`      varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci  NOT NULL,
    `MD5SUM`        varchar(35) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `DESCRIPTION`   varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `COMMENTS`      varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `TAG`           varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `LIQUIBASE`     varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `CONTEXTS`      varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `LABELS`        varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `DEPLOYMENT_ID` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of act_dmn_databasechangelog
-- ----------------------------
INSERT INTO `act_dmn_databasechangelog`
VALUES ('1', 'activiti', 'org/flowable/dmn/db/liquibase/flowable-dmn-db-changelog.xml', '2023-03-09 02:24:52', 1,
        'EXECUTED', '8:c8701f1c71018b55029f450b2e9a10a1',
        'createTable tableName=ACT_DMN_DEPLOYMENT; createTable tableName=ACT_DMN_DEPLOYMENT_RESOURCE; createTable tableName=ACT_DMN_DECISION_TABLE',
        '', NULL, '4.9.1', NULL, NULL, '8933841074');
INSERT INTO `act_dmn_databasechangelog`
VALUES ('2', 'flowable', 'org/flowable/dmn/db/liquibase/flowable-dmn-db-changelog.xml', '2023-03-09 02:24:52', 2,
        'EXECUTED', '8:47f94b27feb7df8a30d4e338c7bd5fb8', 'createTable tableName=ACT_DMN_HI_DECISION_EXECUTION', '',
        NULL, '4.9.1', NULL, NULL, '8933841074');
INSERT INTO `act_dmn_databasechangelog`
VALUES ('3', 'flowable', 'org/flowable/dmn/db/liquibase/flowable-dmn-db-changelog.xml', '2023-03-09 02:24:52', 3,
        'EXECUTED', '8:ac17eae89fbdccb6e08daf3c7797b579', 'addColumn tableName=ACT_DMN_HI_DECISION_EXECUTION', '', NULL,
        '4.9.1', NULL, NULL, '8933841074');
INSERT INTO `act_dmn_databasechangelog`
VALUES ('4', 'flowable', 'org/flowable/dmn/db/liquibase/flowable-dmn-db-changelog.xml', '2023-03-09 02:24:52', 4,
        'EXECUTED', '8:f73aabc4529e7292c2942073d1cff6f9',
        'dropColumn columnName=PARENT_DEPLOYMENT_ID_, tableName=ACT_DMN_DECISION_TABLE', '', NULL, '4.9.1', NULL, NULL,
        '8933841074');
INSERT INTO `act_dmn_databasechangelog`
VALUES ('5', 'flowable', 'org/flowable/dmn/db/liquibase/flowable-dmn-db-changelog.xml', '2023-03-09 02:24:53', 5,
        'EXECUTED', '8:3e03528582dd4eeb4eb41f9b9539140d',
        'modifyDataType columnName=DEPLOY_TIME_, tableName=ACT_DMN_DEPLOYMENT; modifyDataType columnName=START_TIME_, tableName=ACT_DMN_HI_DECISION_EXECUTION; modifyDataType columnName=END_TIME_, tableName=ACT_DMN_HI_DECISION_EXECUTION',
        '', NULL, '4.9.1', NULL, NULL, '8933841074');
INSERT INTO `act_dmn_databasechangelog`
VALUES ('6', 'flowable', 'org/flowable/dmn/db/liquibase/flowable-dmn-db-changelog.xml', '2023-03-09 02:24:53', 6,
        'EXECUTED', '8:646c6a061e0b6e8a62e69844ff96abb0',
        'createIndex indexName=ACT_IDX_DEC_TBL_UNIQ, tableName=ACT_DMN_DECISION_TABLE', '', NULL, '4.9.1', NULL, NULL,
        '8933841074');
INSERT INTO `act_dmn_databasechangelog`
VALUES ('7', 'flowable', 'org/flowable/dmn/db/liquibase/flowable-dmn-db-changelog.xml', '2023-03-09 02:24:53', 7,
        'EXECUTED', '8:215a499ff7ae77685b55355245b8b708',
        'dropIndex indexName=ACT_IDX_DEC_TBL_UNIQ, tableName=ACT_DMN_DECISION_TABLE; renameTable newTableName=ACT_DMN_DECISION, oldTableName=ACT_DMN_DECISION_TABLE; createIndex indexName=ACT_IDX_DMN_DEC_UNIQ, tableName=ACT_DMN_DECISION',
        '', NULL, '4.9.1', NULL, NULL, '8933841074');
INSERT INTO `act_dmn_databasechangelog`
VALUES ('8', 'flowable', 'org/flowable/dmn/db/liquibase/flowable-dmn-db-changelog.xml', '2023-03-09 02:24:53', 8,
        'EXECUTED', '8:5355bee389318afed91a11702f2df032', 'addColumn tableName=ACT_DMN_DECISION', '', NULL, '4.9.1',
        NULL, NULL, '8933841074');

-- ----------------------------
-- Table structure for act_dmn_databasechangeloglock
-- ----------------------------
DROP TABLE IF EXISTS `act_dmn_databasechangeloglock`;
CREATE TABLE `act_dmn_databasechangeloglock`
(
    `ID`          int(11) NOT NULL,
    `LOCKED`      bit(1) NOT NULL,
    `LOCKGRANTED` datetime(0) NULL DEFAULT NULL,
    `LOCKEDBY`    varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    PRIMARY KEY (`ID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of act_dmn_databasechangeloglock
-- ----------------------------
INSERT INTO `act_dmn_databasechangeloglock`
VALUES (1, b'0', NULL, NULL);

-- ----------------------------
-- Table structure for act_dmn_decision
-- ----------------------------
DROP TABLE IF EXISTS `act_dmn_decision`;
CREATE TABLE `act_dmn_decision`
(
    `ID_`            varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
    `NAME_`          varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `VERSION_`       int(11) NULL DEFAULT NULL,
    `KEY_`           varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `CATEGORY_`      varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `DEPLOYMENT_ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `TENANT_ID_`     varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `RESOURCE_NAME_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `DESCRIPTION_`   varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `DECISION_TYPE_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    PRIMARY KEY (`ID_`) USING BTREE,
    UNIQUE INDEX `ACT_IDX_DMN_DEC_UNIQ`(`KEY_`, `VERSION_`, `TENANT_ID_`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for act_dmn_deployment
-- ----------------------------
DROP TABLE IF EXISTS `act_dmn_deployment`;
CREATE TABLE `act_dmn_deployment`
(
    `ID_`                   varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
    `NAME_`                 varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `CATEGORY_`             varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `DEPLOY_TIME_`          datetime(3) NULL DEFAULT NULL,
    `TENANT_ID_`            varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `PARENT_DEPLOYMENT_ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    PRIMARY KEY (`ID_`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for act_dmn_deployment_resource
-- ----------------------------
DROP TABLE IF EXISTS `act_dmn_deployment_resource`;
CREATE TABLE `act_dmn_deployment_resource`
(
    `ID_`             varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
    `NAME_`           varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `DEPLOYMENT_ID_`  varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `RESOURCE_BYTES_` longblob NULL,
    PRIMARY KEY (`ID_`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for act_dmn_hi_decision_execution
-- ----------------------------
DROP TABLE IF EXISTS `act_dmn_hi_decision_execution`;
CREATE TABLE `act_dmn_hi_decision_execution`
(
    `ID_`                     varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
    `DECISION_DEFINITION_ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `DEPLOYMENT_ID_`          varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `START_TIME_`             datetime(3) NULL DEFAULT NULL,
    `END_TIME_`               datetime(3) NULL DEFAULT NULL,
    `INSTANCE_ID_`            varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `EXECUTION_ID_`           varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `ACTIVITY_ID_`            varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `FAILED_`                 bit(1) NULL DEFAULT b'0',
    `TENANT_ID_`              varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `EXECUTION_JSON_`         longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
    `SCOPE_TYPE_`             varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    PRIMARY KEY (`ID_`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for act_evt_log
-- ----------------------------
DROP TABLE IF EXISTS `act_evt_log`;
CREATE TABLE `act_evt_log`
(
    `LOG_NR_`       bigint(20) NOT NULL AUTO_INCREMENT,
    `TYPE_`         varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `PROC_DEF_ID_`  varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `PROC_INST_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `EXECUTION_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `TASK_ID_`      varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `TIME_STAMP_`   timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `USER_ID_`      varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `DATA_`         longblob NULL,
    `LOCK_OWNER_`   varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `LOCK_TIME_`    timestamp(3) NULL DEFAULT NULL,
    `IS_PROCESSED_` tinyint(4) NULL DEFAULT 0,
    PRIMARY KEY (`LOG_NR_`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for act_fo_databasechangelog
-- ----------------------------
DROP TABLE IF EXISTS `act_fo_databasechangelog`;
CREATE TABLE `act_fo_databasechangelog`
(
    `ID`            varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
    `AUTHOR`        varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
    `FILENAME`      varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
    `DATEEXECUTED`  datetime(0) NULL,
    `ORDEREXECUTED` int(11) NOT NULL,
    `EXECTYPE`      varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci  NOT NULL,
    `MD5SUM`        varchar(35) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `DESCRIPTION`   varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `COMMENTS`      varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `TAG`           varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `LIQUIBASE`     varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `CONTEXTS`      varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `LABELS`        varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `DEPLOYMENT_ID` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of act_fo_databasechangelog
-- ----------------------------
INSERT INTO `act_fo_databasechangelog`
VALUES ('1', 'activiti', 'org/flowable/form/db/liquibase/flowable-form-db-changelog.xml', '2023-03-09 02:24:53', 1,
        'EXECUTED', '8:033ebf9380889aed7c453927ecc3250d',
        'createTable tableName=ACT_FO_FORM_DEPLOYMENT; createTable tableName=ACT_FO_FORM_RESOURCE; createTable tableName=ACT_FO_FORM_DEFINITION; createTable tableName=ACT_FO_FORM_INSTANCE',
        '', NULL, '4.9.1', NULL, NULL, '8933841589');
INSERT INTO `act_fo_databasechangelog`
VALUES ('2', 'flowable', 'org/flowable/form/db/liquibase/flowable-form-db-changelog.xml', '2023-03-09 02:24:53', 2,
        'EXECUTED', '8:986365ceb40445ce3b27a8e6b40f159b', 'addColumn tableName=ACT_FO_FORM_INSTANCE', '', NULL, '4.9.1',
        NULL, NULL, '8933841589');
INSERT INTO `act_fo_databasechangelog`
VALUES ('3', 'flowable', 'org/flowable/form/db/liquibase/flowable-form-db-changelog.xml', '2023-03-09 02:24:53', 3,
        'EXECUTED', '8:abf482518ceb09830ef674e52c06bf15',
        'dropColumn columnName=PARENT_DEPLOYMENT_ID_, tableName=ACT_FO_FORM_DEFINITION', '', NULL, '4.9.1', NULL, NULL,
        '8933841589');
INSERT INTO `act_fo_databasechangelog`
VALUES ('4', 'flowable', 'org/flowable/form/db/liquibase/flowable-form-db-changelog.xml', '2023-03-09 02:24:53', 4,
        'EXECUTED', '8:2087829f22a4b2298dbf530681c74854',
        'modifyDataType columnName=DEPLOY_TIME_, tableName=ACT_FO_FORM_DEPLOYMENT; modifyDataType columnName=SUBMITTED_DATE_, tableName=ACT_FO_FORM_INSTANCE',
        '', NULL, '4.9.1', NULL, NULL, '8933841589');
INSERT INTO `act_fo_databasechangelog`
VALUES ('5', 'flowable', 'org/flowable/form/db/liquibase/flowable-form-db-changelog.xml', '2023-03-09 02:24:53', 5,
        'EXECUTED', '8:b4be732b89e5ca028bdd520c6ad4d446',
        'createIndex indexName=ACT_IDX_FORM_DEF_UNIQ, tableName=ACT_FO_FORM_DEFINITION', '', NULL, '4.9.1', NULL, NULL,
        '8933841589');
INSERT INTO `act_fo_databasechangelog`
VALUES ('6', 'flowable', 'org/flowable/form/db/liquibase/flowable-form-db-changelog.xml', '2023-03-09 02:24:53', 6,
        'EXECUTED', '8:384bbd364a649b67c3ca1bcb72fe537f',
        'createIndex indexName=ACT_IDX_FORM_TASK, tableName=ACT_FO_FORM_INSTANCE; createIndex indexName=ACT_IDX_FORM_PROC, tableName=ACT_FO_FORM_INSTANCE; createIndex indexName=ACT_IDX_FORM_SCOPE, tableName=ACT_FO_FORM_INSTANCE',
        '', NULL, '4.9.1', NULL, NULL, '8933841589');

-- ----------------------------
-- Table structure for act_fo_databasechangeloglock
-- ----------------------------
DROP TABLE IF EXISTS `act_fo_databasechangeloglock`;
CREATE TABLE `act_fo_databasechangeloglock`
(
    `ID`          int(11) NOT NULL,
    `LOCKED`      bit(1) NOT NULL,
    `LOCKGRANTED` datetime(0) NULL DEFAULT NULL,
    `LOCKEDBY`    varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    PRIMARY KEY (`ID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of act_fo_databasechangeloglock
-- ----------------------------
INSERT INTO `act_fo_databasechangeloglock`
VALUES (1, b'0', NULL, NULL);

-- ----------------------------
-- Table structure for act_fo_form_definition
-- ----------------------------
DROP TABLE IF EXISTS `act_fo_form_definition`;
CREATE TABLE `act_fo_form_definition`
(
    `ID_`            varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
    `NAME_`          varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `VERSION_`       int(11) NULL DEFAULT NULL,
    `KEY_`           varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `CATEGORY_`      varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `DEPLOYMENT_ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `TENANT_ID_`     varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `RESOURCE_NAME_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `DESCRIPTION_`   varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    PRIMARY KEY (`ID_`) USING BTREE,
    UNIQUE INDEX `ACT_IDX_FORM_DEF_UNIQ`(`KEY_`, `VERSION_`, `TENANT_ID_`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for act_fo_form_deployment
-- ----------------------------
DROP TABLE IF EXISTS `act_fo_form_deployment`;
CREATE TABLE `act_fo_form_deployment`
(
    `ID_`                   varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
    `NAME_`                 varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `CATEGORY_`             varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `DEPLOY_TIME_`          datetime(3) NULL DEFAULT NULL,
    `TENANT_ID_`            varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `PARENT_DEPLOYMENT_ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    PRIMARY KEY (`ID_`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for act_fo_form_instance
-- ----------------------------
DROP TABLE IF EXISTS `act_fo_form_instance`;
CREATE TABLE `act_fo_form_instance`
(
    `ID_`                  varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
    `FORM_DEFINITION_ID_`  varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
    `TASK_ID_`             varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `PROC_INST_ID_`        varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `PROC_DEF_ID_`         varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `SUBMITTED_DATE_`      datetime(3) NULL DEFAULT NULL,
    `SUBMITTED_BY_`        varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `FORM_VALUES_ID_`      varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `TENANT_ID_`           varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `SCOPE_ID_`            varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `SCOPE_TYPE_`          varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `SCOPE_DEFINITION_ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    PRIMARY KEY (`ID_`) USING BTREE,
    INDEX                  `ACT_IDX_FORM_TASK`(`TASK_ID_`) USING BTREE,
    INDEX                  `ACT_IDX_FORM_PROC`(`PROC_INST_ID_`) USING BTREE,
    INDEX                  `ACT_IDX_FORM_SCOPE`(`SCOPE_ID_`, `SCOPE_TYPE_`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for act_fo_form_resource
-- ----------------------------
DROP TABLE IF EXISTS `act_fo_form_resource`;
CREATE TABLE `act_fo_form_resource`
(
    `ID_`             varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
    `NAME_`           varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `DEPLOYMENT_ID_`  varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `RESOURCE_BYTES_` longblob NULL,
    PRIMARY KEY (`ID_`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for act_ge_bytearray
-- ----------------------------
DROP TABLE IF EXISTS `act_ge_bytearray`;
CREATE TABLE `act_ge_bytearray`
(
    `ID_`            varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
    `REV_`           int(11) NULL DEFAULT NULL,
    `NAME_`          varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `DEPLOYMENT_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `BYTES_`         longblob NULL,
    `GENERATED_`     tinyint(4) NULL DEFAULT NULL,
    PRIMARY KEY (`ID_`) USING BTREE,
    INDEX            `ACT_FK_BYTEARR_DEPL`(`DEPLOYMENT_ID_`) USING BTREE,
    CONSTRAINT `ACT_FK_BYTEARR_DEPL` FOREIGN KEY (`DEPLOYMENT_ID_`) REFERENCES `act_re_deployment` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for act_ge_property
-- ----------------------------
DROP TABLE IF EXISTS `act_ge_property`;
CREATE TABLE `act_ge_property`
(
    `NAME_`  varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
    `VALUE_` varchar(300) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `REV_`   int(11) NULL DEFAULT NULL,
    PRIMARY KEY (`NAME_`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of act_ge_property
-- ----------------------------
INSERT INTO `act_ge_property`
VALUES ('batch.schema.version', '6.7.2.0', 1);
INSERT INTO `act_ge_property`
VALUES ('cfg.execution-related-entities-count', 'true', 1);
INSERT INTO `act_ge_property`
VALUES ('cfg.task-related-entities-count', 'true', 1);
INSERT INTO `act_ge_property`
VALUES ('common.schema.version', '6.7.2.0', 1);
INSERT INTO `act_ge_property`
VALUES ('entitylink.schema.version', '6.7.2.0', 1);
INSERT INTO `act_ge_property`
VALUES ('eventsubscription.schema.version', '6.7.2.0', 1);
INSERT INTO `act_ge_property`
VALUES ('identitylink.schema.version', '6.7.2.0', 1);
INSERT INTO `act_ge_property`
VALUES ('job.schema.version', '6.7.2.0', 1);
INSERT INTO `act_ge_property`
VALUES ('next.dbid', '1', 1);
INSERT INTO `act_ge_property`
VALUES ('schema.history', 'create(6.7.2.0)', 1);
INSERT INTO `act_ge_property`
VALUES ('schema.version', '6.7.2.0', 1);
INSERT INTO `act_ge_property`
VALUES ('task.schema.version', '6.7.2.0', 1);
INSERT INTO `act_ge_property`
VALUES ('variable.schema.version', '6.7.2.0', 1);

-- ----------------------------
-- Table structure for act_hi_actinst
-- ----------------------------
DROP TABLE IF EXISTS `act_hi_actinst`;
CREATE TABLE `act_hi_actinst`
(
    `ID_`                varchar(64) CHARACTER SET utf8 COLLATE utf8_bin  NOT NULL,
    `REV_`               int(11) NULL DEFAULT 1,
    `PROC_DEF_ID_`       varchar(64) CHARACTER SET utf8 COLLATE utf8_bin  NOT NULL,
    `PROC_INST_ID_`      varchar(64) CHARACTER SET utf8 COLLATE utf8_bin  NOT NULL,
    `EXECUTION_ID_`      varchar(64) CHARACTER SET utf8 COLLATE utf8_bin  NOT NULL,
    `ACT_ID_`            varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
    `TASK_ID_`           varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `CALL_PROC_INST_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `ACT_NAME_`          varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `ACT_TYPE_`          varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
    `ASSIGNEE_`          varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `START_TIME_`        datetime(3) NULL,
    `END_TIME_`          datetime(3) NULL DEFAULT NULL,
    `TRANSACTION_ORDER_` int(11) NULL DEFAULT NULL,
    `DURATION_`          bigint(20) NULL DEFAULT NULL,
    `DELETE_REASON_`     varchar(4000) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `TENANT_ID_`         varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '',
    PRIMARY KEY (`ID_`) USING BTREE,
    INDEX                `ACT_IDX_HI_ACT_INST_START`(`START_TIME_`) USING BTREE,
    INDEX                `ACT_IDX_HI_ACT_INST_END`(`END_TIME_`) USING BTREE,
    INDEX                `ACT_IDX_HI_ACT_INST_PROCINST`(`PROC_INST_ID_`, `ACT_ID_`) USING BTREE,
    INDEX                `ACT_IDX_HI_ACT_INST_EXEC`(`EXECUTION_ID_`, `ACT_ID_`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for act_hi_attachment
-- ----------------------------
DROP TABLE IF EXISTS `act_hi_attachment`;
CREATE TABLE `act_hi_attachment`
(
    `ID_`           varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
    `REV_`          int(11) NULL DEFAULT NULL,
    `USER_ID_`      varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `NAME_`         varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `DESCRIPTION_`  varchar(4000) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `TYPE_`         varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `TASK_ID_`      varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `PROC_INST_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `URL_`          varchar(4000) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `CONTENT_ID_`   varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `TIME_`         datetime(3) NULL DEFAULT NULL,
    PRIMARY KEY (`ID_`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for act_hi_comment
-- ----------------------------
DROP TABLE IF EXISTS `act_hi_comment`;
CREATE TABLE `act_hi_comment`
(
    `ID_`           varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
    `TYPE_`         varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `TIME_`         datetime(3) NULL,
    `USER_ID_`      varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `TASK_ID_`      varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `PROC_INST_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `ACTION_`       varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `MESSAGE_`      varchar(4000) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `FULL_MSG_`     longblob NULL,
    PRIMARY KEY (`ID_`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for act_hi_detail
-- ----------------------------
DROP TABLE IF EXISTS `act_hi_detail`;
CREATE TABLE `act_hi_detail`
(
    `ID_`           varchar(64) CHARACTER SET utf8 COLLATE utf8_bin  NOT NULL,
    `TYPE_`         varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
    `PROC_INST_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `EXECUTION_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `TASK_ID_`      varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `ACT_INST_ID_`  varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `NAME_`         varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
    `VAR_TYPE_`     varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `REV_`          int(11) NULL DEFAULT NULL,
    `TIME_`         datetime(3) NULL,
    `BYTEARRAY_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `DOUBLE_`       double NULL DEFAULT NULL,
    `LONG_`         bigint(20) NULL DEFAULT NULL,
    `TEXT_`         varchar(4000) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `TEXT2_`        varchar(4000) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    PRIMARY KEY (`ID_`) USING BTREE,
    INDEX           `ACT_IDX_HI_DETAIL_PROC_INST`(`PROC_INST_ID_`) USING BTREE,
    INDEX           `ACT_IDX_HI_DETAIL_ACT_INST`(`ACT_INST_ID_`) USING BTREE,
    INDEX           `ACT_IDX_HI_DETAIL_TIME`(`TIME_`) USING BTREE,
    INDEX           `ACT_IDX_HI_DETAIL_NAME`(`NAME_`) USING BTREE,
    INDEX           `ACT_IDX_HI_DETAIL_TASK_ID`(`TASK_ID_`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for act_hi_entitylink
-- ----------------------------
DROP TABLE IF EXISTS `act_hi_entitylink`;
CREATE TABLE `act_hi_entitylink`
(
    `ID_`                      varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
    `LINK_TYPE_`               varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `CREATE_TIME_`             datetime(3) NULL DEFAULT NULL,
    `SCOPE_ID_`                varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `SUB_SCOPE_ID_`            varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `SCOPE_TYPE_`              varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `SCOPE_DEFINITION_ID_`     varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `PARENT_ELEMENT_ID_`       varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `REF_SCOPE_ID_`            varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `REF_SCOPE_TYPE_`          varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `REF_SCOPE_DEFINITION_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `ROOT_SCOPE_ID_`           varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `ROOT_SCOPE_TYPE_`         varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `HIERARCHY_TYPE_`          varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    PRIMARY KEY (`ID_`) USING BTREE,
    INDEX                      `ACT_IDX_HI_ENT_LNK_SCOPE`(`SCOPE_ID_`, `SCOPE_TYPE_`, `LINK_TYPE_`) USING BTREE,
    INDEX                      `ACT_IDX_HI_ENT_LNK_REF_SCOPE`(`REF_SCOPE_ID_`, `REF_SCOPE_TYPE_`, `LINK_TYPE_`) USING BTREE,
    INDEX                      `ACT_IDX_HI_ENT_LNK_ROOT_SCOPE`(`ROOT_SCOPE_ID_`, `ROOT_SCOPE_TYPE_`, `LINK_TYPE_`) USING BTREE,
    INDEX                      `ACT_IDX_HI_ENT_LNK_SCOPE_DEF`(`SCOPE_DEFINITION_ID_`, `SCOPE_TYPE_`, `LINK_TYPE_`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for act_hi_identitylink
-- ----------------------------
DROP TABLE IF EXISTS `act_hi_identitylink`;
CREATE TABLE `act_hi_identitylink`
(
    `ID_`                  varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
    `GROUP_ID_`            varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `TYPE_`                varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `USER_ID_`             varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `TASK_ID_`             varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `CREATE_TIME_`         datetime(3) NULL DEFAULT NULL,
    `PROC_INST_ID_`        varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `SCOPE_ID_`            varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `SUB_SCOPE_ID_`        varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `SCOPE_TYPE_`          varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `SCOPE_DEFINITION_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    PRIMARY KEY (`ID_`) USING BTREE,
    INDEX                  `ACT_IDX_HI_IDENT_LNK_USER`(`USER_ID_`) USING BTREE,
    INDEX                  `ACT_IDX_HI_IDENT_LNK_SCOPE`(`SCOPE_ID_`, `SCOPE_TYPE_`) USING BTREE,
    INDEX                  `ACT_IDX_HI_IDENT_LNK_SUB_SCOPE`(`SUB_SCOPE_ID_`, `SCOPE_TYPE_`) USING BTREE,
    INDEX                  `ACT_IDX_HI_IDENT_LNK_SCOPE_DEF`(`SCOPE_DEFINITION_ID_`, `SCOPE_TYPE_`) USING BTREE,
    INDEX                  `ACT_IDX_HI_IDENT_LNK_TASK`(`TASK_ID_`) USING BTREE,
    INDEX                  `ACT_IDX_HI_IDENT_LNK_PROCINST`(`PROC_INST_ID_`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for act_hi_procinst
-- ----------------------------
DROP TABLE IF EXISTS `act_hi_procinst`;
CREATE TABLE `act_hi_procinst`
(
    `ID_`                        varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
    `REV_`                       int(11) NULL DEFAULT 1,
    `PROC_INST_ID_`              varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
    `BUSINESS_KEY_`              varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `PROC_DEF_ID_`               varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
    `START_TIME_`                datetime(3) NULL,
    `END_TIME_`                  datetime(3) NULL DEFAULT NULL,
    `DURATION_`                  bigint(20) NULL DEFAULT NULL,
    `START_USER_ID_`             varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `START_ACT_ID_`              varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `END_ACT_ID_`                varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `SUPER_PROCESS_INSTANCE_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `DELETE_REASON_`             varchar(4000) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `TENANT_ID_`                 varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '',
    `NAME_`                      varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `CALLBACK_ID_`               varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `CALLBACK_TYPE_`             varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `REFERENCE_ID_`              varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `REFERENCE_TYPE_`            varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `PROPAGATED_STAGE_INST_ID_`  varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `BUSINESS_STATUS_`           varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    PRIMARY KEY (`ID_`) USING BTREE,
    UNIQUE INDEX `PROC_INST_ID_`(`PROC_INST_ID_`) USING BTREE,
    INDEX                        `ACT_IDX_HI_PRO_INST_END`(`END_TIME_`) USING BTREE,
    INDEX                        `ACT_IDX_HI_PRO_I_BUSKEY`(`BUSINESS_KEY_`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for act_hi_taskinst
-- ----------------------------
DROP TABLE IF EXISTS `act_hi_taskinst`;
CREATE TABLE `act_hi_taskinst`
(
    `ID_`                       varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
    `REV_`                      int(11) NULL DEFAULT 1,
    `PROC_DEF_ID_`              varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `TASK_DEF_ID_`              varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `TASK_DEF_KEY_`             varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `PROC_INST_ID_`             varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `EXECUTION_ID_`             varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `SCOPE_ID_`                 varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `SUB_SCOPE_ID_`             varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `SCOPE_TYPE_`               varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `SCOPE_DEFINITION_ID_`      varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `PROPAGATED_STAGE_INST_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `NAME_`                     varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `PARENT_TASK_ID_`           varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `DESCRIPTION_`              varchar(4000) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `OWNER_`                    varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `ASSIGNEE_`                 varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `START_TIME_`               datetime(3) NULL,
    `CLAIM_TIME_`               datetime(3) NULL DEFAULT NULL,
    `END_TIME_`                 datetime(3) NULL DEFAULT NULL,
    `DURATION_`                 bigint(20) NULL DEFAULT NULL,
    `DELETE_REASON_`            varchar(4000) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `PRIORITY_`                 int(11) NULL DEFAULT NULL,
    `DUE_DATE_`                 datetime(3) NULL DEFAULT NULL,
    `FORM_KEY_`                 varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `CATEGORY_`                 varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `TENANT_ID_`                varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '',
    `LAST_UPDATED_TIME_`        datetime(3) NULL DEFAULT NULL,
    PRIMARY KEY (`ID_`) USING BTREE,
    INDEX                       `ACT_IDX_HI_TASK_SCOPE`(`SCOPE_ID_`, `SCOPE_TYPE_`) USING BTREE,
    INDEX                       `ACT_IDX_HI_TASK_SUB_SCOPE`(`SUB_SCOPE_ID_`, `SCOPE_TYPE_`) USING BTREE,
    INDEX                       `ACT_IDX_HI_TASK_SCOPE_DEF`(`SCOPE_DEFINITION_ID_`, `SCOPE_TYPE_`) USING BTREE,
    INDEX                       `ACT_IDX_HI_TASK_INST_PROCINST`(`PROC_INST_ID_`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for act_hi_tsk_log
-- ----------------------------
DROP TABLE IF EXISTS `act_hi_tsk_log`;
CREATE TABLE `act_hi_tsk_log`
(
    `ID_`                  bigint(20) NOT NULL AUTO_INCREMENT,
    `TYPE_`                varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `TASK_ID_`             varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
    `TIME_STAMP_`          timestamp(3)                                    NOT NULL DEFAULT CURRENT_TIMESTAMP(3) ON UPDATE CURRENT_TIMESTAMP (3),
    `USER_ID_`             varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `DATA_`                varchar(4000) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `EXECUTION_ID_`        varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `PROC_INST_ID_`        varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `PROC_DEF_ID_`         varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `SCOPE_ID_`            varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `SCOPE_DEFINITION_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `SUB_SCOPE_ID_`        varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `SCOPE_TYPE_`          varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `TENANT_ID_`           varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '',
    PRIMARY KEY (`ID_`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for act_hi_varinst
-- ----------------------------
DROP TABLE IF EXISTS `act_hi_varinst`;
CREATE TABLE `act_hi_varinst`
(
    `ID_`                varchar(64) CHARACTER SET utf8 COLLATE utf8_bin  NOT NULL,
    `REV_`               int(11) NULL DEFAULT 1,
    `PROC_INST_ID_`      varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `EXECUTION_ID_`      varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `TASK_ID_`           varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `NAME_`              varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
    `VAR_TYPE_`          varchar(100) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `SCOPE_ID_`          varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `SUB_SCOPE_ID_`      varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `SCOPE_TYPE_`        varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `BYTEARRAY_ID_`      varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `DOUBLE_`            double NULL DEFAULT NULL,
    `LONG_`              bigint(20) NULL DEFAULT NULL,
    `TEXT_`              varchar(4000) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `TEXT2_`             varchar(4000) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `CREATE_TIME_`       datetime(3) NULL DEFAULT NULL,
    `LAST_UPDATED_TIME_` datetime(3) NULL DEFAULT NULL,
    PRIMARY KEY (`ID_`) USING BTREE,
    INDEX                `ACT_IDX_HI_PROCVAR_NAME_TYPE`(`NAME_`, `VAR_TYPE_`) USING BTREE,
    INDEX                `ACT_IDX_HI_VAR_SCOPE_ID_TYPE`(`SCOPE_ID_`, `SCOPE_TYPE_`) USING BTREE,
    INDEX                `ACT_IDX_HI_VAR_SUB_ID_TYPE`(`SUB_SCOPE_ID_`, `SCOPE_TYPE_`) USING BTREE,
    INDEX                `ACT_IDX_HI_PROCVAR_PROC_INST`(`PROC_INST_ID_`) USING BTREE,
    INDEX                `ACT_IDX_HI_PROCVAR_TASK_ID`(`TASK_ID_`) USING BTREE,
    INDEX                `ACT_IDX_HI_PROCVAR_EXE`(`EXECUTION_ID_`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for act_id_bytearray
-- ----------------------------
DROP TABLE IF EXISTS `act_id_bytearray`;
CREATE TABLE `act_id_bytearray`
(
    `ID_`    varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
    `REV_`   int(11) NULL DEFAULT NULL,
    `NAME_`  varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `BYTES_` longblob NULL,
    PRIMARY KEY (`ID_`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for act_id_group
-- ----------------------------
DROP TABLE IF EXISTS `act_id_group`;
CREATE TABLE `act_id_group`
(
    `ID_`   varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
    `REV_`  int(11) NULL DEFAULT NULL,
    `NAME_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `TYPE_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    PRIMARY KEY (`ID_`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for act_id_info
-- ----------------------------
DROP TABLE IF EXISTS `act_id_info`;
CREATE TABLE `act_id_info`
(
    `ID_`        varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
    `REV_`       int(11) NULL DEFAULT NULL,
    `USER_ID_`   varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `TYPE_`      varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `KEY_`       varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `VALUE_`     varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `PASSWORD_`  longblob NULL,
    `PARENT_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    PRIMARY KEY (`ID_`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for act_id_membership
-- ----------------------------
DROP TABLE IF EXISTS `act_id_membership`;
CREATE TABLE `act_id_membership`
(
    `USER_ID_`  varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
    `GROUP_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
    PRIMARY KEY (`USER_ID_`, `GROUP_ID_`) USING BTREE,
    INDEX       `ACT_FK_MEMB_GROUP`(`GROUP_ID_`) USING BTREE,
    CONSTRAINT `ACT_FK_MEMB_GROUP` FOREIGN KEY (`GROUP_ID_`) REFERENCES `act_id_group` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT,
    CONSTRAINT `ACT_FK_MEMB_USER` FOREIGN KEY (`USER_ID_`) REFERENCES `act_id_user` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for act_id_priv
-- ----------------------------
DROP TABLE IF EXISTS `act_id_priv`;
CREATE TABLE `act_id_priv`
(
    `ID_`   varchar(64) CHARACTER SET utf8 COLLATE utf8_bin  NOT NULL,
    `NAME_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
    PRIMARY KEY (`ID_`) USING BTREE,
    UNIQUE INDEX `ACT_UNIQ_PRIV_NAME`(`NAME_`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of act_id_priv
-- ----------------------------
INSERT INTO `act_id_priv`
VALUES ('8fc3428b-c3a2-11ed-890e-e4a8dfaec50c', 'access-admin');
INSERT INTO `act_id_priv`
VALUES ('8fc08369-c3a2-11ed-890e-e4a8dfaec50c', 'access-idm');
INSERT INTO `act_id_priv`
VALUES ('8fc676dd-c3a2-11ed-890e-e4a8dfaec50c', 'access-modeler');
INSERT INTO `act_id_priv`
VALUES ('8fcbce11-c3a2-11ed-890e-e4a8dfaec50c', 'access-rest-api');
INSERT INTO `act_id_priv`
VALUES ('8fc90eef-c3a2-11ed-890e-e4a8dfaec50c', 'access-task');

-- ----------------------------
-- Table structure for act_id_priv_mapping
-- ----------------------------
DROP TABLE IF EXISTS `act_id_priv_mapping`;
CREATE TABLE `act_id_priv_mapping`
(
    `ID_`       varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
    `PRIV_ID_`  varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
    `USER_ID_`  varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `GROUP_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    PRIMARY KEY (`ID_`) USING BTREE,
    INDEX       `ACT_FK_PRIV_MAPPING`(`PRIV_ID_`) USING BTREE,
    INDEX       `ACT_IDX_PRIV_USER`(`USER_ID_`) USING BTREE,
    INDEX       `ACT_IDX_PRIV_GROUP`(`GROUP_ID_`) USING BTREE,
    CONSTRAINT `ACT_FK_PRIV_MAPPING` FOREIGN KEY (`PRIV_ID_`) REFERENCES `act_id_priv` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of act_id_priv_mapping
-- ----------------------------
INSERT INTO `act_id_priv_mapping`
VALUES ('8fc20a0a-c3a2-11ed-890e-e4a8dfaec50c', '8fc08369-c3a2-11ed-890e-e4a8dfaec50c', 'admin', NULL);
INSERT INTO `act_id_priv_mapping`
VALUES ('8fc4f03c-c3a2-11ed-890e-e4a8dfaec50c', '8fc3428b-c3a2-11ed-890e-e4a8dfaec50c', 'admin', NULL);
INSERT INTO `act_id_priv_mapping`
VALUES ('8fc7d66e-c3a2-11ed-890e-e4a8dfaec50c', '8fc676dd-c3a2-11ed-890e-e4a8dfaec50c', 'admin', NULL);
INSERT INTO `act_id_priv_mapping`
VALUES ('8fca9590-c3a2-11ed-890e-e4a8dfaec50c', '8fc90eef-c3a2-11ed-890e-e4a8dfaec50c', 'admin', NULL);
INSERT INTO `act_id_priv_mapping`
VALUES ('8fcd2da2-c3a2-11ed-890e-e4a8dfaec50c', '8fcbce11-c3a2-11ed-890e-e4a8dfaec50c', 'admin', NULL);

-- ----------------------------
-- Table structure for act_id_property
-- ----------------------------
DROP TABLE IF EXISTS `act_id_property`;
CREATE TABLE `act_id_property`
(
    `NAME_`  varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
    `VALUE_` varchar(300) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `REV_`   int(11) NULL DEFAULT NULL,
    PRIMARY KEY (`NAME_`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of act_id_property
-- ----------------------------
INSERT INTO `act_id_property`
VALUES ('schema.version', '6.7.2.0', 1);

-- ----------------------------
-- Table structure for act_id_token
-- ----------------------------
DROP TABLE IF EXISTS `act_id_token`;
CREATE TABLE `act_id_token`
(
    `ID_`          varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
    `REV_`         int(11) NULL DEFAULT NULL,
    `TOKEN_VALUE_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `TOKEN_DATE_`  timestamp(3)                                    NOT NULL DEFAULT CURRENT_TIMESTAMP(3) ON UPDATE CURRENT_TIMESTAMP (3),
    `IP_ADDRESS_`  varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `USER_AGENT_`  varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `USER_ID_`     varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `TOKEN_DATA_`  varchar(2000) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    PRIMARY KEY (`ID_`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of act_id_token
-- ----------------------------
INSERT INTO `act_id_token`
VALUES ('e4uiqNTGcTqOCKecpD0nxQ==', 1, 'wHkxC2HDZEzafkpcwFRwsQ==', '2023-04-04 08:59:43.845', '0:0:0:0:0:0:0:1',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/111.0.0.0 Safari/537.36 Edg/111.0.1661.62',
        'admin', NULL);

-- ----------------------------
-- Table structure for act_id_user
-- ----------------------------
DROP TABLE IF EXISTS `act_id_user`;
CREATE TABLE `act_id_user`
(
    `ID_`           varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
    `REV_`          int(11) NULL DEFAULT NULL,
    `FIRST_`        varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `LAST_`         varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `DISPLAY_NAME_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `EMAIL_`        varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `PWD_`          varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `PICTURE_ID_`   varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `TENANT_ID_`    varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '',
    PRIMARY KEY (`ID_`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of act_id_user
-- ----------------------------
INSERT INTO `act_id_user`
VALUES ('admin', 1, 'Test', 'Administrator', NULL, 'test-admin@example-domain.tld', 'test', NULL, NULL);

-- ----------------------------
-- Table structure for act_procdef_info
-- ----------------------------
DROP TABLE IF EXISTS `act_procdef_info`;
CREATE TABLE `act_procdef_info`
(
    `ID_`           varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
    `PROC_DEF_ID_`  varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
    `REV_`          int(11) NULL DEFAULT NULL,
    `INFO_JSON_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    PRIMARY KEY (`ID_`) USING BTREE,
    UNIQUE INDEX `ACT_UNIQ_INFO_PROCDEF`(`PROC_DEF_ID_`) USING BTREE,
    INDEX           `ACT_IDX_INFO_PROCDEF`(`PROC_DEF_ID_`) USING BTREE,
    INDEX           `ACT_FK_INFO_JSON_BA`(`INFO_JSON_ID_`) USING BTREE,
    CONSTRAINT `ACT_FK_INFO_JSON_BA` FOREIGN KEY (`INFO_JSON_ID_`) REFERENCES `act_ge_bytearray` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT,
    CONSTRAINT `ACT_FK_INFO_PROCDEF` FOREIGN KEY (`PROC_DEF_ID_`) REFERENCES `act_re_procdef` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for act_re_deployment
-- ----------------------------
DROP TABLE IF EXISTS `act_re_deployment`;
CREATE TABLE `act_re_deployment`
(
    `ID_`                   varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
    `NAME_`                 varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `CATEGORY_`             varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `KEY_`                  varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `TENANT_ID_`            varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '',
    `DEPLOY_TIME_`          timestamp(3) NULL DEFAULT NULL,
    `DERIVED_FROM_`         varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `DERIVED_FROM_ROOT_`    varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `PARENT_DEPLOYMENT_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `ENGINE_VERSION_`       varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    PRIMARY KEY (`ID_`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for act_re_model
-- ----------------------------
DROP TABLE IF EXISTS `act_re_model`;
CREATE TABLE `act_re_model`
(
    `ID_`                           varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
    `REV_`                          int(11) NULL DEFAULT NULL,
    `NAME_`                         varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `KEY_`                          varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `CATEGORY_`                     varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `CREATE_TIME_`                  timestamp(3) NULL DEFAULT NULL,
    `LAST_UPDATE_TIME_`             timestamp(3) NULL DEFAULT NULL,
    `VERSION_`                      int(11) NULL DEFAULT NULL,
    `META_INFO_`                    varchar(4000) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `DEPLOYMENT_ID_`                varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `EDITOR_SOURCE_VALUE_ID_`       varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `EDITOR_SOURCE_EXTRA_VALUE_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `TENANT_ID_`                    varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '',
    PRIMARY KEY (`ID_`) USING BTREE,
    INDEX                           `ACT_FK_MODEL_SOURCE`(`EDITOR_SOURCE_VALUE_ID_`) USING BTREE,
    INDEX                           `ACT_FK_MODEL_SOURCE_EXTRA`(`EDITOR_SOURCE_EXTRA_VALUE_ID_`) USING BTREE,
    INDEX                           `ACT_FK_MODEL_DEPLOYMENT`(`DEPLOYMENT_ID_`) USING BTREE,
    CONSTRAINT `ACT_FK_MODEL_DEPLOYMENT` FOREIGN KEY (`DEPLOYMENT_ID_`) REFERENCES `act_re_deployment` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT,
    CONSTRAINT `ACT_FK_MODEL_SOURCE` FOREIGN KEY (`EDITOR_SOURCE_VALUE_ID_`) REFERENCES `act_ge_bytearray` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT,
    CONSTRAINT `ACT_FK_MODEL_SOURCE_EXTRA` FOREIGN KEY (`EDITOR_SOURCE_EXTRA_VALUE_ID_`) REFERENCES `act_ge_bytearray` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for act_re_procdef
-- ----------------------------
DROP TABLE IF EXISTS `act_re_procdef`;
CREATE TABLE `act_re_procdef`
(
    `ID_`                     varchar(64) CHARACTER SET utf8 COLLATE utf8_bin  NOT NULL,
    `REV_`                    int(11) NULL DEFAULT NULL,
    `CATEGORY_`               varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `NAME_`                   varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `KEY_`                    varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
    `VERSION_`                int(11) NOT NULL,
    `DEPLOYMENT_ID_`          varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `RESOURCE_NAME_`          varchar(4000) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `DGRM_RESOURCE_NAME_`     varchar(4000) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `DESCRIPTION_`            varchar(4000) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `HAS_START_FORM_KEY_`     tinyint(4) NULL DEFAULT NULL,
    `HAS_GRAPHICAL_NOTATION_` tinyint(4) NULL DEFAULT NULL,
    `SUSPENSION_STATE_`       int(11) NULL DEFAULT NULL,
    `TENANT_ID_`              varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '',
    `ENGINE_VERSION_`         varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `DERIVED_FROM_`           varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `DERIVED_FROM_ROOT_`      varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `DERIVED_VERSION_`        int(11) NOT NULL DEFAULT 0,
    PRIMARY KEY (`ID_`) USING BTREE,
    UNIQUE INDEX `ACT_UNIQ_PROCDEF`(`KEY_`, `VERSION_`, `DERIVED_VERSION_`, `TENANT_ID_`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for act_ru_actinst
-- ----------------------------
DROP TABLE IF EXISTS `act_ru_actinst`;
CREATE TABLE `act_ru_actinst`
(
    `ID_`                varchar(64) CHARACTER SET utf8 COLLATE utf8_bin  NOT NULL,
    `REV_`               int(11) NULL DEFAULT 1,
    `PROC_DEF_ID_`       varchar(64) CHARACTER SET utf8 COLLATE utf8_bin  NOT NULL,
    `PROC_INST_ID_`      varchar(64) CHARACTER SET utf8 COLLATE utf8_bin  NOT NULL,
    `EXECUTION_ID_`      varchar(64) CHARACTER SET utf8 COLLATE utf8_bin  NOT NULL,
    `ACT_ID_`            varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
    `TASK_ID_`           varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `CALL_PROC_INST_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `ACT_NAME_`          varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `ACT_TYPE_`          varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
    `ASSIGNEE_`          varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `START_TIME_`        datetime(3) NULL,
    `END_TIME_`          datetime(3) NULL DEFAULT NULL,
    `DURATION_`          bigint(20) NULL DEFAULT NULL,
    `TRANSACTION_ORDER_` int(11) NULL DEFAULT NULL,
    `DELETE_REASON_`     varchar(4000) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `TENANT_ID_`         varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '',
    PRIMARY KEY (`ID_`) USING BTREE,
    INDEX                `ACT_IDX_RU_ACTI_START`(`START_TIME_`) USING BTREE,
    INDEX                `ACT_IDX_RU_ACTI_END`(`END_TIME_`) USING BTREE,
    INDEX                `ACT_IDX_RU_ACTI_PROC`(`PROC_INST_ID_`) USING BTREE,
    INDEX                `ACT_IDX_RU_ACTI_PROC_ACT`(`PROC_INST_ID_`, `ACT_ID_`) USING BTREE,
    INDEX                `ACT_IDX_RU_ACTI_EXEC`(`EXECUTION_ID_`) USING BTREE,
    INDEX                `ACT_IDX_RU_ACTI_EXEC_ACT`(`EXECUTION_ID_`, `ACT_ID_`) USING BTREE,
    INDEX                `ACT_IDX_RU_ACTI_TASK`(`TASK_ID_`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for act_ru_deadletter_job
-- ----------------------------
DROP TABLE IF EXISTS `act_ru_deadletter_job`;
CREATE TABLE `act_ru_deadletter_job`
(
    `ID_`                  varchar(64) CHARACTER SET utf8 COLLATE utf8_bin  NOT NULL,
    `REV_`                 int(11) NULL DEFAULT NULL,
    `CATEGORY_`            varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `TYPE_`                varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
    `EXCLUSIVE_`           tinyint(1) NULL DEFAULT NULL,
    `EXECUTION_ID_`        varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `PROCESS_INSTANCE_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `PROC_DEF_ID_`         varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `ELEMENT_ID_`          varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `ELEMENT_NAME_`        varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `SCOPE_ID_`            varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `SUB_SCOPE_ID_`        varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `SCOPE_TYPE_`          varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `SCOPE_DEFINITION_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `CORRELATION_ID_`      varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `EXCEPTION_STACK_ID_`  varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `EXCEPTION_MSG_`       varchar(4000) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `DUEDATE_`             timestamp(3) NULL DEFAULT NULL,
    `REPEAT_`              varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `HANDLER_TYPE_`        varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `HANDLER_CFG_`         varchar(4000) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `CUSTOM_VALUES_ID_`    varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `CREATE_TIME_`         timestamp(3) NULL DEFAULT NULL,
    `TENANT_ID_`           varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '',
    PRIMARY KEY (`ID_`) USING BTREE,
    INDEX                  `ACT_IDX_DEADLETTER_JOB_EXCEPTION_STACK_ID`(`EXCEPTION_STACK_ID_`) USING BTREE,
    INDEX                  `ACT_IDX_DEADLETTER_JOB_CUSTOM_VALUES_ID`(`CUSTOM_VALUES_ID_`) USING BTREE,
    INDEX                  `ACT_IDX_DEADLETTER_JOB_CORRELATION_ID`(`CORRELATION_ID_`) USING BTREE,
    INDEX                  `ACT_IDX_DJOB_SCOPE`(`SCOPE_ID_`, `SCOPE_TYPE_`) USING BTREE,
    INDEX                  `ACT_IDX_DJOB_SUB_SCOPE`(`SUB_SCOPE_ID_`, `SCOPE_TYPE_`) USING BTREE,
    INDEX                  `ACT_IDX_DJOB_SCOPE_DEF`(`SCOPE_DEFINITION_ID_`, `SCOPE_TYPE_`) USING BTREE,
    INDEX                  `ACT_FK_DEADLETTER_JOB_EXECUTION`(`EXECUTION_ID_`) USING BTREE,
    INDEX                  `ACT_FK_DEADLETTER_JOB_PROCESS_INSTANCE`(`PROCESS_INSTANCE_ID_`) USING BTREE,
    INDEX                  `ACT_FK_DEADLETTER_JOB_PROC_DEF`(`PROC_DEF_ID_`) USING BTREE,
    CONSTRAINT `ACT_FK_DEADLETTER_JOB_CUSTOM_VALUES` FOREIGN KEY (`CUSTOM_VALUES_ID_`) REFERENCES `act_ge_bytearray` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT,
    CONSTRAINT `ACT_FK_DEADLETTER_JOB_EXCEPTION` FOREIGN KEY (`EXCEPTION_STACK_ID_`) REFERENCES `act_ge_bytearray` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT,
    CONSTRAINT `ACT_FK_DEADLETTER_JOB_EXECUTION` FOREIGN KEY (`EXECUTION_ID_`) REFERENCES `act_ru_execution` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT,
    CONSTRAINT `ACT_FK_DEADLETTER_JOB_PROCESS_INSTANCE` FOREIGN KEY (`PROCESS_INSTANCE_ID_`) REFERENCES `act_ru_execution` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT,
    CONSTRAINT `ACT_FK_DEADLETTER_JOB_PROC_DEF` FOREIGN KEY (`PROC_DEF_ID_`) REFERENCES `act_re_procdef` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for act_ru_entitylink
-- ----------------------------
DROP TABLE IF EXISTS `act_ru_entitylink`;
CREATE TABLE `act_ru_entitylink`
(
    `ID_`                      varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
    `REV_`                     int(11) NULL DEFAULT NULL,
    `CREATE_TIME_`             datetime(3) NULL DEFAULT NULL,
    `LINK_TYPE_`               varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `SCOPE_ID_`                varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `SUB_SCOPE_ID_`            varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `SCOPE_TYPE_`              varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `SCOPE_DEFINITION_ID_`     varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `PARENT_ELEMENT_ID_`       varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `REF_SCOPE_ID_`            varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `REF_SCOPE_TYPE_`          varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `REF_SCOPE_DEFINITION_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `ROOT_SCOPE_ID_`           varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `ROOT_SCOPE_TYPE_`         varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `HIERARCHY_TYPE_`          varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    PRIMARY KEY (`ID_`) USING BTREE,
    INDEX                      `ACT_IDX_ENT_LNK_SCOPE`(`SCOPE_ID_`, `SCOPE_TYPE_`, `LINK_TYPE_`) USING BTREE,
    INDEX                      `ACT_IDX_ENT_LNK_REF_SCOPE`(`REF_SCOPE_ID_`, `REF_SCOPE_TYPE_`, `LINK_TYPE_`) USING BTREE,
    INDEX                      `ACT_IDX_ENT_LNK_ROOT_SCOPE`(`ROOT_SCOPE_ID_`, `ROOT_SCOPE_TYPE_`, `LINK_TYPE_`) USING BTREE,
    INDEX                      `ACT_IDX_ENT_LNK_SCOPE_DEF`(`SCOPE_DEFINITION_ID_`, `SCOPE_TYPE_`, `LINK_TYPE_`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for act_ru_event_subscr
-- ----------------------------
DROP TABLE IF EXISTS `act_ru_event_subscr`;
CREATE TABLE `act_ru_event_subscr`
(
    `ID_`                  varchar(64) CHARACTER SET utf8 COLLATE utf8_bin  NOT NULL,
    `REV_`                 int(11) NULL DEFAULT NULL,
    `EVENT_TYPE_`          varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
    `EVENT_NAME_`          varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `EXECUTION_ID_`        varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `PROC_INST_ID_`        varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `ACTIVITY_ID_`         varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `CONFIGURATION_`       varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `CREATED_`             timestamp(3)                                     NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `PROC_DEF_ID_`         varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `SUB_SCOPE_ID_`        varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `SCOPE_ID_`            varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `SCOPE_DEFINITION_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `SCOPE_TYPE_`          varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `TENANT_ID_`           varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '',
    PRIMARY KEY (`ID_`) USING BTREE,
    INDEX                  `ACT_IDX_EVENT_SUBSCR_CONFIG_`(`CONFIGURATION_`) USING BTREE,
    INDEX                  `ACT_FK_EVENT_EXEC`(`EXECUTION_ID_`) USING BTREE,
    CONSTRAINT `ACT_FK_EVENT_EXEC` FOREIGN KEY (`EXECUTION_ID_`) REFERENCES `act_ru_execution` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for act_ru_execution
-- ----------------------------
DROP TABLE IF EXISTS `act_ru_execution`;
CREATE TABLE `act_ru_execution`
(
    `ID_`                        varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
    `REV_`                       int(11) NULL DEFAULT NULL,
    `PROC_INST_ID_`              varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `BUSINESS_KEY_`              varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `PARENT_ID_`                 varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `PROC_DEF_ID_`               varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `SUPER_EXEC_`                varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `ROOT_PROC_INST_ID_`         varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `ACT_ID_`                    varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `IS_ACTIVE_`                 tinyint(4) NULL DEFAULT NULL,
    `IS_CONCURRENT_`             tinyint(4) NULL DEFAULT NULL,
    `IS_SCOPE_`                  tinyint(4) NULL DEFAULT NULL,
    `IS_EVENT_SCOPE_`            tinyint(4) NULL DEFAULT NULL,
    `IS_MI_ROOT_`                tinyint(4) NULL DEFAULT NULL,
    `SUSPENSION_STATE_`          int(11) NULL DEFAULT NULL,
    `CACHED_ENT_STATE_`          int(11) NULL DEFAULT NULL,
    `TENANT_ID_`                 varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '',
    `NAME_`                      varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `START_ACT_ID_`              varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `START_TIME_`                datetime(3) NULL DEFAULT NULL,
    `START_USER_ID_`             varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `LOCK_TIME_`                 timestamp(3) NULL DEFAULT NULL,
    `LOCK_OWNER_`                varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `IS_COUNT_ENABLED_`          tinyint(4) NULL DEFAULT NULL,
    `EVT_SUBSCR_COUNT_`          int(11) NULL DEFAULT NULL,
    `TASK_COUNT_`                int(11) NULL DEFAULT NULL,
    `JOB_COUNT_`                 int(11) NULL DEFAULT NULL,
    `TIMER_JOB_COUNT_`           int(11) NULL DEFAULT NULL,
    `SUSP_JOB_COUNT_`            int(11) NULL DEFAULT NULL,
    `DEADLETTER_JOB_COUNT_`      int(11) NULL DEFAULT NULL,
    `EXTERNAL_WORKER_JOB_COUNT_` int(11) NULL DEFAULT NULL,
    `VAR_COUNT_`                 int(11) NULL DEFAULT NULL,
    `ID_LINK_COUNT_`             int(11) NULL DEFAULT NULL,
    `CALLBACK_ID_`               varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `CALLBACK_TYPE_`             varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `REFERENCE_ID_`              varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `REFERENCE_TYPE_`            varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `PROPAGATED_STAGE_INST_ID_`  varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `BUSINESS_STATUS_`           varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    PRIMARY KEY (`ID_`) USING BTREE,
    INDEX                        `ACT_IDX_EXEC_BUSKEY`(`BUSINESS_KEY_`) USING BTREE,
    INDEX                        `ACT_IDC_EXEC_ROOT`(`ROOT_PROC_INST_ID_`) USING BTREE,
    INDEX                        `ACT_IDX_EXEC_REF_ID_`(`REFERENCE_ID_`) USING BTREE,
    INDEX                        `ACT_FK_EXE_PROCINST`(`PROC_INST_ID_`) USING BTREE,
    INDEX                        `ACT_FK_EXE_PARENT`(`PARENT_ID_`) USING BTREE,
    INDEX                        `ACT_FK_EXE_SUPER`(`SUPER_EXEC_`) USING BTREE,
    INDEX                        `ACT_FK_EXE_PROCDEF`(`PROC_DEF_ID_`) USING BTREE,
    CONSTRAINT `ACT_FK_EXE_PARENT` FOREIGN KEY (`PARENT_ID_`) REFERENCES `act_ru_execution` (`ID_`) ON DELETE CASCADE ON UPDATE RESTRICT,
    CONSTRAINT `ACT_FK_EXE_PROCDEF` FOREIGN KEY (`PROC_DEF_ID_`) REFERENCES `act_re_procdef` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT,
    CONSTRAINT `ACT_FK_EXE_PROCINST` FOREIGN KEY (`PROC_INST_ID_`) REFERENCES `act_ru_execution` (`ID_`) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT `ACT_FK_EXE_SUPER` FOREIGN KEY (`SUPER_EXEC_`) REFERENCES `act_ru_execution` (`ID_`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for act_ru_external_job
-- ----------------------------
DROP TABLE IF EXISTS `act_ru_external_job`;
CREATE TABLE `act_ru_external_job`
(
    `ID_`                  varchar(64) CHARACTER SET utf8 COLLATE utf8_bin  NOT NULL,
    `REV_`                 int(11) NULL DEFAULT NULL,
    `CATEGORY_`            varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `TYPE_`                varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
    `LOCK_EXP_TIME_`       timestamp(3) NULL DEFAULT NULL,
    `LOCK_OWNER_`          varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `EXCLUSIVE_`           tinyint(1) NULL DEFAULT NULL,
    `EXECUTION_ID_`        varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `PROCESS_INSTANCE_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `PROC_DEF_ID_`         varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `ELEMENT_ID_`          varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `ELEMENT_NAME_`        varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `SCOPE_ID_`            varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `SUB_SCOPE_ID_`        varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `SCOPE_TYPE_`          varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `SCOPE_DEFINITION_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `CORRELATION_ID_`      varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `RETRIES_`             int(11) NULL DEFAULT NULL,
    `EXCEPTION_STACK_ID_`  varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `EXCEPTION_MSG_`       varchar(4000) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `DUEDATE_`             timestamp(3) NULL DEFAULT NULL,
    `REPEAT_`              varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `HANDLER_TYPE_`        varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `HANDLER_CFG_`         varchar(4000) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `CUSTOM_VALUES_ID_`    varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `CREATE_TIME_`         timestamp(3) NULL DEFAULT NULL,
    `TENANT_ID_`           varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '',
    PRIMARY KEY (`ID_`) USING BTREE,
    INDEX                  `ACT_IDX_EXTERNAL_JOB_EXCEPTION_STACK_ID`(`EXCEPTION_STACK_ID_`) USING BTREE,
    INDEX                  `ACT_IDX_EXTERNAL_JOB_CUSTOM_VALUES_ID`(`CUSTOM_VALUES_ID_`) USING BTREE,
    INDEX                  `ACT_IDX_EXTERNAL_JOB_CORRELATION_ID`(`CORRELATION_ID_`) USING BTREE,
    INDEX                  `ACT_IDX_EJOB_SCOPE`(`SCOPE_ID_`, `SCOPE_TYPE_`) USING BTREE,
    INDEX                  `ACT_IDX_EJOB_SUB_SCOPE`(`SUB_SCOPE_ID_`, `SCOPE_TYPE_`) USING BTREE,
    INDEX                  `ACT_IDX_EJOB_SCOPE_DEF`(`SCOPE_DEFINITION_ID_`, `SCOPE_TYPE_`) USING BTREE,
    CONSTRAINT `ACT_FK_EXTERNAL_JOB_CUSTOM_VALUES` FOREIGN KEY (`CUSTOM_VALUES_ID_`) REFERENCES `act_ge_bytearray` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT,
    CONSTRAINT `ACT_FK_EXTERNAL_JOB_EXCEPTION` FOREIGN KEY (`EXCEPTION_STACK_ID_`) REFERENCES `act_ge_bytearray` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for act_ru_history_job
-- ----------------------------
DROP TABLE IF EXISTS `act_ru_history_job`;
CREATE TABLE `act_ru_history_job`
(
    `ID_`                 varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
    `REV_`                int(11) NULL DEFAULT NULL,
    `LOCK_EXP_TIME_`      timestamp(3) NULL DEFAULT NULL,
    `LOCK_OWNER_`         varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `RETRIES_`            int(11) NULL DEFAULT NULL,
    `EXCEPTION_STACK_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `EXCEPTION_MSG_`      varchar(4000) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `HANDLER_TYPE_`       varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `HANDLER_CFG_`        varchar(4000) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `CUSTOM_VALUES_ID_`   varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `ADV_HANDLER_CFG_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `CREATE_TIME_`        timestamp(3) NULL DEFAULT NULL,
    `SCOPE_TYPE_`         varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `TENANT_ID_`          varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '',
    PRIMARY KEY (`ID_`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for act_ru_identitylink
-- ----------------------------
DROP TABLE IF EXISTS `act_ru_identitylink`;
CREATE TABLE `act_ru_identitylink`
(
    `ID_`                  varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
    `REV_`                 int(11) NULL DEFAULT NULL,
    `GROUP_ID_`            varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `TYPE_`                varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `USER_ID_`             varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `TASK_ID_`             varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `PROC_INST_ID_`        varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `PROC_DEF_ID_`         varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `SCOPE_ID_`            varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `SUB_SCOPE_ID_`        varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `SCOPE_TYPE_`          varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `SCOPE_DEFINITION_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    PRIMARY KEY (`ID_`) USING BTREE,
    INDEX                  `ACT_IDX_IDENT_LNK_USER`(`USER_ID_`) USING BTREE,
    INDEX                  `ACT_IDX_IDENT_LNK_GROUP`(`GROUP_ID_`) USING BTREE,
    INDEX                  `ACT_IDX_IDENT_LNK_SCOPE`(`SCOPE_ID_`, `SCOPE_TYPE_`) USING BTREE,
    INDEX                  `ACT_IDX_IDENT_LNK_SUB_SCOPE`(`SUB_SCOPE_ID_`, `SCOPE_TYPE_`) USING BTREE,
    INDEX                  `ACT_IDX_IDENT_LNK_SCOPE_DEF`(`SCOPE_DEFINITION_ID_`, `SCOPE_TYPE_`) USING BTREE,
    INDEX                  `ACT_IDX_ATHRZ_PROCEDEF`(`PROC_DEF_ID_`) USING BTREE,
    INDEX                  `ACT_FK_TSKASS_TASK`(`TASK_ID_`) USING BTREE,
    INDEX                  `ACT_FK_IDL_PROCINST`(`PROC_INST_ID_`) USING BTREE,
    CONSTRAINT `ACT_FK_ATHRZ_PROCEDEF` FOREIGN KEY (`PROC_DEF_ID_`) REFERENCES `act_re_procdef` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT,
    CONSTRAINT `ACT_FK_IDL_PROCINST` FOREIGN KEY (`PROC_INST_ID_`) REFERENCES `act_ru_execution` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT,
    CONSTRAINT `ACT_FK_TSKASS_TASK` FOREIGN KEY (`TASK_ID_`) REFERENCES `act_ru_task` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for act_ru_job
-- ----------------------------
DROP TABLE IF EXISTS `act_ru_job`;
CREATE TABLE `act_ru_job`
(
    `ID_`                  varchar(64) CHARACTER SET utf8 COLLATE utf8_bin  NOT NULL,
    `REV_`                 int(11) NULL DEFAULT NULL,
    `CATEGORY_`            varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `TYPE_`                varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
    `LOCK_EXP_TIME_`       timestamp(3) NULL DEFAULT NULL,
    `LOCK_OWNER_`          varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `EXCLUSIVE_`           tinyint(1) NULL DEFAULT NULL,
    `EXECUTION_ID_`        varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `PROCESS_INSTANCE_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `PROC_DEF_ID_`         varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `ELEMENT_ID_`          varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `ELEMENT_NAME_`        varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `SCOPE_ID_`            varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `SUB_SCOPE_ID_`        varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `SCOPE_TYPE_`          varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `SCOPE_DEFINITION_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `CORRELATION_ID_`      varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `RETRIES_`             int(11) NULL DEFAULT NULL,
    `EXCEPTION_STACK_ID_`  varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `EXCEPTION_MSG_`       varchar(4000) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `DUEDATE_`             timestamp(3) NULL DEFAULT NULL,
    `REPEAT_`              varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `HANDLER_TYPE_`        varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `HANDLER_CFG_`         varchar(4000) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `CUSTOM_VALUES_ID_`    varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `CREATE_TIME_`         timestamp(3) NULL DEFAULT NULL,
    `TENANT_ID_`           varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '',
    PRIMARY KEY (`ID_`) USING BTREE,
    INDEX                  `ACT_IDX_JOB_EXCEPTION_STACK_ID`(`EXCEPTION_STACK_ID_`) USING BTREE,
    INDEX                  `ACT_IDX_JOB_CUSTOM_VALUES_ID`(`CUSTOM_VALUES_ID_`) USING BTREE,
    INDEX                  `ACT_IDX_JOB_CORRELATION_ID`(`CORRELATION_ID_`) USING BTREE,
    INDEX                  `ACT_IDX_JOB_SCOPE`(`SCOPE_ID_`, `SCOPE_TYPE_`) USING BTREE,
    INDEX                  `ACT_IDX_JOB_SUB_SCOPE`(`SUB_SCOPE_ID_`, `SCOPE_TYPE_`) USING BTREE,
    INDEX                  `ACT_IDX_JOB_SCOPE_DEF`(`SCOPE_DEFINITION_ID_`, `SCOPE_TYPE_`) USING BTREE,
    INDEX                  `ACT_FK_JOB_EXECUTION`(`EXECUTION_ID_`) USING BTREE,
    INDEX                  `ACT_FK_JOB_PROCESS_INSTANCE`(`PROCESS_INSTANCE_ID_`) USING BTREE,
    INDEX                  `ACT_FK_JOB_PROC_DEF`(`PROC_DEF_ID_`) USING BTREE,
    CONSTRAINT `ACT_FK_JOB_CUSTOM_VALUES` FOREIGN KEY (`CUSTOM_VALUES_ID_`) REFERENCES `act_ge_bytearray` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT,
    CONSTRAINT `ACT_FK_JOB_EXCEPTION` FOREIGN KEY (`EXCEPTION_STACK_ID_`) REFERENCES `act_ge_bytearray` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT,
    CONSTRAINT `ACT_FK_JOB_EXECUTION` FOREIGN KEY (`EXECUTION_ID_`) REFERENCES `act_ru_execution` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT,
    CONSTRAINT `ACT_FK_JOB_PROCESS_INSTANCE` FOREIGN KEY (`PROCESS_INSTANCE_ID_`) REFERENCES `act_ru_execution` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT,
    CONSTRAINT `ACT_FK_JOB_PROC_DEF` FOREIGN KEY (`PROC_DEF_ID_`) REFERENCES `act_re_procdef` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for act_ru_suspended_job
-- ----------------------------
DROP TABLE IF EXISTS `act_ru_suspended_job`;
CREATE TABLE `act_ru_suspended_job`
(
    `ID_`                  varchar(64) CHARACTER SET utf8 COLLATE utf8_bin  NOT NULL,
    `REV_`                 int(11) NULL DEFAULT NULL,
    `CATEGORY_`            varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `TYPE_`                varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
    `EXCLUSIVE_`           tinyint(1) NULL DEFAULT NULL,
    `EXECUTION_ID_`        varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `PROCESS_INSTANCE_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `PROC_DEF_ID_`         varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `ELEMENT_ID_`          varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `ELEMENT_NAME_`        varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `SCOPE_ID_`            varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `SUB_SCOPE_ID_`        varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `SCOPE_TYPE_`          varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `SCOPE_DEFINITION_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `CORRELATION_ID_`      varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `RETRIES_`             int(11) NULL DEFAULT NULL,
    `EXCEPTION_STACK_ID_`  varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `EXCEPTION_MSG_`       varchar(4000) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `DUEDATE_`             timestamp(3) NULL DEFAULT NULL,
    `REPEAT_`              varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `HANDLER_TYPE_`        varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `HANDLER_CFG_`         varchar(4000) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `CUSTOM_VALUES_ID_`    varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `CREATE_TIME_`         timestamp(3) NULL DEFAULT NULL,
    `TENANT_ID_`           varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '',
    PRIMARY KEY (`ID_`) USING BTREE,
    INDEX                  `ACT_IDX_SUSPENDED_JOB_EXCEPTION_STACK_ID`(`EXCEPTION_STACK_ID_`) USING BTREE,
    INDEX                  `ACT_IDX_SUSPENDED_JOB_CUSTOM_VALUES_ID`(`CUSTOM_VALUES_ID_`) USING BTREE,
    INDEX                  `ACT_IDX_SUSPENDED_JOB_CORRELATION_ID`(`CORRELATION_ID_`) USING BTREE,
    INDEX                  `ACT_IDX_SJOB_SCOPE`(`SCOPE_ID_`, `SCOPE_TYPE_`) USING BTREE,
    INDEX                  `ACT_IDX_SJOB_SUB_SCOPE`(`SUB_SCOPE_ID_`, `SCOPE_TYPE_`) USING BTREE,
    INDEX                  `ACT_IDX_SJOB_SCOPE_DEF`(`SCOPE_DEFINITION_ID_`, `SCOPE_TYPE_`) USING BTREE,
    INDEX                  `ACT_FK_SUSPENDED_JOB_EXECUTION`(`EXECUTION_ID_`) USING BTREE,
    INDEX                  `ACT_FK_SUSPENDED_JOB_PROCESS_INSTANCE`(`PROCESS_INSTANCE_ID_`) USING BTREE,
    INDEX                  `ACT_FK_SUSPENDED_JOB_PROC_DEF`(`PROC_DEF_ID_`) USING BTREE,
    CONSTRAINT `ACT_FK_SUSPENDED_JOB_CUSTOM_VALUES` FOREIGN KEY (`CUSTOM_VALUES_ID_`) REFERENCES `act_ge_bytearray` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT,
    CONSTRAINT `ACT_FK_SUSPENDED_JOB_EXCEPTION` FOREIGN KEY (`EXCEPTION_STACK_ID_`) REFERENCES `act_ge_bytearray` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT,
    CONSTRAINT `ACT_FK_SUSPENDED_JOB_EXECUTION` FOREIGN KEY (`EXECUTION_ID_`) REFERENCES `act_ru_execution` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT,
    CONSTRAINT `ACT_FK_SUSPENDED_JOB_PROCESS_INSTANCE` FOREIGN KEY (`PROCESS_INSTANCE_ID_`) REFERENCES `act_ru_execution` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT,
    CONSTRAINT `ACT_FK_SUSPENDED_JOB_PROC_DEF` FOREIGN KEY (`PROC_DEF_ID_`) REFERENCES `act_re_procdef` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for act_ru_task
-- ----------------------------
DROP TABLE IF EXISTS `act_ru_task`;
CREATE TABLE `act_ru_task`
(
    `ID_`                       varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
    `REV_`                      int(11) NULL DEFAULT NULL,
    `EXECUTION_ID_`             varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `PROC_INST_ID_`             varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `PROC_DEF_ID_`              varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `TASK_DEF_ID_`              varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `SCOPE_ID_`                 varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `SUB_SCOPE_ID_`             varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `SCOPE_TYPE_`               varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `SCOPE_DEFINITION_ID_`      varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `PROPAGATED_STAGE_INST_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `NAME_`                     varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `PARENT_TASK_ID_`           varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `DESCRIPTION_`              varchar(4000) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `TASK_DEF_KEY_`             varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `OWNER_`                    varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `ASSIGNEE_`                 varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `DELEGATION_`               varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `PRIORITY_`                 int(11) NULL DEFAULT NULL,
    `CREATE_TIME_`              timestamp(3) NULL DEFAULT NULL,
    `DUE_DATE_`                 datetime(3) NULL DEFAULT NULL,
    `CATEGORY_`                 varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `SUSPENSION_STATE_`         int(11) NULL DEFAULT NULL,
    `TENANT_ID_`                varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '',
    `FORM_KEY_`                 varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `CLAIM_TIME_`               datetime(3) NULL DEFAULT NULL,
    `IS_COUNT_ENABLED_`         tinyint(4) NULL DEFAULT NULL,
    `VAR_COUNT_`                int(11) NULL DEFAULT NULL,
    `ID_LINK_COUNT_`            int(11) NULL DEFAULT NULL,
    `SUB_TASK_COUNT_`           int(11) NULL DEFAULT NULL,
    PRIMARY KEY (`ID_`) USING BTREE,
    INDEX                       `ACT_IDX_TASK_CREATE`(`CREATE_TIME_`) USING BTREE,
    INDEX                       `ACT_IDX_TASK_SCOPE`(`SCOPE_ID_`, `SCOPE_TYPE_`) USING BTREE,
    INDEX                       `ACT_IDX_TASK_SUB_SCOPE`(`SUB_SCOPE_ID_`, `SCOPE_TYPE_`) USING BTREE,
    INDEX                       `ACT_IDX_TASK_SCOPE_DEF`(`SCOPE_DEFINITION_ID_`, `SCOPE_TYPE_`) USING BTREE,
    INDEX                       `ACT_FK_TASK_EXE`(`EXECUTION_ID_`) USING BTREE,
    INDEX                       `ACT_FK_TASK_PROCINST`(`PROC_INST_ID_`) USING BTREE,
    INDEX                       `ACT_FK_TASK_PROCDEF`(`PROC_DEF_ID_`) USING BTREE,
    CONSTRAINT `ACT_FK_TASK_EXE` FOREIGN KEY (`EXECUTION_ID_`) REFERENCES `act_ru_execution` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT,
    CONSTRAINT `ACT_FK_TASK_PROCDEF` FOREIGN KEY (`PROC_DEF_ID_`) REFERENCES `act_re_procdef` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT,
    CONSTRAINT `ACT_FK_TASK_PROCINST` FOREIGN KEY (`PROC_INST_ID_`) REFERENCES `act_ru_execution` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for act_ru_timer_job
-- ----------------------------
DROP TABLE IF EXISTS `act_ru_timer_job`;
CREATE TABLE `act_ru_timer_job`
(
    `ID_`                  varchar(64) CHARACTER SET utf8 COLLATE utf8_bin  NOT NULL,
    `REV_`                 int(11) NULL DEFAULT NULL,
    `CATEGORY_`            varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `TYPE_`                varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
    `LOCK_EXP_TIME_`       timestamp(3) NULL DEFAULT NULL,
    `LOCK_OWNER_`          varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `EXCLUSIVE_`           tinyint(1) NULL DEFAULT NULL,
    `EXECUTION_ID_`        varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `PROCESS_INSTANCE_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `PROC_DEF_ID_`         varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `ELEMENT_ID_`          varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `ELEMENT_NAME_`        varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `SCOPE_ID_`            varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `SUB_SCOPE_ID_`        varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `SCOPE_TYPE_`          varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `SCOPE_DEFINITION_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `CORRELATION_ID_`      varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `RETRIES_`             int(11) NULL DEFAULT NULL,
    `EXCEPTION_STACK_ID_`  varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `EXCEPTION_MSG_`       varchar(4000) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `DUEDATE_`             timestamp(3) NULL DEFAULT NULL,
    `REPEAT_`              varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `HANDLER_TYPE_`        varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `HANDLER_CFG_`         varchar(4000) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `CUSTOM_VALUES_ID_`    varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `CREATE_TIME_`         timestamp(3) NULL DEFAULT NULL,
    `TENANT_ID_`           varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '',
    PRIMARY KEY (`ID_`) USING BTREE,
    INDEX                  `ACT_IDX_TIMER_JOB_EXCEPTION_STACK_ID`(`EXCEPTION_STACK_ID_`) USING BTREE,
    INDEX                  `ACT_IDX_TIMER_JOB_CUSTOM_VALUES_ID`(`CUSTOM_VALUES_ID_`) USING BTREE,
    INDEX                  `ACT_IDX_TIMER_JOB_CORRELATION_ID`(`CORRELATION_ID_`) USING BTREE,
    INDEX                  `ACT_IDX_TIMER_JOB_DUEDATE`(`DUEDATE_`) USING BTREE,
    INDEX                  `ACT_IDX_TJOB_SCOPE`(`SCOPE_ID_`, `SCOPE_TYPE_`) USING BTREE,
    INDEX                  `ACT_IDX_TJOB_SUB_SCOPE`(`SUB_SCOPE_ID_`, `SCOPE_TYPE_`) USING BTREE,
    INDEX                  `ACT_IDX_TJOB_SCOPE_DEF`(`SCOPE_DEFINITION_ID_`, `SCOPE_TYPE_`) USING BTREE,
    INDEX                  `ACT_FK_TIMER_JOB_EXECUTION`(`EXECUTION_ID_`) USING BTREE,
    INDEX                  `ACT_FK_TIMER_JOB_PROCESS_INSTANCE`(`PROCESS_INSTANCE_ID_`) USING BTREE,
    INDEX                  `ACT_FK_TIMER_JOB_PROC_DEF`(`PROC_DEF_ID_`) USING BTREE,
    CONSTRAINT `ACT_FK_TIMER_JOB_CUSTOM_VALUES` FOREIGN KEY (`CUSTOM_VALUES_ID_`) REFERENCES `act_ge_bytearray` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT,
    CONSTRAINT `ACT_FK_TIMER_JOB_EXCEPTION` FOREIGN KEY (`EXCEPTION_STACK_ID_`) REFERENCES `act_ge_bytearray` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT,
    CONSTRAINT `ACT_FK_TIMER_JOB_EXECUTION` FOREIGN KEY (`EXECUTION_ID_`) REFERENCES `act_ru_execution` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT,
    CONSTRAINT `ACT_FK_TIMER_JOB_PROCESS_INSTANCE` FOREIGN KEY (`PROCESS_INSTANCE_ID_`) REFERENCES `act_ru_execution` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT,
    CONSTRAINT `ACT_FK_TIMER_JOB_PROC_DEF` FOREIGN KEY (`PROC_DEF_ID_`) REFERENCES `act_re_procdef` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for act_ru_variable
-- ----------------------------
DROP TABLE IF EXISTS `act_ru_variable`;
CREATE TABLE `act_ru_variable`
(
    `ID_`           varchar(64) CHARACTER SET utf8 COLLATE utf8_bin  NOT NULL,
    `REV_`          int(11) NULL DEFAULT NULL,
    `TYPE_`         varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
    `NAME_`         varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
    `EXECUTION_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `PROC_INST_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `TASK_ID_`      varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `SCOPE_ID_`     varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `SUB_SCOPE_ID_` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `SCOPE_TYPE_`   varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `BYTEARRAY_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `DOUBLE_`       double NULL DEFAULT NULL,
    `LONG_`         bigint(20) NULL DEFAULT NULL,
    `TEXT_`         varchar(4000) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `TEXT2_`        varchar(4000) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    PRIMARY KEY (`ID_`) USING BTREE,
    INDEX           `ACT_IDX_RU_VAR_SCOPE_ID_TYPE`(`SCOPE_ID_`, `SCOPE_TYPE_`) USING BTREE,
    INDEX           `ACT_IDX_RU_VAR_SUB_ID_TYPE`(`SUB_SCOPE_ID_`, `SCOPE_TYPE_`) USING BTREE,
    INDEX           `ACT_FK_VAR_BYTEARRAY`(`BYTEARRAY_ID_`) USING BTREE,
    INDEX           `ACT_IDX_VARIABLE_TASK_ID`(`TASK_ID_`) USING BTREE,
    INDEX           `ACT_FK_VAR_EXE`(`EXECUTION_ID_`) USING BTREE,
    INDEX           `ACT_FK_VAR_PROCINST`(`PROC_INST_ID_`) USING BTREE,
    CONSTRAINT `ACT_FK_VAR_BYTEARRAY` FOREIGN KEY (`BYTEARRAY_ID_`) REFERENCES `act_ge_bytearray` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT,
    CONSTRAINT `ACT_FK_VAR_EXE` FOREIGN KEY (`EXECUTION_ID_`) REFERENCES `act_ru_execution` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT,
    CONSTRAINT `ACT_FK_VAR_PROCINST` FOREIGN KEY (`PROC_INST_ID_`) REFERENCES `act_ru_execution` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for flw_channel_definition
-- ----------------------------
DROP TABLE IF EXISTS `flw_channel_definition`;
CREATE TABLE `flw_channel_definition`
(
    `ID_`             varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
    `NAME_`           varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `VERSION_`        int(11) NULL DEFAULT NULL,
    `KEY_`            varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `CATEGORY_`       varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `DEPLOYMENT_ID_`  varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `CREATE_TIME_`    datetime(3) NULL DEFAULT NULL,
    `TENANT_ID_`      varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `RESOURCE_NAME_`  varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `DESCRIPTION_`    varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `TYPE_`           varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `IMPLEMENTATION_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    PRIMARY KEY (`ID_`) USING BTREE,
    UNIQUE INDEX `ACT_IDX_CHANNEL_DEF_UNIQ`(`KEY_`, `VERSION_`, `TENANT_ID_`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for flw_ev_databasechangelog
-- ----------------------------
DROP TABLE IF EXISTS `flw_ev_databasechangelog`;
CREATE TABLE `flw_ev_databasechangelog`
(
    `ID`            varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
    `AUTHOR`        varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
    `FILENAME`      varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
    `DATEEXECUTED`  datetime(0) NULL,
    `ORDEREXECUTED` int(11) NOT NULL,
    `EXECTYPE`      varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci  NOT NULL,
    `MD5SUM`        varchar(35) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `DESCRIPTION`   varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `COMMENTS`      varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `TAG`           varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `LIQUIBASE`     varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `CONTEXTS`      varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `LABELS`        varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `DEPLOYMENT_ID` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of flw_ev_databasechangelog
-- ----------------------------
INSERT INTO `flw_ev_databasechangelog`
VALUES ('1', 'flowable', 'org/flowable/eventregistry/db/liquibase/flowable-eventregistry-db-changelog.xml',
        '2023-03-09 02:24:52', 1, 'EXECUTED', '8:1b0c48c9cf7945be799d868a2626d687',
        'createTable tableName=FLW_EVENT_DEPLOYMENT; createTable tableName=FLW_EVENT_RESOURCE; createTable tableName=FLW_EVENT_DEFINITION; createIndex indexName=ACT_IDX_EVENT_DEF_UNIQ, tableName=FLW_EVENT_DEFINITION; createTable tableName=FLW_CHANNEL_DEFIN...',
        '', NULL, '4.9.1', NULL, NULL, '8933840337');
INSERT INTO `flw_ev_databasechangelog`
VALUES ('2', 'flowable', 'org/flowable/eventregistry/db/liquibase/flowable-eventregistry-db-changelog.xml',
        '2023-03-09 02:24:52', 2, 'EXECUTED', '8:0ea825feb8e470558f0b5754352b9cda',
        'addColumn tableName=FLW_CHANNEL_DEFINITION; addColumn tableName=FLW_CHANNEL_DEFINITION', '', NULL, '4.9.1',
        NULL, NULL, '8933840337');
INSERT INTO `flw_ev_databasechangelog`
VALUES ('3', 'flowable', 'org/flowable/eventregistry/db/liquibase/flowable-eventregistry-db-changelog.xml',
        '2023-03-09 02:24:52', 3, 'EXECUTED', '8:3c2bb293350b5cbe6504331980c9dcee', 'customChange', '', NULL, '4.9.1',
        NULL, NULL, '8933840337');

-- ----------------------------
-- Table structure for flw_ev_databasechangeloglock
-- ----------------------------
DROP TABLE IF EXISTS `flw_ev_databasechangeloglock`;
CREATE TABLE `flw_ev_databasechangeloglock`
(
    `ID`          int(11) NOT NULL,
    `LOCKED`      bit(1) NOT NULL,
    `LOCKGRANTED` datetime(0) NULL DEFAULT NULL,
    `LOCKEDBY`    varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    PRIMARY KEY (`ID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of flw_ev_databasechangeloglock
-- ----------------------------
INSERT INTO `flw_ev_databasechangeloglock`
VALUES (1, b'0', NULL, NULL);

-- ----------------------------
-- Table structure for flw_event_definition
-- ----------------------------
DROP TABLE IF EXISTS `flw_event_definition`;
CREATE TABLE `flw_event_definition`
(
    `ID_`            varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
    `NAME_`          varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `VERSION_`       int(11) NULL DEFAULT NULL,
    `KEY_`           varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `CATEGORY_`      varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `DEPLOYMENT_ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `TENANT_ID_`     varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `RESOURCE_NAME_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `DESCRIPTION_`   varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    PRIMARY KEY (`ID_`) USING BTREE,
    UNIQUE INDEX `ACT_IDX_EVENT_DEF_UNIQ`(`KEY_`, `VERSION_`, `TENANT_ID_`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for flw_event_deployment
-- ----------------------------
DROP TABLE IF EXISTS `flw_event_deployment`;
CREATE TABLE `flw_event_deployment`
(
    `ID_`                   varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
    `NAME_`                 varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `CATEGORY_`             varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `DEPLOY_TIME_`          datetime(3) NULL DEFAULT NULL,
    `TENANT_ID_`            varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `PARENT_DEPLOYMENT_ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    PRIMARY KEY (`ID_`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for flw_event_resource
-- ----------------------------
DROP TABLE IF EXISTS `flw_event_resource`;
CREATE TABLE `flw_event_resource`
(
    `ID_`             varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
    `NAME_`           varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `DEPLOYMENT_ID_`  varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `RESOURCE_BYTES_` longblob NULL,
    PRIMARY KEY (`ID_`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for flw_ru_batch
-- ----------------------------
DROP TABLE IF EXISTS `flw_ru_batch`;
CREATE TABLE `flw_ru_batch`
(
    `ID_`            varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
    `REV_`           int(11) NULL DEFAULT NULL,
    `TYPE_`          varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
    `SEARCH_KEY_`    varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `SEARCH_KEY2_`   varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `CREATE_TIME_`   datetime(3) NULL,
    `COMPLETE_TIME_` datetime(3) NULL DEFAULT NULL,
    `STATUS_`        varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `BATCH_DOC_ID_`  varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `TENANT_ID_`     varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '',
    PRIMARY KEY (`ID_`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for flw_ru_batch_part
-- ----------------------------
DROP TABLE IF EXISTS `flw_ru_batch_part`;
CREATE TABLE `flw_ru_batch_part`
(
    `ID_`            varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
    `REV_`           int(11) NULL DEFAULT NULL,
    `BATCH_ID_`      varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `TYPE_`          varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
    `SCOPE_ID_`      varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `SUB_SCOPE_ID_`  varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `SCOPE_TYPE_`    varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `SEARCH_KEY_`    varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `SEARCH_KEY2_`   varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `CREATE_TIME_`   datetime(3) NULL,
    `COMPLETE_TIME_` datetime(3) NULL DEFAULT NULL,
    `STATUS_`        varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `RESULT_DOC_ID_` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
    `TENANT_ID_`     varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '',
    PRIMARY KEY (`ID_`) USING BTREE,
    INDEX            `FLW_IDX_BATCH_PART`(`BATCH_ID_`) USING BTREE,
    CONSTRAINT `FLW_FK_BATCH_PART_PARENT` FOREIGN KEY (`BATCH_ID_`) REFERENCES `flw_ru_batch` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for process_category
-- ----------------------------
DROP TABLE IF EXISTS `process_category`;
CREATE TABLE `process_category`
(
    `id`            bigint(22) NOT NULL,
    `category_code` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '流程分类编码',
    `category_name` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '流程分类名称',
    `create_by`     varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建人编码',
    `create_name`   varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建人姓名',
    `create_time`   datetime(0) NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `update_by`     varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '修改人编码',
    `update_name`   varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '修改人姓名',
    `update_time`   datetime(0) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP (0) COMMENT '修改时间',
    `is_delete`     tinyint(1) NULL DEFAULT 0 COMMENT '是否删除 0 未删除 1 已删除',
    `delete_by`     varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '删除人编码',
    `tenant_id`     bigint(22) NOT NULL COMMENT '租户ID',
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of process_category
-- ----------------------------
INSERT INTO `process_category`
VALUES (1, 'CODE', 'NAME', NULL, NULL, '2023-03-03 01:41:00', 'admin', 'admin', '2023-03-19 19:48:23', 0, NULL, 0);
INSERT INTO `process_category`
VALUES (1633332742882574338, '123', '123', 'admin', 'admin', '2023-03-08 13:04:06', 'admin', 'admin',
        '2023-03-08 13:11:17', 1, NULL, 0);
INSERT INTO `process_category`
VALUES (1633334479198613506, '123123123', '123', 'admin', 'admin', '2023-03-08 13:11:01', 'admin', 'admin',
        '2023-03-08 13:11:16', 1, NULL, 1);

SET
FOREIGN_KEY_CHECKS = 1;
