-- 주의사항 : Design table을 해서 FK 적용할때 데이터타입, 자릿수 다 맞춰주고
-- COLLATE 에서 utf8mb3_general_ci 을 utf8mb3_unicode로 바꾸는중입니다. 
-- 부모테이블을 어떻게 바꿨더니 collate가 unicode_ci로 되어있었음
-- 아마 general_ci 가 varchar에서의 기본값인듯.
-- 설명은 쿼리문 아래에 기록하였습니다.
-- FK 적용시 마리아db에서는  데이터타입도 맞아야하고 collate 하고 인덱스 등도 다 매치가 되어야 되니까
-- Design table에서 참고하고 고쳐야 될겁니다.

CREATE TABLE `trainers` (
	`member_no`	VARCHAR(30)	NOT NULL,
	`member_nick`	VARCHAR(30)	NOT NULL,
	`tr_smoking`	VARCHAR(4)	NOT NULL	COMMENT '흡연여부',
	`tr_license`	varchar(4)	NOT NULL	COMMENT '자격증',  
	`tr_career`	varchar(600)	NOT NULL comment '경력',
	`tr_special`	varchar(200)	NOT NULL comment '전문분야'
);
ALTER TABLE `amigo`.`trainers` 
ADD CONSTRAINT `FK_tr_no` FOREIGN KEY (`member_no`) REFERENCES `amigo`.`members` (`member_no`),
ADD CONSTRAINT `FK_tr_nick` FOREIGN KEY (`member_nick`) REFERENCES `amigo`.`members` (`member_nick`);
-- 훈련사 부분

	CREATE TABLE `members` (
	`member_no`	VARCHAR(30)	NOT NULL,
	`member_nick`	VARCHAR(30)	NOT NULL,
	`mem_id`	VARCHAR(40)	NOT NULL	COMMENT '회원ID',
	`mem_name`	VARCHAR(30)	NOT NULL	COMMENT '회원명',
	`mem_email`	VARCHAR(100)	NOT NULL	COMMENT '이메일',
	`mem_gender`	VARCHAR(6)	NOT NULL	COMMENT '회원성별',
	`mem_pw`	VARCHAR(40)	NOT NULL	COMMENT '회원PW',
	`mem_birthday`	INT(11)	NOT NULL	COMMENT '생년월일',
	`mem_phone`	VARCHAR(20)	NOT NULL	COMMENT '휴대전화',
	`mem_addr`	VARCHAR(160)	NOT NULL	COMMENT '주소',
	`mem_revoke`	VARCHAR(50)	NULL	COMMENT '회원탈퇴',
	`mem_photo`	varchar(100)	NULL,
	`Key`	VARCHAR(30)	NOT NULL,
	`Field`	boolean	NOT NULL
);
ALTER TABLE `members` 
MODIFY COLUMN `member_no` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL COMMENT '회원번호' FIRST,
MODIFY COLUMN `member_nick` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL COMMENT '회원닉네임' AFTER `member_no`,
ADD PRIMARY KEY (`member_no`, `member_nick`);
ALTER TABLE `members` 
MODIFY COLUMN `mem_photo` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NULL DEFAULT NULL COMMENT '사진' AFTER `mem_revoke`,
MODIFY COLUMN `Key` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL COMMENT '회원타입' AFTER `mem_photo`,
MODIFY COLUMN `Field` tinyint(1) NOT NULL COMMENT '관리자권한' AFTER `Key`;
-- 일단 추가할거 추가하고, mem_photo 는 url을 넣을듯. 그래서 varchar100.. 캐릭셋과 collate는 utf8mb3_unicode_ci로 통일함
-- 가능하면 쿼리로 동작시켜보려고 하였음. 테이블만드는 쿼리와 테이블 수정하는 쿼리를 따로 분리시켰으니 참고하세요.


-- drop table `creditcard`;

CREATE TABLE `creditcard` (
	`c_company`	VARCHAR(50)	NOT NULL	COMMENT '카드사',
	`c_exp`	CHAR(5)	NOT NULL	COMMENT '유효기간',
	`c_no`	VARCHAR(30)	NOT NULL comment '카드번호',
	`member_no`	VARCHAR(30)	NOT NULL COMMENT '회원번호',
	`member_nick`	VARCHAR(30)	NOT NULL COMMENT '회원닉네임'
);
ALTER TABLE `amigo`.`creditcard` 
ADD CONSTRAINT `memno` FOREIGN KEY (`member_no`) REFERENCES `amigo`.`members` (`member_no`);
ALTER TABLE `amigo`.`creditcard` DROP FOREIGN KEY `creditcard_ibfk_1`;

ALTER TABLE `amigo`.`creditcard` DROP FOREIGN KEY `creditcard_ibfk_2`;

