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



Drop TABLE IF EXISTS `enjoytrip`.`file_info`;
Drop TABLE IF EXISTS `enjoytrip`.`post_comments`;
# Drop TABLE IF EXISTS `enjoytrip`.`sido`;
# Drop TABLE IF EXISTS `enjoytrip`.`gugun`;
Drop TABLE IF EXISTS `enjoytrip`.`attraction_info`;
Drop TABLE IF EXISTS `enjoytrip`.`attraction_description`;
Drop TABLE IF EXISTS `enjoytrip`.`attraction_detail`;
DROP TABLE IF EXISTS `enjoytrip`.`members`;
Drop TABLE IF EXISTS `enjoytrip`.`posts`;
Drop TABLE IF EXISTS `enjoytrip`.`posting`;
Drop TABLE IF EXISTS `enjoytrip`.`wishlist`;


-- -----------------------------------------------------
-- Table `enjoytrip`.`sido`
-- -----------------------------------------------------

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


ALTER TABLE `enjoytrip`.`members`
    ADD COLUMN `email` VARCHAR(255) NOT NULL AFTER `user_password`;

ALTER TABLE `enjoytrip`.`members`
    CHANGE COLUMN `email` `user_email` VARCHAR(255) NOT NULL;

-- -----------------------------------------------------
-- Table `enjoytrip`.`posting`
-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS `enjoytrip`.`posting`
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

ALTER TABLE `enjoytrip`.`posting`
    ADD COLUMN `hit` INT NOT NULL DEFAULT 0;



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



-- -----------------------------------------------------
-- Table `enjoytrip`.`members`
-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS `enjoytrip`.`members`
(
    `user_id`       VARCHAR(16) NOT NULL,
    `user_name`     VARCHAR(20) NOT NULL,
    `user_password` VARCHAR(64) NOT NULL,
    `grade`         VARCHAR(10) DEFAULT 'default',
    PRIMARY KEY (`user_id`)
)
    ENGINE = InnoDB
    DEFAULT CHARACTER SET = utf8mb4
    COLLATE = utf8mb4_0900_ai_ci;

ALTER TABLE `enjoytrip`.`members`
    MODIFY `grade` VARCHAR(10) NOT NULL DEFAULT 'default';



CREATE TABLE IF NOT EXISTS `enjoytrip`.`file_info`
(
    `id`            INT AUTO_INCREMENT,
    `post_id`       INT          NOT NULL,
    `save_folder`   VARCHAR(255) NOT NULL,
    `original_file` VARCHAR(255) NOT NULL,
    `save_file`     VARCHAR(255) NOT NULL,
    PRIMARY KEY (`id`),
    INDEX `file_info_to_post_post_id_fk_idx` (`post_id` ASC) VISIBLE,
    CONSTRAINT `file_info_to_post_post_id_fk`
        FOREIGN KEY (`post_id`)
            REFERENCES `enjoytrip`.`posting` (`post_id`)
            ON DELETE CASCADE
)
    ENGINE = InnoDB
    DEFAULT CHARACTER SET = utf8mb4
    COLLATE = utf8mb4_0900_ai_ci;


-- post_comments 테이블 생성
CREATE TABLE IF NOT EXISTS `enjoytrip`.`post_comments`
(
    `comment_id` INT AUTO_INCREMENT,
    `post_id`    INT         NOT NULL,
    `user_id`    VARCHAR(16) NOT NULL,
    `comment`    TEXT        NOT NULL,
    `created_at` TIMESTAMP   NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`comment_id`),
    INDEX `post_comments_to_post_post_id_fk_idx` (`post_id` ASC) VISIBLE,
    INDEX `post_comments_to_members_user_id_fk_idx` (`user_id` ASC) VISIBLE,
    CONSTRAINT `post_comments_to_post_post_id_fk`
        FOREIGN KEY (`post_id`)
            REFERENCES `enjoytrip`.`posting` (`post_id`)
            ON DELETE CASCADE,
    CONSTRAINT `post_comments_to_members_user_id_fk`
        FOREIGN KEY (`user_id`)
            REFERENCES `enjoytrip`.`members` (`user_id`)
            ON DELETE CASCADE
)
    ENGINE = InnoDB
    DEFAULT CHARACTER SET = utf8mb4
    COLLATE = utf8mb4_0900_ai_ci;



