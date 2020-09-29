# delta schema to upgrade apollo config db from v1.6.2 to v1.6.2.1

Use ApolloPortalDB;

ALTER TABLE `serverconfig` CHANGE `key` `key_col` varchar(64) NOT NULL COMMENT '配置项Key';
ALTER TABLE `serverconfig` CHANGE `value` `value_col` varchar(2048) NOT NULL COMMENT '配置项值';
ALTER TABLE `serverconfig` CHANGE `comment` `commt` varchar(1024) NOT NULL COMMENT '注释';