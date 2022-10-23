-- Exercise 01: Design a table
DROP DATABASE IF EXISTS fresher_management;
CREATE DATABASE IF NOT EXISTS fresher_management;
USE fresher_management;

-- Question 01: Tạo bảng trainee
DROP TABLE IF EXISTS trainee;
CREATE TABLE IF NOT EXISTS trainee (
    trainee_id TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    full_name VARCHAR(50) NOT NULL,
    birth_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    gender ENUM('MALE', 'FEMALE', 'UNKNOWN') NOT NULL DEFAULT 'UNKNOWN',
    et_iq TINYINT UNSIGNED CHECK (et_iq BETWEEN 0 AND 20),
    et_gmath TINYINT UNSIGNED CHECK (et_gmath BETWEEN 0 AND 20),
    et_english TINYINT UNSIGNED CHECK (et_english BETWEEN 0 AND 50),
    training_class CHAR(10) NOT NULL,
    evaluation_notes VARCHAR(255) NOT NULL
);

-- Question 02: Thêm cột vti_account với điều kiện NOT NULL và UNIQUE
ALTER TABLE trainee
ADD COLUMN vti_account VARCHAR(50) UNIQUE NOT NULL;

-- Exercise 02: Datatype
DROP TABLE IF EXISTS student;
CREATE TABLE IF NOT EXISTS student (
    id MEDIUMINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(50) NOT NULL,
    `code` CHAR(5) NOT NULL,
    modified_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Exercise 03: Datatype 2
DROP TABLE IF EXISTS customer;
CREATE TABLE IF NOT EXISTS customer (
    id MEDIUMINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(50) NOT NULL,
    gender BIT,
    is_deleted_flag BIT NOT NULL DEFAULT 0
);