-- -----------------------------------------------------
-- Table `enjoytrip`.`review`
-- -----------------------------------------------------
drop table if exists `enjoytrip`.`review`;
CREATE TABLE IF NOT EXISTS `enjoytrip`.`review`
(
    `review_id`  INT          NOT NULL AUTO_INCREMENT,
    `title`      VARCHAR(100) NOT NULL,
    `content`    TEXT         NOT NULL,
    `rating`     TINYINT      NOT NULL,
    `user_id`    VARCHAR(16)  NOT NULL,
    `content_id` INT          NOT NULL,
    `created_at` TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`review_id`),
    INDEX `reviews_to_members_user_id_fk_idx` (`user_id` ASC) VISIBLE,
    INDEX `reviews_to_attraction_info_content_id_fk_idx` (`content_id` ASC) VISIBLE,
    CONSTRAINT `reviews_to_members_user_id_fk`
        FOREIGN KEY (`user_id`)
            REFERENCES `enjoytrip`.`members` (`user_id`)
            ON DELETE CASCADE,
    CONSTRAINT `reviews_to_attraction_info_content_id_fk`
        FOREIGN KEY (`content_id`)
            REFERENCES `enjoytrip`.`attraction_info` (`content_id`)
            ON DELETE CASCADE,
    CONSTRAINT `rating_check`
        CHECK (`rating` BETWEEN 1 AND 5)
)
    ENGINE = InnoDB
    DEFAULT CHARACTER SET = utf8mb4
    COLLATE = utf8mb4_0900_ai_ci;

ALTER TABLE `enjoytrip`.`review`
    ADD COLUMN `together` ENUM ('비지니스', '커플', '가족', '친구', '단독') DEFAULT '단독' AFTER `user_id`;


-- -----------------------------------------------------
-- Table `enjoytrip`.`review_file_info`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `enjoytrip`.`review_file_info`
(
    `id`            INT          NOT NULL AUTO_INCREMENT,
    `review_id`     INT          NOT NULL,
    `save_folder`   VARCHAR(255) NOT NULL,
    `original_file` VARCHAR(255) NOT NULL,
    `save_file`     VARCHAR(255) NOT NULL,
    PRIMARY KEY (`id`),
    INDEX `review_file_info_to_review_review_id_fk_idx` (`review_id` ASC) VISIBLE,
    CONSTRAINT `review_file_info_to_review_review_id_fk`
        FOREIGN KEY (`review_id`)
            REFERENCES `enjoytrip`.`review` (`review_id`)
            ON DELETE CASCADE
)
    ENGINE = InnoDB
    AUTO_INCREMENT = 1
    DEFAULT CHARACTER SET = utf8mb4
    COLLATE = utf8mb4_0900_ai_ci;



insert into sido
values ('0', '전체');


INSERT INTO gugun (gugun_code, gugun_name, sido_code)
SELECT 0, '전체', sido_code
FROM sido;



insert into `enjoytrip`.`members` (user_id, user_name, user_password, grade)
values ('ssafy', '김싸피', 'a477d9bfed77d6d10bcf91408877fec661196de6fa2c513daa2030b234f927ee', "admin"),
       ('admin', '관리자', 'a477d9bfed77d6d10bcf91408877fec661196de6fa2c513daa2030b234f927ee', "admin"),
       ('joo1798', '주수아', 'a477d9bfed77d6d10bcf91408877fec661196de6fa2c513daa2030b234f927ee', "admin"),
       ('dldlswns', '이인준', 'a477d9bfed77d6d10bcf91408877fec661196de6fa2c513daa2030b234f927ee', "admin");

ALTER TABLE attraction_info
    DROP FOREIGN KEY attraction_to_content_type_id_fk;

insert into posting(title, content, user_id, sido_code, gugun_code)
values ("광주 무등산", "수박 졸맛탱", "admin", 1, 5);

insert into posting(title, content, user_id, sido_code, gugun_code)
values ("세종 특별시 살기 좋은 도시", "기모찌", "admin", 1, 8);

INSERT INTO attraction_info (content_id, content_type_id, title, addr1, addr2, zipcode, tel,
                             first_image, first_image2, readcount, sido_code, gugun_code,
                             latitude, longitude, mlevel)

