CREATE TABLE CUSTOMER_TBL
(
    CT_ID       CHAR(5)                         PRIMARY KEY, -- CUSTOMER의 ID
    CT_NAME     VARCHAR2(30)                    NOT NULL,    -- CUSTOMER의 이름
    CT_BIRTH    VARCHAR2(24)                    NOT NULL,    -- CUSTOMER의 생년월일
    CT_REGION   CHAR(6)                         NOT NULL,    -- CUSTOMER의 국가
    CT_GENDER   CHAR(1)                         NOT NULL,    -- CUSTOMER의 성별
    CT_C_NUM    VARCHAR2(33)                    NOT NULL,    -- CUSTOMER의 전화번호
    CT_POINT    NUMBER(10)      DEFAULT 0       NULL,        -- CUSTOMER의 포인트
    CT_GRADE    VARCHAR2(30)                    NULL,        -- CUSTOMER의 등급
    CT_SHOW     CHAR(1)         DEFAULT 'Y'     NOT NULL     -- CUSTOMER의 삭제여부
);

CREATE TABLE APPLY_TBL
(
    A_ID        CHAR(4)                    NOT NULL,   -- 신청 ID
    A_INDEX     NUMBER(7)                  NOT NULL,   -- 신청 인덱스
    G_R_ID      CHAR(5)                    NOT NULL,   -- 예약게임 ID
    CT_ID        CHAR(5)                   NOT NULL,   -- 고객 ID
    S_DATE      DATE                       NOT NULL,   -- 신청 날짜
    PY_ID       CHAR(5)                    NOT NULL,   -- 게임의 결제방식 ID
    A_SHOW      CHAR(1)    DEFAULT 'Y'     NOT NULL    -- 신청테이블의삭제여부
);