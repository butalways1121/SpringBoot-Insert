/*
 Navicat Premium Data Transfer

 Source Server         : test
 Source Server Type    : MySQL
 Source Server Version : 80016
 Source Host           : localhost:3306
 Source Schema         : test

 Target Server Type    : MySQL
 Target Server Version : 80016
 File Encoding         : 65001

 Date: 09/08/2019 09:32:56
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for test
-- ----------------------------
DROP TABLE IF EXISTS `test`;
CREATE TABLE `test`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of test
-- ----------------------------
INSERT INTO `test` VALUES (1, '张三三');
INSERT INTO `test` VALUES (2, '张三三');
INSERT INTO `test` VALUES (3, '张三三');
INSERT INTO `test` VALUES (4, '张三三');
INSERT INTO `test` VALUES (5, '李四四');
INSERT INTO `test` VALUES (6, '李四四');
INSERT INTO `test` VALUES (7, '李四四');
INSERT INTO `test` VALUES (8, '李四四');

SET FOREIGN_KEY_CHECKS = 1;
