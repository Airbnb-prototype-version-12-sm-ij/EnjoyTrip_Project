-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS = @@UNIQUE_CHECKS, UNIQUE_CHECKS = 0;
SET @OLD_FOREIGN_KEY_CHECKS = @@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS = 0;
SET @OLD_SQL_MODE = @@SQL_MODE, SQL_MODE =
        'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema enjoytrip
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema enjoytrip
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `enjoytrip` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
USE `enjoytrip`;

-- -----------------------------------------------------
-- Table `enjoytrip`.`sido`
-- -----------------------------------------------------
Drop TABLE IF EXISTS `enjoytrip`.`sido`;
CREATE TABLE IF NOT EXISTS `enjoytrip`.`sido`
(
    `sido_code` INT         NOT NULL,
    `sido_name` VARCHAR(30) NULL DEFAULT NULL,
    PRIMARY KEY (`sido_code`)
)
    ENGINE = InnoDB
    DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `enjoytrip`.`gugun`
-- -----------------------------------------------------
Drop TABLE IF EXISTS `enjoytrip`.`gugun`;
CREATE TABLE IF NOT EXISTS `enjoytrip`.`gugun`
(
    `gugun_code` INT         NOT NULL,
    `gugun_name` VARCHAR(30) NULL DEFAULT NULL,
    `sido_code`  INT         NOT NULL,
    PRIMARY KEY (`gugun_code`, `sido_code`),
    INDEX `gugun_to_sido_sido_code_fk_idx` (`sido_code` ASC) VISIBLE,
    CONSTRAINT `gugun_to_sido_sido_code_fk`
        FOREIGN KEY (`sido_code`)
            REFERENCES `enjoytrip`.`sido` (`sido_code`)
)
    ENGINE = InnoDB
    DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `enjoytrip`.`attraction_info`
-- -----------------------------------------------------
Drop TABLE IF EXISTS `enjoytrip`.`attraction_info`;
CREATE TABLE IF NOT EXISTS `enjoytrip`.`attraction_info`
(
    `content_id`      INT             NOT NULL,
    `content_type_id` INT             NULL DEFAULT NULL,
    `title`           VARCHAR(100)    NULL DEFAULT NULL,
    `addr1`           VARCHAR(100)    NULL DEFAULT NULL,
    `addr2`           VARCHAR(50)     NULL DEFAULT NULL,
    `zipcode`         VARCHAR(50)     NULL DEFAULT NULL,
    `tel`             VARCHAR(50)     NULL DEFAULT NULL,
    `first_image`     VARCHAR(200)    NULL DEFAULT NULL,
    `first_image2`    VARCHAR(200)    NULL DEFAULT NULL,
    `read_count`      INT             NULL DEFAULT NULL,
    `sido_code`       INT             NULL DEFAULT NULL,
    `gugun_code`      INT             NULL DEFAULT NULL,
    `latitude`        DECIMAL(20, 17) NULL DEFAULT NULL,
    `longitude`       DECIMAL(20, 17) NULL DEFAULT NULL,
    `mlevel`          VARCHAR(2)      NULL DEFAULT NULL,
    PRIMARY KEY (`content_id`),
    INDEX `attraction_to_content_type_id_fk_idx` (`content_type_id` ASC) VISIBLE,
    INDEX `attraction_to_sido_code_fk_idx` (`sido_code` ASC) VISIBLE,
    INDEX `attraction_to_gugun_code_fk_idx` (`gugun_code` ASC) VISIBLE,
    CONSTRAINT `attraction_to_content_type_id_fk`
        FOREIGN KEY (`content_type_id`)
            REFERENCES `enjoytrip`.`content_type` (`content_type_id`),
    CONSTRAINT `attraction_to_gugun_code_fk`
        FOREIGN KEY (`gugun_code`)
            REFERENCES `enjoytrip`.`gugun` (`gugun_code`),
    CONSTRAINT `attraction_to_sido_code_fk`
        FOREIGN KEY (`sido_code`)
            REFERENCES `enjoytrip`.`sido` (`sido_code`)
)
    ENGINE = InnoDB
    DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `enjoytrip`.`attraction_description`
-- -----------------------------------------------------
Drop TABLE IF EXISTS `enjoytrip`.`attraction_description`;
CREATE TABLE IF NOT EXISTS `enjoytrip`.`attraction_description`
(
    `content_id` INT            NOT NULL,
    `homepage`   VARCHAR(100)   NULL DEFAULT NULL,
    `overview`   VARCHAR(10000) NULL DEFAULT NULL,
    `telname`    VARCHAR(45)    NULL DEFAULT NULL,
    PRIMARY KEY (`content_id`),
    CONSTRAINT `attraction_detail_to_attraciton_id_fk`
        FOREIGN KEY (`content_id`)
            REFERENCES `enjoytrip`.`attraction_info` (`content_id`)
)
    ENGINE = InnoDB
    DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `enjoytrip`.`attraction_detail`
