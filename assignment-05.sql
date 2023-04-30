DROP DATABASE IF EXISTS assignment_05;
CREATE DATABASE assignment_05;
USE assignment_05;

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

-- Câu 1: Tạo view có chứa danh sách nhân viên thuộc phòng ban sale
CREATE OR REPLACE VIEW view_01 AS
SELECT *
FROM accounts
WHERE department_id =
    (SELECT department_id
    FROM departments
    WHERE department_name = 'Sale');

-- Câu 2: Tạo view có chứa thông tin các account tham gia vào nhiều group nhất
CREATE OR REPLACE VIEW view_02 AS
WITH c1 AS (
    SELECT accounts.*, COUNT(group_id) AS num_groups
    FROM groups_accounts
    JOIN accounts USING (account_id)
    GROUP BY account_id
)
SELECT *
FROM c1
WHERE num_groups =
    (SELECT MAX(num_groups)
    FROM c1);

-- Câu 3: Tạo view có chứa câu hỏi có những content quá dài (content quá 300 từ
-- được coi là quá dài) và xóa nó đi
CREATE OR REPLACE VIEW view_03 AS
SELECT *
FROM questions
WHERE LENGTH(content) - LENGTH(REPLACE(content, ' ', '')) + 1 > 300;

DELETE FROM view_03;

-- Câu 4: Tạo view có chứa danh sách các phòng ban có nhiều nhân viên nhất
CREATE OR REPLACE VIEW view_04 AS
WITH c1 AS (
    SELECT departments.*, COUNT(account_id) AS num_accounts
    FROM accounts
    JOIN departments USING (department_id)
    GROUP BY department_id
)
SELECT *
FROM c1
WHERE num_accounts =
    (SELECT MAX(num_accounts)
    FROM c1);

-- Câu 5: Tạo view có chứa tất các các câu hỏi do user họ Nguyễn tạo
CREATE OR REPLACE VIEW view_05 AS
SELECT q.*
FROM questions AS q
JOIN accounts AS a ON q.creator_id = a.account_id
WHERE full_name LIKE 'Nguyễn %';