ALTER TABLE `amigo`.`creditcard` 
ADD CONSTRAINT `FK_c_no` FOREIGN KEY (`member_no`) REFERENCES `amigo`.`members` (`member_no`) ON DELETE RESTRICT ON UPDATE RESTRICT,
ADD CONSTRAINT `FK_c_nick` FOREIGN KEY (`member_nick`) REFERENCES `amigo`.`members` (`member_nick`) ON DELETE RESTRICT ON UPDATE RESTRICT;


CREATE TABLE `question_board` (
	`qna_title`	VARCHAR(30)	NOT NULL	COMMENT 'Q&A제목',
	`qna_content`	VARCHAR(500)	NOT NULL	COMMENT 'Q&A내용',
	`qna_date`	DATE	NOT NULL	COMMENT 'Q&A날짜',
	`qna_cnt`	INT	NOT NULL	COMMENT 'Q&A조회수',
	`qna_reply`	VARCHAR(500)	NULL	COMMENT 'Q&A댓글' ) COMMENT '훈련사Q&A'; ALTER TABLE `MY_SCHEMA`.`members` ADD CONSTRAINT `FK_member_type_TO_members` FOREIGN KEY ( `group` ) REFERENCES `MY_SCHEMA`.`member_type` ( `group`
);




CREATE TABLE `petsitter` (
	`member_no`	VARCHAR(30)	NOT NULL,
	`member_nick`	VARCHAR(30)	NOT NULL,
	`s_smoking`	VARCHAR(4)	NOT NULL	COMMENT '흡연여부',
	`s_job`	VARCHAR(10)	NOT NULL	COMMENT '현재직종',
	`s_available`	varchar(50)	NOT NULL	COMMENT '활동가능일수',
	`s_keep`	boolean	NOT NULL	COMMENT '반려경험',
	`s_license`	varchar(100)	NULL comment '자격증',
	`s_route`	VARCHAR(100)	NOT NULL comment '유입경로',
	`s_career`	VARCHAR(250)	NULL comment '활동경력',
	`s_iam`	VARCHAR(1000)	NOT NULL comment '자기소개',
	`s_myexp`	varchar(500)	NULL comment '기타경험'
);
ALTER TABLE `amigo`.`petsitter` 
MODIFY COLUMN `member_no` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL FIRST,
MODIFY COLUMN `member_nick` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL AFTER `member_no`,
ADD CONSTRAINT `FK_s_no` FOREIGN KEY (`member_no`) REFERENCES `amigo`.`members` (`member_no`),
ADD CONSTRAINT `FK_s_no` FOREIGN KEY (`member_nick`) REFERENCES `amigo`.`members` (`member_nick`);



CREATE TABLE `CHAT_DATER` (
	`CHAT_ID`	VARCHAR(50)	NOT NULL,
	`CHAT_TEXT_ID`	VARCHAR(50)	NOT NULL,
	`member_no`	VARCHAR(30)	NOT NULL,
	`member_nick`	VARCHAR(30)	NOT NULL,
	`CHAT_CONT`	VARCHAR(2000)	NOT NULL,
	`CHAT_DATE`	DATE	NOT NULL
);
ALTER TABLE `amigo`.`chat_dater` 
MODIFY COLUMN `CHAT_ID` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL COMMENT '채팅방ID' FIRST,
MODIFY COLUMN `CHAT_TEXT_ID` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL COMMENT '안읽은채팅ID' AFTER `CHAT_ID`,
MODIFY COLUMN `member_no` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL AFTER `CHAT_TEXT_ID`,
MODIFY COLUMN `member_nick` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL AFTER `member_no`,
MODIFY COLUMN `CHAT_CONT` varchar(2000) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '채팅내용' AFTER `member_nick`,
MODIFY COLUMN `CHAT_DATE` date NOT NULL COMMENT '채팅시간' AFTER `CHAT_CONT`,
ADD PRIMARY KEY (`CHAT_ID`, `CHAT_TEXT_ID`),
ADD CONSTRAINT `FK_chdt_no` FOREIGN KEY (`member_no`) REFERENCES `amigo`.`members` (`member_no`),
ADD CONSTRAINT `FK_chdt_nick` FOREIGN KEY (`member_nick`) REFERENCES `amigo`.`members` (`member_nick`);
-- 캐릭터셋과 collate 모두 바꿨음.. 쿼리 참고해주세요.

CREATE TABLE `CHAT_ALARM` (
	`CHAT_ID`	VARCHAR(50)	NOT NULL,
	`CHAT_TEXT_ID2`	VARCHAR(50)	NOT NULL,
	`member_no`	VARCHAR(30)	NOT NULL,
	`member_nick`	VARCHAR(30)	NOT NULL
);
-- 외래키 처리 했는데 쿼리를 추가 못하였음 양해를;


