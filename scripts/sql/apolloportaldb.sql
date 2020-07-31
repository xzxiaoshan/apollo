/*
 Navicat Premium Data Transfer

 Source Server         : 192.168.131.130
 Source Server Type    : MySQL
 Source Server Version : 50731
 Source Host           : 192.168.131.130:3306
 Source Schema         : apolloprotaldb

 Target Server Type    : MySQL
 Target Server Version : 50731
 File Encoding         : 65001

 Date: 30/07/2020 11:13:34
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for app
-- ----------------------------
CREATE TABLE `app`  (
  `id` decimal(20, 0) UNSIGNED NOT NULL COMMENT '主键',
  `appid` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'default' COMMENT 'AppID',
  `name` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'default' COMMENT '应用名',
  `orgid` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'default' COMMENT '部门Id',
  `orgname` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'default' COMMENT '部门名字',
  `ownername` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'default' COMMENT 'ownerName',
  `owneremail` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'default' COMMENT 'ownerEmail',
  `isdeleted` int(1) NOT NULL DEFAULT 0 COMMENT '1: deleted, 0: normal',
  `datachange_createdby` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'default' COMMENT '创建人邮箱前缀',
  `datachange_createdtime` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `datachange_lastmodifiedby` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '最后修改人邮箱前缀',
  `datachange_lasttime` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '最后修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `appid`(`appid`(191)) USING BTREE,
  INDEX `datachange_lasttime`(`datachange_lasttime`) USING BTREE,
  INDEX `ix_name`(`name`(191)) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '应用表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of app
-- ----------------------------
INSERT INTO `app` VALUES (1, 'SampleApp', 'Sample App', 'TEST1', '样例部门1', 'apollo', 'apollo@acme.com', 0, 'default', '2020-07-21 02:02:56', 'apollo', '2020-07-21 05:38:07');

-- ----------------------------
-- Table structure for appnamespace
-- ----------------------------
CREATE TABLE `appnamespace`  (
  `id` decimal(20, 0) UNSIGNED NOT NULL COMMENT '自增主键',
  `name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT 'namespace名字，注意，需要全局唯一',
  `appid` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT 'app id',
  `format` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'properties' COMMENT 'namespace的format类型',
  `ispublic` int(1) NOT NULL DEFAULT 0 COMMENT 'namespace是否为公共',
  `commt` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '注释',
  `isdeleted` int(1) NOT NULL DEFAULT 0 COMMENT '1: deleted, 0: normal',
  `datachange_createdby` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建人邮箱前缀',
  `datachange_createdtime` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `datachange_lastmodifiedby` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '最后修改人邮箱前缀',
  `datachange_lasttime` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '最后修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `ix_appid`(`appid`) USING BTREE,
  INDEX `name_appid`(`name`, `appid`) USING BTREE,
  INDEX `datachange_lasttime`(`datachange_lasttime`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '应用namespace定义' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of appnamespace
-- ----------------------------
INSERT INTO `appnamespace` VALUES (1, 'application', 'SampleApp', 'properties', 0, 'default app namespace', 0, '', '2020-07-21 02:02:56', '', '2020-07-21 02:02:56');

-- ----------------------------
-- Table structure for authorities
-- ----------------------------
CREATE TABLE `authorities`  (
  `id` decimal(20, 0) UNSIGNED NOT NULL COMMENT '自增Id',
  `username` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `authority` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of authorities
-- ----------------------------
INSERT INTO `authorities` VALUES (1, 'apollo', 'ROLE_user');

-- ----------------------------
-- Table structure for consumer
-- ----------------------------
CREATE TABLE `consumer`  (
  `id` decimal(20, 0) UNSIGNED NOT NULL COMMENT '自增Id',
  `appid` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'default' COMMENT 'AppID',
  `name` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'default' COMMENT '应用名',
  `orgid` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'default' COMMENT '部门Id',
  `orgname` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'default' COMMENT '部门名字',
  `ownername` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'default' COMMENT 'ownerName',
  `owneremail` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'default' COMMENT 'ownerEmail',
  `isdeleted` int(1) NOT NULL DEFAULT 0 COMMENT '1: deleted, 0: normal',
  `datachange_createdby` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'default' COMMENT '创建人邮箱前缀',
  `datachange_createdtime` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `datachange_lastmodifiedby` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '最后修改人邮箱前缀',
  `datachange_lasttime` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '最后修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `appid`(`appid`(191)) USING BTREE,
  INDEX `datachange_lasttime`(`datachange_lasttime`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '开放API消费者' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for consumeraudit
-- ----------------------------
CREATE TABLE `consumeraudit`  (
  `id` decimal(20, 0) UNSIGNED NOT NULL COMMENT '自增Id',
  `consumerid` decimal(20, 0) UNSIGNED NULL DEFAULT NULL COMMENT 'Consumer Id',
  `uri` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '访问的Uri',
  `method` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '访问的Method',
  `datachange_createdtime` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `datachange_lasttime` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '最后修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `ix_datachange_lasttime`(`datachange_lasttime`) USING BTREE,
  INDEX `ix_consumerid`(`consumerid`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = 'consumer审计表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for consumerrole
-- ----------------------------
CREATE TABLE `consumerrole`  (
  `id` decimal(20, 0) UNSIGNED NOT NULL COMMENT '自增Id',
  `consumerid` decimal(20, 0) UNSIGNED NULL DEFAULT NULL COMMENT 'Consumer Id',
  `roleid` decimal(20, 0) UNSIGNED NULL DEFAULT NULL COMMENT 'Role Id',
  `isdeleted` int(1) NOT NULL DEFAULT 0 COMMENT '1: deleted, 0: normal',
  `datachange_createdby` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建人邮箱前缀',
  `datachange_createdtime` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `datachange_lastmodifiedby` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '最后修改人邮箱前缀',
  `datachange_lasttime` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '最后修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `ix_datachange_lasttime`(`datachange_lasttime`) USING BTREE,
  INDEX `ix_roleid`(`roleid`) USING BTREE,
  INDEX `ix_consumerid_roleid`(`consumerid`, `roleid`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = 'consumer和role的绑定表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for consumertoken
-- ----------------------------
CREATE TABLE `consumertoken`  (
  `id` decimal(20, 0) UNSIGNED NOT NULL COMMENT '自增Id',
  `consumerid` decimal(20, 0) UNSIGNED NULL DEFAULT NULL COMMENT 'ConsumerId',
  `token` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT 'token',
  `expires` datetime(0) NOT NULL DEFAULT '2099-01-01 00:00:00' COMMENT 'token失效时间',
  `isdeleted` int(1) NOT NULL DEFAULT 0 COMMENT '1: deleted, 0: normal',
  `datachange_createdby` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'default' COMMENT '创建人邮箱前缀',
  `datachange_createdtime` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `datachange_lastmodifiedby` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '最后修改人邮箱前缀',
  `datachange_lasttime` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '最后修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `ix_token`(`token`) USING BTREE,
  INDEX `datachange_lasttime`(`datachange_lasttime`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = 'consumer token表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for favorite
-- ----------------------------
CREATE TABLE `favorite`  (
  `id` decimal(20, 0) UNSIGNED NOT NULL COMMENT '主键',
  `userid` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'default' COMMENT '收藏的用户',
  `appid` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'default' COMMENT 'AppID',
  `position` int(32) NOT NULL DEFAULT 10000 COMMENT '收藏顺序',
  `isdeleted` int(1) NOT NULL DEFAULT 0 COMMENT '1: deleted, 0: normal',
  `datachange_createdby` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'default' COMMENT '创建人邮箱前缀',
  `datachange_createdtime` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `datachange_lastmodifiedby` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '最后修改人邮箱前缀',
  `datachange_lasttime` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '最后修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `appid`(`appid`(191)) USING BTREE,
  INDEX `ix_userid`(`userid`) USING BTREE,
  INDEX `datachange_lasttime`(`datachange_lasttime`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '应用收藏表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for permission
-- ----------------------------
CREATE TABLE `permission`  (
  `id` decimal(20, 0) UNSIGNED NOT NULL COMMENT '自增Id',
  `permissiontype` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '权限类型',
  `targetid` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '权限对象类型',
  `isdeleted` int(1) NOT NULL DEFAULT 0 COMMENT '1: deleted, 0: normal',
  `datachange_createdby` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建人邮箱前缀',
  `datachange_createdtime` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `datachange_lastmodifiedby` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '最后修改人邮箱前缀',
  `datachange_lasttime` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '最后修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `ix_targetid_permissiontype`(`targetid`(191), `permissiontype`) USING BTREE,
  INDEX `ix_datachange_lasttime`(`datachange_lasttime`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = 'permission表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of permission
-- ----------------------------
INSERT INTO `permission` VALUES (1, 'CreateCluster', 'SampleApp', 0, '', '2020-07-21 02:02:56', '', '2020-07-21 02:02:56');
INSERT INTO `permission` VALUES (2, 'CreateNamespace', 'SampleApp', 0, '', '2020-07-21 02:02:56', '', '2020-07-21 02:02:56');
INSERT INTO `permission` VALUES (3, 'AssignRole', 'SampleApp', 0, '', '2020-07-21 02:02:56', '', '2020-07-21 02:02:56');
INSERT INTO `permission` VALUES (4, 'ModifyNamespace', 'SampleApp+application', 0, '', '2020-07-21 02:02:56', '', '2020-07-21 02:02:56');
INSERT INTO `permission` VALUES (5, 'ReleaseNamespace', 'SampleApp+application', 0, '', '2020-07-21 02:02:56', '', '2020-07-21 02:02:56');
INSERT INTO `permission` VALUES (6, 'CreateApplication', 'SystemRole', 0, 'apollo', '2020-07-21 15:27:47', 'apollo', '2020-07-21 15:27:47');

-- ----------------------------
-- Table structure for role
-- ----------------------------
CREATE TABLE `role`  (
  `id` decimal(20, 0) UNSIGNED NOT NULL COMMENT '自增Id',
  `rolename` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT 'Role name',
  `isdeleted` int(1) NOT NULL DEFAULT 0 COMMENT '1: deleted, 0: normal',
  `datachange_createdby` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'default' COMMENT '创建人邮箱前缀',
  `datachange_createdtime` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `datachange_lastmodifiedby` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '最后修改人邮箱前缀',
  `datachange_lasttime` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '最后修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `ix_rolename`(`rolename`(191)) USING BTREE,
  INDEX `ix_datachange_lasttime`(`datachange_lasttime`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '角色表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of role
-- ----------------------------
INSERT INTO `role` VALUES (1, 'Master+SampleApp', 0, 'default', '2020-07-21 02:02:56', '', '2020-07-21 02:02:56');
INSERT INTO `role` VALUES (2, 'ModifyNamespace+SampleApp+application', 0, 'default', '2020-07-21 02:02:56', '', '2020-07-21 02:02:56');
INSERT INTO `role` VALUES (3, 'ReleaseNamespace+SampleApp+application', 0, 'default', '2020-07-21 02:02:56', '', '2020-07-21 02:02:56');
INSERT INTO `role` VALUES (4, 'CreateApplication+SystemRole', 0, 'apollo', '2020-07-21 15:27:47', 'apollo', '2020-07-21 15:27:47');

-- ----------------------------
-- Table structure for rolepermission
-- ----------------------------
CREATE TABLE `rolepermission`  (
  `id` decimal(20, 0) UNSIGNED NOT NULL COMMENT '自增Id',
  `roleid` decimal(20, 0) UNSIGNED NULL DEFAULT NULL COMMENT 'Role Id',
  `permissionid` decimal(20, 0) UNSIGNED NULL DEFAULT NULL COMMENT 'Permission Id',
  `isdeleted` int(1) NOT NULL DEFAULT 0 COMMENT '1: deleted, 0: normal',
  `datachange_createdby` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建人邮箱前缀',
  `datachange_createdtime` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `datachange_lastmodifiedby` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '最后修改人邮箱前缀',
  `datachange_lasttime` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '最后修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `ix_datachange_lasttime`(`datachange_lasttime`) USING BTREE,
  INDEX `ix_roleid`(`roleid`) USING BTREE,
  INDEX `ix_permissionid`(`permissionid`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '角色和权限的绑定表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of rolepermission
-- ----------------------------
INSERT INTO `rolepermission` VALUES (1, 1, 1, 0, '', '2020-07-21 02:02:56', '', '2020-07-21 02:02:56');
INSERT INTO `rolepermission` VALUES (2, 1, 2, 0, '', '2020-07-21 02:02:56', '', '2020-07-21 02:02:56');
INSERT INTO `rolepermission` VALUES (3, 1, 3, 0, '', '2020-07-21 02:02:56', '', '2020-07-21 02:02:56');
INSERT INTO `rolepermission` VALUES (4, 2, 4, 0, '', '2020-07-21 02:02:56', '', '2020-07-21 02:02:56');
INSERT INTO `rolepermission` VALUES (5, 3, 5, 0, '', '2020-07-21 02:02:56', '', '2020-07-21 02:02:56');
INSERT INTO `rolepermission` VALUES (6, 4, 6, 0, 'apollo', '2020-07-21 15:27:47', 'apollo', '2020-07-21 15:27:47');

-- ----------------------------
-- Table structure for serverconfig
-- ----------------------------
CREATE TABLE `serverconfig`  (
  `id` decimal(20, 0) UNSIGNED NOT NULL COMMENT '自增Id',
  `key_col` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'default' COMMENT '配置项Key',
  `value_col` varchar(2048) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'default' COMMENT '配置项值',
  `commt` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '注释',
  `isdeleted` int(1) NOT NULL DEFAULT 0 COMMENT '1: deleted, 0: normal',
  `datachange_createdby` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'default' COMMENT '创建人邮箱前缀',
  `datachange_createdtime` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `datachange_lastmodifiedby` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '最后修改人邮箱前缀',
  `datachange_lasttime` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '最后修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `ix_key`(`key_col`) USING BTREE,
  INDEX `datachange_lasttime`(`datachange_lasttime`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '配置服务自身配置' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of serverconfig
-- ----------------------------
INSERT INTO `serverconfig` VALUES (1, 'apollo.portal.envs', 'dev', '可支持的环境列表', 0, 'default', '2020-07-21 02:02:56', '', '2020-07-21 02:02:56');
INSERT INTO `serverconfig` VALUES (2, 'organizations', '[{\"orgId\":\"dept01\",\"orgName\":\"部门1\"},{\"orgId\":\"dept02\",\"orgName\":\"部门2\"}]', '部门列表', 0, 'default', '2020-07-21 02:02:56', '', '2020-07-21 02:02:56');
INSERT INTO `serverconfig` VALUES (3, 'superAdmin', 'apollo', 'Portal超级管理员', 0, 'default', '2020-07-21 02:02:56', '', '2020-07-21 02:02:56');
INSERT INTO `serverconfig` VALUES (4, 'api.readTimeout', '10000', 'http接口read timeout', 0, 'default', '2020-07-21 02:02:56', '', '2020-07-21 02:02:56');
INSERT INTO `serverconfig` VALUES (5, 'consumer.token.salt', 'someSalt', 'consumer token salt', 0, 'default', '2020-07-21 02:02:56', '', '2020-07-21 02:02:56');
INSERT INTO `serverconfig` VALUES (6, 'admin.createPrivateNamespace.switch', 'true', '是否允许项目管理员创建私有namespace', 0, 'default', '2020-07-21 02:02:56', '', '2020-07-21 02:02:56');
INSERT INTO `serverconfig` VALUES (7, 'configView.memberOnly.envs', 'dev', '只对项目成员显示配置信息的环境列表，多个env以英文逗号分隔', 0, 'default', '2020-07-21 02:02:56', '', '2020-07-21 02:02:56');

-- ----------------------------
-- Table structure for sys_id_machine
-- ----------------------------
CREATE TABLE `sys_id_machine`  (
  `machine_ip` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '主机IP',
  `machine_id` decimal(11, 0) NOT NULL COMMENT '主机IP对应的机器码',
  `add_time` datetime(0) NOT NULL COMMENT '创建时间',
  `heart_last_time` datetime(0) NOT NULL COMMENT '最后一次心跳时间',
  UNIQUE INDEX `sys_id_machine_indexs_ip`(`machine_ip`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_id_machine
-- ----------------------------
INSERT INTO `sys_id_machine` VALUES ('192.168.52.1', 1, '2020-07-29 17:45:26', '2020-07-30 11:12:16');

-- ----------------------------
-- Table structure for userrole
-- ----------------------------
CREATE TABLE `userrole`  (
  `id` decimal(20, 0) UNSIGNED NOT NULL COMMENT '自增Id',
  `userid` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '用户身份标识',
  `roleid` decimal(20, 0) UNSIGNED NULL DEFAULT NULL COMMENT 'Role Id',
  `isdeleted` int(1) NOT NULL DEFAULT 0 COMMENT '1: deleted, 0: normal',
  `datachange_createdby` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建人邮箱前缀',
  `datachange_createdtime` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `datachange_lastmodifiedby` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '最后修改人邮箱前缀',
  `datachange_lasttime` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '最后修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `ix_datachange_lasttime`(`datachange_lasttime`) USING BTREE,
  INDEX `ix_roleid`(`roleid`) USING BTREE,
  INDEX `ix_userid_roleid`(`userid`, `roleid`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户和role的绑定表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of userrole
-- ----------------------------
INSERT INTO `userrole` VALUES (1, 'apollo', 1, 0, '', '2020-07-21 02:02:56', '', '2020-07-21 02:02:56');
INSERT INTO `userrole` VALUES (2, 'apollo', 2, 0, '', '2020-07-21 02:02:56', '', '2020-07-21 02:02:56');
INSERT INTO `userrole` VALUES (3, 'apollo', 3, 0, '', '2020-07-21 02:02:56', '', '2020-07-21 02:02:56');

-- ----------------------------
-- Table structure for users
-- ----------------------------
CREATE TABLE `users`  (
  `id` decimal(20, 0) UNSIGNED NOT NULL COMMENT '自增Id',
  `username` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'default' COMMENT '用户名',
  `password` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'default' COMMENT '密码',
  `email` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'default' COMMENT '邮箱地址',
  `enabled` tinyint(4) NULL DEFAULT NULL COMMENT '是否有效',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES (1, 'apollo', '$2a$10$7r20uS.BQ9uBpf3Baj3uQOZvMVvB1RN3PYoKE94gtz2.WAOuiiwXS', 'apollo@acme.com', 1);

SET FOREIGN_KEY_CHECKS = 1;
