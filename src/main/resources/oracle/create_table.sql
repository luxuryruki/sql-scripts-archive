
-- 메뉴 생성 (트리구조)
CREATE TABLE MENU (
                      MENU_ID NUMBER,                           -- 메뉴 아이디
                      SITE_NAME VARCHAR2(20 CHAR),              -- 메뉴 사이트
                      PARENT_MENU_ID NUMBER,                    -- 상위 메뉴 아이디
                      MENU_NAME VARCHAR2(100 CHAR),             -- 메뉴명
                      URL_TYPE VARCHAR2(15 CHAR),               -- 메뉴 URL 유형
                      MENU_URL VARCHAR2(100 CHAR),              -- 메뉴 URL
                      ACCESS_AUTH VARCHAR2(100 CHAR),           -- 접근 권한
                      NEW_WINDOW_YN CHAR(1),                    -- 새창 사용 여부
                      DISPLAY_YN CHAR(1),                       -- 전시 여부
                      MENU_ORDER NUMBER,                        -- 정렬 순서
                      CREATED_AT DATE,                          -- 최초 등록일시
                      CREATED_BY VARCHAR2(15 CHAR),             -- 최초 등록자
                      UPDATED_AT DATE,                          -- 최종 수정일시
                      UPDATED_BY VARCHAR2(15 CHAR),             -- 최종 수정자
                      PRIMARY KEY (MENU_ID) -- 제약조건에 명시적인 이름 없이 간단하게 기본키 정의
);

--MENU 외래키 제약조건 추가
ALTER TABLE MENU -- 테이블 수정
    ADD CONSTRAINT FK_MENU_PARENT_MENU_ID -- 제약조건 추가
        FOREIGN KEY (PARENT_MENU_ID) -- 외래 키 설정
            REFERENCES MENU(MENU_ID) -- 참조 테이블 및 컬럼
            ON DELETE CASCADE; -- 상위메뉴 삭제시 자식 메뉴도 자동 삭제
-- MENU 코멘트 설정
COMMENT ON COLUMN MENU.MENU_ID IS '메뉴 아이디';
COMMENT ON COLUMN MENU.SITE_NAME IS '메뉴 사이트';
COMMENT ON COLUMN MENU.PARENT_MENU_ID IS '상위 메뉴 아이디';
COMMENT ON COLUMN MENU.MENU_NAME IS '메뉴명';
COMMENT ON COLUMN MENU.URL_TYPE IS '메뉴 URL 유형';
COMMENT ON COLUMN MENU.MENU_URL IS '메뉴 URL';
COMMENT ON COLUMN MENU.ACCESS_AUTH IS '접근 권한';
COMMENT ON COLUMN MENU.NEW_WINDOW_YN IS '새창 사용 여부';
COMMENT ON COLUMN MENU.DISPLAY_YN IS '전시 여부';
COMMENT ON COLUMN MENU.MENU_ORDER IS '정렬 순서';
COMMENT ON COLUMN MENU.CREATED_AT IS '최초 등록일시';
COMMENT ON COLUMN MENU.CREATED_BY IS '최초 등록자';
COMMENT ON COLUMN MENU.UPDATED_AT IS '최종 수정일시';
COMMENT ON COLUMN MENU.UPDATED_BY IS '최종 수정자';

    
    
-- 메뉴 히스토리
CREATE TABLE MENU_HISTORY (
                              MENU_HISTORY_ID NUMBER,                  -- 메뉴 기록 아이디
                              MENU_ID NUMBER,                          -- 메뉴 아이디
                              REMARKS VARCHAR2(255),                   -- 비고
                              CREATED_AT DATE,                         -- 최초 등록일시
                              CREATED_BY VARCHAR2(15 CHAR),            -- 최초 등록자
                              UPDATED_AT DATE,                         -- 최종 수정일시
                              UPDATED_BY VARCHAR2(15 CHAR),            -- 최종 수정자
                              CONSTRAINT PK_MENU_HISTORY PRIMARY KEY (MENU_HISTORY_ID) -- 제약조건에 명시적인 이름 추가 (제약조건 관리에 유리)
);

ALTER TABLE MENU_HISTORY --테이블 수정
    ADD CONSTRAINT FK_MENU_HISTORY_MENU_ID -- 제약조건 추가
        FOREIGN KEY (MENU_ID) -- 외래 키 설정
            REFERENCES MENU(MENU_ID) -- 참조 테이블 및 컬럼
            ON DELETE CASCADE; -- 참조 MENU 삭제 시 해당 MENU를 참조하는 MENU_HISTORY도 자동 삭제

COMMENT ON COLUMN MENU_HISTORY.MENU_HISTORY_ID IS '메뉴 기록 아이디';
COMMENT ON COLUMN MENU_HISTORY.MENU_ID IS '메뉴 아이디';
COMMENT ON COLUMN MENU_HISTORY.REMARKS IS '비고';
COMMENT ON COLUMN MENU_HISTORY.CREATED_AT IS '최초 등록일시';
COMMENT ON COLUMN MENU_HISTORY.CREATED_BY IS '최초 등록자';
COMMENT ON COLUMN MENU_HISTORY.UPDATED_AT IS '최종 수정일시';
COMMENT ON COLUMN MENU_HISTORY.UPDATED_BY IS '최종 수정자';
