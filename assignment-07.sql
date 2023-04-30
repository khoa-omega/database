DROP DATABASE IF EXISTS assignment_07;
CREATE DATABASE assignment_07;
USE assignment_07;

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
-- Câu 1: Tạo trigger không cho phép người dùng nhập vào group có ngày tạo trước 1 năm trước
DROP TRIGGER IF EXISTS trigger_01;
DELIMITER $$
CREATE TRIGGER trigger_01
BEFORE INSERT ON `groups`
FOR EACH ROW
BEGIN
    IF NEW.created_date < CURRENT_DATE - INTERVAL 1 YEAR THEN
        SIGNAL SQLSTATE '11111'
        SET MESSAGE_TEXT = 'Không thể tạo group trước 1 năm trước.';
    END IF;
END $$
DELIMITER ;

INSERT INTO `groups` (group_name, creator_id, created_date )
VALUES               ('MySQL'   , '5'       , '2011-03-05');

-- Câu 2: Tạo trigger không cho phép người dùng thêm bất kỳ user nào vào
-- department "Sale" nữa, khi thêm thì hiện ra thông báo "Department
-- "Sale" cannot add more user"
DROP TRIGGER IF EXISTS trigger_02;
DELIMITER $$
CREATE TRIGGER trigger_02
BEFORE INSERT ON accounts
FOR EACH ROW
BEGIN
    DECLARE v_sale_id INT;

    SELECT department_id INTO v_sale_id
    FROM departments
    WHERE department_name = 'Sale';

    IF NEW.department_id = v_sale_id THEN
        SIGNAL SQLSTATE '22222'
        SET MESSAGE_TEXT = 'Department "Sale" can NOT add more user.';
    END IF;
END $$
DELIMITER ;

INSERT INTO accounts (full_name        , email               , username , department_id, position_id)
VALUES               ('Nguyễn Văn Khoa', 'nvkhoa05@gmail.com', 'khoa.nv', 2            , 2          );

-- Câu 3: Cấu hình 1 group có nhiều nhất là 5 users
DROP TRIGGER IF EXISTS trigger_03;
DELIMITER $$
CREATE TRIGGER trigger_03
BEFORE INSERT ON groups_accounts
FOR EACH ROW
BEGIN
    DECLARE v_num_accounts TINYINT UNSIGNED;
    
    SELECT COUNT(account_id) INTO v_num_accounts
    FROM groups_accounts
    WHERE group_id = NEW.group_id;
    
    IF v_num_accounts >= 5 THEN
        SIGNAL SQLSTATE '33333'
        SET MESSAGE_TEXT = 'Một nhóm có tối đa 5 người.';
    END IF;
END $$
DELIMITER ;

-- Câu 4: Cấu hình 1 bài thi có nhiều nhất là 10 questions
DROP TRIGGER IF EXISTS trigger_04;
DELIMITER $$
CREATE TRIGGER trigger_04
BEFORE INSERT ON exams_questions
FOR EACH ROW
BEGIN
    DECLARE v_num_questions TINYINT UNSIGNED;

    SELECT COUNT(question_id) INTO v_num_questions
    FROM exams_questions
    WHERE exam_id = NEW.exam_id;

    IF v_num_questions >= 10 THEN
        SIGNAL SQLSTATE '44444'
        SET MESSAGE_TEXT = 'Một bài thi có tối đa 10 câu hỏi.';
    END IF;
END $$
DELIMITER ;

-- Câu 5: Tạo trigger không cho phép người dùng xóa tài khoản có email là
-- admin@gmail.com (đây là tài khoản admin, không cho phép user xóa),
-- còn lại các tài khoản khác thì sẽ cho phép xóa và sẽ xóa tất cả các thông
-- tin liên quan tới user đó
DROP TRIGGER IF EXISTS trigger_05;
DELIMITER $$
CREATE TRIGGER trigger_05
BEFORE DELETE ON accounts
FOR EACH ROW
BEGIN
    IF OLD.email = 'admin@gmail.com' THEN
        SIGNAL SQLSTATE '55555'
        SET MESSAGE_TEXT = 'Không thể xóa tài khoản của admin.';
    END IF;
END $$
DELIMITER ;

DELETE FROM accounts
WHERE email = 'admin@gmail.com';

-- Câu 6: Không sử dụng cấu hình default cho field department_id của table
-- account, hãy tạo trigger cho phép người dùng khi tạo account không điền
-- vào department_id thì sẽ được phân vào phòng ban "Waiting Room"
DROP TRIGGER IF EXISTS trigger_06;
DELIMITER $$
CREATE TRIGGER trigger_06
BEFORE INSERT ON accounts
FOR EACH ROW
BEGIN
    IF NEW.department_id IS NULL THEN
        SET NEW.department_id = 11;
    END IF;
END $$
DELIMITER ;

