-- Câu 1: Tạo view có chứa danh sách nhân viên thuộc phòng ban sale
CREATE OR REPLACE VIEW view_question_01_subquery AS
SELECT *
FROM `account`
WHERE department_id =
    (SELECT department_id
    FROM department
    WHERE department_name = 'Sale');
    
-- Câu 2: Tạo view có chứa thông tin các account tham gia vào nhiều group nhất
CREATE OR REPLACE VIEW view_question_02_subquery AS
SELECT `account`.*, COUNT(group_id) AS total_groups
FROM `account`
LEFT JOIN group_account USING(account_id)
GROUP BY account_id
HAVING total_groups =
    (SELECT MAX(total_groups)
    FROM
        (SELECT COUNT(group_id) AS total_groups
        FROM group_account
        GROUP BY account_id) AS total_groups_per_account);
