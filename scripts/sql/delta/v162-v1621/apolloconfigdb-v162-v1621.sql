# delta schema to upgrade apollo config db from v1.6.2 to v1.6.2.1

Use ApolloConfigDB;


-- ----------------------------
-- Table structure for sys_id_machine
-- ----------------------------
DROP TABLE IF EXISTS `sys_id_machine`;
CREATE TABLE `sys_id_machine`  (
  `machine_ip` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '主机IP',
  `machine_id` decimal(11, 0) NOT NULL COMMENT '主机IP对应的机器码',
  `add_time` datetime(0) NOT NULL COMMENT '创建时间',
  `heart_last_time` datetime(0) NOT NULL COMMENT '最后一次心跳时间',
  UNIQUE INDEX `sys_id_machine_indexs_ip`(`machine_ip`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;



ALTER TABLE `appnamespace` CHANGE `comment` `commt` varchar(64) NULL  DEFAULT '' COMMENT '注释';
ALTER TABLE `audit` CHANGE `comment` `commt` varchar(500) NULL DEFAULT NULL COMMENT '备注';
ALTER TABLE `commit` CHANGE `comment` `commt` varchar(500)  NULL DEFAULT NULL COMMENT '备注';
ALTER TABLE `item` CHANGE `key` `key_col` varchar(128) NOT NULL DEFAULT 'default' COMMENT '配置项Key';
ALTER TABLE `item` CHANGE `value` `value_col` longtext  NULL COMMENT '配置项值';
ALTER TABLE `item` CHANGE `comment` `commt` varchar(1024) NULL DEFAULT '' COMMENT '注释';
ALTER TABLE `release` CHANGE `comment` `commt` varchar(256) NULL DEFAULT NULL COMMENT '发布说明';
ALTER TABLE `serverconfig` CHANGE `cluster` `cluster_col` varchar(32) NOT NULL DEFAULT 'default' COMMENT '配置对应的集群，default为不针对特定的集群';
ALTER TABLE `serverconfig` CHANGE `key` `key_col` NOT NULL DEFAULT 'default' COMMENT '配置项Key';
ALTER TABLE `serverconfig` CHANGE `value` `value_col` varchar(2048) NULL DEFAULT 'default' COMMENT '配置项值';
ALTER TABLE `serverconfig` CHANGE `comment` `commt` varchar(1024) NULL DEFAULT '' COMMENT '注释';

RENAME TABLE `cluster` TO `cluster_table`;
RENAME TABLE `audit` TO `audit_table`;
RENAME TABLE `release` TO `release_table`;