CREATE TABLE `Dog` (
	`dog_no`	INT	NOT NULL	COMMENT '반려견번호',
	`member_no`	VARCHAR(30)	NOT NULL,
	`member_nick`	VARCHAR(30)	NOT NULL,
	`dog_breeds`	VARCHAR(30)	NOT NULL	COMMENT '품종',
	`dog_name`	VARCHAR(20)	NOT NULL	COMMENT '이름',
	`dog_birth`	DATE	NULL	COMMENT '생년월일',
	`dog_weight`	DOUBLE	NULL	COMMENT '몸무게',
	`dog_neutered`	tinyint(1) 		COMMENT '중성화',
	`dog_gender`	varchar(1)	NOT NULL	COMMENT '성별',
	`dog_image_url`	varchar(100)	NULL	COMMENT '사진경로',
	`dog_vaccine`	DATE	NULL	COMMENT '백신날짜',
	`dog_etc`	VARCHAR(100)	NULL	COMMENT '기타사항'
);

ALTER TABLE `amigo`.`dog` 
MODIFY COLUMN `member_no` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL AFTER `dog_no`,
MODIFY COLUMN `member_nick` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL AFTER `member_no`,
ADD PRIMARY KEY (`dog_no`),
ADD CONSTRAINT `FK_dog_m_no` FOREIGN KEY (`member_no`) REFERENCES `amigo`.`members` (`member_no`),
ADD CONSTRAINT `FK_dog_m_nick` FOREIGN KEY (`member_nick`) REFERENCES `amigo`.`members` (`member_nick`);
-- collation 은 member_no, member_nick 열은 utf8mb3 unicode_ci로 통일함
-- Dog 테이블에서 몸무게칼럼에서 double(20)에서 자릿수 뺌, 중성화는 boolean -> tinyint(1)로바꿈.
-- 테이블디자인에서 boolean으로 맞춰도 자꾸 tinyint(1)로 처리가 되는데 아마도 mySQL버전관련문제일듯..
-- 버전 관련 에러와 syntax 에러가 자꾸 떠서 tinyint 로변경함 기능은 동일하다고합니다.

CREATE TABLE `beauty` (
	`bt_name`	varchar(30)	NOT NULL,
	`bt_price`	number	NOT NULL,
	`bt_home`	VARCHAR(255)	NULL,
	`bt_local`	int	NULL
);



CREATE TABLE `user_board` (
	`member_no`	VARCHAR(30)	NOT NULL,
	`member_nick`	VARCHAR(30)	NOT NULL,
	`ubd_no`	INT(11)	NOT NULL	COMMENT '글번호',
	`ubd_dogType`	varchar(50)	NULL	COMMENT '견종',
	`ubd_subject`	varchar(100)	NOT NULL	COMMENT '제목',
	`ubd_content`	varchar(5000)	NOT NULL	COMMENT '글내용',
	`ubd_readcount`	INT(11)	NULL	COMMENT '조회수',
	`ubd_regdate`	DATE	NOT NULL	COMMENT '작성일자',
	`ubd_file`	varchar(500)	NULL	COMMENT '파일경로',
	`ubd_like_cnt`	INT(11)	NULL	COMMENT '추천수' 
);
ALTER TABLE `amigo`.`user_board` 
MODIFY COLUMN `member_no` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL FIRST,
MODIFY COLUMN `member_nick` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL AFTER `member_no`,
ADD CONSTRAINT `FK_user_b_no` FOREIGN KEY (`member_no`) REFERENCES `amigo`.`members` (`member_no`),
ADD CONSTRAINT `FK_user_b_nick` FOREIGN KEY (`member_nick`) REFERENCES `amigo`.`members` (`member_nick`);
ALTER TABLE `amigo`.`user_board` 
ADD PRIMARY KEY (`ubd_no`);

