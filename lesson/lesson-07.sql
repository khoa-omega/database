-- CONNECTION: Kết nối vật lý tới database
-- SESSION: Phiên làm việc

-- VARIABLE: Biến
-- Gồm 2 loại: USER-DEFINED VARIABLE và SYSTEM VARIABLE

-- Biến có 3 scopes: LOCAL, GLOBAL, SESSION
-- LOCAL: Có phạm vi trong khối lệnh BEGIN - END
-- Cú pháp khai báo: DECLARE <tên_biến> <kiểu_dữ_liệu> [DEFAULT <giá_trị_mặc_định>];

-- SESSION: Có phạm vi trong phiên làm việc đấy
-- Cú pháp khai báo: SET @<tên_biến> [= <giá_trị_mặc_định>];
-- VD:
SET @department_name = 'Bảo vệ';
SELECT @department_name;

-- GLOBAL: Có phạm vi trong toàn bộ MySQL
-- Cú pháp khai báo: SET @@global.<tên_biến> [= <giá_trị_mặc_định>];
-- VD:
SET @@global.connect_timeout = 10;
SELECT @@connect_timeout;

-- TRIGGER: Tự động thực thi khối lệnh BEFORE / AFTER khi INSERT / UPDATE / DELETE dữ liệu
-- Trong khối lệnh BEGIN - END, có 2 từ khóa NEW và OLD
-- NEW: Tham chiếu đến bản ghi mới
-- OLD: Tham chiếu đến bản ghi cũ
-- VD: Không cho phép người dùng tạo account có created_date > now
DROP TRIGGER IF EXISTS trigger_example;
DELIMITER $$
CREATE TRIGGER trigger_example
BEFORE INSERT ON `account`
FOR EACH ROW
BEGIN
    IF NEW.created_date > NOW() THEN
        SIGNAL SQLSTATE '12345'
        SET MESSAGE_TEXT = 'Can NOT insert account.';
    END IF;
END $$
DELIMITER ;

INSERT INTO `account` (full_name        , email              , username , department_id, position_id, created_date)
VALUES                ('Nguyễn Văn Khoa', 'khoa.nv@gmail.com', 'khoa.nv', 2            , 2          , '3000-09-09');

-- INDEX: Đánh chỉ mục
-- Giống như mục lục => Tăng tốc truy vấn
DROP INDEX index_department_name ON department;
CREATE INDEX index_department_name
ON department (department_name);

-- CASE WHEN: Ánh xạ dữ liệu
-- VD: Lấy ra thông tin exam trong đó:
-- duration <= 60 thì sẽ đổi thành giá trị "Short time"
-- 60 < duration <= 90 thì sẽ đổi thành giá trị "Medium time"
-- duration > 90 thì sẽ đổi thành giá trị "Long time"
SELECT *,
    CASE
        WHEN duration <= 60 THEN 'Short time'
        WHEN duration <= 90 THEN 'Medium time'
        ELSE 'Long time'
    END AS duration_type
FROM exam;
