/*
 Navicat Premium Data Transfer

 Source Server         : 192.168.131.130
 Source Server Type    : MySQL
 Source Server Version : 50731
 Source Host           : 192.168.131.130:3306
 Source Schema         : apolloconfigdb

 Target Server Type    : MySQL
 Target Server Version : 50731
 File Encoding         : 65001

 Date: 30/07/2020 11:13:26
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for accesskey
-- ----------------------------
CREATE TABLE `accesskey`  (
  `id` decimal(20, 0) UNSIGNED NOT NULL COMMENT '自增主键',
  `appid` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'default' COMMENT 'AppID',
  `secret` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT 'Secret',
  `isenabled` int(1) NOT NULL DEFAULT 0 COMMENT '启用标志：1: enabled, 0: disabled',
  `isdeleted` int(1) NOT NULL DEFAULT 0 COMMENT '删除标志：1: deleted, 0: normal',
  `datachange_createdby` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'default' COMMENT '创建人邮箱前缀',
  `datachange_createdtime` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `datachange_lastmodifiedby` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '最后修改人邮箱前缀',
  `datachange_lasttime` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '最后修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `appid`(`appid`(191)) USING BTREE,
  INDEX `datachange_lasttime`(`datachange_lasttime`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '访问密钥' ROW_FORMAT = Dynamic;

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
INSERT INTO `app` VALUES (1, 'SampleApp', 'Sample App', 'TEST1', '样例部门1', 'apollo', 'apollo@acme.com', 0, 'default', '2020-07-21 02:02:46', 'apollo', '2020-07-21 05:38:07');

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
INSERT INTO `appnamespace` VALUES (1, 'application', 'SampleApp', 'properties', 0, 'default app namespace', 0, '', '2020-07-21 02:02:46', '', '2020-07-21 02:02:46');

-- ----------------------------
-- Table structure for audit_table
-- ----------------------------
CREATE TABLE `audit_table`  (
  `id` decimal(20, 0) UNSIGNED NOT NULL COMMENT '主键',
  `entityname` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'default' COMMENT '表名',
  `entityid` decimal(20, 0) UNSIGNED NULL DEFAULT NULL COMMENT '记录ID',
  `opname` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'default' COMMENT '操作类型',
  `commt` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  `isdeleted` int(1) NOT NULL DEFAULT 0 COMMENT '1: deleted, 0: normal',
  `datachange_createdby` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'default' COMMENT '创建人邮箱前缀',
  `datachange_createdtime` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `datachange_lastmodifiedby` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '最后修改人邮箱前缀',
  `datachange_lasttime` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '最后修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `datachange_lasttime`(`datachange_lasttime`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '日志审计表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of audit_table
-- ----------------------------
INSERT INTO `audit_table` VALUES (1, 'Item', 2, 'INSERT', NULL, 0, 'apollo', '2020-07-21 05:32:23', NULL, '2020-07-21 05:32:23');
INSERT INTO `audit_table` VALUES (2, 'Release', 2, 'INSERT', NULL, 0, 'apollo', '2020-07-21 05:32:35', NULL, '2020-07-21 05:32:35');
INSERT INTO `audit_table` VALUES (3, 'ReleaseHistory', 2, 'INSERT', NULL, 0, 'apollo', '2020-07-21 05:32:36', NULL, '2020-07-21 05:32:36');
INSERT INTO `audit_table` VALUES (4, 'Item', 2, 'UPDATE', NULL, 0, 'apollo', '2020-07-21 05:35:06', NULL, '2020-07-21 05:35:06');
INSERT INTO `audit_table` VALUES (5, 'Release', 3, 'INSERT', NULL, 0, 'apollo', '2020-07-21 05:35:09', NULL, '2020-07-21 05:35:09');
INSERT INTO `audit_table` VALUES (6, 'ReleaseHistory', 3, 'INSERT', NULL, 0, 'apollo', '2020-07-21 05:35:09', NULL, '2020-07-21 05:35:09');
INSERT INTO `audit_table` VALUES (7, 'ReleaseHistory', 4, 'INSERT', NULL, 0, 'apollo', '2020-07-21 05:35:58', NULL, '2020-07-21 05:35:58');
INSERT INTO `audit_table` VALUES (8, 'Release', 4, 'INSERT', NULL, 0, 'apollo', '2020-07-21 05:36:10', NULL, '2020-07-21 05:36:10');
INSERT INTO `audit_table` VALUES (9, 'ReleaseHistory', 5, 'INSERT', NULL, 0, 'apollo', '2020-07-21 05:36:10', NULL, '2020-07-21 05:36:10');
INSERT INTO `audit_table` VALUES (10, 'ReleaseHistory', 6, 'INSERT', NULL, 0, 'apollo', '2020-07-21 05:37:27', NULL, '2020-07-21 05:37:27');
INSERT INTO `audit_table` VALUES (11, 'Release', 5, 'INSERT', NULL, 0, 'apollo', '2020-07-21 05:37:37', NULL, '2020-07-21 05:37:37');
INSERT INTO `audit_table` VALUES (12, 'ReleaseHistory', 7, 'INSERT', NULL, 0, 'apollo', '2020-07-21 05:37:37', NULL, '2020-07-21 05:37:37');
INSERT INTO `audit_table` VALUES (13, 'App', 1, 'UPDATE', NULL, 0, 'apollo', '2020-07-21 05:38:07', NULL, '2020-07-21 05:38:07');
INSERT INTO `audit_table` VALUES (14, 'Item', 1, 'UPDATE', NULL, 0, 'apollo', '2020-07-21 05:38:54', NULL, '2020-07-21 05:38:54');
INSERT INTO `audit_table` VALUES (15, 'Item', 1, 'UPDATE', NULL, 0, 'apollo', '2020-07-21 05:39:16', NULL, '2020-07-21 05:39:16');
INSERT INTO `audit_table` VALUES (16, 'Release', 6, 'INSERT', NULL, 0, 'apollo', '2020-07-21 05:39:18', NULL, '2020-07-21 05:39:18');
INSERT INTO `audit_table` VALUES (17, 'ReleaseHistory', 8, 'INSERT', NULL, 0, 'apollo', '2020-07-21 05:39:18', NULL, '2020-07-21 05:39:18');
INSERT INTO `audit_table` VALUES (208646267176226816, 'Item', 1, 'UPDATE', NULL, 0, 'apollo', '2020-07-29 18:05:47', NULL, '2020-07-29 18:05:47');
INSERT INTO `audit_table` VALUES (208646466527301632, 'Item', 1, 'UPDATE', NULL, 0, 'apollo', '2020-07-29 18:06:34', NULL, '2020-07-29 18:06:34');
INSERT INTO `audit_table` VALUES (208648685876154368, 'Item', 1, 'UPDATE', NULL, 0, 'apollo', '2020-07-29 18:15:23', NULL, '2020-07-29 18:15:23');
INSERT INTO `audit_table` VALUES (208904849851420672, 'Release', 208904849813671936, 'INSERT', NULL, 0, 'apollo', '2020-07-30 11:13:17', NULL, '2020-07-30 11:13:17');
INSERT INTO `audit_table` VALUES (208904849956278273, 'ReleaseHistory', 208904849956278272, 'INSERT', NULL, 0, 'apollo', '2020-07-30 11:13:17', NULL, '2020-07-30 11:13:17');

-- ----------------------------
-- Table structure for cluster_table
-- ----------------------------
CREATE TABLE `cluster_table`  (
  `id` decimal(20, 0) UNSIGNED NOT NULL COMMENT '自增主键',
  `name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '集群名字',
  `appid` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT 'App id',
  `parentclusterid` decimal(20, 0) UNSIGNED NOT NULL DEFAULT 0 COMMENT '父cluster',
  `isdeleted` int(1) NOT NULL DEFAULT 0 COMMENT '1: deleted, 0: normal',
  `datachange_createdby` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建人邮箱前缀',
  `datachange_createdtime` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `datachange_lastmodifiedby` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '最后修改人邮箱前缀',
  `datachange_lasttime` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '最后修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `ix_appid_name`(`appid`, `name`) USING BTREE,
  INDEX `ix_parentclusterid`(`parentclusterid`) USING BTREE,
  INDEX `datachange_lasttime`(`datachange_lasttime`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '集群' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of cluster_table
-- ----------------------------
INSERT INTO `cluster_table` VALUES (1, 'default', 'SampleApp', 0, 0, '', '2020-07-21 02:02:46', '', '2020-07-21 02:02:46');

-- ----------------------------
-- Table structure for commit
-- ----------------------------
CREATE TABLE `commit`  (
  `id` decimal(20, 0) UNSIGNED NOT NULL COMMENT '主键',
  `changesets` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '修改变更集',
  `appid` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'default' COMMENT 'AppID',
  `clustername` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'default' COMMENT 'ClusterName',
  `namespacename` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'default' COMMENT 'namespaceName',
  `commt` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  `isdeleted` int(1) NOT NULL DEFAULT 0 COMMENT '1: deleted, 0: normal',
  `datachange_createdby` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'default' COMMENT '创建人邮箱前缀',
  `datachange_createdtime` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `datachange_lastmodifiedby` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '最后修改人邮箱前缀',
  `datachange_lasttime` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '最后修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `datachange_lasttime`(`datachange_lasttime`) USING BTREE,
  INDEX `appid`(`appid`(191)) USING BTREE,
  INDEX `clustername`(`clustername`(191)) USING BTREE,
  INDEX `namespacename`(`namespacename`(191)) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = 'commit 历史表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of commit
-- ----------------------------
INSERT INTO `commit` VALUES (208648685964234752, '{\"createItems\":[],\"updateItems\":[{\"oldItem\":{\"namespaceId\":1,\"key\":\"timeout\",\"value\":\"200\",\"comment\":\"sample timeout配置\",\"lineNum\":1,\"id\":1,\"isDeleted\":false,\"dataChangeCreatedBy\":\"default\",\"dataChangeCreatedTime\":\"2020-07-21 02:02:46\",\"dataChangeLastModifiedBy\":\"apollo\",\"dataChangeLastModifiedTime\":\"2020-07-21 05:39:16\"},\"newItem\":{\"namespaceId\":1,\"key\":\"timeout\",\"value\":\"20000\",\"comment\":\"sample timeout配置\",\"lineNum\":1,\"id\":1,\"isDeleted\":false,\"dataChangeCreatedBy\":\"default\",\"dataChangeCreatedTime\":\"2020-07-21 02:02:46\",\"dataChangeLastModifiedBy\":\"apollo\",\"dataChangeLastModifiedTime\":\"2020-07-29 18:15:23\"}}],\"deleteItems\":[]}', 'SampleApp', 'default', 'application', NULL, 0, 'apollo', '2020-07-29 18:15:23', 'apollo', '2020-07-29 18:15:23');

-- ----------------------------
-- Table structure for grayreleaserule
-- ----------------------------
CREATE TABLE `grayreleaserule`  (
  `id` decimal(20, 0) UNSIGNED NOT NULL COMMENT '主键',
  `appid` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'default' COMMENT 'AppID',
  `clustername` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'default' COMMENT 'Cluster Name',
  `namespacename` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'default' COMMENT 'Namespace Name',
  `branchname` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'default' COMMENT 'branch name',
  `rules` varchar(16000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '[]' COMMENT '灰度规则',
  `releaseid` decimal(20, 0) UNSIGNED NOT NULL DEFAULT 0 COMMENT '灰度对应的release',
  `branchstatus` tinyint(2) NULL DEFAULT 1 COMMENT '灰度分支状态: 0:删除分支,1:正在使用的规则 2：全量发布',
  `isdeleted` int(1) NOT NULL DEFAULT 0 COMMENT '1: deleted, 0: normal',
  `datachange_createdby` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'default' COMMENT '创建人邮箱前缀',
  `datachange_createdtime` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `datachange_lastmodifiedby` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '最后修改人邮箱前缀',
  `datachange_lasttime` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '最后修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `datachange_lasttime`(`datachange_lasttime`) USING BTREE,
  INDEX `ix_namespace`(`appid`, `clustername`, `namespacename`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '灰度规则表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for instance
-- ----------------------------
CREATE TABLE `instance`  (
  `id` decimal(20, 0) UNSIGNED NOT NULL COMMENT '自增Id',
  `appid` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'default' COMMENT 'AppID',
  `clustername` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'default' COMMENT 'ClusterName',
  `datacenter` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'default' COMMENT 'Data Center Name',
  `ip` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT 'instance ip',
  `datachange_createdtime` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `datachange_lasttime` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '最后修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `ix_unique_key`(`appid`, `clustername`, `ip`, `datacenter`) USING BTREE,
  INDEX `ix_ip`(`ip`) USING BTREE,
  INDEX `ix_datachange_lasttime`(`datachange_lasttime`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '使用配置的应用实例' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for instanceconfig
-- ----------------------------
CREATE TABLE `instanceconfig`  (
  `id` decimal(20, 0) UNSIGNED NOT NULL COMMENT '自增Id',
  `instanceid` decimal(20, 0) UNSIGNED NULL DEFAULT NULL COMMENT 'Instance Id',
  `configappid` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'default' COMMENT 'Config App Id',
  `configclustername` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'default' COMMENT 'Config Cluster Name',
  `confignamespacename` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'default' COMMENT 'Config Namespace Name',
  `releasekey` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '发布的Key',
  `releasedeliverytime` timestamp(0) NULL DEFAULT NULL COMMENT '配置获取时间',
  `datachange_createdtime` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `datachange_lasttime` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '最后修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `ix_unique_key`(`instanceid`, `configappid`, `confignamespacename`) USING BTREE,
  INDEX `ix_releasekey`(`releasekey`) USING BTREE,
  INDEX `ix_datachange_lasttime`(`datachange_lasttime`) USING BTREE,
  INDEX `ix_valid_namespace`(`configappid`, `configclustername`, `confignamespacename`, `datachange_lasttime`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '应用实例的配置信息' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for item
-- ----------------------------
CREATE TABLE `item`  (
  `id` decimal(20, 0) UNSIGNED NOT NULL COMMENT '自增Id',
  `namespaceid` decimal(20, 0) UNSIGNED NOT NULL DEFAULT 0 COMMENT '集群NamespaceId',
  `key_col` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'default' COMMENT '配置项Key',
  `value_col` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '配置项值',
  `commt` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '注释',
  `linenum` int(10) UNSIGNED NULL DEFAULT 0 COMMENT '行号',
  `isdeleted` int(1) NOT NULL DEFAULT 0 COMMENT '1: deleted, 0: normal',
  `datachange_createdby` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'default' COMMENT '创建人邮箱前缀',
  `datachange_createdtime` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `datachange_lastmodifiedby` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '最后修改人邮箱前缀',
  `datachange_lasttime` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '最后修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `ix_groupid`(`namespaceid`) USING BTREE,
  INDEX `datachange_lasttime`(`datachange_lasttime`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '配置项目' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of item
-- ----------------------------
INSERT INTO `item` VALUES (1, 1, 'timeout', '20000', 'sample timeout配置', 1, 0, 'default', '2020-07-21 02:02:46', 'apollo', '2020-07-29 18:15:23');

-- ----------------------------
-- Table structure for namespace
-- ----------------------------
CREATE TABLE `namespace`  (
  `id` decimal(20, 0) UNSIGNED NOT NULL COMMENT '自增主键',
  `appid` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'default' COMMENT 'AppID',
  `clustername` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'default' COMMENT 'Cluster Name',
  `namespacename` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'default' COMMENT 'Namespace Name',
  `isdeleted` int(1) NOT NULL DEFAULT 0 COMMENT '1: deleted, 0: normal',
  `datachange_createdby` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'default' COMMENT '创建人邮箱前缀',
  `datachange_createdtime` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `datachange_lastmodifiedby` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '最后修改人邮箱前缀',
  `datachange_lasttime` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '最后修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `appid_clustername_namespacename`(`appid`(191), `clustername`(191), `namespacename`(191)) USING BTREE,
  INDEX `datachange_lasttime`(`datachange_lasttime`) USING BTREE,
  INDEX `ix_namespacename`(`namespacename`(191)) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '命名空间' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of namespace
-- ----------------------------
INSERT INTO `namespace` VALUES (1, 'SampleApp', 'default', 'application', 0, 'default', '2020-07-21 02:02:46', '', '2020-07-21 02:02:46');

-- ----------------------------
-- Table structure for namespacelock
-- ----------------------------
CREATE TABLE `namespacelock`  (
  `id` decimal(20, 0) UNSIGNED NOT NULL COMMENT '自增id',
  `namespaceid` decimal(20, 0) UNSIGNED NOT NULL DEFAULT 0 COMMENT '集群NamespaceId',
  `isdeleted` int(1) NOT NULL DEFAULT 0 COMMENT '软删除',
  `datachange_createdby` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'default' COMMENT '创建人邮箱前缀',
  `datachange_createdtime` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `datachange_lastmodifiedby` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'default' COMMENT '最后修改人邮箱前缀',
  `datachange_lasttime` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '最后修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `ix_namespaceid`(`namespaceid`) USING BTREE,
  INDEX `datachange_lasttime`(`datachange_lasttime`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = 'namespace的编辑锁' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for release_table
-- ----------------------------
CREATE TABLE `release_table`  (
  `id` decimal(20, 0) UNSIGNED NOT NULL COMMENT '自增主键',
  `releasekey` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '发布的Key',
  `name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'default' COMMENT '发布名字',
  `commt` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '发布说明',
  `appid` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'default' COMMENT 'AppID',
  `clustername` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'default' COMMENT 'ClusterName',
  `namespacename` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'default' COMMENT 'namespaceName',
  `configurations` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '发布配置',
  `isabandoned` int(1) NOT NULL DEFAULT 0 COMMENT '是否废弃',
  `isdeleted` int(1) NOT NULL DEFAULT 0 COMMENT '1: deleted, 0: normal',
  `datachange_createdby` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'default' COMMENT '创建人邮箱前缀',
  `datachange_createdtime` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `datachange_lastmodifiedby` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '最后修改人邮箱前缀',
  `datachange_lasttime` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '最后修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `appid_clustername_groupname`(`appid`(191), `clustername`(191), `namespacename`(191)) USING BTREE,
  INDEX `datachange_lasttime`(`datachange_lasttime`) USING BTREE,
  INDEX `ix_releasekey`(`releasekey`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '发布' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of release_table
-- ----------------------------
INSERT INTO `release_table` VALUES (1, '20161009155425-d3a0749c6e20bc15', '20161009155424-release', 'Sample发布', 'SampleApp', 'default', 'application', '{\"timeout\":\"100\"}', 0, 0, 'default', '2020-07-21 02:02:46', '', '2020-07-21 02:02:46');
INSERT INTO `release_table` VALUES (208904849813671936, '20200730111317-1dc5c619884fd6a2', '20200730111304-release', '发布timeout', 'SampleApp', 'default', 'application', '{\"timeout\":\"20000\"}', 0, 0, 'apollo', '2020-07-30 11:13:17', 'apollo', '2020-07-30 11:13:17');

-- ----------------------------
-- Table structure for releasehistory
-- ----------------------------
CREATE TABLE `releasehistory`  (
  `id` decimal(20, 0) UNSIGNED NOT NULL COMMENT '自增Id',
  `appid` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'default' COMMENT 'AppID',
  `clustername` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'default' COMMENT 'ClusterName',
  `namespacename` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'default' COMMENT 'namespaceName',
  `branchname` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'default' COMMENT '发布分支名',
  `releaseid` decimal(20, 0) UNSIGNED NOT NULL DEFAULT 0 COMMENT '关联的Release Id',
  `previousreleaseid` decimal(20, 0) UNSIGNED NOT NULL DEFAULT 0 COMMENT '前一次发布的ReleaseId',
  `operation` tinyint(3) UNSIGNED NOT NULL DEFAULT 0 COMMENT '发布类型，0: 普通发布，1: 回滚，2: 灰度发布，3: 灰度规则更新，4: 灰度合并回主分支发布，5: 主分支发布灰度自动发布，6: 主分支回滚灰度自动发布，7: 放弃灰度',
  `operationcontext` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '发布上下文信息',
  `isdeleted` int(1) NOT NULL DEFAULT 0 COMMENT '1: deleted, 0: normal',
  `datachange_createdby` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'default' COMMENT '创建人邮箱前缀',
  `datachange_createdtime` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `datachange_lastmodifiedby` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '最后修改人邮箱前缀',
  `datachange_lasttime` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '最后修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `ix_namespace`(`appid`, `clustername`, `namespacename`, `branchname`) USING BTREE,
  INDEX `ix_releaseid`(`releaseid`) USING BTREE,
  INDEX `ix_datachange_lasttime`(`datachange_lasttime`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '发布历史' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of releasehistory
-- ----------------------------
INSERT INTO `releasehistory` VALUES (1, 'SampleApp', 'default', 'application', 'default', 1, 0, 0, '{}', 0, 'apollo', '2020-07-21 02:02:46', 'apollo', '2020-07-21 02:02:46');
INSERT INTO `releasehistory` VALUES (2, 'SampleApp', 'default', 'application', 'default', 2, 1, 0, '{\"isEmergencyPublish\":false}', 0, 'apollo', '2020-07-21 05:32:36', 'apollo', '2020-07-21 05:32:36');
INSERT INTO `releasehistory` VALUES (3, 'SampleApp', 'default', 'application', 'default', 3, 2, 0, '{\"isEmergencyPublish\":false}', 0, 'apollo', '2020-07-21 05:35:09', 'apollo', '2020-07-21 05:35:09');
INSERT INTO `releasehistory` VALUES (4, 'SampleApp', 'default', 'application', 'default', 2, 3, 1, '{}', 0, 'apollo', '2020-07-21 05:35:58', 'apollo', '2020-07-21 05:35:58');
INSERT INTO `releasehistory` VALUES (5, 'SampleApp', 'default', 'application', 'default', 4, 2, 0, '{\"isEmergencyPublish\":false}', 0, 'apollo', '2020-07-21 05:36:10', 'apollo', '2020-07-21 05:36:10');
INSERT INTO `releasehistory` VALUES (6, 'SampleApp', 'default', 'application', 'default', 1, 4, 1, '{}', 0, 'apollo', '2020-07-21 05:37:27', 'apollo', '2020-07-21 05:37:27');
INSERT INTO `releasehistory` VALUES (7, 'SampleApp', 'default', 'application', 'default', 5, 1, 0, '{\"isEmergencyPublish\":false}', 0, 'apollo', '2020-07-21 05:37:37', 'apollo', '2020-07-21 05:37:37');
INSERT INTO `releasehistory` VALUES (8, 'SampleApp', 'default', 'application', 'default', 6, 5, 0, '{\"isEmergencyPublish\":false}', 0, 'apollo', '2020-07-21 05:39:18', 'apollo', '2020-07-21 05:39:18');
INSERT INTO `releasehistory` VALUES (208904849956278272, 'SampleApp', 'default', 'application', 'default', 208904849813671936, 1, 0, '{\"isEmergencyPublish\":false}', 0, 'apollo', '2020-07-30 11:13:17', 'apollo', '2020-07-30 11:13:17');

-- ----------------------------
-- Table structure for releasemessage
-- ----------------------------
CREATE TABLE `releasemessage`  (
  `id` decimal(20, 0) UNSIGNED NOT NULL COMMENT '自增主键',
  `message` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '发布的消息内容',
  `datachange_lasttime` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '最后修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `datachange_lasttime`(`datachange_lasttime`) USING BTREE,
  INDEX `ix_message`(`message`(191)) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '发布消息' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of releasemessage
-- ----------------------------
INSERT INTO `releasemessage` VALUES (208904849981444096, 'SampleApp+default+application', '2020-07-30 11:13:18');

-- ----------------------------
-- Table structure for serverconfig
-- ----------------------------
CREATE TABLE `serverconfig`  (
  `id` decimal(20, 0) UNSIGNED NOT NULL COMMENT '自增Id',
  `key_col` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'default' COMMENT '配置项Key',
  `cluster_col` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'default' COMMENT '配置对应的集群，default为不针对特定的集群',
  `value_col` varchar(2048) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'default' COMMENT '配置项值',
  `commt` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '注释',
  `isdeleted` int(1) NOT NULL DEFAULT 0 COMMENT '1: deleted, 0: normal',
  `datachange_createdby` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'default' COMMENT '创建人邮箱前缀',
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
INSERT INTO `serverconfig` VALUES (1, 'eureka.service.url', 'default', 'http://localhost:6166/eureka/', 'Eureka服务Url，多个service以英文逗号分隔', 0, 'default', '2020-07-21 02:02:46', '', '2020-07-21 02:02:46');
INSERT INTO `serverconfig` VALUES (2, 'namespace.lock.switch', 'default', 'false', '一次发布只能有一个人修改开关', 0, 'default', '2020-07-21 02:02:46', '', '2020-07-21 02:02:46');
INSERT INTO `serverconfig` VALUES (3, 'item.value.length.limit', 'default', '20000', 'item value最大长度限制', 0, 'default', '2020-07-21 02:02:46', '', '2020-07-21 02:02:46');
INSERT INTO `serverconfig` VALUES (4, 'config-service.cache.enabled', 'default', 'false', 'ConfigService是否开启缓存，开启后能提高性能，但是会增大内存消耗！', 0, 'default', '2020-07-21 02:02:46', '', '2020-07-21 02:02:46');
INSERT INTO `serverconfig` VALUES (5, 'item.key.length.limit', 'default', '128', 'item key 最大长度限制', 0, 'default', '2020-07-21 02:02:46', '', '2020-07-21 02:02:46');

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
INSERT INTO `sys_id_machine` VALUES ('192.168.52.1', 1, '2020-07-29 17:06:17', '2020-07-30 11:13:22');

SET FOREIGN_KEY_CHECKS = 1;