-- 서피비치 정보
VALUES (129999, -- content_id (임의로 설정)
        12, -- content_type_id (예시로 12: 관광지)
        '양양 서피비치', -- title
        '강원도 양양군 현남면 인구리 해변', -- addr1
        '', -- addr2 (세부 주소가 없는 경우 공백으로 설정)
        '25042', -- zipcode (양양군 현남면의 우편번호)
        '', -- tel (예시 전화번호)
        'https://www.bigtanews.co.kr/data/big/image/2023/07/06/big20230706000015.800x.0.jpg', -- first_image (이미지 URL 예시)
        '', -- first_image2 (이미지 URL 예시)
        999999, -- readcount (초기 조회수)
        32, -- sido_code (강원도의 시도 코드, 예시)
        7, -- gugun_code (양양군의 구군 코드, 예시)
        38.027834441415756, -- latitude (실제 위도)
        128.71728231189653, -- longitude (실제 경도)
        '6' -- mlevel (예시로 설정)
       );

INSERT INTO attraction_description (content_id, homepage, overview, telname)
VALUES (129999, -- content_id (양양 서피비치의 content_id와 동일하게 설정)
        '', -- homepage (서피비치의 공식 홈페이지 URL)
        '양양 서피비치는 대한민국 강원도 양양군 현남면에 위치한 인기 있는 서핑 장소입니다. 맑은 바다와 아름다운 해변으로 유명하며, 서핑과 해양 스포츠를 즐길 수 있는 최적의 장소입니다. 매년 많은 서핑 애호가들이 방문하여 다양한 서핑 대회와 이벤트가 개최됩니다. 서핑뿐만 아니라 해변에서의 휴식과 다양한 해양 활동을 즐길 수 있습니다.', -- overview (서피비치에 대한 설명)
        '' -- telname (전화번호 담당자 이름)
       );


-- 한라산 정보 삽입
INSERT INTO attraction_info (content_id, content_type_id, title, addr1, addr2, zipcode, tel,
                             first_image, first_image2, readcount, sido_code, gugun_code,
                             latitude, longitude, mlevel)
VALUES (399999, -- content_id (임의로 설정)
        12, -- content_type_id (관광지)
        '한라산', -- title
        '제주특별자치도 서귀포시 한라산로', -- addr1
        '', -- addr2
        '63524', -- zipcode
        '', -- tel
        'https://api.cdn.visitjeju.net/photomng/imgpath/201911/29/48bdb99e-20ba-4fb6-82f2-6ea79ceefb0d.jpg', -- first_image
        '', -- first_image2
        999999, -- readcount
        39, -- sido_code (제주특별자치도)
        3, -- gugun_code (서귀포시)
        33.361424638771474, -- latitude
        126.52941927591584, -- longitude
        '6' -- mlevel
       );

-- 한라산 설명 삽입
INSERT INTO attraction_description (content_id, homepage, overview, telname)
VALUES (399999, -- content_id
        '', -- homepage
        '한라산은 제주도의 최고봉으로, 대한민국에서 가장 아름다운 자연 경관을 자랑합니다. 화산학적 유산과 다양한 식물, 동물이 서식하고 있으며, 등산으로 유명합니다.', -- overview
        '' -- telname
       );

-- 감천 문화 마을 정보 삽입
INSERT INTO attraction_info (content_id, content_type_id, title, addr1, addr2, zipcode, tel,
                             first_image, first_image2, readcount, sido_code, gugun_code,
                             latitude, longitude, mlevel)
VALUES (124989, -- content_id (임의로 설정)
        12, -- content_type_id (관광지)
        '감천문화마을', -- title
        '부산 사하구 감천동 10-13', -- addr1
        '', -- addr2
        '', -- zipcode (우편번호 정보가 없는 경우 빈 문자열로 설정)
        '051-204-1444', -- tel
        'https://a.cdn-hotels.com/gdcs/production37/d1169/1dcbfef5-2070-48ce-8d62-3e0fffa21797.jpg?impolicy=fcrop&w=800&h=533&q=medium', -- first_image
        '', -- first_image2
        999999, -- readcount
        6, -- sido_code (부산광역시)
        10, -- gugun_code (사하구)
        35.09630012826786, -- latitude (위도)
        129.00942831915552, -- longitude (경도)
        '6' -- mlevel
       );

