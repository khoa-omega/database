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
    SELECT group_name, COUNT(account_id) AS total_accounts
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
    SELECT type_name, created_date, COUNT(question_id) AS total_questions
    FROM type_question
    LEFT JOIN question USING(type_id)
    GROUP BY type_id
    HAVING EXTRACT(YEAR_MONTH FROM CURRENT_DATE) = EXTRACT(YEAR_MONTH FROM created_date);
END $$
DELIMITER ;

CALL sp_cau_03();

-- Câu 4: Tạo store để trả ra id của type question có nhiều câu hỏi nhất
DROP FUNCTION IF EXISTS fn_cau_04;
DELIMITER $$
CREATE FUNCTION fn_cau_04 () RETURNS TINYINT UNSIGNED
BEGIN
    DECLARE var_type_id TINYINT UNSIGNED;

    WITH cte_total_questions_per_type AS (
        SELECT type_id, COUNT(question_id) AS total_questions
        FROM type_question
        LEFT JOIN question USING(type_id)
        GROUP BY type_id
    )
    SELECT type_id INTO var_type_id
    FROM cte_total_questions_per_type
    WHERE total_questions =
        (SELECT MAX(total_questions)
        FROM cte_total_questions_per_type)
    LIMIT 1;

    RETURN var_type_id;
END $$
DELIMITER ;

SELECT fn_cau_04();

-- Câu 5: Sử dụng store ở question 4 để tìm ra tên của type question
SELECT type_name
FROM type_question
WHERE type_id = fn_cau_04();

-- Câu 6: Viết 1 store cho phép người dùng nhập vào 1 chuỗi và trả về group có tên
-- chứa chuỗi của người dùng nhập vào hoặc trả về user có username chứa
-- chuỗi của người dùng nhập vào
DROP PROCEDURE IF EXISTS sp_cau_06;
DELIMITER $$
CREATE PROCEDURE sp_cau_06 (IN search VARCHAR(50))
BEGIN
    DECLARE pattern VARCHAR(52) DEFAULT CONCAT('%', search, '%');
    
    SELECT 'Group' AS `type`, group_name AS `name`
    FROM `group`
    WHERE group_name LIKE pattern
    UNION
    SELECT 'Account' AS `type`, username AS `name`
    FROM `account`
    WHERE username LIKE pattern;
END $$
DELIMITER ;

CALL sp_cau_06('g');

-- Câu 7: Viết 1 store cho phép người dùng nhập vào thông tin full name, email và trong store sẽ tự động gán:
--     * username sẽ giống email nhưng bỏ phần @..mail đi
--     * position_id: sẽ có default là developer
--     * department_id: sẽ được cho vào 1 phòng chờ
-- Sau đó in ra kết quả tạo thành công
DROP PROCEDURE IF EXISTS sp_cau_07;
DELIMITER $$
CREATE PROCEDURE sp_cau_07 (IN in_full_name VARCHAR(50), IN in_email VARCHAR(50))
BEGIN
    DECLARE var_username VARCHAR(50) DEFAULT SUBSTRING_INDEX(in_email, '@', 1);
    DECLARE var_position_id TINYINT UNSIGNED DEFAULT 1;
    DECLARE var_department_id TINYINT UNSIGNED DEFAULT 11;

    INSERT INTO `account` (full_name   , email   , username    , position_id    , department_id    )
    VALUES                (in_full_name, in_email, var_username, var_position_id, var_department_id);

    SELECT *
    FROM `account`
    ORDER BY created_date DESC
    LIMIT 1;
END $$
DELIMITER ;

CALL sp_cau_07('Nguyen Van Khoa', 'khoa.nv@gmail.com');

-- Câu 8: Viết 1 store cho phép người dùng nhập vào ESSAY hoặc MULTIPLE_CHOICE
-- để thống kê câu hỏi ESSAY hoặc MULTIPLE_CHOICE nào có content dài nhất
DROP PROCEDURE IF EXISTS sp_cau_08;
DELIMITER $$
CREATE PROCEDURE sp_cau_08 (IN in_type_name ENUM('ESSAY', 'MULTIPLE_CHOICE'))
BEGIN
    WITH c1 AS (
        SELECT *, CHAR_LENGTH(content) AS content_length
        FROM question
        WHERE type_id =
            (SELECT type_id
            FROM type_question
            WHERE type_name = in_type_name)
    )
    SELECT *
    FROM c1
    WHERE content_length =
        (SELECT MAX(content_length)
        FROM c1);
END $$
DELIMITER ;

CALL sp_cau_08('ESSAY');

-- Câu 9: Viết 1 store cho phép người dùng xóa exam dựa vào id
DROP PROCEDURE IF EXISTS sp_cau_09;
DELIMITER $$
CREATE PROCEDURE sp_cau_09 (IN in_exam_id TINYINT UNSIGNED)
BEGIN
    DELETE FROM exam
    WHERE exam_id = in_exam_id;