-- 여기 INT 는 자릿수를 추가하였음 (디폴트값(11자리)
-- collate를 general 에서 unicode로 바꿔준후 FK를 추가하였음.
-- alter table `스키마`.`테이블명` modify column `컬럼명` 타입(자릿수) character set utf8mb3 collate 바꾼거 not null after `첫컬럼`, add cons-
-- traint `외래키명` foerign key (`대상컬럼명`) references `스키마명`.`참조(부모)테이블명` (`참조컬럼명`); 
-- user_board 의 글번호에는 PK를 달았음. alter table `스키마명`.`user_board` add primary key(`대상테이블명`);
CREATE TABLE `user_bd_like` (
	`ubd_no`	varchar(30)	NOT NULL,
	`us_like_is`	BOOLEAN	NOT NULL	COMMENT '좋아요여부',
	`member_no`	VARCHAR(30)	NOT NULL,	
	`member_nick`	varchar(30)	NOT NULL)
;
ALTER TABLE `amigo`.`user_bd_like` 
MODIFY COLUMN `ubd_no` int(11) NOT NULL FIRST,
MODIFY COLUMN `member_no` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL AFTER `us_like_is`,
MODIFY COLUMN `member_nick` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL AFTER `member_no`,
ADD CONSTRAINT `FK_ubd_no_ref` FOREIGN KEY (`ubd_no`) REFERENCES `amigo`.`user_board` (`ubd_no`),
ADD CONSTRAINT `FK_mem_no` FOREIGN KEY (`member_no`) REFERENCES `amigo`.`members` (`member_no`),
ADD CONSTRAINT `FK_mem_nick` FOREIGN KEY (`member_nick`) REFERENCES `amigo`.`members` (`member_nick`);
-- 테이블 정리해서 만들었음
-- ubd_no 는 int 11자리로 바꿨고 나머지는 collate 바꾸고 그담에 외래키 처리하였음.

CREATE TABLE `help_board` (
	`member_no`	VARCHAR(30)	NOT NULL,
	`member_nick`	VARCHAR(30)	NOT NULL,
	`hbd_no`	INT(11)	NOT NULL	COMMENT '글번호',
	`hbd_subject`	varchar(100)	NOT NULL	COMMENT '제목',
	`hbd_content`	varchar(5000)	NOT NULL	COMMENT '글내용',
	`hbd_readcount`	INT(1)	NULL	COMMENT '조회수',
	`hbd_regdate`	DATE	NOT NULL	COMMENT '작성일자',
	`hbd_file`	varchar(500)	NULL	COMMENT '파일경로'
);
ALTER TABLE `amigo`.`help_board` 
MODIFY COLUMN `member_no` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL FIRST,
MODIFY COLUMN `member_nick` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL AFTER `member_no`,
ADD CONSTRAINT `FK_help_mno` FOREIGN KEY (`member_no`) REFERENCES `amigo`.`members` (`member_no`),
ADD CONSTRAINT `FK_help_mnick` FOREIGN KEY (`member_nick`) REFERENCES `amigo`.`members` (`member_nick`);
ALTER TABLE `amigo`.`help_board` 
ADD PRIMARY KEY (`hbd_no`);
-- user_board 와 상동.

CREATE TABLE `user_reply` (
	`ubd_r_no`	INT(11)	NOT NULL	COMMENT '댓글번호',
	`ubd_no`	INT(11)	NOT NULL	COMMENT '게시글번호',
	`ubd_r_content`	VARCHAR(400)	NOT NULL	COMMENT '댓글내용',
	`ubd_r_regdate`	DATE	NOT NULL	COMMENT '댓글등록일자',
	`ubd_r_ref`	INT(11)	NULL	COMMENT '참조댓글',
	`ubd_r_lev`	INT(11)	NULL	COMMENT '댓글단계',
	`ubd_r_seq`	INT(11)	NULL	COMMENT '댓글순서',
	`member_no`	VARCHAR(30)	NOT NULL,
	`member_nick`	VARCHAR(30)	NOT NULL
);
ALTER TABLE `amigo`.`user_reply` 
MODIFY COLUMN `member_no` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL AFTER `ubd_r_seq`,
MODIFY COLUMN `member_nick` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL AFTER `member_no`,
ADD CONSTRAINT `FK_board_refno` FOREIGN KEY (`ubd_no`) REFERENCES `amigo`.`user_board` (`ubd_no`),
ADD CONSTRAINT `FK_user_no` FOREIGN KEY (`member_no`) REFERENCES `amigo`.`members` (`member_no`),
ADD CONSTRAINT `FK_user_nick` FOREIGN KEY (`member_nick`) REFERENCES `amigo`.`members` (`member_nick`);
-- 게시글번호는 user_board에서 참조했고, 멤버에서 번호와 닉네임을 가져옴 

CREATE TABLE `help_reply` (
	`hbd_r_no`	INT(11)	NOT NULL	COMMENT '댓글번호',
	`hbd_r_content`	VARCHAR(400)	NOT NULL	COMMENT '댓글내용',
	`hbd_r_regdate`	DATE	NOT NULL	COMMENT '댓글등록일자',
	`hbd_r_ref`	INT(11)	NULL	COMMENT '참조댓글',
	`hbd_r_lev`	INT(11)	NULL	COMMENT '댓글단계',
	`hbd_r_seq`	INT(11)	NULL	COMMENT '댓글순서',
	`hbd_no`	INT(11)	NOT NULL	COMMENT '글번호',
	`member_no`	VARCHAR(30)	NOT NULL,
	`member_nick`	VARCHAR(30)	NOT NULL
);
ALTER TABLE `amigo`.`help_reply` 
MODIFY COLUMN `member_no` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL AFTER `hbd_no`,
MODIFY COLUMN `member_nick` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL AFTER `member_no`,
ADD CONSTRAINT `FK_hbd_no` FOREIGN KEY (`hbd_no`) REFERENCES `amigo`.`help_board` (`hbd_no`),
ADD CONSTRAINT `FK_hmno` FOREIGN KEY (`member_no`) REFERENCES `amigo`.`members` (`member_no`),
ADD CONSTRAINT `FK_hmnick` FOREIGN KEY (`member_nick`) REFERENCES `amigo`.`members` (`member_nick`);
-- 유저와 상동...


CREATE TABLE `partner_community` (
	`pc_no`	INT	NOT NULL,
	`pc_title`	VARCHAR(100)	NOT NULL,
	`pc_content`	VARCHAR(1000)	NOT NULL,
	`pc_cnt`	INT	NOT NULL,
	`pc_date`	DATE	NOT NULL
);
ALTER TABLE `amigo`.`partner_community` 
MODIFY COLUMN `pc_no` int(11) NOT NULL COMMENT '글번호' FIRST,
MODIFY COLUMN `pc_title` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL COMMENT '글제목' AFTER `pc_no`,
MODIFY COLUMN `pc_content` varchar(1000) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL COMMENT '글내용' AFTER `pc_title`,
MODIFY COLUMN `pc_cnt` int(11) NOT NULL COMMENT '조회수' AFTER `pc_content`,
MODIFY COLUMN `pc_date` date NOT NULL COMMENT '작성일자' AFTER `pc_cnt`,
ADD PRIMARY KEY (`pc_no`);
-- 파트너 게시판..펫시터와 트레이너의 공간.  pk적용함.




CREATE TABLE `partner_community_reply` (
	`pc_re_no`	INT	NOT NULL,
	`pc_no`	INT	NOT NULL,
	`pc_re_con`	VARCHAR(400)	NOT NULL,
	`pc_re_date`	DATE	NOT NULL,
	`pc_re_ref`	INT	NULL,
	`pc_re_lev`	INT	NULL,
	`pc_re_seq`	INT	NULL
);
ALTER TABLE `amigo`.`partner_community_reply` 
MODIFY COLUMN `pc_re_no` int(11) NOT NULL COMMENT '댓글번호' FIRST,
MODIFY COLUMN `pc_no` int(11) NOT NULL COMMENT '글번호' AFTER `pc_re_no`,
MODIFY COLUMN `pc_re_con` varchar(400) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL COMMENT '댓글내용' AFTER `pc_no`,
MODIFY COLUMN `pc_re_date` date NOT NULL COMMENT '작성일자' AFTER `pc_re_con`,
MODIFY COLUMN `pc_re_ref` int(11) NULL DEFAULT NULL COMMENT '참조댓글' AFTER `pc_re_date`,
MODIFY COLUMN `pc_re_lev` int(11) NULL DEFAULT NULL COMMENT '댓글단계' AFTER `pc_re_ref`,
MODIFY COLUMN `pc_re_seq` int(11) NULL DEFAULT NULL COMMENT '댓글순서' AFTER `pc_re_lev`,
ADD PRIMARY KEY (`pc_re_no`),
ADD CONSTRAINT `FK_pc_no` FOREIGN KEY (`pc_no`) REFERENCES `amigo`.`partner_community` (`pc_no`);
-- 파트너게시판의 댓글란이고, 댓글번호는 기본키, 글번호는 파트너게시판에서 참조키로 가져온다.



CREATE TABLE `SDB` (
	`no`	NUMERIC	NOT NULL,
	`lat`	NUMERIC	NULL,
	`lng`	NUMERIC	NULL,
	`place`	varchar(1000)	NULL
);
-- number 데이터타입이 지원이 안됨, 그래서 NUMERIC으로 바꿨는데 DECIMAL로 처리가 됨. 참고하세요.(number/numeric/decimal 다 동의어)
ALTER TABLE `amigo`.`sdb` 
MODIFY COLUMN `no` decimal(10, 0) NOT NULL COMMENT '장소번호' FIRST,
MODIFY COLUMN `lat` decimal(10, 0) NULL DEFAULT NULL COMMENT '위도' AFTER `no`,
MODIFY COLUMN `lng` decimal(10, 0) NULL DEFAULT NULL COMMENT '경도' AFTER `lat`,
MODIFY COLUMN `place` varchar(1000) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NULL DEFAULT NULL COMMENT '장소' AFTER `lng`,
ADD PRIMARY KEY (`no`);


-- DECIMAL 자릿수 수정하였음.....
ALTER TABLE `amigo`.`sdb` 
MODIFY COLUMN `no` decimal(20, 10) NOT NULL COMMENT '장소번호' FIRST,
MODIFY COLUMN `lat` decimal(18, 16) NOT NULL COMMENT '위도' AFTER `no`,
MODIFY COLUMN `lng` decimal(18, 16) NOT NULL COMMENT '경도' AFTER `lat`;
-- 여기까지 SDB  공간DB




CREATE TABLE `hospital` (
	`Key`	varchar(500)	NOT NULL,
	`no`	DECIMAL(20, 10)	NOT NULL,
	`hos_tel`	int(11)	NOT NULL,
	`hos_local`	int(11)	NOT NULL,
	`hos_price`	int(11)	NOT NULL,
	`hos_home`	VARCHAR(255)	NULL 
);
ALTER TABLE `amigo`.`hospital` 
ADD CONSTRAINT `FK_no` FOREIGN KEY (`no`) REFERENCES `amigo`.`sdb` (`no`);
ALTER TABLE `amigo`.`hospital` 
MODIFY COLUMN `Key` varchar(500) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL FIRST,
MODIFY COLUMN `hos_home` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NULL DEFAULT NULL AFTER `hos_price`;

ALTER TABLE `amigo`.`hospital` 
MODIFY COLUMN `Key` varchar(500) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL COMMENT '병원이름' FIRST,
MODIFY COLUMN `no` decimal(20, 10) NOT NULL COMMENT '장소번호' AFTER `Key`,
MODIFY COLUMN `hos_tel` int(11) NOT NULL COMMENT '전화번호' AFTER `no`,
MODIFY COLUMN `hos_local` int(11) NOT NULL COMMENT '업체위치정보' AFTER `hos_tel`,
MODIFY COLUMN `hos_price` int(11) NOT NULL COMMENT '가격정보' AFTER `hos_local`,
MODIFY COLUMN `hos_home` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NULL DEFAULT NULL COMMENT '병원홈페이지' AFTER `hos_price`;

ALTER TABLE `amigo`.`hospital` 
ADD PRIMARY KEY (`Key`);

-- number -> decimal 로 바꿈 .
-- int에는 자릿수(11, 디폴트값)을 추가함. 그리고 데이터타입들 int로 바꿈.(소수점 안쓰는 컬럼들만)
-- comment 추가함. 그리고 병원이름에 기본키 추가함.


CREATE TABLE `hos_review` (
	`hos_reviewNo`	int(11)	NOT NULL COMMENT '병원리뷰번호' ,
	`Key`	varchar(500)	NOT NULL COMMENT '병원이름',
	`no`	decimal(20,10)	NOT NULL COMMENT '장소번호',
	`hos_star`	int(11)	NOT NULL COMMENT '별점',
	`hos_content`	varchar(500)	NULL COMMENT '내용',
	`hos_photo`	VARCHAR(255)	NULL COMMENT '사진'
);
-- 원 쿼리에서 데이터타입 변경하고 decimal 자릿수 설정한후에 추가함.
ALTER TABLE `amigo`.`hos_review` 
MODIFY COLUMN `Key` varchar(500) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL COMMENT '병원이름' AFTER `hos_reviewNo`,
MODIFY COLUMN `hos_content` varchar(500) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NULL DEFAULT NULL COMMENT '내용' AFTER `hos_star`,
MODIFY COLUMN `hos_photo` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NULL DEFAULT NULL COMMENT '사진' AFTER `hos_content`,
ADD PRIMARY KEY (`hos_reviewNo`),
ADD CONSTRAINT `FK_Key` FOREIGN KEY (`Key`) REFERENCES `amigo`.`hospital` (`Key`);

ALTER TABLE `amigo`.`hos_review` 
ADD CONSTRAINT `FK_rev_no` FOREIGN KEY (`no`) REFERENCES `amigo`.`sdb` (`no`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--  FK 이름을 바꿔서 하느라 add constraint 를 두개로 나눴음..시행착오;


CREATE TABLE `walk` (
	`walking_no`	varchar(30)	NOT NULL primary key COMMENT '산책로번호',
	`no2`	decimal(20, 10)	NOT NULL COMMENT '장소번호',
	`walking_time`	time	NOT NULL COMMENT '산책시간기록',
	`walk_poop`	tinyint(1)	NOT NULL COMMENT '대변기록',
	`walking_distance`	int(11)	NOT NULL COMMENT '산책거리기록',
	`walking_dog`	varchar(30)	NULL COMMENT '이동중품종',
	`dog_no`	INT(11)	NOT NULL	COMMENT '반려견번호',
	`wt_place`	VARCHAR(255)	NOT NULL COMMENT '산책로위치',
	`wt_enter`	tinyint(1)	NULL COMMENT '산책로출입여부'
);
ALTER TABLE `amigo`.`walk` 
MODIFY COLUMN `walking_no` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL COMMENT '산책로번호' FIRST,
MODIFY COLUMN `walking_dog` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NULL DEFAULT NULL COMMENT '이동중품종' AFTER `walking_distance`,
MODIFY COLUMN `wt_place` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL COMMENT '산책로위치' AFTER `dog_no`,
ADD CONSTRAINT `FK_walk_no` FOREIGN KEY (`no2`) REFERENCES `amigo`.`sdb` (`no`);

ALTER TABLE `amigo`.`walk` 
MODIFY COLUMN `wt_enter` tinyint(1) NOT NULL COMMENT '산책로출입여부' AFTER `wt_place`;

-- walk 테이블 데이터타입 수정
-- boolean -> tinyint  /  number -> decimal(20,10)  / varchar에는 unicode_ci로 변경.
-- tinyint(boolean) 항목은 not null 로 처리.














CREATE TABLE `walkreview` (
	`walk_reviewNo`	int(11)	NOT NULL primary key COMMENT '산책루트리뷰번호',
	`walking_no` varchar(30) not null COMMENT '산책로번호',
	`star`	int(11)	NOT NULL COMMENT '별점',
	`walk_content`	varchar(600)	NULL COMMENT '내용',
	`walk_photo`	VARCHAR(255)	NULL COMMENT '산책로사진'
);
ALTER TABLE `amigo`.`walkreview` 
MODIFY COLUMN `walking_no` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL COMMENT '산책로번호' AFTER `walk_reviewNo`,
MODIFY COLUMN `walk_content` varchar(600) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NULL DEFAULT NULL COMMENT '내용' AFTER `star`,
MODIFY COLUMN `walk_photo` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NULL DEFAULT NULL COMMENT '산책로사진' AFTER `walk_content`,
ADD CONSTRAINT `FK_rvw_walking_no` FOREIGN KEY (`walking_no`) REFERENCES `amigo`.`walk` (`walking_no`);
-- 데이터타입 및 크기 변경 number->int(11)  /  varchar(500) -> varchar(600) 등등.



CREATE TABLE `pet_sit_reservation` (
	`sit_res_no`	INT(11)	NOT NULL primary key COMMENT '펫시터예약번호',
	`sit_dog_no`	int(11)	NOT NULL COMMENT '강아지번호',
	`sit_reg_date`	DATE	NOT NULL COMMENT '예약등록일자',
	`sit_res_date`	DATE	NOT NULL COMMENT '예약진행일자',
	`sit_res_visit`	tinyint(1)	NOT NULL COMMENT '방문여부',
	`sit_pay_cost`	varchar(30)	NOT NULL COMMENT '결제금액',
	`sit_notice_to`	VARCHAR(300)	NULL COMMENT '특이사항',
	`sit_res_time`	date	NOT NULL COMMENT '예약시간'
);
ALTER TABLE `amigo`.`pet_sit_reservation` 
MODIFY COLUMN `sit_pay_cost` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL COMMENT '결제금액' AFTER `sit_res_visit`,
MODIFY COLUMN `sit_notice_to` varchar(300) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NULL DEFAULT NULL COMMENT '특이사항' AFTER `sit_pay_cost`;
-- 물리이름, 데이터타입, 논리이름 수정하고, collate 맞춰줌....



CREATE TABLE `pet_sit_price` (
	`sit_res_no`	INT(11)	NOT NULL COMMENT '훈련예약번호',
	`sit_service`	VARCHAR(20)	NOT NULL COMMENT '서비스종류',
	`sit_price`	INT(11)	NOT NULL COMMENT '가격',
	`sit_time`	INT(11)	NOT NULL COMMENT '시간'
);
ALTER TABLE `amigo`.`pet_sit_price` 
MODIFY COLUMN `sit_service` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL COMMENT '서비스종류' AFTER `sit_res_no`,
ADD CONSTRAINT `FK_sit_res_no` FOREIGN KEY (`sit_res_no`) REFERENCES `amigo`.`pet_sit_reservation` (`sit_res_no`);
-- 펫시터비용........물리타입 네임 수정 등등..







CREATE TABLE `training_resevation` (
	`tr_res_no`	INT(11)	NOT NULL primary key	COMMENT '훈련예약번호',
	`tr_member_no`	VARCHAR(30)	NOT NULL	COMMENT '고객번호',
	`tr_member_name`	varchar(30)	NULL	COMMENT '고객닉네임',
	`tr_dog_no`	INT(11)	NOT NULL	COMMENT '강아지번호',
	`tr_res_date`	DATE	NOT NULL	COMMENT '예약등록일자',
	`tr_reg_date`	DATE	NOT NULL	COMMENT '예약진행일자',
	`tr_no`	VARCHAR(30)	NOT NULL	COMMENT '훈련사번호',
	`tr_name`	VARCHAR(30)	NULL	COMMENT '훈련사네임',
	`tr_res_visit`	tinyint(1)	NOT NULL	COMMENT '방문여부',
	`tr_pay_cost`	VARCHAR(30)	NOT NULL COMMENT '결제금액',
	`tr_notice_to`	VARCHAR(300)	NULL COMMENT '특이사항',
	`tr_res_time`	VARCHAR(30)	NOT NULL COMMENT '예약시간'
);
ALTER TABLE `amigo`.`training_resevation` 
MODIFY COLUMN `tr_member_no` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL COMMENT '고객번호' AFTER `tr_res_no`,
MODIFY COLUMN `tr_member_name` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NULL DEFAULT NULL COMMENT '고객닉네임' AFTER `tr_member_no`,
MODIFY COLUMN `tr_no` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL COMMENT '훈련사번호' AFTER `tr_reg_date`,
MODIFY COLUMN `tr_name` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NULL DEFAULT NULL COMMENT '훈련사네임' AFTER `tr_no`,
MODIFY COLUMN `tr_pay_cost` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL COMMENT '결제금액' AFTER `tr_res_visit`,
MODIFY COLUMN `tr_notice_to` varchar(300) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NULL DEFAULT NULL COMMENT '특이사항' AFTER `tr_pay_cost`,
MODIFY COLUMN `tr_res_time` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL COMMENT '예약시간' AFTER `tr_notice_to`;

-- 데이터타입 다시 맞추고 collation 등등 다시 맞추었습니다.




CREATE TABLE `training_price` (
	`tr_res_no`	INT(11)	NOT NULL	COMMENT '훈련예약번호',
	`tr_service`	VARCHAR(20)	NOT NULL COMMENT '서비스종류',
	`tr_price`	INT(11)	NOT NULL COMMENT '가격',
	`tr_time`	INT(11)	NOT NULL COMMENT '시간'
);
ALTER TABLE `amigo`.`training_price` 
MODIFY COLUMN `tr_service` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL COMMENT '서비스종류' AFTER `tr_res_no`,
ADD CONSTRAINT `FK_tr_res_no` FOREIGN KEY (`tr_res_no`) REFERENCES `amigo`.`training_resevation` (`tr_res_no`);
-- 위에꺼랑 동일하게.





--    2023   /    01    /     06       여기까지.
-- 아래 쿼리문은 보류;
























/*CREATE TABLE `walking _trails` (
	`wt_no`	number	NOT NULL,
	`wt_place`	varchar(1000)	NOT NULL,
	`wt_enter`	boolean	NULL,
	`walking_name`	varchar(30)	NOT NULL,
	`dog_no`	INT	NOT NULL	COMMENT '반려견번호',
	`member_no2`	VARCHAR(30)	NOT NULL,
	`member_nick2`	VARCHAR(30)	NOT NULL,
	`no22`	number	NOT NULL
);*/

CREATE TABLE `bookmark` (
	`Key`	VARCHAR(255)	NOT NULL,
	`bookmark_pet`	VARCHAR(20)	NULL,
	`bookmark_tr`	VARCHAR(20)	NULL
);

CREATE TABLE `training_resevation` (
	`training_res_no`	INT	NOT NULL	COMMENT '예약번호',
	`member_no`	VARCHAR(30)	NOT NULL	COMMENT '고객번호',
	`member_name`	varchar(30)	NULL	COMMENT '고객닉네임',
	`dog_no`	INT	NOT NULL	COMMENT '강아지번호',
	`res_date`	DATE	NOT NULL	COMMENT '예약일자',
	`reg_date`	DATE	NOT NULL	COMMENT '예약등록일자',
	`trainer_no`	VARCHAR(30)	NOT NULL	COMMENT '훈련사번호',
	`trainer_name`	VARCHAR(30)	NULL	COMMENT '훈련사닉네임',
	`t_res_visit`	BOOLEAN	NOT NULL	COMMENT '예약여부' ) COMMENT 'training_resevation'; ALTER TABLE `MY_SCHEMA`.`training_resevation` ADD CONSTRAINT `PK_training_resevation` PRIMARY KEY ( `training_res_no',
	`Field`	VARCHAR(30)	NOT NULL,
	`Field2`	VARCHAR(300)	NULL,
	`Field3`	VARCHAR(30)	NOT NULL,
	`member_no2`	VARCHAR(30)	NOT NULL,
	`member_nick`	VARCHAR(30)	NOT NULL
);

CREATE TABLE `bt_review` (
	`bt_reviewNo`	number	NOT NULL,
	`star`	number	NOT NULL,
	`bt_content`	varcher(500)	NULL,
	`bt_photo`	VARCHAR(255)	NULL
);

CREATE TABLE `price` (
	`Key`	INT	NOT NULL,
	`s_service`	VARCHAR(20)	NOT NULL,
	`s_price`	INT	NOT NULL,
	`Field`	INT	NOT NULL
);

CREATE TABLE `cost_result` (
	`training_res_no`	INT	NOT NULL	COMMENT '예약번호',
	`s_service`	VARCHAR(20)	NOT NULL,
	`s_price`	INT	NOT NULL,
	`Field`	INT	NOT NULL
);

