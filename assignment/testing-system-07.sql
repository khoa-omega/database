-- Câu 1: Tạo trigger không cho phép người dùng nhập vào group có ngày tạo trước 1 năm trước
DROP TRIGGER IF EXISTS trigger_cau_01;
DELIMITER $$
CREATE TRIGGER trigger_cau_01
BEFORE INSERT ON `group`
FOR EACH ROW
BEGIN
    IF NEW.created_date < NOW() - INTERVAL 1 YEAR THEN
        SIGNAL SQLSTATE '11111'
        SET MESSAGE_TEXT = 'Can NOT create the group.';
    END IF;
END $$
DELIMITER ;

INSERT INTO `group` (group_name, creator_id, created_date )
VALUES              ('MySQL'   , '5'       , '2011-03-05');

-- Câu 2: Tạo trigger không cho phép người dùng thêm bất kỳ user nào vào
-- department "Sale" nữa, khi thêm thì hiện ra thông báo "Department
-- "Sale" cannot add more user"
DROP TRIGGER IF EXISTS trigger_cau_02;
DELIMITER $$
CREATE TRIGGER trigger_cau_02
BEFORE INSERT ON `account`
FOR EACH ROW
BEGIN
    DECLARE var_id_of_sale TINYINT UNSIGNED;

    SELECT department_id INTO var_id_of_sale
    FROM department
    WHERE department_name = 'Sale';

    IF NEW.department_id = var_id_of_sale THEN
        SIGNAL SQLSTATE '22222'
        SET MESSAGE_TEXT = 'Department "Sale" can NOT add more user.';
    END IF;
END $$
DELIMITER ;

INSERT INTO `account` (full_name        , email              , username , department_id, position_id)
VALUES                ('Nguyễn Văn Khoa', 'khoa.nv@gmail.com', 'khoa.nv', 2            , 2          );

-- Câu 3: Cấu hình 1 group có nhiều nhất là 5 users
DROP TRIGGER IF EXISTS trigger_cau_03_insert;
DELIMITER $$
CREATE TRIGGER trigger_cau_03_insert
BEFORE INSERT ON group_account
FOR EACH ROW
BEGIN
    DECLARE var_total_accounts TINYINT UNSIGNED;
    
    SELECT COUNT(account_id) INTO var_total_accounts
    FROM group_account
    WHERE group_id = NEW.group_id;
    
    IF var_total_accounts >= 5 THEN
        SIGNAL SQLSTATE '33333'
        SET MESSAGE_TEXT = 'A group has max 5 accounts.';
    END IF;
END $$
DELIMITER ;

DROP TRIGGER IF EXISTS trigger_cau_03_update;
DELIMITER $$
CREATE TRIGGER trigger_cau_03_update
BEFORE UPDATE ON group_account
FOR EACH ROW
BEGIN
    DECLARE var_total_accounts TINYINT UNSIGNED;
    
    SELECT COUNT(account_id) INTO var_total_accounts
    FROM group_account
    WHERE group_id = NEW.group_id;
    
    IF var_total_accounts >= 5 THEN
        SIGNAL SQLSTATE '33333'
        SET MESSAGE_TEXT = 'A group has max 5 accounts.';
    END IF;
END $$
DELIMITER ;

-- Câu 4: Cấu hình 1 bài thi có nhiều nhất là 10 questions
DROP TRIGGER IF EXISTS trigger_cau_04_insert;
DELIMITER $$
CREATE TRIGGER trigger_cau_04_insert
BEFORE INSERT ON exam_question
FOR EACH ROW
BEGIN
    DECLARE var_total_questions TINYINT UNSIGNED;

    SELECT COUNT(question_id) INTO var_total_questions
    FROM exam_question
    WHERE exam_id = NEW.exam_id;

    IF var_total_questions >= 10 THEN
        SIGNAL SQLSTATE '44444'
        SET MESSAGE_TEXT = 'A exam has max 10 questions.';
    END IF;
END $$
DELIMITER ;

DROP TRIGGER IF EXISTS trigger_cau_04_update;
DELIMITER $$
CREATE TRIGGER trigger_cau_04_update
BEFORE UPDATE ON exam_question
FOR EACH ROW
BEGIN
    DECLARE var_total_questions TINYINT UNSIGNED;

    SELECT COUNT(question_id) INTO var_total_questions
    FROM exam_question
    WHERE exam_id = NEW.exam_id;

    IF var_total_questions >= 10 THEN
        SIGNAL SQLSTATE '44444'
        SET MESSAGE_TEXT = 'A exam has max 10 questions.';
    END IF;
END $$
DELIMITER ;

-- Câu 5: Tạo trigger không cho phép người dùng xóa tài khoản có email là
-- admin@gmail.com (đây là tài khoản admin, không cho phép user xóa),
-- còn lại các tài khoản khác thì sẽ cho phép xóa và sẽ xóa tất cả các thông
-- tin liên quan tới user đó
DROP TRIGGER IF EXISTS trigger_cau_05;
DELIMITER $$
CREATE TRIGGER trigger_cau_05
BEFORE DELETE ON `account`
FOR EACH ROW
BEGIN
    IF OLD.email = 'admin@gmail.com' THEN
        SIGNAL SQLSTATE '55555'
        SET MESSAGE_TEXT = 'Can NOT delete account of ADMIN.';
    END IF;
END $$
DELIMITER ;

DELETE FROM `account`
WHERE email = 'admin@gmail.com';

