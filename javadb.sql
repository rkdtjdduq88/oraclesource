-- javadb

-- userTBL 테이블 생성
-- no(번호-숫자(4)), username(이름 - 한글(4)), birthYear(년도-숫자(4)), addr(주소-문자(한글,숫자), mobile(010-1234-1234)
-- no pk 제약조건 지정(제약조건명 pk_userTBL)
CREATE TABLE userTBL(
        no number(4) CONSTRAINT pk_userTBL PRIMARY KEY,
        username nvarchar2(10) NOT NULL,
        birthYear number(4)NOT NULL,
        addr nvarchar2(50)NOT NULL,
        mobile nvarchar2(20)
        );
        
drop table userTBL;
-- 시퀀스 생성
-- user_seq 생성(기본)
CREATE SEQUENCE user_seq;


-- insert
-- no : user_seq 값 넣기
INSERT INTO userTBL(no, username, birthYear, addr, mobile) 
VALUES(user_seq.nextval,'홍길동','2010','서울시 종로구 123','010-1234-5678');

commit;






