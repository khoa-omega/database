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

-- Toán tử logic: LIKE, NOT LIKE
-- WILDCARD: %, _
-- %: Ký tự đại diện cho 0 hoặc nhiều ký tự
-- _: Ký tự đại diện 1 ký tự 
SELECT *
FROM department
WHERE department_name NOT LIKE '%i%';

-- Toán tử logic: IS NULL, IS NOT NULL
-- Sử dụng để truy vấn giá trị NULL
-- Chú ý: không dùng toán tử ==, != với NULL
SELECT *
FROM department
WHERE department_name IS NOT NULL;

-- Định dạng date time trong MySQL: yyyy-MM-dd (VD: 2022-01-09)

-- Từ khóa DISTINCT: Riêng biệt
-- Dùng sau từ khóa SELECT
SELECT DISTINCT duration
FROM exam;

-- Từ khóa ORDER BY: Sắp xếp theo
-- ASC(ending): Tăng dần
-- DESC(ending): Giảm dần
SELECT *
FROM exam
ORDER BY duration DESC;
