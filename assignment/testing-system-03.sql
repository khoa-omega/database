-- Câu 1: Thêm ít nhất 10 records vào mỗi table

-- Thêm dữ liệu vào bảng department
INSERT INTO department  (department_name)
VALUES                  ('Marketing'    ),
                        ('Sale'         ),
                        ('Bảo vệ'       ),
                        ('Nhân sự'      ),
                        ('Kỹ thuật'     ),
                        ('Tài chính'    ),
                        ('Phò giám đốc' ),
                        ('Giám đốc'     ),
                        ('Thư kí'       ),
                        ('Bán hàng'     ); 

-- Thêm dữ liệu vào bảng position
INSERT INTO `position`  (position_name    )
VALUES                  ('DEVELOPER'      ),
                        ('TESTER'         ),
                        ('SCRUM_MASTER'   ),
                        ('PROJECT_MANAGER');

-- Thêm dữ liệu vào bảng account
INSERT INTO `account`   (email                           , username      , full_name           , department_id, position_id, created_date)
VALUES                  ('haidang29productions@gmail.com', 'dangblack'   , 'Nguyen Hai Dang'   , 5            , 1          , '2020-03-05'),
                        ('account1@gmail.com'            , 'quanganh'    , 'Tong Quang Anh'    , 1            , 2          , '2020-03-05'),
                        ('account2@gmail.com'            , 'vanchien'    , 'Nguyen Van Chien'  , 2            , 3          , '2020-03-07'),
                        ('account3@gmail.com'            , 'cocoduongqua', 'Duong Do'          , 3            , 4          , '2020-03-08'),
                        ('account4@gmail.com'            , 'doccocaubai' , 'Nguyen Chien Thang', 4            , 4          , '2020-03-10'),
                        ('dapphatchetngay@gmail.com'     , 'khabanh'     , 'Ngo Ba Kha'        , 6            , 3          , '2020-04-05'),
                        ('songcodaoly@gmail.com'         , 'huanhoahong' , 'Bui Xuan Huan'     , 7            , 2          , '2020-04-05'),
                        ('sontungmtp@gmail.com'          , 'tungnui'     , 'Nguyen Thanh Tung' , 8            , 1          , '2020-04-07'),
                        ('duongghuu@gmail.com'           , 'duongghuu'   , 'Duong Van Huu'     , 9            , 2          , '2020-04-07'),
                        ('vtiaccademy@gmail.com'         , 'vtiaccademy' , 'Vi Ti Ai'          , 10           , 1          , '2020-04-09');

-- Thêm dữ liệu vào bảng group
INSERT INTO `group` (group_name         , creator_id, created_date)
VALUES              ('Testing System'   , 5         , '2019-03-05'),
                    ('Developement'     , 1         , '2020-03-07'),
                    ('VTI Sale 01'      , 2         , '2020-03-09'),
                    ('VTI Sale 02'      , 3         , '2020-03-10'),
                    ('VTI Sale 03'      , 4         , '2020-03-28'),
                    ('VTI Creator'      , 6         , '2020-04-06'),
                    ('VTI Marketing 01' , 7         , '2020-04-07'),
                    ('Management'       , 8         , '2020-04-08'),
                    ('Chat with love'   , 9         , '2020-04-09'),
                    ('Vi Ti Ai'         , 10        , '2020-04-10');

-- Thêm dữ liệu vào bảng group_account
INSERT INTO group_account   (group_id, account_id, joined_date )
VALUES                      (1       , 1         , '2019-03-05'),
                            (2       , 2         , '2020-03-07'),
                            (3       , 3         , '2020-03-09'),
                            (4       , 4         , '2020-03-10'),
                            (5       , 5         , '2020-03-28'),
                            (6       , 6         , '2020-04-06'),
                            (7       , 7         , '2020-04-07'),
                            (8       , 8         , '2020-04-08'),
                            (9       , 9         , '2020-04-09'),
                            (10      , 10        , '2020-04-10');

-- Thêm dữ liệu vào bảng type_question
INSERT INTO type_question (type_name) VALUES ('ESSAY'), ('MULTIPLE_CHOICE'); 

-- Thêm dữ liệu vào bảng category_question
INSERT INTO category_question   (category_name)
VALUES                          ('Java'       ),
                                ('ASP.NET'    ),
                                ('ADO.NET'    ),
                                ('SQL'        ),
                                ('Postman'    ),
                                ('Ruby'       ),
                                ('Python'     ),
                                ('C++'        ),
                                ('C Sharp'    ),
                                ('PHP'        ); 

