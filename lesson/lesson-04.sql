DROP DATABASE IF EXISTS student_management;
CREATE DATABASE student_management;
USE student_management;

DROP TABLE IF EXISTS boy;
CREATE TABLE boy (
    id TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(50) NOT NULL
);

DROP TABLE IF EXISTS girl;
CREATE TABLE girl (
    id TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(50) NOT NULL
);

INSERT INTO boy (id, `name` )
VALUES          (1 , 'Khoa' ),
                (2 , 'Duy'  ),
                (3 , 'Hùng' ),
                (4 , 'Cường'),
                (6 , 'Linh' );

INSERT INTO girl (id, `name`    )
VALUES           (1 , 'Thương'  ),
                 (2 , 'Ngọc Anh'),
                 (5 , 'Trang'   ),
                 (6 , 'Linh'    );

-- JOIN: Kết hợp các hàng từ 2 bảng thành 1 bảng tổng hợp (thêm cột)
-- ON: Điều kiện kết hợp 2 hàng
-- USING: Là cú pháp ngắn gọn của ON, sử dụng khi tên cột giống nhau ở cả 2 bảng
-- Nguyên tắc kết hợp: Từng hàng trong bảng này bắt cặp lần lượt với từng hàng trong bảng kia
-- Chú ý: Trong truy vấn, bảng nào viết trước thì bảng đó ở bên trái
-- [INNER] JOIN: Giữ lại những cặp thỏa mãn điều kiện kết hợp
SELECT *
FROM boy
JOIN girl USING(id)
WHERE id = 1;

SELECT *
FROM boy
JOIN girl ON boy.id = girl.id
WHERE boy.id = 1;

-- LEFT (RIGHT) JOIN:
--     1. Giữ lại những cặp thỏa mãn điều kiện kết hợp
--     2. Với những hàng ĐANG CÔ ĐƠN ở bảng bên trái (phải), nó sẽ được ghép với 1 hàng chứa toàn giá trị NULL
SELECT *
FROM boy
LEFT JOIN girl USING(id);

SELECT *
FROM boy
RIGHT JOIN girl USING(id);

-- LEFT (RIGHT) EXCLUDING JOIN: Chỉ giữ lại những hàng ĐANG CÔ ĐƠN ở bảng bên trái (phải), ghép nó với hàng toàn NULL
SELECT *
FROM boy
LEFT JOIN girl USING(id)
WHERE girl.id IS NULL;

-- CROSS JOIN: Giữ lại tất cả các cặp (bắt tay)
SELECT *
FROM boy
CROSS JOIN girl;

-- UNION / UNION ALL: Gộp tập kết quả của 2 hay nhiều truy vấn (thêm hàng)
-- Điều kiện gộp: Trong mệnh đề SELECT của các truy vấn
--     1. Số lượng cột phải bằng nhau
--     2. Thứ tự cột phải giống nhau
--     3. Các cột tương ứng phải có cùng tên và kiểu dữ liệu
-- UNION: Phần chung chỉ được lấy duy nhất 1 lần
SELECT *
FROM boy
UNION
SELECT *
FROM girl;

-- UNION ALL: Phần chung được lấy nhiều lần
SELECT *
FROM boy
UNION ALL
SELECT *
FROM girl;
