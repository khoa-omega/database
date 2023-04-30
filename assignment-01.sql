DROP DATABASE IF EXISTS assignment_01;
CREATE DATABASE assignment_01;
USE assignment_01;

-- Tạo bảng departments
DROP TABLE IF EXISTS departments;
CREATE TABLE departments (
    department_id INT,
    department_name VARCHAR(50)
);

-- Tạo bảng positions
DROP TABLE IF EXISTS positions;
CREATE TABLE positions (
    position_id INT,
    position_name ENUM('DEVELOPER', 'TESTER', 'SCRUM_MASTER', 'PROJECT_MANAGER')
);

-- Tạo bảng accounts
DROP TABLE IF EXISTS accounts;
CREATE TABLE accounts (
    account_id INT,
    email VARCHAR(50),
    username VARCHAR(50),
    full_name VARCHAR(50),
    department_id INT,
    position_id INT,
    created_date DATE
);

-- Tạo bảng groups
DROP TABLE IF EXISTS `groups`;
CREATE TABLE IF NOT EXISTS `groups` (
    group_id INT,
    group_name VARCHAR(50),
    creator_id INT,
    created_date DATE
);

-- Tạo bảng groups_accounts
DROP TABLE IF EXISTS groups_accounts;
CREATE TABLE groups_accounts (
    group_id INT,
    account_id INT,
    joined_date DATE
);

-- Tạo bảng question_types
DROP TABLE IF EXISTS question_types;
CREATE TABLE question_types (
    type_id INT,
    type_name ENUM('ESSAY', 'MULTIPLE_CHOICE')
);

-- Tạo bảng question_categories
DROP TABLE IF EXISTS question_categories;
CREATE TABLE question_categories (
    category_id INT,
    category_name VARCHAR(50)
);

-- Tạo bảng questions
DROP TABLE IF EXISTS questions;
CREATE TABLE questions (
    question_id INT,
    content VARCHAR(50),
    category_id INT,
    type_id INT,
    creator_id INT,
    created_date DATE
);

-- Tạo bảng answers
DROP TABLE IF EXISTS answers;
CREATE TABLE answers (
    answer_id INT,
    content VARCHAR(50),
    question_id INT,
    is_correct BOOLEAN
);

-- Tạo bảng exams
DROP TABLE IF EXISTS exams;
CREATE TABLE exams (
    exam_id INT,
    code CHAR(10),
    title VARCHAR(50),
    category_id INT,
    duration INT,
    creator_id INT,
    created_date DATE
);

-- Tạo bảng exams_questions
DROP TABLE IF EXISTS exams_questions;
CREATE TABLE exams_questions (
    exam_id INT,
    question_id INT
);
