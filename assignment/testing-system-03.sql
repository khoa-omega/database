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

-- Câu 7: Lấy ra ID của question có >= 4 câu trả lời
SELECT question_id, COUNT(answer_id)
FROM answer
GROUP BY question_id
HAVING COUNT(answer_id) >= 4;

-- Câu 8: Lấy ra các mã đề thi có thời gian thi >= 60 phút và được tạo trước ngày 20/12/2019
SELECT `code`
FROM exam
WHERE duration >= 60 AND created_date < '2019-12-20';

-- Câu 9: Lấy ra 5 group được tạo gần đây nhất
SELECT *
FROM `group`
ORDER BY created_date DESC
LIMIT 5;

-- Câu 10: Đếm số nhân viên thuộc department có id = 2
SELECT COUNT(account_id)
FROM `account`
WHERE department_id = 2;

-- Câu 11: Lấy ra nhân viên có tên bắt đầu bằng chữ "D" và kết thúc bằng chữ "o"
SELECT *
FROM `account`
WHERE full_name LIKE 'D%o';

-- Câu 12: Xóa tất cả các exam được tạo trước ngày 20/12/2019
DELETE FROM exam
WHERE created_date < '2019-12-20';

-- Câu 13: Xóa tất cả các question có nội dung bắt đầu bằng từ "câu hỏi"
DELETE FROM question
WHERE content LIKE 'câu hỏi %';

-- Câu 14: Update thông tin của account có id = 5 thành tên "Nguyễn Bá Lộc" và
-- email thành loc.nguyenba@vti.com.vn
UPDATE `account`
SET full_name = 'Nguyễn Bá Lộc',
    email = 'loc.nguyenba@vti.com.vn'
WHERE account_id = 5;

-- Câu 15: Update account có id = 5 sẽ thuộc group có id = 4
UPDATE group_account
SET group_id = 4
WHERE account_id = 5;
