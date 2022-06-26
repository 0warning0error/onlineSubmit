SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for distribute
-- ----------------------------
DROP TABLE IF EXISTS `distribute`;
CREATE TABLE `distribute`  (
  `distribute_id` int(11) NOT NULL AUTO_INCREMENT,
  `distribute_idstring` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `distribute_num` int(11) NOT NULL,
  PRIMARY KEY (`distribute_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 35 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of distribute
-- ----------------------------
INSERT INTO `distribute` VALUES (13, '2,3,4', 3);
INSERT INTO `distribute` VALUES (14, '6,7', 2);
INSERT INTO `distribute` VALUES (15, '1,2,3,4,5,6,7,8,9,10', 10);
INSERT INTO `distribute` VALUES (16, '11,13,14', 3);
INSERT INTO `distribute` VALUES (17, '15,16,17', 3);
INSERT INTO `distribute` VALUES (18, '1,2,3,4', 4);
INSERT INTO `distribute` VALUES (19, '1,2,3', 3);
INSERT INTO `distribute` VALUES (20, '25,11,13,14,15,16,17,18,19,20,21', 11);
INSERT INTO `distribute` VALUES (21, '1,2,3', 3);
INSERT INTO `distribute` VALUES (22, '11', 1);
INSERT INTO `distribute` VALUES (23, '16', 1);
INSERT INTO `distribute` VALUES (24, '19', 1);
INSERT INTO `distribute` VALUES (25, '20', 1);
INSERT INTO `distribute` VALUES (26, '28', 1);
INSERT INTO `distribute` VALUES (27, '21', 1);
INSERT INTO `distribute` VALUES (28, '29', 1);
INSERT INTO `distribute` VALUES (29, '22', 1);
INSERT INTO `distribute` VALUES (30, '23', 1);
INSERT INTO `distribute` VALUES (31, '24', 1);
INSERT INTO `distribute` VALUES (32, '26', 1);
INSERT INTO `distribute` VALUES (33, '27', 1);
INSERT INTO `distribute` VALUES (34, '30', 1);
INSERT INTO `distribute` VALUES (35, '38', 1);

-- ----------------------------
-- Table structure for editor
-- ----------------------------
DROP TABLE IF EXISTS `editor`;
CREATE TABLE `editor`  (
  `editor_id` int(4) NOT NULL AUTO_INCREMENT,
  `username` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `password` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `editor_name` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `sex` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`editor_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of editor
-- ----------------------------
INSERT INTO `editor` VALUES (1, '10000', '10000', '牛魔', '男');

-- ----------------------------
-- Table structure for editor_review
-- ----------------------------
DROP TABLE IF EXISTS `editor_review`;
CREATE TABLE `editor_review`  (
  `editor_review_id` int(4) NOT NULL AUTO_INCREMENT,
  `manuscript_id` int(4) NOT NULL COMMENT '外键',
  `editor_id` int(4) NOT NULL COMMENT '外键',
  `editor_opinion` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `editor_review_time` datetime(6) NOT NULL,
  PRIMARY KEY (`editor_review_id`) USING BTREE,
  INDEX `稿件ID`(`manuscript_id`) USING BTREE,
  INDEX `编辑ID`(`editor_id`) USING BTREE,
  CONSTRAINT `稿件ID` FOREIGN KEY (`manuscript_id`) REFERENCES `manuscript` (`manuscript_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `编辑ID` FOREIGN KEY (`editor_id`) REFERENCES `editor` (`editor_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of editor_review
-- ----------------------------
INSERT INTO `editor_review` VALUES (1, 10, 1, '已发布', '2020-03-25 05:09:19.000000');
INSERT INTO `editor_review` VALUES (2, 13, 1, '已发布', '2020-03-26 03:45:22.000000');
INSERT INTO `editor_review` VALUES (3, 4, 1, '已退回', '2020-03-26 03:57:26.000000');
INSERT INTO `editor_review` VALUES (4, 28, 1, '已发布', '2020-03-26 04:44:27.000000');
INSERT INTO `editor_review` VALUES (5, 14, 1, '已发布', '2020-03-28 07:44:40.000000');
INSERT INTO `editor_review` VALUES (6, 19, 1, '已发布', '2020-03-28 07:44:47.000000');
INSERT INTO `editor_review` VALUES (7, 2, 1, '已退回', '2020-03-28 07:51:27.000000');

-- ----------------------------
-- Table structure for expert
-- ----------------------------
DROP TABLE IF EXISTS `expert`;
CREATE TABLE `expert`  (
  `expert_id` int(4) NOT NULL AUTO_INCREMENT,
  `username` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `password` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `expert_name` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `sex` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `phone_number` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `address` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`expert_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of expert
-- ----------------------------
INSERT INTO `expert` VALUES (3, '10086', '10086', '小牛', '男', '18370844820', '江西九江');

-- ----------------------------
-- Table structure for expert_review
-- ----------------------------
DROP TABLE IF EXISTS `expert_review`;
CREATE TABLE `expert_review`  (
  `expert_review_id` int(4) NOT NULL AUTO_INCREMENT,
  `manuscript_id` int(4) NOT NULL COMMENT '外键',
  `expert_id` int(4) NOT NULL COMMENT '外键',
  `expert_opinion` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `expert_review_time` datetime(6) NOT NULL,
  PRIMARY KEY (`expert_review_id`) USING BTREE,
  INDEX `稿件`(`manuscript_id`) USING BTREE,
  INDEX `专家ID`(`expert_id`) USING BTREE,
  CONSTRAINT `专家ID` FOREIGN KEY (`expert_id`) REFERENCES `expert` (`expert_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 33 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of expert_review
-- ----------------------------
INSERT INTO `expert_review` VALUES (1, 6, 3, '已通过', '2020-03-25 09:34:28.000000');
INSERT INTO `expert_review` VALUES (2, 25, 3, '已通过', '2020-03-25 09:53:52.000000');
INSERT INTO `expert_review` VALUES (3, 6, 3, '已通过', '2020-03-25 09:56:19.000000');
INSERT INTO `expert_review` VALUES (4, 9, 3, '已通过', '2020-03-25 09:57:30.000000');
INSERT INTO `expert_review` VALUES (5, 8, 3, '已通过', '2020-03-25 09:58:56.000000');
INSERT INTO `expert_review` VALUES (6, 8, 3, '已通过', '2020-03-25 10:00:06.000000');
INSERT INTO `expert_review` VALUES (7, 7, 3, '已通过', '2020-03-25 10:01:25.000000');
INSERT INTO `expert_review` VALUES (8, 10, 3, '未通过', '2020-03-25 10:01:45.000000');
INSERT INTO `expert_review` VALUES (9, 4, 3, '未通过', '2020-03-25 10:52:56.000000');
INSERT INTO `expert_review` VALUES (10, 1, 3, '已通过', '2020-03-25 04:54:23.000000');
INSERT INTO `expert_review` VALUES (11, 7, 3, '已通过', '2020-03-25 04:54:29.000000');
INSERT INTO `expert_review` VALUES (12, 13, 3, '已通过', '2020-03-25 05:04:09.000000');
INSERT INTO `expert_review` VALUES (13, 7, 3, '已通过', '2020-03-25 05:04:14.000000');
INSERT INTO `expert_review` VALUES (14, 9, 3, '已通过', '2020-03-25 05:04:18.000000');
INSERT INTO `expert_review` VALUES (15, 2, 3, '已通过', '2020-03-25 05:04:22.000000');
INSERT INTO `expert_review` VALUES (16, 6, 3, '已通过', '2020-03-25 05:04:26.000000');
INSERT INTO `expert_review` VALUES (17, 10, 3, '已通过', '2020-03-25 05:04:31.000000');
INSERT INTO `expert_review` VALUES (18, 4, 3, '已通过', '2020-03-25 05:04:35.000000');
INSERT INTO `expert_review` VALUES (19, 14, 3, '已通过', '2020-03-26 12:44:57.000000');
INSERT INTO `expert_review` VALUES (20, 3, 3, '未通过', '2020-03-26 12:56:33.000000');
INSERT INTO `expert_review` VALUES (21, 18, 3, '未通过', '2020-03-26 12:56:49.000000');
INSERT INTO `expert_review` VALUES (22, 17, 3, '未通过', '2020-03-26 12:56:52.000000');
INSERT INTO `expert_review` VALUES (23, 15, 3, '已通过', '2020-03-26 12:58:47.000000');
INSERT INTO `expert_review` VALUES (24, 28, 3, '已通过', '2020-03-26 04:44:02.000000');
INSERT INTO `expert_review` VALUES (25, 19, 3, '已通过', '2020-03-28 07:43:21.000000');
INSERT INTO `expert_review` VALUES (26, 11, 3, '已通过', '2020-03-28 07:54:28.000000');
INSERT INTO `expert_review` VALUES (27, 22, 3, '未通过', '2020-03-28 07:54:31.000000');
INSERT INTO `expert_review` VALUES (28, 26, 3, '未通过', '2020-03-28 07:54:35.000000');
INSERT INTO `expert_review` VALUES (29, 27, 3, '未通过', '2020-03-28 07:54:37.000000');
INSERT INTO `expert_review` VALUES (30, 23, 3, '未通过', '2020-03-28 07:54:40.000000');
INSERT INTO `expert_review` VALUES (31, 20, 3, '已通过', '2020-03-28 07:54:43.000000');
INSERT INTO `expert_review` VALUES (32, 16, 3, '已通过', '2020-04-03 09:17:05.000000');
INSERT INTO `expert_review` VALUES (33, 24, 3, '已通过', '2020-04-03 09:21:26.000000');

-- ----------------------------
-- Table structure for manuscript
-- ----------------------------
DROP TABLE IF EXISTS `manuscript`;
CREATE TABLE `manuscript`  (
  `manuscript_id` int(11) NOT NULL AUTO_INCREMENT,
  `id` int(11) NOT NULL COMMENT '外键,用户ID',
  `author_name` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `title` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `summary` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '摘要',
  `submit_time` datetime(6) NOT NULL,
  `filePath` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `state` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `nav_id` int(11) NOT NULL,
  `remarks` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`manuscript_id`) USING BTREE,
  INDEX `作者ID`(`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 39 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of manuscript
-- ----------------------------
INSERT INTO `manuscript` VALUES (1, 3, 'admin', 'asdsad', 'dsadsad', '2020-03-15 09:28:03.000000', '/onlineSubmit/upload/1584278879872.docx', '已发布', 1, '已分配');
INSERT INTO `manuscript` VALUES (2, 3, 'admin', 'sadsad', 'dsadsad', '2020-03-15 09:29:26.000000', '/onlineSubmit/upload/1584278949868.docx', '已退回', 2, '已分配');
INSERT INTO `manuscript` VALUES (4, 9, 'admin', '新闻', '家乡', '2020-03-15 09:36:07.000000', '/onlineSubmit/upload/1584279367348.docx', '已退回', 1, NULL);
INSERT INTO `manuscript` VALUES (5, 9, 'admin', '实训', '软件设计', '2020-03-15 09:39:07.000000', '/onlineSubmit/upload/1584279547368.doc', '已通过', 2, NULL);
INSERT INTO `manuscript` VALUES (6, 3, 'admin', 'asdsad', 'dsadsadsadsad', '2020-03-16 11:05:36.000000', '/onlineSubmit/upload/1584327936253.doc', '已发布', 3, NULL);
INSERT INTO `manuscript` VALUES (7, 3, 'admin', '同学', '我们', '2020-03-17 10:38:56.000000', '/onlineSubmit/upload/1584412734890.doc', '已发布', 1, NULL);
INSERT INTO `manuscript` VALUES (8, 3, 'admin', '乡村的', '多大', '2020-03-17 11:00:49.000000', '/onlineSubmit/upload/1584414049131.docx', '已发布', 3, NULL);
INSERT INTO `manuscript` VALUES (9, 9, 'admin', '我们的故事', '你好', '2020-03-17 01:31:38.000000', '/onlineSubmit/upload/1584423098748.docx', '已发布', 2, NULL);
INSERT INTO `manuscript` VALUES (10, 3, 'admin', '想在', '撒大声的撒', '2020-03-17 01:33:22.000000', '/onlineSubmit/upload/1584423202035.docx', '已发布', 1, NULL);
INSERT INTO `manuscript` VALUES (11, 3, 'admin', '我们的向往', '行走在路上', '2020-03-17 01:33:59.000000', '/onlineSubmit/upload/1584423239698.docx', '已通过', 2, '已分配');
INSERT INTO `manuscript` VALUES (13, 1, 'admin', 'sadsad', 'dsadsads', '2020-03-18 09:21:12.000000', '/onlineSubmit/upload/1584537672476.docx', '已发布', 1, NULL);
INSERT INTO `manuscript` VALUES (14, 1, 'admin', 'dasd', 'sadsadsad', '2020-03-18 09:42:07.000000', '/onlineSubmit/upload/1584538927653.docx', '已发布', 3, NULL);
INSERT INTO `manuscript` VALUES (15, 1, 'admin', 'sadsa', 'dsadsadsad', '2020-03-22 12:02:52.000000', '/onlineSubmit/upload/1584806572627.docx', '已通过', 2, NULL);
INSERT INTO `manuscript` VALUES (16, 1, 'admin', 'ss', 'aaa', '2020-03-22 12:20:13.000000', '/onlineSubmit/upload/1584850813244.docx', '已通过', 2, '已分配');
INSERT INTO `manuscript` VALUES (17, 9, 'ssss', 'sad', 'sadsads', '2020-03-22 12:24:41.000000', '/onlineSubmit/upload/1584851081544.docx', '未通过', 2, NULL);
INSERT INTO `manuscript` VALUES (18, 1, 'admin', '我们的果实', '实施的与文化的', '2020-03-24 10:20:57.000000', '/onlineSubmit/upload/1585016457937.docx', '未通过', 1, NULL);
INSERT INTO `manuscript` VALUES (19, 1, 'admin', ' 山海经', '我们都是', '2020-03-24 10:57:10.000000', '/onlineSubmit/upload/1585018630183.docx', '已发布', 1, '已分配');
INSERT INTO `manuscript` VALUES (20, 1, 'admin', '其大大', '故事', '2020-03-24 05:22:43.000000', '/onlineSubmit/upload/1585041763618.docx', '已通过', 1, '已分配');
INSERT INTO `manuscript` VALUES (21, 1, 'admin', 'sad', 'sadsadsa', '2020-03-24 05:53:54.000000', '/onlineSubmit/upload/1585043634746.docx', '待审核', 1, '已分配');
INSERT INTO `manuscript` VALUES (22, 1, 'admin', 'asd', 'sadsadsa', '2020-03-24 06:37:03.000000', '/onlineSubmit/upload/1585046223371.docx', '未通过', 1, '已分配');
INSERT INTO `manuscript` VALUES (23, 1, 'admin', 'asds', 'adsadsad', '2020-03-24 06:40:04.000000', '/onlineSubmit/upload/1585046404546.docx', '未通过', 1, '已分配');
INSERT INTO `manuscript` VALUES (24, 1, 'admin', 'sadsad', 'adsadsadasd', '2020-03-24 06:41:01.000000', '/onlineSubmit/upload/1585046461627.docx', '已通过', 1, '已分配');
INSERT INTO `manuscript` VALUES (25, 1, 'admin', 'sadas', 'dsadsasa', '2020-03-24 09:40:38.000000', '/onlineSubmit/upload/1585057238599.docx', '已发布', 1, NULL);
INSERT INTO `manuscript` VALUES (26, 1, 'admin', '打算打算你家沙发技术开发开始发货', '的撒的撒的撒打算打的地方地方', '2020-03-25 05:20:29.000000', '/onlineSubmit/upload/1585128029602.docx', '未通过', 2, '已分配');
INSERT INTO `manuscript` VALUES (27, 1, 'admin', '我要', '带着', '2020-03-26 12:14:33.000000', '/onlineSubmit/upload/1585196073422.docx', '未通过', 1, '已分配');
INSERT INTO `manuscript` VALUES (28, 1, 'admin', '春天', '我们', '2020-03-26 04:41:58.000000', '/onlineSubmit/upload/1585212118647.docx', '已发布', 1, '已分配');
INSERT INTO `manuscript` VALUES (29, 17, '小菜菜', 'asdsad', 'sadsadsad', '2020-03-28 07:41:03.000000', '/onlineSubmit/upload/1585395663393.docx', '待审核', 1, '已分配');
INSERT INTO `manuscript` VALUES (30, 4, '六神', 'title', 'abstract', '2020-04-03 05:37:51.000000', '/onlineSubmit/upload/1585906671862.docx', '待审核', 2, '已分配');
INSERT INTO `manuscript` VALUES (31, 4, '六神', 'test01', 'test01', '2020-04-03 05:40:34.000000', '/onlineSubmit/upload/1585906834458.docx', '待审核', 2, NULL);
INSERT INTO `manuscript` VALUES (32, 4, '六神', 'test02', 'test02', '2020-04-03 05:40:49.000000', '/onlineSubmit/upload/1585906849871.docx', '待审核', 2, NULL);
INSERT INTO `manuscript` VALUES (33, 4, '六神', 'test03', 'test03', '2020-04-03 05:41:03.000000', '/onlineSubmit/upload/1585906863131.docx', '待审核', 2, NULL);
INSERT INTO `manuscript` VALUES (34, 4, '六神', 'test04', 'test04', '2020-04-03 05:41:09.000000', '/onlineSubmit/upload/1585906869558.docx', '待审核', 2, NULL);
INSERT INTO `manuscript` VALUES (35, 4, '六神', 'test05', 'test05', '2020-04-03 05:41:15.000000', '/onlineSubmit/upload/1585906875747.docx', '待审核', 2, NULL);
INSERT INTO `manuscript` VALUES (36, 4, '六神', 'test06', 'test06', '2020-04-03 05:41:21.000000', '/onlineSubmit/upload/1585906881837.docx', '待审核', 2, NULL);
INSERT INTO `manuscript` VALUES (37, 4, '六神', 'test08', 'test08', '2020-04-03 09:00:18.000000', '/onlineSubmit/upload/1585918818111.docx', '待审核', 1, NULL);
INSERT INTO `manuscript` VALUES (38, 4, '六神', 'test08', 'test08', '2020-04-03 09:01:55.000000', '/onlineSubmit/upload/1585918915763.docx', '待审核', 1, '已分配');

-- ----------------------------
-- Table structure for nav
-- ----------------------------
DROP TABLE IF EXISTS `nav`;
CREATE TABLE `nav`  (
  `nav_id` int(11) NOT NULL AUTO_INCREMENT,
  `nav_name` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`nav_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of nav
-- ----------------------------
INSERT INTO `nav` VALUES (1, '消息');
INSERT INTO `nav` VALUES (2, '评论');
INSERT INTO `nav` VALUES (3, '通讯');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `password` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `author_name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `sex` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `phone_number` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `address` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `author_name`(`author_name`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 18 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (1, '小王', '123456', 'admin', '男', '18379281161', '广寒宫');
INSERT INTO `user` VALUES (4, 'test001', '123456', 'test001', '男', '18379281161', 'test001');
INSERT INTO `user` VALUES (6, 'xiaowu', 'wck9876523', 'heieh', '男', '18379281161', 'dsadsad');
INSERT INTO `user` VALUES (7, 'xiaowang', 'qwe', '小刘', '男', '18379281161', '江西省九江市柴桑区');
INSERT INTO `user` VALUES (9, '2016101878', 'wck9876523', 'admin', '男', '18379281161', '江西九江');
INSERT INTO `user` VALUES (10, 'username', 'pwd', 'admin', '男', '18379281161', '江西');
INSERT INTO `user` VALUES (11, 'admin', 'admin', 'xiaowu', '男', '18422331161', 'women');
INSERT INTO `user` VALUES (14, 'whenok', '123456', 'qweqweqweq', '男', '18327871265', '广州');
INSERT INTO `user` VALUES (16, '小刘', '123456', '吴小新', '男', '18379281161', '九江');
INSERT INTO `user` VALUES (17, 'cuinn', 'wck9876523', '小菜菜', '男', '18379281161', '深圳');

SET FOREIGN_KEY_CHECKS = 1;
