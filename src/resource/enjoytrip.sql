CREATE DATABASE IF NOT EXISTS `enjoytrip`;
USE `enjoytrip`;
-- -----------------------------------------------------
-- Table `enjoytrip`.`members`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `enjoytrip`.`members`;
CREATE TABLE IF NOT EXISTS `enjoytrip`.`members`
(
    `user_id`       VARCHAR(16) NOT NULL,
    `user_name`     VARCHAR(20) NOT NULL,
    `user_password` VARCHAR(16) NOT NULL,
    `grade`         VARCHAR(10) NOT NULL,
    PRIMARY KEY (`user_id`)
)
    ENGINE = InnoDB
    DEFAULT CHARACTER SET = utf8mb4
    COLLATE = utf8mb4_0900_ai_ci;

insert into `enjoytrip`.`members` (user_id, user_name, user_password, grade)
values ('ssafy', '김싸피', '1234', 'default'),
       ('admin', '관리자', '1234', 'default'),
       ('joo1798', '주수아', '1798', 'admin'),
       ('dldlswns', '이인준', '1234', 'admin');

