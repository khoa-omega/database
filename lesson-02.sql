DROP DATABASE IF EXISTS lesson_02;
CREATE DATABASE lesson_02;
USE lesson_02;

-- Tạo bảng department
DROP TABLE IF EXISTS department;
CREATE TABLE department (
    department_id TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    department_name VARCHAR(50) UNIQUE NOT NULL
);

-- Tạo bảng position
DROP TABLE IF EXISTS position;
CREATE TABLE position (
    position_id TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    position_name ENUM("Dev", "Test", "Scrum Master", "PM") UNIQUE NOT NULL
);

-- Tạo bảng account
DROP TABLE IF EXISTS account;
CREATE TABLE account (
    account_id TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    email VARCHAR(50) UNIQUE NOT NULL,
    username VARCHAR(50) UNIQUE NOT NULL,
    full_name VARCHAR(50) NOT NULL,
    department_id TINYINT UNSIGNED,
    position_id TINYINT UNSIGNED,
    created_date DATE NOT NULL,
    FOREIGN KEY (department_id) REFERENCES department (department_id),
    FOREIGN KEY (position_id) REFERENCES position (position_id)
);

-- Tạo bảng group
DROP TABLE IF EXISTS `group`;
CREATE TABLE `group` (
    group_id TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    group_name VARCHAR(50) UNIQUE NOT NULL,
    creator_id TINYINT UNSIGNED,
    created_date DATE NOT NULL DEFAULT (CURRENT_DATE),
    FOREIGN KEY (creator_id) REFERENCES account (account_id)
);

-- Tạo bảng group_account
DROP TABLE IF EXISTS group_account;
CREATE TABLE group_account (
    group_id TINYINT UNSIGNED,
    account_id TINYINT UNSIGNED,
    joined_date DATE NOT NULL DEFAULT (CURRENT_DATE),
    PRIMARY KEY (group_id, account_id),
    FOREIGN KEY (group_id) REFERENCES `group` (group_id),
    FOREIGN KEY (account_id) REFERENCES account (account_id)
);

-- Tạo bảng type_question
DROP TABLE IF EXISTS type_question;
CREATE TABLE type_question (
    type_id TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    type_name ENUM("Essay", "Multiple-Choice") UNIQUE NOT NULL
);

-- Tạo bảng category_question
DROP TABLE IF EXISTS category_question;
CREATE TABLE category_question (
    category_id TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    category_name VARCHAR(50) UNIQUE NOT NULL
);

-- Tạo bảng question
DROP TABLE IF EXISTS question;
CREATE TABLE question (
    question_id TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    content VARCHAR(50) NOT NULL,
    category_id TINYINT UNSIGNED,
    type_id TINYINT UNSIGNED,
    creator_id TINYINT UNSIGNED,
    created_date DATE NOT NULL DEFAULT (CURRENT_DATE),
    FOREIGN KEY (category_id) REFERENCES category_question (category_id),
    FOREIGN KEY (type_id) REFERENCES type_question (type_id),
    FOREIGN KEY (creator_id) REFERENCES account (account_id)
);

-- Tạo bảng answer
DROP TABLE IF EXISTS answer;
CREATE TABLE answer (
    answer_id TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    content VARCHAR(50),
    question_id TINYINT UNSIGNED,
    is_correct BOOLEAN NOT NULL, -- TRUE hoặc FALSE
    FOREIGN KEY (question_id) REFERENCES question (question_id)
);

-- Tạo bảng exam
DROP TABLE IF EXISTS exam;
CREATE TABLE exam (
    exam_id TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    code CHAR(10) UNIQUE NOT NULL,
    title VARCHAR(50) NOT NULL,
    category_id TINYINT UNSIGNED,
    duration TINYINT UNSIGNED NOT NULL CHECK (duration >= 15),
    creator_id TINYINT UNSIGNED,
    created_date DATE NOT NULL DEFAULT (CURRENT_DATE),
    FOREIGN KEY (category_id) REFERENCES category_question (category_id),
    FOREIGN KEY (creator_id) REFERENCES account (account_id)
);

-- Tạo bảng exam_question
DROP TABLE IF EXISTS exam_question;
CREATE TABLE exam_question (
    exam_id TINYINT UNSIGNED,
    question_id TINYINT UNSIGNED,
    PRIMARY KEY (exam_id, question_id),
    FOREIGN KEY (exam_id) REFERENCES exam (exam_id),
    FOREIGN KEY (question_id) REFERENCES question (question_id)
);

-- Đơn vị đo thông tin
-- bit (b) -> Byte (B) -> KiB -> MiB -> GiB -> TiB
-- 1 bit  = 0 hoặc 1
-- 1 Byte = 8 bit
-- 1 KiB  = 1024 Byte
-- 1 MiB  = 1024 KiB
-- 1 GiB  = 1024 MiB
-- 1 TiB  = 1024 GiB

