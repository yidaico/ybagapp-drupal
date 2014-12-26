create user 'ybagapp'@'localhost' identified by 'ybagapp';
create database ybagapp default character set utf8mb4 collate utf8mb4_general_ci;
grant all on ybagapp.* to 'ybagapp'@'localhost';