END $$
DELIMITER ;

CALL sp_cau_09(1);

-- Câu 10: Tìm ra các exam được tạo từ 3 năm trước và xóa các exam đó đi (sử dụng store ở câu 9 để xóa)
-- Sau đó in số lượng record đã remove từ các table liên quan trong khi removing
DROP PROCEDURE IF EXISTS sp_cau_10;
DELIMITER $$
CREATE PROCEDURE sp_cau_10 ()
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE eid TINYINT UNSIGNED;
    DECLARE removed_exams TINYINT UNSIGNED DEFAULT 0;
    DECLARE removed_exam_questions TINYINT UNSIGNED DEFAULT 0;
    DECLARE cur CURSOR FOR
        (SELECT exam_id
        FROM exam
        WHERE created_date < DATE_SUB(NOW(), INTERVAL 0 YEAR));
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    OPEN cur;

    read_loop: LOOP
        FETCH cur INTO eid;
        IF done THEN
            LEAVE read_loop;
        END IF;
        -- Đếm số bản ghi trong exam_question sẽ bị xóa
        SELECT COUNT(exam_id) INTO removed_exam_questions
        FROM exam_question
        WHERE exam_id = eid;
        -- Xóa exam có exam_id = eid
        CALL sp_cau_09(eid);
        -- Cập nhật xóa bản ghi đã bị xóa
        SET removed_exams = removed_exams + removed_exam_questions + 1;
    END LOOP;

    CLOSE cur;

    SELECT CONCAT('Số bản ghi đã bị xóa là: ', removed_exams) AS message;
END $$
DELIMITER ;

CALL sp_cau_10();

-- Câu 11: Viết store cho phép người dùng xóa phòng ban bằng cách người dùng
-- nhập vào tên phòng ban và các account thuộc phòng ban đó sẽ được
-- chuyển về phòng ban default là phòng ban chờ việc
DROP PROCEDURE IF EXISTS sp_cau_11;
DELIMITER $$
CREATE PROCEDURE sp_cau_11 (IN in_department_name VARCHAR(50))
BEGIN
    DECLARE d_id TINYINT UNSIGNED;
    
    SELECT department_id INTO d_id
    FROM department
    WHERE department_name = in_department_name;
    
    UPDATE `account`
    SET department_id = 11
    WHERE department_id = d_id;
    
    DELETE FROM department
    WHERE department_id = d_id;
END $$
DELIMITER ;

CALL sp_cau_11('Bảo vệ');

-- Câu 12: Viết store để in ra mỗi tháng có bao nhiêu câu hỏi được tạo trong năm nay
DROP PROCEDURE IF EXISTS sp_cau_12;
DELIMITER $$
CREATE PROCEDURE sp_cau_12 ()
BEGIN
    WITH RECURSIVE cte_12_months (`month`) AS (
        SELECT 1
        UNION ALL
        SELECT `month` + 1
        FROM cte_12_months
        WHERE `month` < 12
    ), c2 AS (
        SELECT question_id, MONTH(created_date) AS `month`
        FROM question
        WHERE YEAR(CURRENT_DATE) = YEAR(created_date)
    )
    SELECT `month`, COUNT(question_id) AS total_questions
    FROM cte_12_months
    LEFT JOIN c2 USING(`month`)
    GROUP BY `month`;
END $$
DELIMITER ;

CALL sp_cau_12();

-- Câu 13: Viết store để in ra mỗi tháng có bao nhiêu câu hỏi được tạo trong 6 tháng gần đây nhất
-- (Nếu tháng nào không có thì sẽ in ra là "Không có câu hỏi nào trong tháng")
DROP PROCEDURE IF EXISTS sp_cau_13;
DELIMITER $$
CREATE PROCEDURE sp_cau_13 ()
BEGIN
    WITH RECURSIVE cte_last_6_months (n, `date`) AS (
        SELECT 1, CURRENT_DATE - INTERVAL 1 MONTH
        UNION ALL
        SELECT n + 1, `date` - INTERVAL 1 MONTH
        FROM cte_last_6_months
        WHERE n < 6
    ), c1 AS (
        SELECT EXTRACT(YEAR_MONTH FROM `date`) AS `year_month`
        FROM cte_last_6_months
    ), c2 AS (
        SELECT question_id, EXTRACT(YEAR_MONTH FROM created_date) AS `year_month`
        FROM question
    )
    SELECT `year_month`, 
        CASE WHEN COUNT(question_id) = 0
            THEN 'Không có câu hỏi nào trong tháng'
            ELSE COUNT(question_id)
        END AS total_questions
    FROM c1
    LEFT JOIN c2 USING(`year_month`)
    GROUP BY `year_month`;
END $$
DELIMITER ;

CALL sp_cau_13();
