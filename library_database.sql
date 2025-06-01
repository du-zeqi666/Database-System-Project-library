/*
 Navicat Premium Dump SQL

 Source Server         : 测试数据库
 Source Server Type    : MySQL
 Source Server Version : 80033 (8.0.33)
 Source Host           : localhost:3306
 Source Schema         : library_database

 Target Server Type    : MySQL
 Target Server Version : 80033 (8.0.33)
 File Encoding         : 65001

 Date: 01/06/2025 15:40:09
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for author
-- ----------------------------
DROP TABLE IF EXISTS `author`;
CREATE TABLE `author`  (
  `Author_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '作者姓名',
  `Author_country` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '作者国籍',
  `Author_popularity` int NULL DEFAULT NULL COMMENT '作者图书被借阅数决定受欢迎度',
  `Author_id` int NOT NULL AUTO_INCREMENT COMMENT '作者序',
  PRIMARY KEY (`Author_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for book
-- ----------------------------
DROP TABLE IF EXISTS `book`;
CREATE TABLE `book`  (
  `Book_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '书名',
  `ISBN` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '书籍编码',
  `Author_id` int NULL DEFAULT NULL COMMENT '作者',
  `Publisher` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '出版商',
  `Publish_date` date NULL DEFAULT NULL COMMENT '出版时间',
  `Book_id` int NOT NULL AUTO_INCREMENT COMMENT '图书馆编码',
  `Book_introduction` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '图书简介',
  `Type_id` int NULL DEFAULT NULL COMMENT '图书类型编码',
  `Borrow_status` tinyint NULL DEFAULT NULL COMMENT '借阅状态(1)/在馆状态(0)/预约状态(2)',
  `Book_location` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '图书存储地点',
  PRIMARY KEY (`Book_id`) USING BTREE,
  INDEX `fk_book_author`(`Author_id` ASC) USING BTREE,
  INDEX `fk_book_type`(`Type_id` ASC) USING BTREE,
  CONSTRAINT `fk_book_author` FOREIGN KEY (`Author_id`) REFERENCES `author` (`Author_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `fk_book_type` FOREIGN KEY (`Type_id`) REFERENCES `type` (`Type_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 31 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for booklist
-- ----------------------------
DROP TABLE IF EXISTS `booklist`;
CREATE TABLE `booklist`  (
  `Booklist_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `Booklist_information` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `Booklist_id` int NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`Booklist_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 32 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for booklist_relation
-- ----------------------------
DROP TABLE IF EXISTS `booklist_relation`;
CREATE TABLE `booklist_relation`  (
  `Reader_id` int NOT NULL,
  `Book_id` int NOT NULL,
  `Booklist_id` int NOT NULL,
  PRIMARY KEY (`Booklist_id`, `Book_id`) USING BTREE,
  INDEX `fk_relation_book`(`Book_id` ASC) USING BTREE,
  INDEX `fk_relation_reader`(`Reader_id` ASC) USING BTREE,
  CONSTRAINT `fk_relation_book` FOREIGN KEY (`Book_id`) REFERENCES `book` (`Book_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_relation_booklist` FOREIGN KEY (`Booklist_id`) REFERENCES `booklist` (`Booklist_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_relation_reader` FOREIGN KEY (`Reader_id`) REFERENCES `reader` (`Reader_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for borrow_records
-- ----------------------------
DROP TABLE IF EXISTS `borrow_records`;
CREATE TABLE `borrow_records`  (
  `Borrow_id` int NOT NULL AUTO_INCREMENT,
  `Book_id` int NOT NULL,
  `Reader_id` int NOT NULL,
  `Borrow_date` date NOT NULL COMMENT '借阅日期',
  `Back_date` date NULL DEFAULT NULL COMMENT '归还日期',
  `Deadline` date NOT NULL COMMENT '还书截止日期',
  `Back_status` tinyint NOT NULL COMMENT '归还状态(0归还，1未归还, 2已预约）',
  `More_information` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注信息',
  `Renew_loan` tinyint NOT NULL COMMENT '能否续借（1可续借，0不可续借）',
  `Breach_of_contract` tinyint NOT NULL COMMENT '是否违约（1已违约，0未违约）',
  PRIMARY KEY (`Borrow_id`) USING BTREE,
  INDEX `fk_records_book`(`Book_id` ASC) USING BTREE,
  INDEX `fk_records_reader`(`Reader_id` ASC) USING BTREE,
  CONSTRAINT `fk_records_book` FOREIGN KEY (`Book_id`) REFERENCES `book` (`Book_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_records_reader` FOREIGN KEY (`Reader_id`) REFERENCES `reader` (`Reader_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 78 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for librarian
-- ----------------------------
DROP TABLE IF EXISTS `librarian`;
CREATE TABLE `librarian`  (
  `Librarian_id` int NOT NULL AUTO_INCREMENT,
  `Librarian_username` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `department` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`Librarian_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for news
-- ----------------------------
DROP TABLE IF EXISTS `news`;
CREATE TABLE `news`  (
  `News_id` int NOT NULL AUTO_INCREMENT,
  `News_information` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '通告内容',
  `News_topic` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `News_author` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `News_date` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`News_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 16 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for reader
-- ----------------------------
DROP TABLE IF EXISTS `reader`;
CREATE TABLE `reader`  (
  `Reader_id` int NOT NULL AUTO_INCREMENT COMMENT '读者编码',
  `Reader_username` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '读者用户名',
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '密码',
  `Reader_realname` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '读者真实姓名',
  `gender` varchar(5) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '性别',
  `Reader_telephone` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '读者电话',
  `Reader_address` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '读者地址',
  `Reader_college` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '读者学院',
  `Reader_majority` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '读者专业',
  `Reader_email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '读者邮箱',
  `Reader_age` int NULL DEFAULT NULL COMMENT '读者年龄',
  `reader_role` enum('student','teacher') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`Reader_id`) USING BTREE,
  UNIQUE INDEX `uq_reader_username`(`Reader_username` ASC) USING BTREE,
  UNIQUE INDEX `uq_reader_email`(`Reader_email` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 44 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for student
-- ----------------------------
DROP TABLE IF EXISTS `student`;
CREATE TABLE `student`  (
  `Reader_id` int NOT NULL,
  `Student_id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '学号',
  `Grade` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '年级',
  `Class` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '班级',
  PRIMARY KEY (`Reader_id`) USING BTREE,
  CONSTRAINT `fk_student_reader` FOREIGN KEY (`Reader_id`) REFERENCES `reader` (`Reader_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for teacher
-- ----------------------------
DROP TABLE IF EXISTS `teacher`;
CREATE TABLE `teacher`  (
  `Reader_id` int NOT NULL,
  `Teacher_id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '教职工号',
  `Title` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '职称',
  `Department` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '所属部门',
  PRIMARY KEY (`Reader_id`) USING BTREE,
  CONSTRAINT `fk_teacher_reader` FOREIGN KEY (`Reader_id`) REFERENCES `reader` (`Reader_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for type
-- ----------------------------
DROP TABLE IF EXISTS `type`;
CREATE TABLE `type`  (
  `Type_id` int NOT NULL AUTO_INCREMENT COMMENT '图书类别码',
  `Type_information` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '图书类别信息',
  `Type_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '图书类别名',
  PRIMARY KEY (`Type_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- View structure for book_status_summary
-- ----------------------------
DROP VIEW IF EXISTS `book_status_summary`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `book_status_summary` AS select `b`.`Book_id` AS `Book_id`,`b`.`Book_name` AS `Book_name`,`b`.`ISBN` AS `ISBN`,`a`.`Author_name` AS `Author_name`,`t`.`Type_name` AS `Type_name`,(case `b`.`Borrow_status` when 0 then '在馆' when 1 then '借出' when 2 then '预约' else '未知' end) AS `Borrow_status` from ((`book` `b` left join `author` `a` on((`b`.`Author_id` = `a`.`Author_id`))) left join `type` `t` on((`b`.`Type_id` = `t`.`Type_id`)));

-- ----------------------------
-- View structure for popular_authors
-- ----------------------------
DROP VIEW IF EXISTS `popular_authors`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `popular_authors` AS select `author`.`Author_id` AS `Author_id`,`author`.`Author_name` AS `Author_name`,`author`.`Author_country` AS `Author_country`,coalesce(`author`.`Author_popularity`,0) AS `Author_popularity` from `author` order by coalesce(`author`.`Author_popularity`,0) desc;

-- ----------------------------
-- View structure for reader_booklist_summary
-- ----------------------------
DROP VIEW IF EXISTS `reader_booklist_summary`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `reader_booklist_summary` AS select `r`.`Reader_id` AS `Reader_id`,`r`.`Reader_username` AS `Reader_username`,`bl`.`Booklist_id` AS `Booklist_id`,`bl`.`Booklist_name` AS `Booklist_name`,count(`br`.`Book_id`) AS `book_count` from ((`reader` `r` left join `booklist_relation` `br` on((`r`.`Reader_id` = `br`.`Reader_id`))) left join `booklist` `bl` on((`br`.`Booklist_id` = `bl`.`Booklist_id`))) group by `r`.`Reader_id`,`r`.`Reader_username`,`bl`.`Booklist_id`,`bl`.`Booklist_name`;

-- ----------------------------
-- View structure for reader_borrow_count
-- ----------------------------
DROP VIEW IF EXISTS `reader_borrow_count`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `reader_borrow_count` AS select `r`.`Reader_id` AS `Reader_id`,`r`.`Reader_username` AS `Reader_username`,`r`.`reader_role` AS `reader_role`,count(`br`.`Borrow_id`) AS `borrow_count` from (`reader` `r` left join `borrow_records` `br` on((`r`.`Reader_id` = `br`.`Reader_id`))) group by `r`.`Reader_id`,`r`.`Reader_username`,`r`.`reader_role`;

-- ----------------------------
-- Procedure structure for delete_book
-- ----------------------------
DROP PROCEDURE IF EXISTS `delete_book`;
delimiter ;;
CREATE PROCEDURE `delete_book`(IN p_book_id INT)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION 
    BEGIN
        ROLLBACK;
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '错误：无法删除图书';
    END;

    -- 验证 Book_id
    IF NOT EXISTS (SELECT 1 FROM book WHERE Book_id = p_book_id) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '图书不存在';
    END IF;

    START TRANSACTION;
    -- 删除 book（会自动级联删除 borrow_records 和 booklist_relation）
    DELETE FROM book WHERE Book_id = p_book_id;
    
    COMMIT;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for delete_booklist
-- ----------------------------
DROP PROCEDURE IF EXISTS `delete_booklist`;
delimiter ;;
CREATE PROCEDURE `delete_booklist`(IN p_booklist_id INT)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION 
    BEGIN
        ROLLBACK;
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '错误：无法删除书单';
    END;

    -- 验证 Booklist_id
    IF NOT EXISTS (SELECT 1 FROM booklist WHERE Booklist_id = p_booklist_id) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '书单不存在';
    END IF;

    START TRANSACTION;
    -- 删除 booklist（会自动级联删除 booklist_relation）
    DELETE FROM booklist WHERE Booklist_id = p_booklist_id;
    
    COMMIT;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for delete_reader
-- ----------------------------
DROP PROCEDURE IF EXISTS `delete_reader`;
delimiter ;;
CREATE PROCEDURE `delete_reader`(IN p_reader_id INT)
BEGIN
    DECLARE v_role ENUM('student', 'teacher');
    DECLARE EXIT HANDLER FOR SQLEXCEPTION 
    BEGIN
        ROLLBACK;
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '错误：无法删除读者';
    END;

    -- 验证 Reader_id
    IF NOT EXISTS (SELECT 1 FROM reader WHERE Reader_id = p_reader_id) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '读者不存在';
    END IF;

    -- 获取 reader_role
    SELECT reader_role INTO v_role FROM reader WHERE Reader_id = p_reader_id;

    START TRANSACTION;
    -- 删除 student 或 teacher
    IF v_role = 'student' THEN
        DELETE FROM student WHERE Reader_id = p_reader_id;
    ELSEIF v_role = 'teacher' THEN
        DELETE FROM teacher WHERE Reader_id = p_reader_id;
    END IF;

    -- 删除 reader（会自动级联删除 borrow_records 和 booklist_relation）
    DELETE FROM reader WHERE Reader_id = p_reader_id;
    
    COMMIT;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for update_book_status
-- ----------------------------
DROP PROCEDURE IF EXISTS `update_book_status`;
delimiter ;;
CREATE PROCEDURE `update_book_status`(IN p_book_id INT,
    IN p_new_status TINYINT,
    IN p_operator VARCHAR(30))
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION 
    BEGIN
        ROLLBACK;
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '错误：无法更新图书状态';
    END;

    -- 验证输入
    IF p_book_id <= 0 OR p_new_status NOT IN (0, 1, 2) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '无效的 Book_id 或状态值';
    END IF;

    -- 验证 Book_id 存在
    IF NOT EXISTS (SELECT 1 FROM book WHERE Book_id = p_book_id) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '图书不存在';
    END IF;

    START TRANSACTION;
    -- 更新图书状态
    UPDATE book 
    SET Borrow_status = p_new_status 
    WHERE Book_id = p_book_id;
    
    -- 记录操作到 news 表
    INSERT INTO news (News_information, News_topic, News_author)
    VALUES (CONCAT('图书状态更新，Book_id: ', p_book_id, '，新状态: ', p_new_status), '图书管理', p_operator);
    
    COMMIT;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for update_borrow_record
-- ----------------------------
DROP PROCEDURE IF EXISTS `update_borrow_record`;
delimiter ;;
CREATE PROCEDURE `update_borrow_record`(IN p_borrow_id INT,
    IN p_new_back_status TINYINT,
    IN p_back_date DATE,
    IN p_operator VARCHAR(30))
BEGIN
    DECLARE v_book_id INT;
    DECLARE v_deadline DATE;
    DECLARE v_author_id INT;
    DECLARE v_current_status TINYINT;
    DECLARE EXIT HANDLER FOR SQLEXCEPTION 
    BEGIN
        ROLLBACK;
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '错误：无法更新借阅记录';
    END;

    -- 验证输入
    IF p_borrow_id <= 0 OR p_new_back_status NOT IN (0, 1, 2) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '无效的 Borrow_id 或状态值';
    END IF;

    -- 验证 Borrow_id
    IF NOT EXISTS (SELECT 1 FROM borrow_records WHERE Borrow_id = p_borrow_id) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '借阅记录不存在';
    END IF;

    -- 获取 Book_id, Deadline 和当前状态
    SELECT Book_id, Deadline, Back_status 
    INTO v_book_id, v_deadline, v_current_status
    FROM borrow_records 
    WHERE Borrow_id = p_borrow_id;

    -- 获取 Author_id
    SELECT Author_id INTO v_author_id 
    FROM book 
    WHERE Book_id = v_book_id;

    START TRANSACTION;
    -- 更新 borrow_records
    UPDATE borrow_records 
    SET Back_status = p_new_back_status,
        Back_date = p_back_date,
        Breach_of_contract = CASE 
            WHEN p_new_back_status = 0 AND p_back_date > v_deadline THEN 1 
            ELSE 0 
        END
    WHERE Borrow_id = p_borrow_id;

    -- 更新 book 状态
    UPDATE book 
    SET Borrow_status = p_new_back_status 
    WHERE Book_id = v_book_id;

    -- 更新 Author_popularity（如果从借出变为归还）
    IF v_current_status = 1 AND p_new_back_status = 0 AND v_author_id IS NOT NULL THEN
        UPDATE author 
        SET Author_popularity = GREATEST(COALESCE(Author_popularity, 0) - 1, 0)
        WHERE Author_id = v_author_id;
    END IF;

    -- 记录操作到 news 表
    INSERT INTO news (News_information, News_topic, News_author)
    VALUES (CONCAT('借阅记录更新，Borrow_id: ', p_borrow_id, '，新状态: ', p_new_back_status), '借阅管理', p_operator);
    
    COMMIT;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for update_reader_info
-- ----------------------------
DROP PROCEDURE IF EXISTS `update_reader_info`;
delimiter ;;
CREATE PROCEDURE `update_reader_info`(IN p_reader_id INT,
    IN p_telephone VARCHAR(30),
    IN p_email VARCHAR(255),
    IN p_address VARCHAR(30),
    IN p_operator VARCHAR(30))
BEGIN
    DECLARE v_role ENUM('student', 'teacher');
    DECLARE EXIT HANDLER FOR SQLEXCEPTION 
    BEGIN
        ROLLBACK;
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '错误：无法更新读者信息';
    END;

    -- 验证 Reader_id
    IF NOT EXISTS (SELECT 1 FROM reader WHERE Reader_id = p_reader_id) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '读者不存在';
    END IF;

    -- 获取 reader_role
    SELECT reader_role INTO v_role FROM reader WHERE Reader_id = p_reader_id;

    START TRANSACTION;
    -- 更新 reader 表
    UPDATE reader 
    SET Reader_telephone = p_telephone,
        Reader_email = p_email,
        Reader_address = p_address
    WHERE Reader_id = p_reader_id;

    -- 根据角色更新 student 或 teacher
    IF v_role = 'student' THEN
        UPDATE student 
        SET Class = COALESCE(Class, '未知班级') 
        WHERE Reader_id = p_reader_id;
    ELSEIF v_role = 'teacher' THEN
        UPDATE teacher 
        SET Department = COALESCE(Department, '未知部门') 
        WHERE Reader_id = p_reader_id;
    END IF;

    -- 记录操作到 news 表
    INSERT INTO news (News_information, News_topic, News_author)
    VALUES (CONCAT('读者信息更新，Reader_id: ', p_reader_id), '读者管理', p_operator);
    
    COMMIT;
END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table borrow_records
-- ----------------------------
DROP TRIGGER IF EXISTS `before_borrow_insert_breach`;
delimiter ;;
CREATE TRIGGER `before_borrow_insert_breach` BEFORE INSERT ON `borrow_records` FOR EACH ROW BEGIN
    IF NEW.Back_date IS NOT NULL AND NEW.Back_date > NEW.Deadline THEN
        SET NEW.Breach_of_contract = 1;
    ELSE
        SET NEW.Breach_of_contract = 0;
    END IF;
END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table borrow_records
-- ----------------------------
DROP TRIGGER IF EXISTS `after_borrow_insert_combined`;
delimiter ;;
CREATE TRIGGER `after_borrow_insert_combined` AFTER INSERT ON `borrow_records` FOR EACH ROW BEGIN
    DECLARE v_reader_username VARCHAR(30);

    -- 获取读者用户名
    SELECT Reader_username INTO v_reader_username 
    FROM reader 
    WHERE Reader_id = NEW.Reader_id;

    -- 更新图书借阅状态
    IF NEW.Back_status = 1 THEN
        UPDATE book 
        SET Borrow_status = 1 
        WHERE Book_id = NEW.Book_id;
        
        -- 更新作者受欢迎度
        UPDATE author
        SET Author_popularity = COALESCE(Author_popularity, 0) + 1
        WHERE Author_id = (SELECT Author_id FROM book WHERE Book_id = NEW.Book_id);

        -- 插入借阅通知到 news 表
        INSERT INTO news (News_information, News_topic, News_author)
        VALUES (
            CONCAT('用户 ', v_reader_username, ' (ID: ', NEW.Reader_id, ') 借阅了图书ID: ', NEW.Book_id),
            '借阅管理',
            v_reader_username
        );
    ELSEIF NEW.Back_status = 2 THEN
        UPDATE book 
        SET Borrow_status = 2 
        WHERE Book_id = NEW.Book_id;

        -- 插入预约通知到 news 表
        INSERT INTO news (News_information, News_topic, News_author)
        VALUES (
            CONCAT('用户 ', v_reader_username, ' (ID: ', NEW.Reader_id, ') 预约了图书ID: ', NEW.Book_id),
            '预约管理',
            v_reader_username
        );
    END IF;
END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table student
-- ----------------------------
DROP TRIGGER IF EXISTS `after_student_insert_role`;
delimiter ;;
CREATE TRIGGER `after_student_insert_role` AFTER INSERT ON `student` FOR EACH ROW BEGIN
    UPDATE reader SET reader_role = 'student' WHERE Reader_id = NEW.Reader_id;
END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table teacher
-- ----------------------------
DROP TRIGGER IF EXISTS `after_teacher_insert_role`;
delimiter ;;
CREATE TRIGGER `after_teacher_insert_role` AFTER INSERT ON `teacher` FOR EACH ROW BEGIN
    UPDATE reader SET reader_role = 'teacher' WHERE Reader_id = NEW.Reader_id;
END
;;
delimiter ;

SET FOREIGN_KEY_CHECKS = 1;
