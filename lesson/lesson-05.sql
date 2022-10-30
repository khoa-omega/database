-- SUBQUERY: Truy vấn con
-- Kết quả trả về có thể là một bảng hoặc một giá trị
-- Có thể dùng trong các mệnh đề FROM, WHERE...
-- Toán tử: IN, ALL, ANY, EXISTS
-- ALL: Trả về TRUE khi thỏa mãn tất cả điều kiện
SELECT *
FROM boy
WHERE id >= ALL (SELECT id FROM boy);

-- ANY: Trả về TRUE nếu thỏa ít nhất 1 điều kiện

-- (NOT) EXISTS: Trả về TRUE nếu kết quả của truy vấn con tồn tại dữ liệu
SELECT *
FROM boy
WHERE NOT EXISTS (SELECT id FROM boy WHERE id = 100);


