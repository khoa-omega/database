-- SUBQUERY: Truy vấn con
-- Kết quả trả về có thể là một bảng hoặc một giá trị
-- Có thể dùng trong các mệnh đề SELECT, FROM, WHERE...
-- Khi dùng trong mệnh đề FROM cần đặt ALIAS cho nó
-- Toán tử: IN, ALL, ANY, EXISTS
-- ALL: Trả về TRUE khi thỏa mãn tất cả điều kiện
-- VD: Tìm boy có id lớn nhất trong bảng boy
SELECT *
FROM boy
WHERE id >= ALL (SELECT id FROM boy);

-- ANY: Trả về TRUE nếu thỏa ít nhất 1 điều kiện

-- (NOT) EXISTS: Trả về TRUE nếu kết quả của truy vấn con tồn tại dữ liệu
SELECT *
FROM boy
WHERE NOT EXISTS (SELECT id FROM boy WHERE id = 100);

-- VIEW: Bảng ảo, không chứa dữ liệu
-- Tạo view: CREATE VIEW <view> AS
-- Xóa view: DROP VIEW <view>;
-- Tạo mới hoặc thay thế view: CREATE OR REPLACE VIEW <view> AS
CREATE VIEW view_all_boys AS
SELECT *
FROM boy;

SELECT *
FROM view_all_boys;

-- CTE: Common Table Expression
-- Bảng ảo, chứa dữ liệu trong bộ nhớ tạm thời
-- Giúp giảm số lần phải truy cập vào bộ nhớ ổ cứng => cải thiện tốc độ
-- Có hiệu lực trong câu truy vấn đó
-- VD: Tạo view có chứa thông tin các account tham gia vào nhiều group nhất
WITH cte AS (
    SELECT `account`.*, COUNT(group_id) AS total_groups
    FROM `account`
    LEFT JOIN group_account USING(account_id)
    GROUP BY account_id
)
SELECT *
FROM cte
WHERE total_groups =
    (SELECT MAX(total_groups)
    FROM cte);
