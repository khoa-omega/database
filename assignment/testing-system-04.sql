-- Exercise 01: JOIN
-- Câu 1: Viết lệnh để lấy ra danh sách nhân viên và thông tin phòng ban của họ
SELECT *
FROM `account`
JOIN department USING (department_id);

-- Câu 2: Viết lệnh để lấy ra thông tin các account được tạo sau ngày 20/12/2010
SELECT *
FROM `account`
JOIN department USING(department_id)
JOIN `position` USING(position_id)
WHERE created_date > '2010-12-20';

-- Câu 3: Viết lệnh để lấy ra tất cả các developer
SELECT *
FROM `account`
JOIN `position` USING (position_id)
WHERE position_name = 'DEVELOPER';

-- Câu 4: Viết lệnh để lấy ra danh sách các phòng ban có > 3 nhân viên
SELECT department.*
FROM `account`
JOIN department USING(department_id)
GROUP BY department_id
HAVING COUNT(account_id) > 3;

-- Câu 5: Viết lệnh để lấy ra danh sách câu hỏi được sử dụng trong đề thi nhiều nhất
SELECT question.*
FROM exam_question
JOIN question USING(question_id)
GROUP BY question_id
HAVING COUNT(exam_id) =
	(SELECT MAX(total_exams)
	FROM (SELECT COUNT(exam_id) AS total_exams
		FROM exam_question
		GROUP BY question_id) AS total_exams_per_question);

-- Câu 6: Thống kê mỗi category question được sử dụng trong bao nhiêu question
-- DELETE FROM question
-- WHERE question_id = 1;
SELECT cq.*, COUNT(question_id) AS total_questions
FROM category_question AS cq
LEFT JOIN question USING(category_id)
GROUP BY category_id;

-- Câu 7: Thống kê mỗi question được sử dụng trong bao nhiêu exam
-- DELETE FROM exam_question
-- WHERE exam_id = 2 AND question_id = 2;
SELECT question.*, COUNT(exam_id) AS total_exams
FROM question
LEFT JOIN exam_question USING(question_id)
GROUP BY question_id;

-- Câu 8: Lấy ra question có nhiều câu trả lời nhất
SELECT question.*
FROM answer
JOIN question USING(question_id)
GROUP BY question_id
HAVING COUNT(answer_id) =
	(SELECT MAX(total_answers)
	FROM 
		(SELECT COUNT(answer_id) AS total_answers
		FROM answer
		GROUP BY question_id) AS total_answers_per_question);

-- Câu 9: Thống kê số lượng account trong mỗi group
SELECT `group`.*, COUNT(account_id) AS total_accounts
FROM `group`
LEFT JOIN group_account USING(group_id)
GROUP BY group_id;

-- Câu 10: Tìm chức vụ có ít người nhất
SELECT position_name
FROM `account`
JOIN `position` USING(position_id)
GROUP BY position_id
HAVING COUNT(account_id) = 
	(SELECT MIN(total_accounts)
	FROM
		(SELECT COUNT(account_id) AS total_accounts
		FROM `account`
		GROUP BY position_id) AS total_accounts_per_position);

-- Câu 11: Thống kê mỗi phòng ban có bao nhiêu Dev, Test, Scrum Master, PM
SELECT department_name, position_name, IFNULL(total_accounts, 0)
FROM
    (SELECT *
    FROM department
    CROSS JOIN `position`
    WHERE position_name IN ('DEVELOPER' , 'TESTER', 'SCRUM_MASTER', 'PROJECT_MANAGER')) AS t1
	LEFT JOIN
		(SELECT department_id, position_id, COUNT(account_id) AS total_accounts
		FROM `account`
		JOIN `position` USING (position_id)
		JOIN department USING (department_id)
		WHERE position_name IN ('DEVELOPER' , 'TESTER', 'SCRUM_MASTER', 'PROJECT_MANAGER')
		GROUP BY department_id, position_id) AS t2 USING (department_id, position_id)
GROUP BY department_id , position_id
ORDER BY department_id , position_id;

-- Câu 13: Lấy ra số lượng câu hỏi của mỗi loại tự luận hay trắc nghiệm
SELECT type_question.*, COUNT(question_id) AS total_questions
FROM type_question
LEFT JOIN question USING(type_id)
WHERE type_name IN ('ESSAY', 'MULTIPLE_CHOICE')
GROUP BY type_id;

-- Câu 14, 15: Lấy ra group không có account nào
SELECT `group`.*
FROM `group`
LEFT JOIN group_account USING(group_id)
WHERE account_id IS NULL;

-- Câu 16: Lấy ra question không có answer nào
SELECT question.*
FROM question
LEFT JOIN answer USING(question_id)
WHERE answer_id IS NULL;

-- Exercise 02: UNION
-- Câu 17:
-- a. Lấy các account thuộc nhóm thứ 1
SELECT `account`.*
FROM `account`
JOIN group_account USING(account_id)
WHERE group_id = 1;

-- b) Lấy các account thuộc nhóm thứ 2
SELECT `account`.*
FROM `account`
JOIN group_account USING(account_id)
WHERE group_id = 2;

-- c) Ghép 2 kết quả từ câu a) và câu b) sao cho không có record nào trùng nhau
SELECT `account`.*
FROM `account`
JOIN group_account USING(account_id)
WHERE group_id = 1
UNION
SELECT `account`.*
FROM `account`
JOIN group_account USING(account_id)
WHERE group_id = 2;

-- Câu 18:
-- a) Lấy các group có lớn hơn 5 thành viên
SELECT `group`.*, COUNT(account_id) AS total_accounts
FROM `group`
JOIN group_account USING(group_id)
GROUP BY group_id
HAVING total_accounts > 5;

-- b) Lấy các group có nhỏ hơn 7 thành viên
SELECT `group`.*, COUNT(account_id) AS total_accounts
FROM `group`
JOIN group_account USING(group_id)
GROUP BY group_id
HAVING total_accounts < 7;

-- c) Ghép 2 kết quả từ câu a) và câu b)
SELECT `group`.*, COUNT(account_id) AS total_accounts
FROM `group`
JOIN group_account USING(group_id)
GROUP BY group_id
HAVING total_accounts > 5
UNION ALL
SELECT `group`.*, COUNT(account_id) AS total_accounts
FROM `group`
JOIN group_account USING(group_id)
GROUP BY group_id
HAVING total_accounts < 7;