-- Data types: Các kiểu dữ liệu
-- Kiểu số nguyên: TINYINT, SMALLINT, MEDIUMINT, INT, BIGINT
-- +--------------+------------+----------------------------+---------------------------+
-- | Kiểu dữ liệu | Kích thước | Giá trị nhỏ nhất           | Giá trị lớn nhất          |
-- +--------------+------------+----------------------------+---------   ---------------+
-- | TINYINT      | 1 Byte     | -128                       | 127                       |
-- | SMALLINT     | 2 Byte     | -32.768                    | 32.767                    |
-- | MEDIUMINT    | 3 Byte     | -8.388.608                 | 8.388.607                 |
-- | INT          | 4 Byte     | -2.147.483.648             | 2.147.483.647             |
-- | BIGINT       | 8 Byte     | -9.223.372.036.854.775.808 | 9.223.372.036.854.775.807 |
-- +--------------+------------+----------------------------+---------------------------+

-- Kiểu số thực: FLOAT, DOUBLE
-- +--------------+------------+---------------------+
-- | Kiểu dữ liệu | Kích thước | Độ chính xác        |
-- +--------------+------------+---------------------+
-- | FLOAT        | 4 Byte     | 7 chữ số thập phân  |
-- | DOUBLE       | 8 Byte     | 15 chữ số thập phân |
-- +--------------+------------+---------------------+

-- Kiểu chuỗi ký tự: CHAR, VARCHAR
-- +--------------+------------+-----------+--------------+
-- | Kiểu dữ liệu | Kích thước | Tốc độ    | Tối đa       |
-- +--------------+------------+-----------+--------------+
-- | CHAR         | Cố định    | Nhanh hơn | 255 ký tự    |
-- | VARCHAR      | Thay đổi   | Chậm hơn  | 65.535 ký tự |
-- +--------------+------------+-----------+--------------+

-- Kiểu thời gian: DATE, TIME, DATETIME
-- +--------------+-----------------------+
-- | Kiểu dữ liệu | Pattern               |
-- +--------------+-----------------------+
-- | DATE         | yyyy-MM-dd            |
-- | TIME         | hh:mm:ss              |
-- | DATETIME     | yyyy-MM-dd hh:mm:ss   |
-- +--------------+-----------------------+

-- ENUM: Tập hợp hữu hạn các giá trị
-- VD: ENUM("Male", "Female")

-- Thêm dữ liệu vào bảng
INSERT INTO department (department_id, department_name)
VALUES                 (1            , "Giám đốc"     );

-- Hiển thị bảng dữ liệu
TABLE department;

-- Mô tả bảng dữ liệu
DESCRIBE department;

-- Constraints: Các ràng buộc dữ liệu
-- NOT NULL: Đảm bảo một cột không thể có giá trị NULL
INSERT INTO department (department_id, department_name)
VALUES                 (2            , NULL           );

-- UNIQUE KEY: Đảm bảo tất cả giá trị trong một cột là khác nhau
INSERT INTO department (department_id, department_name)
VALUES                 (3            , "Giám đốc"     );

-- PRIMARY KEY = UNIQUE KEY + NOT NULL
-- Định danh duy nhất mỗi hàng trong một bảng
-- Chú ý:
-- + Một bảng có tối đa một khóa chính
-- + Một khóa chính có thể có nhiều trường
-- AUTO_INCREMENT: Giá trị tự động tăng (start = 1, step = 1)
INSERT INTO department (department_id, department_name)
VALUES                 (1            , "Bảo vệ"       );

-- DEFAULT: Đặt giá trị mặc định cho một cột nếu không có giá trị nào được chỉ định
INSERT INTO group_account (group_id, account_id)
VALUES                    (1       , 2         );

-- CHECK: Đảm bảo các giá trị trong một cột thỏa mãn một điều kiện cụ thể
INSERT INTO exam (
    exam_id,
    code,
    title,
    category_id,
    duration,
    creator_id,
    created_date
)
VALUES (
    1,
    "VTI0001",
    "Đề thi MySQL",
    1,
    15,
    1,
    "2020-04-19"
);

-- FOREIGN KEY: Ngăn chặn các hành động phá hủy liên kết giữa các bảng
INSERT INTO account (
    account_id,
    email,
    username,
    full_name,
    department_id,
    position_id,
    created_date
)
VALUES (
    1,
    "khoa.nv@gmail.com",
    "khoa.nv",
    "Nguyễn Văn Khoa",
    100,
    100,
    "2023-08-16"
);
