-- 1. 기존 BOOKS 테이블이 없는 경우 테이블 생성
BEGIN
    EXECUTE IMMEDIATE 'CREATE TABLE BOOKS (
        ID NUMBER PRIMARY KEY,
        TITLE VARCHAR2(255) NOT NULL,
        AUTHOR VARCHAR2(255),
        PRICE NUMBER,
        DESCRIPTION CLOB,
        COVER_URL VARCHAR2(255)
    )';
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE = -955 THEN
            NULL; -- 테이블이 이미 존재하는 경우 무시
        ELSE
            RAISE;
        END IF;
END;
/

-- 2. 샘플 데이터 입력 (테이블이 비어있는 경우)
DECLARE
    v_count NUMBER;
BEGIN
    SELECT COUNT(*) INTO v_count FROM BOOKS;
    
    IF v_count = 0 THEN
        -- 미스터리 책 추가 (ID: 1-5)
        INSERT INTO BOOKS (ID, TITLE, AUTHOR, PRICE, DESCRIPTION, COVER_URL) 
        VALUES (1, '가공범', '정세랑', 15000, '흥미로운 미스터리 소설입니다.', '/images/books/book1.jpg');
        
        INSERT INTO BOOKS (ID, TITLE, AUTHOR, PRICE, DESCRIPTION, COVER_URL) 
        VALUES (2, '고독한 옵저버', '이정명', 14000, '긴장감 넘치는 스릴러입니다.', '/images/books/book2.jpg');
        
        INSERT INTO BOOKS (ID, TITLE, AUTHOR, PRICE, DESCRIPTION, COVER_URL) 
        VALUES (3, '하우스메이드', '김주연', 13500, '가정부의 시선으로 본 미스터리.', '/images/books/book3.jpg');
        
        INSERT INTO BOOKS (ID, TITLE, AUTHOR, PRICE, DESCRIPTION, COVER_URL) 
        VALUES (4, '매듭의 끝', '백선희', 12900, '복잡한 인간관계의 미스터리.', '/images/books/book4.jpg');
        
        INSERT INTO BOOKS (ID, TITLE, AUTHOR, PRICE, DESCRIPTION, COVER_URL) 
        VALUES (5, '지리 글리코', '히가시노 게이고', 16000, '일본의 인기 미스터리 소설.', '/images/books/book5.jpg');
        
        -- 베스트셀러 책 추가 (ID: 6-10)
        INSERT INTO BOOKS (ID, TITLE, AUTHOR, PRICE, DESCRIPTION, COVER_URL) 
        VALUES (6, '고백', '히가시노 게이고', 14500, '학교를 배경으로 한 충격적인 이야기.', '/images/books/book6.jpg');
        
        INSERT INTO BOOKS (ID, TITLE, AUTHOR, PRICE, DESCRIPTION, COVER_URL) 
        VALUES (7, '네버 라이', 'J.T. 엘리슨', 15000, '한 여성의 거짓말이 만들어낸 파국.', '/images/books/book7.jpg');
        
        INSERT INTO BOOKS (ID, TITLE, AUTHOR, PRICE, DESCRIPTION, COVER_URL) 
        VALUES (8, '당신이 누군가를 죽였다', '손원평', 14000, '소름 돋는 심리 스릴러.', '/images/books/book8.jpg');
        
        INSERT INTO BOOKS (ID, TITLE, AUTHOR, PRICE, DESCRIPTION, COVER_URL) 
        VALUES (9, '죽은 자에게', '히가시노 게이고', 15500, '사랑과 증오의 경계를 다룬 명작.', '/images/books/book9.jpg');
        
        INSERT INTO BOOKS (ID, TITLE, AUTHOR, PRICE, DESCRIPTION, COVER_URL) 
        VALUES (10, '밤에 찾아온 개', '도나 타트', 17000, '세계적인 베스트셀러 소설.', '/images/books/book10.jpg');
        
        COMMIT;
        DBMS_OUTPUT.PUT_LINE('샘플 데이터가 성공적으로 추가되었습니다.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('테이블에 이미 데이터가 있어 샘플 데이터를 추가하지 않았습니다.');
    END IF;
END;
/

-- 3. 커버 이미지 URL 경로 확인 및 수정
UPDATE BOOKS
SET COVER_URL = '/images/default_cover.jpg'
WHERE COVER_URL IS NULL OR COVER_URL = '';

COMMIT;
DBMS_OUTPUT.PUT_LINE('데이터베이스 업데이트가 완료되었습니다.'); 