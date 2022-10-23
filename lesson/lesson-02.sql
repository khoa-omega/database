-- DATATYPE: Kiểu dữ liệu
-- Đại lượng đo: Bit -> Byte -> KiB -> MiB -> GiB -> TiB
-- Bit: Có 2 giá trị là 0 và 1
-- Byte: 1 Byte  =  8 Bit
-- KiB:  1 KiB   =  1024 Byte
-- MiB:  1 MiB   =  1024 KiB
-- GiB:  1 GiB   =  1024 MiB
-- TiB:  1 TiB   =  1024 GiB

-- Kiểu số nguyên: TINYINT, SMALLINT, MEDIUMINT, INT, BIGINT
-- +------------------------------------------------------------------------------------------------+
-- | Kiểu dữ liệu		| Kích thước	| Giá trị nhỏ nhất				| Giá trị lớn nhất			|
-- | TINYINT			| 1 Byte		| -128							| 127						|
-- | SMALLINT			| 2 Byte		| -32.768						| 32.767					|
-- | MEDIUMINT			| 3 Byte		| -8.388.608					| 8.388.607					|
-- | INT				| 4 Byte		| -2.147.483.648				| 2.147.483.647				|
-- | BIGINT				| 8 Byte		| -9.223.372.036.854.775.808	| 9.223.372.036.854.775.807	|
-- +------------------------------------------------------------------------------------------------+
-- VD: id TINYINT UNSIGNED

-- Kiểu số thực: FLOAT (4 Byte), DOUBLE (8 Byte)
-- VD: pi DOUBLE

-- Kiểu chuỗi: VARCHAR(50), CHAR(10)
-- +--------------------------------------------------------------------------------------+
-- | So sánh	| VARCHAR							| CHAR								  |
-- | Kích thước	| Kích thước phụ thuộc vào giá trị	| Kích thước cố định như lúc khai báo |
-- | Tốc độ		| Chậm hơn							| Nhanh hơn							  |
-- +--------------------------------------------------------------------------------------+
-- VD: name VARCHAR(50)
-- VD: code CHAR(10)

-- Kiểu thời gian: DATE, DATETIME
-- Pattern: yyyy-MM-dd HH-mm-ss
-- VD: created_at DATETIME

-- Kiểu enum: ENUM('MALE', 'FEMALE')
-- VD: gender ENUM('MALE', 'FEMALE')

-- CONSTRAINTS: Ràng buộc dữ liệu
-- PRIMARY KEY: Khóa chính
-- Ta có thể cấu hình thêm AUTO_INCREMENT để tạo một khóa chính có giá trị tự động tăng.
-- Một bảng có nhiều nhất 1 khóa chính.
-- Khóa chính có 1 hoặc nhiều cột.
-- VD: id TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT

-- FOREIGN KEY: Khóa ngoại
-- Ràng buộc giá trị của cột (của bảng này) tham chiếu đến giá trị của cột (của bảng khác)
-- Với mỗi khóa ngoại, sẽ có 2 sự kiện: ON DELETE, ON UPDATE
-- Với mỗi sự kiện, sẽ có 3 hành động: NO ACTION (default), SET NULL, CASCADE
-- VD: FOREIGN KEY (department_id) REFERENCES department (department_id) ON DELETE CASCADE ON UPDATE CASCADE

-- UNIQUE: Ràng buộc giá trị của cột này trong mỗi bản ghi là duy nhất
-- VD: email VARCHAR(50) UNIQUE

-- NOT NULL: Ràng buộc cột này không được để trống (phải có dữ liệu)
-- VD: title VARCHAR(50) NOT NULL

-- => PRIMARY KEY = UNIQUE + NOT NULL

-- DEFAULT: Ràng buộc giá trị mặc định của cột này
-- VD: updated_at DATETIME DEFAULT NOW()

-- CHECK: Ràng buộc điều kiện để thêm giá trị cho cột này
-- VD: age TINYINT UNSIGNED CHECK (age >= 18)

-- CODING CONVENSION: https://www.sqlstyle.guide/
