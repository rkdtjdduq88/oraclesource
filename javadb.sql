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

-- [실습] eclipse shop 프로젝트를 db에서 구현
-- 모든 컬럼 not null

-- paytype : pay_no(숫자-1 pk), info(문자-card, cash)
-- paytype_seq 생성
CREATE TABLE paytype(
        pay_no number(1) PRIMARY KEY,
        info varchar2(10) not null
        );
CREATE SEQUENCE paytype_seq;

INSERT INTO paytype values(paytype_seq.nextval, 'card');
INSERT INTO paytype values(paytype_seq.nextval, 'cash');

SELECT * FROM paytype; -- 1 : card, 2 : cash 
-- user : user_id(숫자-4 pk), name(문자-한글), pay_no(숫자-1 : paytype 테이블에 있는 pay_no 참조해서 사용)
CREATE TABLE suser(
        user_id number(4) PRIMARY key,
        name varchar2(20) not null,
        pay_no number(1) not null references paytype(pay_no)
        );

-- product
-- product_id(숫자-8 pk), pname(문자), price(숫자), content(문자)
CREATE TABLE product(
        product_id number(8) PRIMARY KEY,
        pname varchar2(30) not null,
        price number(8) not null,
        content varchar2(50) not null
        );
        

CREATE SEQUENCE product_seq;
-- sorder
-- order_id(숫자-8 pk), user_id(user 테이블의 user_id 참조), product_id(product 테이블의 product_id 참조)
-- order_seq
CREATE table sorder(
        order_id number(8) PRIMARY KEY,
        user_id number(4) not null references suser(user_id),
        product_id number(8) not null references product(product_id)
        );
        
ALTER TABLE sorder ADD order_date DATE; -- 구매날짜 추가
CREATE SEQUENCE order_seq;

-- user_id, name, pay_no, info 조회
-- suser와 paytype join
SELECT u.user_id, u.name, p.pay_no, p.info
FROM suser u, paytype p
WHERE u.pay_no = p.pay_no AND u.user_id = 1000;

-- 주문정보 전체 조회
SELECT * FROM sorder;

-- 주문목록 조회
-- user_id, name, card/cash, product_id, pname, price, content

-- 기준 : sorder
-- suser 테이블 : name,
-- paytype 테이블 : card/cash
-- product 테이블 : product_id, pname, price, content

-- 전체 주문목록
SELECT u.user_id, u.name, t.info, p.product_id, p.pname, p.price, p.content, o.order_date
FROM suser u, paytype t, sorder o, product p
WHERE u.user_id = o.user_id and u.pay_no = t.pay_no and p.product_id = o.product_id
ORDER BY p.price desc;

-- 홍길동 주문목록 조회
SELECT u.user_id, u.name, t.info, p.product_id, p.pname, p.price, p.content, o.order_date
FROM suser u, paytype t, sorder o, product p
WHERE u.user_id = o.user_id and u.pay_no = t.pay_no and p.product_id = o.product_id and u.user_id = 1000;

commit;