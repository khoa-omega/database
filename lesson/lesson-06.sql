-- DELIMITER: Dùng để đổi ký tự ngăn cách các câu lệnh MySQL

-- STORED PROCEDURE: Thủ tục lưu trữ
-- IN: Khai báo tham số dùng để truyền dữ liệu vào
-- OUT: Khai báo tham số dùng để lấy dữ liệu ra
-- INOUT: Là kết hợp của cả IN và OUT
-- DECLARE: Khai báo biến trong STORE PROCEDURE
-- VD 1: Hiển thị thông tin tất cả phòng ban
DROP PROCEDURE IF EXISTS sp_find_all_departments;
DELIMITER $$
CREATE PROCEDURE sp_find_all_departments ()
BEGIN
    SELECT *
    FROM department;
END $$
DELIMITER ;

CALL sp_find_all_departments();

-- VD 2: Hiển thị thông tin phòng ban theo id
DROP PROCEDURE IF EXISTS sp_find_department_by_id;
DELIMITER $$
CREATE PROCEDURE sp_find_department_by_id (IN in_id TINYINT UNSIGNED)
BEGIN
    SELECT *
    FROM department
    WHERE department_id = in_id;
END $$
DELIMITER ;

CALL sp_find_department_by_id(5);

-- VD 3: Lấy ra tên phòng ban theo id
DROP PROCEDURE IF EXISTS sp_find_department_name_by_id;
DELIMITER $$
CREATE PROCEDURE sp_find_department_name_by_id (
    IN in_id TINYINT UNSIGNED,
    OUT out_department_name VARCHAR(50)
)
BEGIN
    SELECT department_name INTO out_department_name
    FROM department
    WHERE department_id = in_id;
END $$
DELIMITER ;

SET @department_name = '';
SELECT @department_name;
CALL sp_find_department_name_by_id(5, @department_name);
SELECT @department_name;

-- FUNCTION: Hàm số, phương thức
-- Chỉ trả về duy nhất một giá trị
-- VD: Lấy ra tên phòng ban từ id
SET GLOBAL log_bin_trust_function_creators = 1;

DROP FUNCTION IF EXISTS fn_find_department_name_by_id;
DELIMITER $$
CREATE FUNCTION fn_find_department_name_by_id (id TINYINT UNSIGNED) RETURNS VARCHAR(50)
BEGIN
    DECLARE var_department_name VARCHAR(50);

    SELECT department_name INTO var_department_name
    FROM department
    WHERE department_id = id;

    RETURN var_department_name;
END $$
DELIMITER ;

SELECT fn_find_department_name_by_id(4);

-- So sánh STORE PROCEDURE và FUNCTION
-- +--------------------------------------------+-------------------------------------------+
-- | STORED PROCEDURE                           | FUNCTION                                  |
-- +--------------------------------------------+-------------------------------------------+
-- | Có thể trả về nhiều tham số đầu ra         | Chỉ trả về duy nhất 1 giá trị             |
-- +--------------------------------------------+-------------------------------------------+
-- | Sử dụng từ khóa CALL để thực thi           | Sử dụng từ khóa SELECT để thực thi        |
-- +--------------------------------------------+-------------------------------------------+
-- | Có thể dùng ĐỌC, THÊM, SỬA, XÓA dữ liệu    | Chỉ có thể dùng ĐỌC dữ liệu               |
-- +--------------------------------------------+-------------------------------------------+
-- | Tham số đầu ra không thể là một BẢNG       | Giá trị trả về không thể là một BẢNG      |
-- +--------------------------------------------+-------------------------------------------+
