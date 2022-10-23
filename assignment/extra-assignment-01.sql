-- Exercise 01
DROP DATABASE IF EXISTS fresher_management;
CREATE DATABASE IF NOT EXISTS fresher_management;
USE fresher_management;

-- Question 01: Tạo bảng trainee
DROP TABLE IF EXISTS trainee;
CREATE TABLE IF NOT EXISTS trainee (
    trainee_id INT,
    full_name VARCHAR(50),
    birth_date DATETIME,
    gender ENUM('MALE', 'FEMALE', 'UNKNOWN'),
    et_iq INT,
    et_gmath INT,
    et_english INT,
    training_class CHAR(10),
    evaluation_notes VARCHAR(255)
);