-- 감천 문화 마을 설명 삽입
INSERT INTO attraction_description (content_id, homepage, overview, telname)
VALUES (124989, -- content_id
        'http://place.map.kakao.com/21362956', -- homepage (카카오맵 페이지)
        '부산의 사하구 감천동에 위치한 감천문화마을은 예술가들의 작업실과 다양한 예술작품이 있는 아름다운 마을입니다. 전통 가옥과 작은 골목길이 어우러진 곳으로, 많은 관광객들이 찾는 관광 명소입니다.', -- overview
        '감천문화마을 안내실' -- telname
       );

-- 석굴암 정보 삽입
INSERT INTO attraction_info (content_id, content_type_id, title, addr1, addr2, zipcode, tel,
                             first_image, first_image2, readcount, sido_code, gugun_code,
                             latitude, longitude, mlevel)
VALUES (129494, -- content_id (임의로 설정)
        12, -- content_type_id (관광지)
        '석굴암', -- title
        '경북 경주시 진현동 999', -- addr1
        '', -- addr2
        '', -- zipcode (우편번호 정보가 없는 경우 빈 문자열로 설정)
        '054-746-9933', -- tel
        'https://i.namu.wiki/i/xLSOdP-J_zLPsabiBGRaemNXJGXoFkTnwNLV3UFOup2dxP7J2NtoztrO2l4BTVd-6ElW6yrV4Xv15q5Of3CfV1GLs1Xyra5KKzoOVB92q1FjTJP7T8kOQk5wbsCuFX_5_yGcG4ym5vCQgo3hqgJy0g.webp', -- first_image
        '', -- first_image2
        999999, -- readcount
        35, -- sido_code (경상북도)
        2, -- gugun_code (경주시)
        35.79524166200299, -- latitude (위도)
        129.35052073446747, -- longitude (경도)
        '6' -- mlevel
       );

-- 석굴암 설명 삽입
INSERT INTO attraction_description (content_id, homepage, overview, telname)
VALUES (129494, -- content_id
        '', -- homepage (카카오맵 페이지)
        '경북 경주시에 위치한 석굴암은 한국의 대표적인 사찰로, 고려시대에 지어진 석가탑이 있는 곳으로 유명합니다. 석굴암은 불교 사찰로 유서 깊은 곳으로, 많은 관광객들이 찾는 경주의 대표적인 관광지입니다.', -- overview
        '석굴암 관리실' -- telname
       );


-- 에버랜드 정보 삽입
INSERT INTO attraction_info (content_id, content_type_id, title, addr1, addr2, zipcode, tel,
                             first_image, first_image2, readcount, sido_code, gugun_code,
                             latitude, longitude, mlevel)
VALUES (129904, -- content_id (임의로 설정)
        12, -- content_type_id (관광지)
        '에버랜드', -- title
        '경기 용인시 처인구 포곡읍 전대리 310', -- addr1
        '', -- addr2
        '', -- zipcode (우편번호 정보가 없는 경우 빈 문자열로 설정)
        '031-320-5000', -- tel
        'https://image.kkday.com/v2/image/get/s1.kkday.com/product_36325/20230216025250_CIXCh/jpg', -- first_image
        '', -- first_image2
        999999, -- readcount
        31, -- sido_code (경기도)
        23, -- gugun_code (용인시 처인구)
        37.293101115700345, -- latitude (위도)
        127.20219830178264, -- longitude (경도)
        '6' -- mlevel
       );

-- 에버랜드 설명 삽입
INSERT INTO attraction_description (content_id, homepage, overview, telname)
VALUES (129904, -- content_id
        'http://place.map.kakao.com/784414359', -- homepage (카카오맵 페이지)
        '에버랜드는 대한민국 경기도 용인시에 위치한 대규모 테마파크로, 다양한 놀이시설과 쇼, 이벤트가 개최되는 인기 있는 관광지입니다. 가족이나 친구와 함께 즐길 수 있는 다채로운 놀이 체험과 액티비티를 제공하며, 매년 많은 관광객들이 찾는 곳입니다.', -- overview
        '에버랜드 관리실' -- telname
       );


SET SQL_MODE = @OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS = @OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS = @OLD_UNIQUE_CHECKS;

commit;