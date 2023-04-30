DROP DATABASE IF EXISTS assignment_06;
CREATE DATABASE assignment_06;
USE assignment_06;

-- Tạo bảng departments
DROP TABLE IF EXISTS departments;
CREATE TABLE departments (
    department_id INT PRIMARY KEY AUTO_INCREMENT,
    department_name VARCHAR(50) UNIQUE NOT NULL
);

-- Tạo bảng positions
DROP TABLE IF EXISTS positions;
CREATE TABLE positions (
    position_id INT PRIMARY KEY AUTO_INCREMENT,
    position_name ENUM('DEVELOPER', 'TESTER', 'SCRUM_MASTER', 'PROJECT_MANAGER') UNIQUE NOT NULL
);

-- Tạo bảng accounts
DROP TABLE IF EXISTS accounts;
CREATE TABLE accounts (
    account_id INT PRIMARY KEY AUTO_INCREMENT,
    email VARCHAR(50) UNIQUE NOT NULL,
    username VARCHAR(50) UNIQUE NOT NULL,
    full_name VARCHAR(50) NOT NULL,
    department_id INT NOT NULL,
    position_id INT NOT NULL,
    created_date DATE NOT NULL DEFAULT (CURRENT_DATE),
    FOREIGN KEY (department_id)
        REFERENCES departments (department_id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (position_id)
        REFERENCES positions (position_id)
        ON DELETE CASCADE ON UPDATE CASCADE
);

-- Tạo bảng groups
DROP TABLE IF EXISTS `groups`;
CREATE TABLE IF NOT EXISTS `groups` (
    group_id INT PRIMARY KEY AUTO_INCREMENT,
    group_name VARCHAR(50) UNIQUE NOT NULL,
    creator_id INT NOT NULL,
    created_date DATE NOT NULL DEFAULT (CURRENT_DATE),
    FOREIGN KEY (creator_id)
        REFERENCES accounts (account_id)
        ON DELETE CASCADE ON UPDATE CASCADE
);

-- Tạo bảng groups_accounts
DROP TABLE IF EXISTS groups_accounts;
CREATE TABLE groups_accounts (
    group_id INT NOT NULL,
    account_id INT NOT NULL,
    joined_date DATE NOT NULL DEFAULT (CURRENT_DATE),
    PRIMARY KEY (group_id , account_id),
    FOREIGN KEY (group_id)
        REFERENCES `groups` (group_id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (account_id)
        REFERENCES accounts (account_id)
        ON DELETE CASCADE ON UPDATE CASCADE
);

-- Tạo bảng question_types
DROP TABLE IF EXISTS question_types;
CREATE TABLE question_types (
    type_id INT PRIMARY KEY AUTO_INCREMENT,
    type_name ENUM('ESSAY', 'MULTIPLE_CHOICE') UNIQUE NOT NULL
);

-- Tạo bảng question_categories
DROP TABLE IF EXISTS question_categories;
CREATE TABLE question_categories (
    category_id INT PRIMARY KEY AUTO_INCREMENT,
    category_name VARCHAR(50) UNIQUE NOT NULL
);

-- Tạo bảng questions
DROP TABLE IF EXISTS questions;
CREATE TABLE questions (
    question_id INT PRIMARY KEY AUTO_INCREMENT,
    content VARCHAR(50) NOT NULL,
    category_id INT NOT NULL,
    type_id INT NOT NULL,
    creator_id INT NOT NULL,
    created_date DATE NOT NULL DEFAULT (CURRENT_DATE),
    FOREIGN KEY (category_id)
        REFERENCES question_categories (category_id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (type_id)
        REFERENCES question_types (type_id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (creator_id)
        REFERENCES accounts (account_id)
        ON DELETE CASCADE ON UPDATE CASCADE
);

-- Tạo bảng answers
DROP TABLE IF EXISTS answers;
CREATE TABLE answers (
    answer_id INT PRIMARY KEY AUTO_INCREMENT,
    content VARCHAR(50) NOT NULL,
    question_id INT NOT NULL,
    is_correct BOOLEAN NOT NULL,
    FOREIGN KEY (question_id)
        REFERENCES questions (question_id)
        ON DELETE CASCADE ON UPDATE CASCADE
);

-- Tạo bảng exams
DROP TABLE IF EXISTS exams;
CREATE TABLE exams (
    exam_id INT PRIMARY KEY AUTO_INCREMENT,
    code CHAR(10) NOT NULL,
    title VARCHAR(50) NOT NULL,
    category_id INT NOT NULL,
    duration INT NOT NULL,
    creator_id INT NOT NULL,
    created_date DATE  NOT NULL DEFAULT (CURRENT_DATE),
    FOREIGN KEY (category_id)
        REFERENCES question_categories (category_id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (creator_id)
        REFERENCES accounts (account_id)
        ON DELETE CASCADE ON UPDATE CASCADE
);

-- Tạo bảng exams_questions
DROP TABLE IF EXISTS exams_questions;
CREATE TABLE exams_questions (
    exam_id INT NOT NULL,
    question_id INT NOT NULL,
    PRIMARY KEY (exam_id , question_id),
    FOREIGN KEY (exam_id)
        REFERENCES exams (exam_id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (question_id)
        REFERENCES questions (question_id)
        ON DELETE CASCADE ON UPDATE CASCADE
);

-- Thêm dữ liệu vào bảng departments
INSERT INTO departments (department_name)
VALUES                  ('Marketing'    ),
                        ('Sale'         ),
                        ('Bảo vệ'       ),
                        ('Nhân sự'      ),
                        ('Kỹ thuật'     ),
                        ('Tài chính'    ),
                        ('Phò giám đốc' ),
                        ('Giám đốc'     ),
                        ('Thư kí'       ),
                        ('Bán hàng'     );

-- Thêm dữ liệu vào bảng positions
INSERT INTO positions (position_name    )
VALUES                ('DEVELOPER'      ),
                      ('TESTER'         ),
                      ('SCRUM_MASTER'   ),
                      ('PROJECT_MANAGER');

-- Thêm dữ liệu vào bảng accounts
INSERT INTO accounts (email                           , username      , full_name           , department_id, position_id, created_date)
VALUES               ('haidang29productions@gmail.com', 'dangblack'   , 'Nguyen Hai Dang'   , 5            , 1          , '2020-03-05'),
                     ('account1@gmail.com'            , 'quanganh'    , 'Tong Quang Anh'    , 1            , 2          , '2020-03-05'),
                     ('account2@gmail.com'            , 'vanchien'    , 'Nguyen Van Chien'  , 2            , 3          , '2020-03-07'),
                     ('account3@gmail.com'            , 'cocoduongqua', 'Duong Do'          , 3            , 4          , '2020-03-08'),
                     ('account4@gmail.com'            , 'doccocaubai' , 'Nguyen Chien Thang', 4            , 4          , '2020-03-10'),
                     ('dapphatchetngay@gmail.com'     , 'khabanh'     , 'Ngo Ba Kha'        , 6            , 3          , '2020-04-05'),
                     ('songcodaoly@gmail.com'         , 'huanhoahong' , 'Bui Xuan Huan'     , 7            , 2          , '2020-04-05'),
                     ('sontungmtp@gmail.com'          , 'tungnui'     , 'Nguyen Thanh Tung' , 8            , 1          , '2020-04-07'),
                     ('duongghuu@gmail.com'           , 'duongghuu'   , 'Duong Van Huu'     , 9            , 2          , '2020-04-07'),
                     ('vtiaccademy@gmail.com'         , 'vtiaccademy' , 'Vi Ti Ai'          , 10           , 1          , '2020-04-09');

-- Thêm dữ liệu vào bảng groups
INSERT INTO `groups` (group_name         , creator_id, created_date)
VALUES               ('Testing System'   , 5         , '2019-03-05'),
                     ('Developement'     , 1         , '2020-03-07'),
                     ('VTI Sale 01'      , 2         , '2020-03-09'),
                     ('VTI Sale 02'      , 3         , '2020-03-10'),
                     ('VTI Sale 03'      , 4         , '2020-03-28'),
                     ('VTI Creator'      , 6         , '2020-04-06'),
                     ('VTI Marketing 01' , 7         , '2020-04-07'),
                     ('Management'       , 8         , '2020-04-08'),
                     ('Chat with love'   , 9         , '2020-04-09'),
                     ('Vi Ti Ai'         , 10        , '2020-04-10');

-- Thêm dữ liệu vào bảng groups_accounts
INSERT INTO groups_accounts (group_id, account_id, joined_date )
VALUES                      (1       , 1         , '2019-03-05'),
                            (2       , 2         , '2020-03-07'),
                            (3       , 3         , '2020-03-09'),
                            (4       , 4         , '2020-03-10'),
                            (5       , 5         , '2020-03-28'),
                            (6       , 6         , '2020-04-06'),
                            (7       , 7         , '2020-04-07'),
                            (8       , 8         , '2020-04-08'),
                            (9       , 9         , '2020-04-09'),
                            (10      , 10        , '2020-04-10');

-- Thêm dữ liệu vào bảng question_types
INSERT INTO question_types (type_name) VALUES ('ESSAY'), ('MULTIPLE_CHOICE'); 

-- Thêm dữ liệu vào bảng question_categories
INSERT INTO question_categories (category_name)
VALUES                          ('Java'       ),
                                ('ASP.NET'    ),
                                ('ADO.NET'    ),
                                ('SQL'        ),
                                ('Postman'    ),
                                ('Ruby'       ),
                                ('Python'     ),
                                ('C++'        ),
                                ('C Sharp'    ),
                                ('PHP'        ); 

-- Thêm dữ liệu vào bảng questions
INSERT INTO questions (content          , category_id, type_id, creator_id, created_date)
VALUES                ('Câu hỏi về Java', 1          , 1      , 1         , '2020-04-05'),
                      ('Câu Hỏi về PHP' , 10         , 2      , 2         , '2020-04-05'),
                      ('Hỏi về C#'      , 9          , 2      , 3         , '2020-04-06'),
                      ('Hỏi về Ruby'    , 6          , 1      , 4         , '2020-04-06'),
                      ('Hỏi về Postman' , 5          , 1      , 5         , '2020-04-06'),
                      ('Hỏi về ADO.NET' , 3          , 2      , 6         , '2020-04-06'),
                      ('Hỏi về ASP.NET' , 2          , 1      , 7         , '2020-04-06'),
                      ('Hỏi về C++'     , 8          , 1      , 8         , '2020-04-07'),
                      ('Hỏi về SQL'     , 4          , 2      , 9         , '2020-04-07'),
                      ('Hỏi về Python'  , 7          , 1      , 10        , '2020-04-07');

-- Thêm dữ liệu vào bảng answers
INSERT INTO answers (content     , question_id, is_correct)
VALUES              ('Trả lời 01', 1          , TRUE      ),
                    ('Trả lời 02', 1          , TRUE      ),
                    ('Trả lời 03', 1          , FALSE     ),
                    ('Trả lời 04', 1          , TRUE      ),
                    ('Trả lời 05', 2          , TRUE      ),
                    ('Trả lời 06', 3          , TRUE      ),
                    ('Trả lời 07', 4          , FALSE     ),
                    ('Trả lời 08', 8          , FALSE     ),
                    ('Trả lời 09', 9          , TRUE      ),
                    ('Trả lời 10', 10         , TRUE      );

-- Thêm dữ liệu vào bảng exams
INSERT INTO exams (`code`   , title           , category_id, duration, creator_id, created_date)
VALUES            ('VTIQ001', 'Đề thi C#'     , 1          , 60      , 5         , '2019-04-05'),
                  ('VTIQ002', 'Đề thi PHP'    , 10         , 60      , 1         , '2019-04-05'),
                  ('VTIQ003', 'Đề thi C++'    , 9          , 120     , 2         , '2019-04-07'),
                  ('VTIQ004', 'Đề thi Java'   , 6          , 60      , 3         , '2020-04-08'),
                  ('VTIQ005', 'Đề thi Ruby'   , 5          , 120     , 4         , '2020-04-10'),
                  ('VTIQ006', 'Đề thi Postman', 3          , 60      , 6         , '2020-04-05'),
                  ('VTIQ007', 'Đề thi SQL'    , 2          , 60      , 7         , '2020-04-05'),
                  ('VTIQ008', 'Đề thi Python' , 8          , 60      , 8         , '2020-04-07'),
                  ('VTIQ009', 'Đề thi ADO.NET', 4          , 90      , 9         , '2020-04-07'),
                  ('VTIQ010', 'Đề thi ASP.NET', 7          , 90      , 10        , '2020-04-08');

-- Thêm dữ liệu vào bảng exams_questions
INSERT INTO exams_questions (question_id, exam_id)
VALUES                      (1          , 1      ),
                            (2          , 2      ),
                            (3          , 3      ),
                            (4          , 4      ),
                            (5          , 5      ),
                            (6          , 6      ),
                            (7          , 7      ),
                            (8          , 8      ),
                            (9          , 9      ),
                            (10         , 10     );

-- Câu 1: Tạo store để người dùng nhập vào tên phòng ban và in ra tất cả các
-- account thuộc phòng ban đó
DROP PROCEDURE IF EXISTS sp_01;
DELIMITER $$
CREATE PROCEDURE sp_01 (IN in_department_name VARCHAR(50))
BEGIN
    SELECT *
    FROM accounts
    WHERE department_id =
        (SELECT department_id
        FROM departments
        WHERE department_name = in_department_name);
END $$
DELIMITER ;

CALL sp_01('Giám đốc');

-- Câu 2: Tạo store để in ra số lượng account trong mỗi group
DROP PROCEDURE IF EXISTS sp_02;
DELIMITER $$
CREATE PROCEDURE sp_02 ()
BEGIN
    SELECT group_name, COUNT(account_id) AS num_accounts
    FROM `groups`
    LEFT JOIN groups_accounts USING (group_id)
    GROUP BY group_id;
END $$
DELIMITER ;

CALL sp_02();

-- Câu 3: Tạo store để thống kê mỗi type question có bao nhiêu question được tạo
-- trong tháng hiện tại
DROP PROCEDURE IF EXISTS sp_03;
DELIMITER $$
CREATE PROCEDURE sp_03 ()
BEGIN
    SELECT type_name, COUNT(question_id) AS num_questions
    FROM question_types
    LEFT JOIN questions USING (type_id)
    WHERE EXTRACT(YEAR_MONTH FROM created_date) = EXTRACT(YEAR_MONTH FROM CURRENT_DATE)
    GROUP BY type_id;
END $$
DELIMITER ;

CALL sp_03();

-- Câu 4: Tạo store để trả ra id của type question có nhiều câu hỏi nhất
DROP FUNCTION IF EXISTS fn_04;
DELIMITER $$
CREATE FUNCTION fn_04 () RETURNS INT
BEGIN
    DECLARE v_type_id INT;

    WITH c1 AS (
        SELECT type_id, COUNT(question_id) AS num_questions
        FROM question_types
        JOIN questions USING (type_id)
        GROUP BY type_id
    )
    SELECT type_id INTO v_type_id
    FROM c1
    WHERE num_questions =
        (SELECT MAX(num_questions)
        FROM c1);
        
    RETURN v_type_id;
END $$
DELIMITER ;

SELECT fn_04();

-- Câu 5: Sử dụng store ở question 4 để tìm ra tên của type question
DROP PROCEDURE IF EXISTS sp_05;
DELIMITER $$
CREATE PROCEDURE sp_05 ()
BEGIN
    SELECT type_name
    FROM question_types
    WHERE type_id = fn_04();
END $$
DELIMITER ;

CALL sp_05();

-- Câu 6: Viết 1 store cho phép người dùng nhập vào 1 chuỗi và trả về group có tên
-- chứa chuỗi của người dùng nhập vào hoặc trả về user có username chứa
-- chuỗi của người dùng nhập vào
DROP PROCEDURE IF EXISTS sp_06;
DELIMITER $$
CREATE PROCEDURE sp_06 (IN search VARCHAR(50))
BEGIN
    SELECT 'Group' AS type, group_name AS name
    FROM `groups`
    WHERE group_name LIKE CONCAT('%', search, '%')
    UNION
    SELECT 'Account' AS type, username AS name
    FROM accounts
    WHERE username LIKE CONCAT('%', search, '%');
END $$
DELIMITER ;

CALL sp_06('g');

-- Câu 7: Viết 1 store cho phép người dùng nhập vào thông tin full name, email và trong store sẽ tự động gán:
--     * username sẽ giống email nhưng bỏ phần @..mail đi
--     * position_id: sẽ có default là developer
--     * department_id: sẽ được cho vào 1 phòng chờ
-- Sau đó in ra kết quả tạo thành công
DROP PROCEDURE IF EXISTS sp_07;
DELIMITER $$
CREATE PROCEDURE sp_07 (IN in_full_name VARCHAR(50), IN in_email VARCHAR(50))
BEGIN
    DECLARE v_username VARCHAR(50) DEFAULT SUBSTRING_INDEX(in_email, '@', 1);
    DECLARE v_position_id INT DEFAULT 1;
    DECLARE v_department_id INT DEFAULT 11;

    INSERT INTO accounts (full_name   , email   , username  , position_id  , department_id  )
    VALUES               (in_full_name, in_email, v_username, v_position_id, v_department_id);

    SELECT *
    FROM accounts
    ORDER BY created_date DESC
    LIMIT 1;
END $$
DELIMITER ;

CALL sp_07('Nguyễn Văn Khoa', 'nvkhoa05@gmail.com');

-- Câu 8: Viết 1 store cho phép người dùng nhập vào ESSAY hoặc MULTIPLE_CHOICE
-- để thống kê câu hỏi ESSAY hoặc MULTIPLE_CHOICE nào có content dài nhất
DROP PROCEDURE IF EXISTS sp_08;
DELIMITER $$
CREATE PROCEDURE sp_08 (IN in_type_name ENUM('ESSAY', 'MULTIPLE_CHOICE'))
BEGIN
    WITH c1 AS (
        SELECT *, CHAR_LENGTH(content) AS content_length
        FROM questions
        WHERE type_id =
            (SELECT type_id
            FROM question_types
            WHERE type_name = in_type_name)
    )
    SELECT *
    FROM c1
    WHERE content_length =
        (SELECT MAX(content_length)
        FROM c1);
END $$
DELIMITER ;

CALL sp_08('ESSAY');

-- Câu 9: Viết 1 store cho phép người dùng xóa exam dựa vào id
DROP PROCEDURE IF EXISTS sp_09;
DELIMITER $$
CREATE PROCEDURE sp_09 (IN in_exam_id INT)
BEGIN
    DELETE FROM exams
    WHERE exam_id = in_exam_id;
END $$
DELIMITER ;

CALL sp_09(1);

-- Câu 10: Tìm ra các exam được tạo từ 3 năm trước và xóa các exam đó đi (sử dụng store ở câu 9 để xóa)
-- Sau đó in số lượng record đã remove từ các table liên quan trong khi removing
DROP PROCEDURE IF EXISTS sp_10;
DELIMITER $$
CREATE PROCEDURE sp_10 ()
BEGIN
    DECLARE v_removed INT;
    DECLARE v_removed_exams INT;
    DECLARE v_removed_exams_questions INT;

    SELECT COUNT(exam_id) INTO v_removed_exams
    FROM exams
    WHERE created_date < CURRENT_DATE - INTERVAL 3 YEAR;
    
    SELECT COUNT(exam_id) INTO v_removed_exams_questions
    FROM exams_questions
    JOIN exams USING (exam_id)
    WHERE created_date < CURRENT_DATE - INTERVAL 3 YEAR;
    
    SET v_removed = v_removed_exams + v_removed_exams_questions;
    
    DELETE FROM exams
    WHERE created_date < CURRENT_DATE - INTERVAL 3 YEAR;
    
    SELECT CONCAT('Số bản ghi đã bị xóa là: ', v_removed) AS message;
END $$
DELIMITER ;

CALL sp_10();

-- Câu 11: Viết store cho phép người dùng xóa phòng ban bằng cách người dùng
-- nhập vào tên phòng ban và các account thuộc phòng ban đó sẽ được
-- chuyển về phòng ban default là phòng ban chờ việc
DROP PROCEDURE IF EXISTS sp_11;
DELIMITER $$
CREATE PROCEDURE sp_11 (IN in_department_name VARCHAR(50))
BEGIN
    DECLARE v_department_id TINYINT UNSIGNED;
    
    SELECT department_id INTO v_department_id
    FROM departments
    WHERE department_name = in_department_name;
    
    UPDATE accounts
    SET department_id = 11
    WHERE department_id = v_department_id;
    
    DELETE FROM departments
    WHERE department_id = v_department_id;
END $$
DELIMITER ;

CALL sp_11('Bảo vệ');

-- Câu 12: Viết store để in ra mỗi tháng có bao nhiêu câu hỏi được tạo trong năm nay
DROP PROCEDURE IF EXISTS sp_12;
DELIMITER $$
CREATE PROCEDURE sp_12 ()
BEGIN
    SELECT month, COUNT(question_id) AS num_questions
    FROM
        (SELECT 1 AS month
        UNION
        SELECT 2 AS month
        UNION
        SELECT 3 AS month
        UNION
        SELECT 4 AS month
        UNION
        SELECT 5 AS month
        UNION
        SELECT 6 AS month
        UNION
        SELECT 7 AS month
        UNION
        SELECT 8 AS month
        UNION
        SELECT 9 AS month
        UNION
        SELECT 10 AS month
        UNION
        SELECT 11 AS month
        UNION
        SELECT 12 AS month) AS t1
    LEFT JOIN
        (SELECT MONTH(created_date) AS month, question_id
        FROM questions
        WHERE YEAR(created_date) = YEAR(CURRENT_DATE)) AS t2 USING (month)
    GROUP BY month;
END $$
DELIMITER ;

CALL sp_12();

-- Câu 13: Viết store để in ra mỗi tháng có bao nhiêu câu hỏi được tạo trong 6 tháng gần đây nhất
-- (Nếu tháng nào không có thì sẽ in ra là "Không có câu hỏi nào trong tháng")
DROP PROCEDURE IF EXISTS sp_13;
DELIMITER $$
CREATE PROCEDURE sp_13 ()
BEGIN
    SELECT year, month, IF (COUNT(question_id) = 0, 'Không có câu hỏi nào trong tháng', COUNT(question_id)) AS num_questions
    FROM
        (SELECT YEAR(CURRENT_DATE - INTERVAL 1 MONTH) AS year, MONTH(CURRENT_DATE - INTERVAL 1 MONTH) AS month
        UNION
        SELECT YEAR(CURRENT_DATE - INTERVAL 2 MONTH) AS year, MONTH(CURRENT_DATE - INTERVAL 2 MONTH) AS month
        UNION
        SELECT YEAR(CURRENT_DATE - INTERVAL 3 MONTH) AS year, MONTH(CURRENT_DATE - INTERVAL 3 MONTH) AS month
        UNION
        SELECT YEAR(CURRENT_DATE - INTERVAL 4 MONTH) AS year, MONTH(CURRENT_DATE - INTERVAL 4 MONTH) AS month
        UNION
        SELECT YEAR(CURRENT_DATE - INTERVAL 5 MONTH) AS year, MONTH(CURRENT_DATE - INTERVAL 5 MONTH) AS month
        UNION
        SELECT YEAR(CURRENT_DATE - INTERVAL 6 MONTH) AS year, MONTH(CURRENT_DATE - INTERVAL 6 MONTH) AS month) AS t1
    LEFT JOIN
        (SELECT YEAR(created_date) AS year, MONTH(created_date) AS month, question_id
        FROM questions) AS t2 USING (year, month)
    GROUP BY year, month;
END $$
DELIMITER ;

CALL sp_13();
