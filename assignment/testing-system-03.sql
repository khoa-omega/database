-- Câu 2: Lấy ra tất cả các phòng ban
SELECT *
FROM department;

-- Câu 3: Lấy ra id của phòng ban "Sale"
SELECT department_id
FROM department
WHERE department_name = 'Sale';

-- Câu 6: Lấy ra tên group đã tham gia trước ngày 20/12/2019
SELECT group_name
FROM `group`
WHERE created_date < '2019-12-20';

-- Câu 8: Lấy ra các mã đề thi có thời gian thi >= 60 phút và được tạo trước ngày 20/12/2019
SELECT `code`
FROM exam
WHERE duration >= 60 AND created_date < '2019-12-20';

-- Câu 11: Lấy ra nhân viên có tên bắt đầu bằng chữ "D" và kết thúc bằng chữ "o"
SELECT *
FROM `account`
WHERE full_name LIKE 'D%o';
