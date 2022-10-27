-- Câu 2: Viết lệnh để lấy ra tất cả các thực tập sinh đã vượt qua bài test đầu vào,
-- nhóm chúng thành các tháng sinh khác nhau
SELECT MONTH(birth_date) AS month_of_birth, COUNT(trainee_id) AS total_trainees
FROM trainee
WHERE (et_iq + et_gmath) >= 20 AND et_iq >= 8 AND et_gmath >= 8 AND et_english >= 1
GROUP BY MONTH(birth_date);

-- Câu 3: Viết lệnh để lấy ra thực tập sinh có tên dài nhất, lấy ra các thông tin sau:
-- tên, tuổi, các thông tin cơ bản (như đã được định nghĩa trong table)

-- Câu 4: Viết lệnh để lấy ra tất cả các thực tập sinh là ET, 1 ET thực tập sinh là
-- những người đã vượt qua bài test đầu vào và thỏa mãn số điểm như sau:
--   * ET_IQ + ET_Gmath >= 20
--   * ET_IQ >= 8
--   * ET_Gmath >= 8
--   * ET_English >= 1
SELECT *
FROM trainee
WHERE (et_iq + et_gmath) >= 20 AND et_iq >= 8 AND et_gmath >= 8 AND et_english >= 1;

-- Câu 5: Xóa thực tập sinh có trainee_id = 3
DELETE FROM trainee
WHERE trainee_id = 3;

-- Câu 6: Thực tập sinh có trainee_id = 5 được chuyển sang lớp "2". Hãy cập nhật
-- thông tin vào database
UPDATE trainee
SET training_class = 2
WHERE trainee_id = 5;
