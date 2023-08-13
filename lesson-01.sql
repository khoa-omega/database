-- RDBMS: Hệ quản trị cơ sở dữ liệu quan hệ
-- Database: Cơ sở dữ liệu
-- Table: Bảng dữ liệu
-- Field (Column): Trường dữ liệu (cột)
-- Record (Row): Bản ghi (hàng)

-- Xóa cơ sở dữ liệu (nếu tồn tại)
DROP DATABASE IF EXISTS lesson_01;

-- Tạo cơ sở dữ liệu
CREATE DATABASE lesson_01;

-- Chọn cơ sở dữ liệu cần thao tác
USE lesson_01;

-- Hiển thị danh sách cơ sở dữ liệu
SHOW DATABASES;

-- Data types: Các kiểu dữ liệu
-- INT: Số nguyên
-- VARCHAR(50): Chuỗi (tối đa 50 ký tự)
-- DATE: Thời gian (ISO 8601: yyyy-MM-dd)

-- Xóa bảng (nếu tồn tại)
DROP TABLE IF EXISTS department;

-- Tạo bảng
CREATE TABLE department (
    department_id INT,
    department_name VARCHAR(50)
);

-- Hiển thị danh sách bảng
SHOW TABLES;
