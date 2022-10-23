DROP DATABASE IF EXISTS testing_system_01;
CREATE DATABASE IF NOT EXISTS testing_system_01;
USE testing_system_01;

-- Tạo bảng department
DROP TABLE IF EXISTS department;
CREATE TABLE IF NOT EXISTS department (
    department_id INT,
    department_name VARCHAR(50)
);

-- Tạo bảng position
DROP TABLE IF EXISTS `position`;
CREATE TABLE IF NOT EXISTS `position` (
    position_id INT,
    position_name ENUM('DEVELOPER', 'TESTER', 'SCRUM_MASTER', 'PROJECT_MANAGER')
);

-- Tạo bảng account
DROP TABLE IF EXISTS `account`;
CREATE TABLE IF NOT EXISTS `account` (
    account_id INT,
    email VARCHAR(50),
    username VARCHAR(50),
    full_name VARCHAR(50),
    department_id INT,
    position_id INT,
    created_date DATETIME
);

-- Tạo bảng group
DROP TABLE IF EXISTS `group`;
CREATE TABLE IF NOT EXISTS `group` (
    group_id INT,
    group_name VARCHAR(50),
    creator_id INT,
    created_date DATETIME
);

-- Tạo bảng group_account
DROP TABLE IF EXISTS group_account;
CREATE TABLE IF NOT EXISTS group_account (
    group_id INT,
    account_id INT,
    joined_date DATETIME
);

-- Tạo bảng type_question
DROP TABLE IF EXISTS type_question;
CREATE TABLE IF NOT EXISTS type_question (
    type_id INT,
    type_name ENUM('ESSAY', 'MULTIPLE_CHOICE')
);

-- Tạo bảng category_question
DROP TABLE IF EXISTS category_question;
CREATE TABLE IF NOT EXISTS category_question (
    category_id INT,
    category_name VARCHAR(50)
);

-- Tạo bảng question
DROP TABLE IF EXISTS question;
CREATE TABLE IF NOT EXISTS question (
    question_id INT,
    content VARCHAR(255),
    category_id INT,
    type_id INT,
    creator_id INT,
    created_date DATETIME
);

-- Tạo bảng answer
DROP TABLE IF EXISTS answer;
CREATE TABLE IF NOT EXISTS answer (
    answer_id INT,
    content VARCHAR(255),
    question_id INT,
    is_correct BIT
);

-- Tạo bảng exam
DROP TABLE IF EXISTS exam;
CREATE TABLE IF NOT EXISTS exam (
    exam_id INT,
    `code` CHAR(10),
    title VARCHAR(50),
    category_id INT,
    duration INT,
    creator_id INT,
    created_date DATETIME
);

-- Tạo bảng exam_question
DROP TABLE IF EXISTS exam_question;
CREATE TABLE IF NOT EXISTS exam_question (
    exam_id INT,
    question_id INT
);
