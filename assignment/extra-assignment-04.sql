DROP DATABASE IF EXISTS extra_assignment_04;
CREATE DATABASE extra_assignment_04;
USE extra_assignment_04;

-- Câu 1: Tạo table với các ràng buộc và kiểu dữ liệu
DROP TABLE IF EXISTS department;
CREATE TABLE department (
    department_number TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    department_name VARCHAR(50) NOT NULL
);

DROP TABLE IF EXISTS employee;
CREATE TABLE employee (
    employee_number TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    employee_name VARCHAR(50) NOT NULL,
    department_number TINYINT UNSIGNED NOT NULL,
    FOREIGN KEY (department_number)
        REFERENCES department (department_number)
        ON DELETE CASCADE ON UPDATE CASCADE
);

DROP TABLE IF EXISTS employee_skill;
CREATE TABLE employee_skill (
    employee_number TINYINT UNSIGNED NOT NULL,
    skill_code CHAR(10) NOT NULL,
    registered_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (employee_number, skill_code),
    FOREIGN KEY (employee_number) 
        REFERENCES employee (employee_number)
        ON DELETE CASCADE ON UPDATE CASCADE
);

-- Câu 2: Thêm ít nhất 10 bản ghi vào table
-- Tự làm

-- Câu 3: Viết lệnh để lấy ra danh sách nhân viên (name) có skill Java
SELECT employee_name
FROM employee
JOIN employee_skill USING(employee_number)
WHERE skill_code = 'Java';

-- Câu 4: Viết lệnh để lấy ra danh sách các phòng ban có > 3 nhân viên
SELECT department.*
FROM department
JOIN employee USING(department_number)
GROUP BY department_number
HAVING COUNT(employee_number) > 3;

-- Câu 5: Viết lệnh để lấy ra danh sách nhân viên của mỗi văn phòng ban.
SELECT department.*, COUNT(employee_number) AS total_employees
FROM department
LEFT JOIN employee USING(department_number)
GROUP BY department_number;

-- Câu 6: Viết lệnh để lấy ra danh sách nhân viên có > 1 skills.
SELECT employee_name, COUNT(skill_code) AS total_skills
FROM employee
LEFT JOIN employee_skill USING(employee_number)
GROUP BY employee_number
HAVING total_skills > 1;
