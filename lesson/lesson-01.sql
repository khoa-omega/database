-- Xóa database: DROP DATABASE [IF EXISTS] <database_name>;
DROP DATABASE IF EXISTS sale_management;

-- Tạo database: CREATE DATABASE [IF NOT EXISTS] <database_name>;
CREATE DATABASE IF NOT EXISTS sale_management;

-- Chọn database muốn thao tác: USE <database_name>;
USE sale_management;

-- Xóa table: DROP TABLE [IF EXISTS] <table_name>;
DROP TABLE IF EXISTS customers;

-- Tạo table:
-- CREATE TABLE [IF NOT EXISTS] <table_name> (
--     <column_name_1> <data_type>,
--     <column_name_2> <data_type>,
--     ...
--     <column_name_n> <data_type>
-- );
CREATE TABLE IF NOT EXISTS customers (
    id INT,
    full_name VARCHAR(50),
    birthday DATE
);
