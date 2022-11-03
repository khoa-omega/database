-- STORED PROCEDURE: Thủ tục
-- DELIMITER: Chuyển ký tự phân cách các câu lệnh (VD: Từ ; thành $$)
-- IN: Khai báo biến dùng để truyền dữ liệu vào
-- OUT: Khai báo biến dùng để lấy dữ liệu ra
-- INOUT: Là kết hợp của cả IN và OUT
-- DECLARE: Khai báo biến trong thủ tục
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

-- FUNCTION: Hàm, phương thức
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