-- Thêm dữ liệu vào bảng question
INSERT INTO question    (content          , category_id, type_id, creator_id, created_date)
VALUES                  ('Câu hỏi về Java', 1          , 1      , 1         , '2020-04-05'),
                        ('Câu Hỏi về PHP' , 10         , 2      , 2         , '2020-04-05'),
                        ('Hỏi về C#'      , 9          , 2      , 3         , '2020-04-06'),
                        ('Hỏi về Ruby'    , 6          , 1      , 4         , '2020-04-06'),
                        ('Hỏi về Postman' , 5          , 1      , 5         , '2020-04-06'),
                        ('Hỏi về ADO.NET' , 3          , 2      , 6         , '2020-04-06'),
                        ('Hỏi về ASP.NET' , 2          , 1      , 7         , '2020-04-06'),
                        ('Hỏi về C++'     , 8          , 1      , 8         , '2020-04-07'),
                        ('Hỏi về SQL'     , 4          , 2      , 9         , '2020-04-07'),
                        ('Hỏi về Python'  , 7          , 1      , 10        , '2020-04-07');

-- Thêm dữ liệu vào bảng answer
INSERT INTO answer  (content     , question_id, is_correct)
VALUES              ('Trả lời 01', 1          , 0         ),
                    ('Trả lời 02', 1          , 1         ),
                    ('Trả lời 03', 1          , 0         ),
                    ('Trả lời 04', 1          , 1         ),
                    ('Trả lời 05', 2          , 1         ),
                    ('Trả lời 06', 3          , 1         ),
                    ('Trả lời 07', 4          , 0         ),
                    ('Trả lời 08', 8          , 0         ),
                    ('Trả lời 09', 9          , 1         ),
                    ('Trả lời 10', 10         , 1         );

-- Thêm dữ liệu vào bảng exam
INSERT INTO exam    (`code`   , title           , category_id, duration, creator_id, created_date)
VALUES              ('VTIQ001', 'Đề thi C#'     , 1          , 60      , 5         , '2019-04-05'),
                    ('VTIQ002', 'Đề thi PHP'    , 10         , 60      , 1         , '2019-04-05'),
                    ('VTIQ003', 'Đề thi C++'    , 9          , 120     , 2         , '2019-04-07'),
                    ('VTIQ004', 'Đề thi Java'   , 6          , 60      , 3         , '2020-04-08'),
                    ('VTIQ005', 'Đề thi Ruby'   , 5          , 120     , 4         , '2020-04-10'),
                    ('VTIQ006', 'Đề thi Postman', 3          , 60      , 6         , '2020-04-05'),
                    ('VTIQ007', 'Đề thi SQL'    , 2          , 60      , 7         , '2020-04-05'),
                    ('VTIQ008', 'Đề thi Python' , 8          , 60      , 8         , '2020-04-07'),
                    ('VTIQ009', 'Đề thi ADO.NET', 4          , 90      , 9         , '2020-04-07'),
                    ('VTIQ010', 'Đề thi ASP.NET', 7          , 90      , 10        , '2020-04-08');

-- Thêm dữ liệu vào bảng exam_question
INSERT INTO exam_question   (question_id, exam_id)
VALUES                      (1          , 1      ),
                            (2          , 2      ),
                            (3          , 3      ),
                            (4          , 4      ),
                            (5          , 5      ),
                            (6          , 6      ),
                            (7          , 7      ),
                            (8          , 8      ),
                            (9          , 9      ),
                            (10         , 10     );

-- Câu 2: Lấy ra tất cả các phòng ban
SELECT *
FROM department;

-- Câu 3: Lấy ra id của phòng ban "Sale"
SELECT department_id
FROM department
WHERE department_name = 'Sale';

-- Câu 4: Lấy ra thông tin account có full name dài nhất
SELECT *
FROM `account`
WHERE CHAR_LENGTH(full_name) =
    (SELECT MAX(CHAR_LENGTH(full_name))
    FROM `account`);

-- Câu 5: Lấy ra thông tin account có full name dài nhất và thuộc phòng ban có id = 3
SELECT *
FROM `account`
WHERE department_id = 3 AND LENGTH(full_name) =
	(SELECT MAX(LENGTH(full_name))
	FROM `account`);

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
WHERE SUBSTRING_INDEX(full_name, ' ', -1) LIKE 'D%o';

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