-- Câu 6: Không sử dụng cấu hình default cho field department_id của table
-- account, hãy tạo trigger cho phép người dùng khi tạo account không điền
-- vào department_id thì sẽ được phân vào phòng ban "Waiting Room"
DROP TRIGGER IF EXISTS trigger_cau_06;
DELIMITER $$
CREATE TRIGGER trigger_cau_06
BEFORE INSERT ON `account`
FOR EACH ROW
BEGIN
    IF NEW.department_id IS NULL THEN
        SET NEW.department_id = 11;
    END IF;
END $$
DELIMITER ;

-- Câu 7: Cấu hình 1 bài thi chỉ cho phép user tạo tối đa 4 answers cho mỗi
-- question, trong đó có tối đa 2 đáp án đúng.
DROP TRIGGER IF EXISTS trigger_cau_07;
DELIMITER $$
CREATE TRIGGER trigger_cau_07
BEFORE INSERT ON answer
FOR EACH ROW
BEGIN
    DECLARE var_total_answers TINYINT UNSIGNED;
    DECLARE var_total_correct_answers TINYINT UNSIGNED;

    SELECT COUNT(answer_id) INTO var_total_answers
    FROM answer
    WHERE question_id = NEW.question_id;

    IF var_total_answers >= 4 THEN
        SIGNAL SQLSTATE '77777'
        SET MESSAGE_TEXT = 'A question has max 4 answers.';
    END IF;

    SELECT COUNT(answer_id) INTO var_total_correct_answers
    FROM answer
    WHERE question_id = NEW.question_id AND is_correct = TRUE;

    IF var_total_correct_answers >= 2 THEN
        SIGNAL SQLSTATE '77777'
        SET MESSAGE_TEXT = 'A question has max 2 correct answers.';
    END IF;
END $$
DELIMITER ;

-- Câu 8: Viết trigger sửa lại dữ liệu cho đúng:
-- Nếu người dùng nhập vào gender của account là nam, nữ, chưa xác định
-- thì sẽ đổi lại thành M, F, U cho giống với cấu hình ở database

-- Câu 9: Viết trigger không cho phép người dùng xóa bài thi mới tạo được 2 ngày
DROP TRIGGER IF EXISTS trigger_cau_09;
DELIMITER $$
CREATE TRIGGER trigger_cau_09
BEFORE INSERT ON exam
FOR EACH ROW
BEGIN
    IF NEW.created_date > NOW() - INTERVAL 2 DAY THEN
        SIGNAL SQLSTATE '99999'
        SET MESSAGE_TEXT = 'Can NOT delete the exam.';
    END IF;
END $$
DELIMITER ;

-- Câu 10: Viết trigger chỉ cho phép người dùng chỉ được update, delete các
-- question khi question đó chưa nằm trong exam nào
DROP TRIGGER IF EXISTS trigger_cau_10_update;
DELIMITER $$
CREATE TRIGGER trigger_cau_10_update
BEFORE UPDATE ON question
FOR EACH ROW
BEGIN
    DECLARE var_total_exams TINYINT UNSIGNED;

    SELECT COUNT(exam_id) INTO var_total_exams
    FROM exam_question
    WHERE question_id = NEW.question_id;

    IF var_total_exams > 0 THEN
        SIGNAL SQLSTATE '10101'
        SET MESSAGE_TEXT = 'Can NOT update the question.';
    END IF;
END $$
DELIMITER ;

DROP TRIGGER IF EXISTS trigger_cau_10_delete;
DELIMITER $$
CREATE TRIGGER trigger_cau_10_update
BEFORE DELETE ON question
FOR EACH ROW
BEGIN
    DECLARE var_total_exams TINYINT UNSIGNED;

    SELECT COUNT(exam_id) INTO var_total_exams
    FROM exam_question
    WHERE question_id = OLD.question_id;

    IF var_total_exams > 0 THEN
        SIGNAL SQLSTATE '10101'
        SET MESSAGE_TEXT = 'Can NOT delete the question.';
    END IF;
END $$
DELIMITER ;

-- Câu 12: Lấy ra thông tin exam trong đó:
-- duration <= 30 thì sẽ đổi thành giá trị "Short time"
-- 30 < duration <= 60 thì sẽ đổi thành giá trị "Medium time"
-- duration > 60 thì sẽ đổi thành giá trị "Long time"
SELECT *,
    CASE
        WHEN duration <= 30 THEN 'Short time'
        WHEN duration <= 60 THEN 'Medium time'
        ELSE 'Long time'
    END AS duration_type
FROM exam;

-- Câu 13: Thống kê số account trong mỗi group và in ra thêm 1 column nữa có tên
-- là the_number_user_amount và mang giá trị được quy định như sau:
-- Nếu số lượng user trong group <= 5 thì sẽ có giá trị là few
-- Nếu số lượng user trong group <= 20 và > 5 thì sẽ có giá trị là normal
-- Nếu số lượng user trong group > 20 thì sẽ có giá trị là higher
SELECT group_name, COUNT(account_id) AS total_accounts,
    CASE
        WHEN COUNT(account_id) <= 5 THEN 'Few'
        WHEN COUNT(account_id) <= 20 THEN 'Normal'
        ELSE 'Higher'
    END AS the_number_user_amount
FROM `group`
LEFT JOIN group_account USING(group_id)
GROUP BY group_id;

-- Câu 14: Thống kê số mỗi phòng ban có bao nhiêu user, nếu phòng ban nào
-- không có user thì sẽ thay đổi giá trị 0 thành "Không có user"
SELECT department_name,
    CASE
        WHEN COUNT(account_id) = 0 THEN 'Không có user'
        ELSE COUNT(account_id)
    END AS total_accounts
FROM department
LEFT JOIN `account` USING(department_id)
GROUP BY department_id;
