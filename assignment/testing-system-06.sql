-- Câu 1: Tạo store để người dùng nhập vào tên phòng ban và in ra tất cả các
-- account thuộc phòng ban đó
-- Cách 1: Dùng subquery
DROP PROCEDURE IF EXISTS sp_cau_01;
DELIMITER $$
CREATE PROCEDURE sp_cau_01 (IN in_department_name VARCHAR(50))
BEGIN
    SELECT *
    FROM `account`
    WHERE department_id IN
        (SELECT department_id
        FROM department
        WHERE department_name = in_department_name);
END $$
DELIMITER ;

CALL sp_cau_01('Kỹ thuật');

-- Cách 2: Dùng biến
DROP PROCEDURE IF EXISTS sp_cau_01;
DELIMITER $$
CREATE PROCEDURE sp_cau_01 (IN in_department_name VARCHAR(50))
BEGIN
    DECLARE var_department_id TINYINT UNSIGNED;

    SELECT department_id INTO var_department_id
    FROM department
    WHERE department_name = in_department_name;

    SELECT *
    FROM `account`
    WHERE department_id = var_department_id;
END $$
DELIMITER ;

CALL sp_cau_01('Kỹ thuật');

-- Câu 2: Tạo store để in ra số lượng account trong mỗi group
DROP PROCEDURE IF EXISTS sp_cau_02;
DELIMITER $$
CREATE PROCEDURE sp_cau_02 ()
BEGIN
    SELECT COUNT(account_id) AS total_accounts
    FROM `group`
    LEFT JOIN group_account USING(group_id)
    GROUP BY group_id;
END $$
DELIMITER ;

CALL sp_cau_02();

-- Câu 3: Tạo store để thống kê mỗi type question có bao nhiêu question được tạo
-- trong tháng hiện tại
DROP PROCEDURE IF EXISTS sp_cau_03;
DELIMITER $$
CREATE PROCEDURE sp_cau_03 ()
BEGIN
    DECLARE var_now DATETIME DEFAULT NOW();

    SELECT type_question.*, created_date, COUNT(question_id) AS total_questions
    FROM type_question
    LEFT JOIN question USING(type_id)
    GROUP BY type_id
    HAVING MONTH(created_date) = MONTH(var_now) AND YEAR(created_date) = YEAR(var_now);
END $$
DELIMITER ;

CALL sp_cau_03();
