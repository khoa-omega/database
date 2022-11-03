-- Câu 1: Tạo view có chứa danh sách nhân viên thuộc phòng ban sale
CREATE OR REPLACE VIEW view_question_01_subquery AS
SELECT *
FROM `account`
WHERE department_id =
    (SELECT department_id
    FROM department
    WHERE department_name = 'Sale');

CREATE OR REPLACE VIEW view_quesiton_01_cte AS
WITH cte_id_of_sale AS (
    SELECT department_id
    FROM department
    WHERE department_name = 'Sale'
)
SELECT *
FROM `account`
WHERE department_id =
    (SELECT department_id
    FROM cte_id_of_sale);

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
        FROM `account`
        LEFT JOIN group_account USING(account_id)
        GROUP BY account_id) AS total_groups_per_account);

CREATE OR REPLACE VIEW view_question_02_cte AS
WITH cte_total_groups_per_account AS (
    SELECT `account`.*, COUNT(group_id) AS total_groups
    FROM `account`
    LEFT JOIN group_account USING(account_id)
    GROUP BY account_id
)
SELECT *
FROM cte_total_groups_per_account
WHERE total_groups =
    (SELECT MAX(total_groups)
    FROM cte_total_groups_per_account);

-- Câu 3: Tạo view có chứa câu hỏi có những content quá dài (content quá 300 từ
-- được coi là quá dài) và xóa nó đi
CREATE OR REPLACE VIEW view_question_03_subquery AS
SELECT *
FROM question
WHERE CHAR_LENGTH(content) > 300;

DELETE FROM view_question_03_subquery;

-- Câu 5: Tạo view có chứa tất các các câu hỏi do user họ Nguyễn tạo
CREATE OR REPLACE VIEW view_question_05_subquery AS
SELECT *
FROM question
WHERE creator_id IN
    (SELECT account_id
    FROM `account`
    WHERE full_name LIKE 'Nguyen %');

CREATE OR REPLACE VIEW view_question_05_cte AS
WITH cte_account_has_username_start_with_nguyen AS (
    SELECT account_id
    FROM `account`
    WHERE full_name LIKE 'Nguyen %'
)
SELECT *
FROM question
WHERE creator_id IN
    (SELECT account_id
    FROM cte_account_has_username_start_with_nguyen)