-- Câu 7: Cấu hình 1 bài thi chỉ cho phép user tạo tối đa 4 answers cho mỗi
-- question, trong đó có tối đa 2 đáp án đúng.
DROP TRIGGER IF EXISTS trigger_07;
DELIMITER $$
CREATE TRIGGER trigger_07
BEFORE INSERT ON answers
FOR EACH ROW
BEGIN
    DECLARE v_num_answers INT;
    DECLARE v_num_correct_answers INT;

    SELECT COUNT(answer_id) INTO v_num_answers
    FROM answers
    WHERE question_id = NEW.question_id;

    IF v_num_answers >= 4 THEN
        SIGNAL SQLSTATE '77777'
        SET MESSAGE_TEXT = 'Một câu hỏi có tối đa 4 câu trả lời.';
    END IF;

    SELECT COUNT(answer_id) INTO v_num_correct_answers
    FROM answers
    WHERE question_id = NEW.question_id AND is_correct = TRUE;

    IF v_num_correct_answers >= 2 THEN
        SIGNAL SQLSTATE '77777'
        SET MESSAGE_TEXT = 'Một câu hỏi có tối đa 2 câu trả lời đúng.';
    END IF;
END $$
DELIMITER ;

-- Câu 8: Viết trigger sửa lại dữ liệu cho đúng:
-- Nếu người dùng nhập vào gender của account là nam, nữ, chưa xác định
-- thì sẽ đổi lại thành M, F, U cho giống với cấu hình ở database

-- Câu 9: Viết trigger không cho phép người dùng xóa bài thi mới tạo được 2 ngày
DROP TRIGGER IF EXISTS trigger_09;
DELIMITER $$
CREATE TRIGGER trigger_09
BEFORE DELETE ON exams
FOR EACH ROW
BEGIN
    IF OLD.created_date > CURRENT_DATE - INTERVAL 2 DAY THEN
        SIGNAL SQLSTATE '99999'
        SET MESSAGE_TEXT = 'Không thể xóa bài thi mới tạo được 2 ngày.';
    END IF;
END $$
DELIMITER ;

-- Câu 10: Viết trigger chỉ cho phép người dùng chỉ được update, delete các
-- question khi question đó chưa nằm trong exam nào
DROP TRIGGER IF EXISTS trigger_10_update;
DELIMITER $$
CREATE TRIGGER trigger_10_update
BEFORE UPDATE ON questions
FOR EACH ROW
BEGIN
    DECLARE v_num_exams INT;

    SELECT COUNT(exam_id) INTO v_num_exams
    FROM exams_questions
    WHERE question_id = OLD.question_id;

    IF v_num_exams > 0 THEN
        SIGNAL SQLSTATE '10101'
        SET MESSAGE_TEXT = 'Không thể cập nhật câu hỏi này.';
    END IF;
END $$
DELIMITER ;

DROP TRIGGER IF EXISTS trigger_10_delete;
DELIMITER $$
CREATE TRIGGER trigger_10_delete
BEFORE DELETE ON question
FOR EACH ROW
BEGIN
    DECLARE v_num_exams TINYINT UNSIGNED;

    SELECT COUNT(exam_id) INTO v_num_exams
    FROM exams_questions
    WHERE question_id = OLD.question_id;

    IF v_num_exams > 0 THEN
        SIGNAL SQLSTATE '10101'
        SET MESSAGE_TEXT = 'Không thể xóa câu hỏi này.';
    END IF;
END $$
DELIMITER ;

-- Câu 12: Lấy ra thông tin exam trong đó:
-- duration <= 30 thì sẽ đổi thành giá trị "Short time"
-- 30 < duration <= 60 thì sẽ đổi thành giá trị "Medium time"
-- duration > 60 thì sẽ đổi thành giá trị "Long time"
SELECT *,
    CASE
        WHEN duration <= 30 THEN 'Short time'
        WHEN duration <= 60 THEN 'Medium time'
        ELSE 'Long time'
    END AS duration_type
FROM exams;

-- Câu 13: Thống kê số account trong mỗi group và in ra thêm 1 column nữa có tên
-- là the_number_user_amount và mang giá trị được quy định như sau:
-- Nếu số lượng user trong group <= 5 thì sẽ có giá trị là few
-- Nếu số lượng user trong group <= 20 và > 5 thì sẽ có giá trị là normal
-- Nếu số lượng user trong group > 20 thì sẽ có giá trị là higher
SELECT group_name, COUNT(account_id) AS num_accounts,
    CASE
        WHEN COUNT(account_id) <= 5 THEN 'Few'
        WHEN COUNT(account_id) <= 20 THEN 'Normal'
        ELSE 'Higher'
    END AS the_number_user_amount
FROM `groups`
LEFT JOIN groups_accounts USING(group_id)
GROUP BY group_id;

-- Câu 14: Thống kê số mỗi phòng ban có bao nhiêu user, nếu phòng ban nào
-- không có user thì sẽ thay đổi giá trị 0 thành "Không có user"
SELECT department_name,
    CASE
        WHEN COUNT(account_id) = 0 THEN 'Không có user'
        ELSE COUNT(account_id)
    END AS num_accounts
FROM departments
LEFT JOIN accounts USING(department_id)
GROUP BY department_id;
