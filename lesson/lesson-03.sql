-- SELECT BASIC: Truy vấn dữ liệu từ database
-- *: Ký tự đại diện cho tất cả các cột
SELECT *
FROM department;

-- WHERE: Thêm điều kiện cho câu truy vấn
-- OPERATOR: Toán tử
-- Toán tử: =, >, <, >=, <=, != (khác)
SELECT *
FROM department
WHERE department_id != 5;

-- Toán tử: AND, OR
-- AND: Trả về TRUE nếu cả 2 vế là TRUE
-- OR: Trả về FALSE nếu cả 2 vế là FALSE
SELECT *
FROM department
WHERE department_id >= 3 AND department_id <= 8;

-- Toán tử: BETWEEN AND
SELECT *
FROM department
WHERE department_id BETWEEN 3 AND 8;

-- Toán tử: IN, NOT IN
SELECT *
FROM department
WHERE department_id NOT IN (2, 4, 6);

-- Toán tử: LIKE, NOT LIKE
-- WILDCARD: %, _
-- %: Ký tự đại diện cho 0 hoặc nhiều ký tự
-- _: Ký tự đại diện 1 ký tự 
SELECT *
FROM department
WHERE department_name NOT LIKE '%i%';

-- Toán tử: IS NULL, IS NOT NULL
-- Sử dụng để truy vấn giá trị NULL
-- Chú ý: không dùng toán tử ==, != với NULL
SELECT *
FROM department
WHERE department_name IS NOT NULL;

-- Định dạng date time trong MySQL: yyyy-MM-dd (VD: 2022-01-09)

-- Từ khóa DISTINCT: Riêng biệt
-- Dùng sau từ khóa SELECT
-- Lấy dữ liệu không bị trùng lặp
SELECT DISTINCT duration
FROM exam;

-- Từ khóa ORDER BY: Sắp xếp theo
-- ASC(ending): Tăng dần
-- DESC(ending): Giảm dần
-- Mặc định là tăng dần
SELECT *
FROM exam
ORDER BY duration ASC;

-- Các hàm tổng hợp: COUNT, SUM, MIN, MAX, AVG
-- Dùng trong mệnh đề SELECT, HAVING
-- Chú ý: Chỉ áp dụng cho các giá trị khác NULL
-- COUNT: Đếm
-- COUNT(*): Đếm dòng
-- COUNT(tên_cột): Đếm những dòng mà tên_cột khác NULL
-- SUM: Tính tổng
-- MIN, MAX
-- AVG: Tính trung bình
SELECT COUNT(*), SUM(duration), MIN(duration), MAX(duration), AVG(duration)
FROM exam;

-- Mệnh đề GROUP BY / HAVING
-- GROUP BY: Gom nhóm
-- HAVING: Điều kiện cho một nhóm
-- Chú ý: Các cột được SELECT phải thỏa mãn:
--      1. Là hàm tổng hợp (COUNT, SUM, MIN, MAX hoặc AVG)
--      2. Là cột dùng để phân nhóm
SELECT duration, COUNT(*)
FROM exam
GROUP BY duration
HAVING COUNT(*) > 2;

-- ALIAS: Đặt định danh tạm thời cho cột hoặc bảng
-- Có hiệu lực trong câu truy vấn
SELECT duration, COUNT(*) AS 'Số bài thi'
FROM exam
GROUP BY duration
HAVING COUNT(*) > 2;

-- LIMIT: Giới hạn số bản ghi trả về
SELECT *
FROM exam
LIMIT 2;

-- Thêm mới dữ liệu
-- Thứ tự truyền tham số là quan trọng
INSERT INTO department (department_name)
VALUES  ('Google'),
        ('Oppo');

-- Cập nhật dữ liệu
UPDATE department
SET department_name = 'Xiaomi'
WHERE department_name = 'Google';

-- Xóa dữ liệu
DELETE FROM department
WHERE department_name = 'Oppo';

-- TRUNCATE: Xóa toàn bộ dữ liệu trong bảng mà không xóa bảng
SET FOREIGN_KEY_CHECKS = 0;
TRUNCATE TABLE department;
SET FOREIGN_KEY_CHECKS = 1;