-- -----------------------------------------------------
Drop TABLE IF EXISTS `enjoytrip`.`attraction_detail`;
CREATE TABLE IF NOT EXISTS `enjoytrip`.`attraction_detail`
(
    `content_id`    INT         NOT NULL,
    `cat1`          VARCHAR(3)  NULL DEFAULT NULL,
    `cat2`          VARCHAR(5)  NULL DEFAULT NULL,
    `cat3`          VARCHAR(9)  NULL DEFAULT NULL,
    `created_time`  VARCHAR(14) NULL DEFAULT NULL,
    `modified_time` VARCHAR(14) NULL DEFAULT NULL,
    `booktour`      VARCHAR(5)  NULL DEFAULT NULL,
    PRIMARY KEY (`content_id`),
    CONSTRAINT `attraction_detail_to_basic_content_id_fk`
        FOREIGN KEY (`content_id`)
            REFERENCES `enjoytrip`.`attraction_info` (`content_id`)
)
    ENGINE = InnoDB
    DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `enjoytrip`.`members`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `enjoytrip`.`members`;
CREATE TABLE IF NOT EXISTS `enjoytrip`.`members`
(
    `user_id`           VARCHAR(16) NOT NULL,
    `user_name`         VARCHAR(20) NOT NULL,
    `user_password`     VARCHAR(64) NOT NULL,
    `grade`             VARCHAR(10) NOT NULL,
    `registration_date` TIMESTAMP   NOT NULL DEFAULT CURRENT_TIMESTAMP, -- 가입일 열 추가
    PRIMARY KEY (`user_id`)
)
    ENGINE = InnoDB
    DEFAULT CHARACTER SET = utf8mb4
    COLLATE = utf8mb4_0900_ai_ci;



-- -----------------------------------------------------
-- Table `enjoytrip`.`posts`
-- -----------------------------------------------------
Drop TABLE IF EXISTS `enjoytrip`.`posts`;
CREATE TABLE IF NOT EXISTS `enjoytrip`.`posts`
(
    `post_id`    INT          NOT NULL AUTO_INCREMENT,
    `title`      VARCHAR(100) NOT NULL,
    `content`    TEXT         NOT NULL,
    `user_id`    VARCHAR(16)  NOT NULL,
    `sido_code`  INT          NOT NULL,                                -- 시도 코드 추가
    `gugun_code` INT          NOT NULL,
    `created_at` TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`post_id`),
    INDEX `posts_to_members_user_id_fk_idx` (`user_id` ASC) VISIBLE,
    INDEX `posts_to_gugun_gugun_code_fk_idx` (`gugun_code` ASC) VISIBLE,
    INDEX `posts_to_gugun_sido_code_fk_idx` (`sido_code` ASC) VISIBLE, -- 시도 코드 인덱스 추가
    CONSTRAINT `posts_to_members_user_id_fk`
        FOREIGN KEY (`user_id`)
            REFERENCES `enjoytrip`.`members` (`user_id`)
            ON DELETE CASCADE,
    CONSTRAINT `posts_to_gugun_gugun_code_fk`
        FOREIGN KEY (`gugun_code`)
            REFERENCES `enjoytrip`.`gugun` (`gugun_code`)
            ON DELETE CASCADE,
    CONSTRAINT `posts_to_gugun_sido_code_fk`                           -- 시도 코드 외래 키 제약 조건 추가
        FOREIGN KEY (`sido_code`)
            REFERENCES `enjoytrip`.`gugun` (`sido_code`)               -- 구군 테이블의 시도 코드 컬럼을 참조
            ON DELETE CASCADE
)
    ENGINE = InnoDB
    DEFAULT CHARACTER SET = utf8mb4
    COLLATE = utf8mb4_0900_ai_ci;


Drop TABLE IF EXISTS `enjoytrip`.`wishlist`;
CREATE TABLE IF NOT EXISTS `enjoytrip`.`wishlist`
(
    `wishlist_id` INT         NOT NULL AUTO_INCREMENT,
    `user_id`     VARCHAR(16) NOT NULL,
    `content_id`  INT         NOT NULL,
    `added_at`    TIMESTAMP   NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`wishlist_id`),
    INDEX `wishlist_to_members_user_id_fk_idx` (`user_id` ASC) VISIBLE,
    INDEX `wishlist_to_attraction_info_content_id_fk_idx` (`content_id` ASC) VISIBLE,
    CONSTRAINT `wishlist_to_members_user_id_fk`
        FOREIGN KEY (`user_id`)
            REFERENCES `enjoytrip`.`members` (`user_id`)
            ON DELETE CASCADE,
    CONSTRAINT `wishlist_to_attraction_info_content_id_fk`
        FOREIGN KEY (`content_id`)
            REFERENCES `enjoytrip`.`attraction_info` (`content_id`)
            ON DELETE CASCADE
)
    ENGINE = InnoDB
    DEFAULT CHARACTER SET = utf8mb4
    COLLATE = utf8mb4_0900_ai_ci;



SET SQL_MODE = @OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS = @OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS = @OLD_UNIQUE_CHECKS;

