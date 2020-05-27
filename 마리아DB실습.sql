/*
블력단위 주석
*/
# 라인 단위 주석1
-- 라인 단위 주석2
SELECT *
FROM ts_test;
#모델1방식(JSP) + MariaDB를 이용한 게시판
CREATE TABLE member
(
 id VARCHAR(30) NOT NULL,
 pass VARCHAR(30) NOT NULL,
 name VARCHAR(30) NOT NULL,
 /* 현재시간을 디폴트로 사용 datatime : 날짜와 시간을 동시에 표현할 수 있는 자료형 */
 regidate DATETIME DEFAULT CURRENT_TIMESTAMP, PRIMARY KEY (id)
);
# 게시판 테이블(자식)
/*
AUTO_INCREMENT : 오라클의 시퀀스를 대체할 수 있는 속성으로 지정된 컬럼은 자동으로 값이 증가하게 된다.
	단 자동증가로 지정된 컬럼은 데이터를 임의로 삽입할 수 없게 된다.
*/
CREATE TABLE board
(
 num INT NOT NULL AUTO_INCREMENT,
 title VARCHAR(100) NOT NULL,
 content TEXT NOT NULL,
 postdate DATETIME DEFAULT CURRENT_TIMESTAMP,
 id VARCHAR(30) NOT NULL,
 visitcount MEDIUMINT NOT NULL DEFAULT 0, PRIMARY KEY (num) 
);
# 회원테이블과 게시판테이블의 참조 제약 조건
ALTER TABLE board ADD CONSTRAINT fk_board_member FOREIGN KEY (id) REFERENCES member (id);
# 더미데이터 삽입
INSERT INTO member (id, pass, name) VALUES ('kosmo', 1234, 'junseung');
# member테이블과 외래키 제약조건이 있으므로 board테이블에 먼저 삽입할 경우 에러가 발생한다.
INSERT INTO board (title, content, id) VALUES ('제목입니다.1', '내용입니다.1', 'kosmo');
INSERT INTO board (title, content, id) VALUES ('제목입니다.2', '내용입니다.2', 'kosmo');
INSERT INTO board (title, content, id) VALUES ('제목입니다.3', '내용입니다.3', 'kosmo');
INSERT INTO board (title, content, id) VALUES ('제목입니다.4', '내용입니다.4', 'kosmo');
INSERT INTO board (title, content, id) VALUES ('제목입니다.5', '내용입니다.5', 'kosmo');
INSERT INTO board (title, content, id) VALUES ('제목입니다.6', '내용입니다.6', 'kosmo');

# 데이터타입의 종류
# 숫자형
CREATE TABLE tb_int (
	idx INT PRIMARY KEY AUTO_INCREMENT,
	num1 TINYINT UNSIGNED NOT NULL,
	num2 SMALLINT NOT NULL,
	num3 MEDIUMINT DEFAULT '100',
	num4 BIGINT,
	fnum1 FLOAT(10, 5) NOT NULL,
	fnum2 DOUBLE(20, 10)
);
/*
자동증가 컬럼에 임의의 값을 삽입할 수 있으나 사용하지 않는 것이 좋다.
*/
INSERT INTO tb_int (num1,num2,num3,num4,fnum1,fnum2) VALUES(100,12345,1234567,1234567890,
 12345.12345, 1234567890.1234567891);
# 빈값은 삽입할 수 없다. 오류 발생됨
INSERT INTO tb_int (idx, num1,num2,num3,num4,fnum1,fnum2) VALUES('', 100,12345,1234567,1234567890,
 12345.12345, 1234567890.1234567891);
SELECT *
FROM tb_int;

# 날짜형
CREATE TABLE tb_date (
	idx INT PRIMARY KEY AUTO_INCREMENT,
	DATE1 DATE NOT NULL,
	DATE2 DATETIME DEFAULT CURRENT_TIMESTAMP
);
/*
날짜타입의 컬럼에 현재 날짜를 입력할 때 오라클은 sysdate를 사용하지만 MySQL은 now()함수를 사용한다.
*/
INSERT INTO tb_date(DATE1, DATE2) VALUES ('2020-05-27', NOW());
SELECT *
FROM tb_date;
/*
시간변환 함수 date_format(컬럼명, '서식')
*/
SELECT DATE_FORMAT(DATE2, '%Y-%m-%d')
FROM tb_date;
SELECT DATE_FORMAT(DATE2, '%H:%i:%s')
FROM tb_date;

# 특수형
CREATE TABLE tb_spec(
 idx INT AUTO_INCREMENT,
 spec1 ENUM('M','w','T'), # radio느낌
 spec2
SET('A','B','C','D'), # checkbox느낌
PRIMARY KEY(idx)
);
INSERT INTO tb_spec (spec1, spec2) VALUES('W', 'A,B,C');
# spec1는 디폴트가 설정되었으므로 자동입력
INSERT INTO tb_spec (spec2) VALUES('A,B,C');
# 설정되지 않은 값으로 입력시 오류발생
INSERT INTO tb_spec (spec1, spec2) VALUES('A', 'A,B,E');
SELECT *
FROM tb_spec;

/*
Model1 방식의 게시판을 MariaDB로 컨버팅
*/
# 전체 레코드 수 조회
SELECT COUNT(*)
FROM board;
SELECT COUNT(*)
FROM board
WHERE title LIKE '%1%';

-- 페이지 처리를 위한 쿼리문 (오라클과 다름)
SELECT *
FROM board
ORDER BY num DESC;
/*
한페이지에 2개의 게시물이 출력된다고 가정했을 때 1페이지 레코드셋

페이지처리를 위해 게시물의 범위를 정할 때 Oracle은 rownum의 속성을 사용하지만 MariaDB는 limit을 사용한다.
	방법 : limit 시작인덱스, 가져올 레코드 수
*/
# 1페이지 레코드 셋
SELECT *
FROM board
ORDER BY num DESC
LIMIT 0, 2;
# 2페이지 레코드 셋
SELECT *
FROM board
ORDER BY num DESC
LIMIT 2, 2;
# 3페이지 레코드 셋
SELECT *
FROM board
ORDER BY num DESC
LIMIT 4, 2;

-- 상세보기 처리 - 조회수 update
UPDATE board SET visitcount = visitcount + 1
WHERE num = 2;
SELECT *
FROM board
ORDER BY num DESC;

-- 회원테이블과 게시판 테이블 내부 조인을 통한 조회
# 표준SQL 방식
SELECT B.*, M.name
FROM member M
INNER JOIN board B ON M.id = B.id
WHERE num = 2;
# 간단방식
SELECT B.*, M.name
FROM member M, board B
WHERE M.id = B.id AND num = 2;

-- 게시물 수정하기
UPDATE board SET title = '수장해볼까요', content = '미안하다 사랑하다 임수정 '
WHERE num = 2;

-- 게시물 삭제하기
DELETE FROM board WHERE num=2;
SELECT * FROM board;

/*
기존의 게시판을 멀티게시판으로 변경
	자유게시판 : freeboard
	공지사항 : notice
	질문과 답변 : qna
	FAQ : faq
하나의 테이블로 여러개의 게시판을 제작하는 경우 게시판의 구분을 위해 flag(플래그)가 필요하다.
*/
-- 공지사항 게시판에 글쓰기
INSERT INTO board (title, content, id, bname) VALUE ('여긴 공지사항', '내용없음', 'kosmo', 'notice');

-- 자유게시판 리스트 보기
SELECT * FROM board WHERE bname = 'freeboard';

-- 공지사항 리스트 보기
SELECT * FROM board WHERE bname = 'notice';









