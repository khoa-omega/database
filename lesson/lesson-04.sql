DROP DATABASE IF EXISTS student_management;
CREATE DATABASE student_management;
USE student_management;

DROP TABLE IF EXISTS boy;
CREATE TABLE boy(
    id TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(50) NOT NULL
);

DROP TABLE IF EXISTS girl;
CREATE TABLE girl(
    id TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(50) NOT NULL
);

INSERT INTO boy(id, `name`)
VALUES      (1, 'Khoa'),
            (2, 'Duy'),
            (3, 'Hùng'),
            (4, 'Cường');

INSERT INTO girl(id, `name`)
VALUES      (1, 'Thương'),
            (2, 'Ngọc Anh'),
            (5, 'Trang'),
            (6, 'Linh');

-- JOIN: Gộp 2 bảng
-- ON: Điều kiện gộp bảng
-- USING: Điều kiện gộp bảng (sử dụng khi cột này có mặt ở cả 2 bảng)
-- [INNER] JOIN: Lấy phần chung giữa 2 bảng
-- Trong truy vấn, bảng nào viết trước thì bảng đó ở bên trái
SELECT *
FROM boy
JOIN girl USING(id)
WHERE id = 1;

SELECT *
FROM boy
JOIN girl ON boy.id = girl.id
WHERE boy.id = 1;

-- LEFT (RIGHT) JOIN: Lấy phần chung và phần riêng của bảng bên trái (phải)
-- Chú ý: Ứng với phần riêng chỉ có ở bảng bên trái (phải), bảng bên phải (trái) sẽ có giá trị NULL
SELECT *
FROM boy
LEFT JOIN girl USING(id);

SELECT *
FROM boy
RIGHT JOIN girl USING(id);
