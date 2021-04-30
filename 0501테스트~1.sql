create or replace NONEDITIONABLE PACKAGE PKG_CUSTOMER_TBL AS 
/* 고객(CUSTOMER_TBL)테이블 프로시저 시작 */

  --고객테이블 SELECT 프로시저 시작
  PROCEDURE PROC_SELECT_CUSTOMER_TBL
  (
    IN_CT_ID        IN       VARCHAR2,
    IN_CT_NAME      IN       VARCHAR2,
    IN_CT_BIRTH     IN       VARCHAR2,
    IN_CT_REGION    IN       VARCHAR2,
    IN_CT_GENDER    IN       VARCHAR2,
    IN_CT_C_NUM     IN       VARCHAR2,
    IN_CT_POINT     IN       NUMBER,
    IN_CT_GRADE     IN       VARCHAR2,
    IN_CT_SHOW      IN       VARCHAR2,
    O_CUR           OUT      SYS_REFCURSOR
  );
  --고객테이블 SELECT 프로시저 끝


  --고객테이블 INSERT 프로시저 시작
  PROCEDURE PROC_INSERT_CUSTOMER_TBL
  (
    IN_CT_NAME      IN      VARCHAR2,
    IN_CT_BIRTH     IN      VARCHAR2,
    IN_CT_REGION    IN      VARCHAR2,
    IN_CT_GENDER    IN      VARCHAR2,
    IN_CT_C_NUM     IN      VARCHAR2
  );
  --고객테이블 INSERT 프로시저 끝

  --고객테이블 UPDATE 프로시저 시작
  PROCEDURE PROC_UPDATE_CUSTOMER_TBL
  (
    IN_CT_ID        IN       VARCHAR2,
    IN_CT_NAME      IN       VARCHAR2,
    IN_CT_BIRTH     IN       VARCHAR2,
    IN_CT_REGION    IN       VARCHAR2,
    IN_CT_GENDER    IN       VARCHAR2,
    IN_CT_C_NUM     IN       VARCHAR2,
    IN_CT_POINT     IN       NUMBER,
    IN_CT_GRADE     IN       VARCHAR2
  );
  --고객테이블 UPDATE 프로시저 끝

   --고객테이블 DELETE 프로시저 시작
  PROCEDURE PROC_DELETE_CUSTOMER_TBL
  (
    IN_CT_ID        IN       VARCHAR2
  );
  --고객테이블 DELETE 프로시저 끝

/* 고객(CUSTOMER_TBL)테이블 프로시저 시작 */

END PKG_CUSTOMER_TBL;

--------------------------------------고객 패키지 헤드

create or replace NONEDITIONABLE PACKAGE BODY PKG_CUSTOMER_TBL AS
/* 고객(CUSTOMER_TBL)테이블 프로시저 시작 */
  
  --고객테이블 SELECT 프로시저 시작
   PROCEDURE PROC_SELECT_CUSTOMER_TBL
  (
    IN_CT_ID        IN       VARCHAR2,
    IN_CT_NAME      IN       VARCHAR2,
    IN_CT_BIRTH     IN       VARCHAR2,
    IN_CT_REGION    IN       VARCHAR2,
    IN_CT_GENDER    IN       VARCHAR2,
    IN_CT_C_NUM     IN       VARCHAR2,
    IN_CT_POINT     IN       NUMBER,
    IN_CT_GRADE     IN       VARCHAR2,
    IN_CT_SHOW      IN       VARCHAR2,
    O_CUR           OUT      SYS_REFCURSOR
  )
  AS
  BEGIN
    
    --고객테이블 전체 SELECT
    OPEN O_CUR FOR
    SELECT *
    FROM CUSTOMER_TBL
    --고객의 조건을 선별해서 검색하기위 한 조건
    WHERE CT_ID         LIKE '%' || IN_CT_ID || '%'
    AND   CT_NAME       LIKE '%' || IN_CT_NAME || '%'
    AND   CT_BIRTH      LIKE '%' || IN_CT_BIRTH || '%'
    AND   CT_REGION     LIKE '%' || IN_CT_REGION || '%'
    AND   CT_GENDER     LIKE '%' || IN_CT_GENDER || '%'
    AND   CT_C_NUM      LIKE '%' || IN_CT_C_NUM || '%'
    AND   CT_POINT      LIKE '%' || IN_CT_POINT || '%'
    AND   CT_GRADE      LIKE '%' || IN_CT_GRADE || '%'
    AND   CT_SHOW       = CASE WHEN IN_CT_SHOW = 'N' THEN 'N' -- 숨긴데이터를 보고싶을 경우 N으로 작동
                        ELSE 'Y'
                        END
    ;
    
  END PROC_SELECT_CUSTOMER_TBL
  ;
  --고객테이블 SELECT 프로시저 끝
  
  --고객테이블 INSERT 프로시저 시작
  PROCEDURE PROC_INSERT_CUSTOMER_TBL
  (
    IN_CT_NAME      IN      VARCHAR2,
    IN_CT_BIRTH     IN      VARCHAR2,
    IN_CT_REGION    IN      VARCHAR2,
    IN_CT_GENDER    IN      VARCHAR2,
    IN_CT_C_NUM     IN      VARCHAR2
  ) AS
  
  V_NEW_CT_ID       CHAR(5); -- ID 생성변수
  
  BEGIN
    
    --회원가입으로 생각 모든 등급 및 포인트는 NULL
    
    /* ID 생성 */
    SELECT 'CT' || TO_CHAR(TO_NUMBER(SUBSTR(NVL(MAX(CT_ID),'CT000'),3)) +1, 'FM000')
    INTO V_NEW_CT_ID
    FROM CUSTOMER_TBL
    ;
    
    /* POINT  */
    
    /* ROW 생성 */
    INSERT INTO CUSTOMER_TBL(CT_ID, CT_NAME, CT_BIRTH, CT_REGION, CT_GENDER, CT_C_NUM, CT_POINT, CT_GRADE, CT_SHOW)
    VALUES (V_NEW_CT_ID, IN_CT_NAME, IN_CT_BIRTH, IN_CT_REGION, IN_CT_GENDER, IN_CT_C_NUM, 0, '일반회원', 'Y')
    ;
    
  END PROC_INSERT_CUSTOMER_TBL
  ;
  --고객테이블 INSERT 프로시저 끝 

  
  --고객테이블 UPDATE 프로시저 시작
  PROCEDURE PROC_UPDATE_CUSTOMER_TBL
  (
    IN_CT_ID        IN       VARCHAR2,
    IN_CT_NAME      IN       VARCHAR2,
    IN_CT_BIRTH     IN       VARCHAR2,
    IN_CT_REGION    IN       VARCHAR2,
    IN_CT_GENDER    IN       VARCHAR2,
    IN_CT_C_NUM     IN       VARCHAR2,
    IN_CT_POINT     IN       NUMBER,
    IN_CT_GRADE     IN       VARCHAR2
  )
  AS
  
    V_CT_NAME       VARCHAR2(30);
    V_CT_BIRTH      VARCHAR2(30);
    V_CT_REGION     CHAR(6);
    V_CT_GENDER     CHAR(1);
    V_CT_C_NUM      VARCHAR2(33);
    V_CT_POINT      NUMBER(10);
    V_CT_GRADE      VARCHAR2(30);
    
  BEGIN
    
    --IN_CT 매개변수들이 NULL일 경우 원래값을 넣는다
    
    SELECT CASE
           WHEN IN_CT_NAME IS NULL THEN CT_NAME
           ELSE IN_CT_NAME
           END
    INTO V_CT_NAME
    FROM CUSTOMER_TBL
    WHERE CT_ID = IN_CT_ID
    ;
    
    SELECT CASE
           WHEN IN_CT_BIRTH IS NULL THEN CT_BIRTH
           ELSE IN_CT_BIRTH
           END
    INTO V_CT_BIRTH
    FROM CUSTOMER_TBL
    WHERE CT_ID = IN_CT_ID
    ;
    
    SELECT CASE
           WHEN IN_CT_REGION IS NULL THEN CT_REGION
           ELSE IN_CT_REGION
           END
    INTO V_CT_REGION
    FROM CUSTOMER_TBL
    WHERE CT_ID = IN_CT_ID
    ;
    
    SELECT CASE
           WHEN IN_CT_GENDER IS NULL THEN CT_GENDER
           ELSE IN_CT_GENDER
           END
    INTO V_CT_GENDER
    FROM CUSTOMER_TBL
    WHERE CT_ID = IN_CT_ID
    ;
    
    SELECT CASE
           WHEN IN_CT_C_NUM IS NULL THEN CT_C_NUM
           ELSE IN_CT_C_NUM
           END
    INTO V_CT_C_NUM
    FROM CUSTOMER_TBL
    WHERE CT_ID = IN_CT_ID
    ;
    
    SELECT CASE
          WHEN IN_CT_POINT IS NULL THEN CT_POINT
          ELSE IN_CT_POINT
          END
    INTO V_CT_POINT
    FROM CUSTOMER_TBL
    WHERE CT_ID = IN_CT_ID
    ;
    
    SELECT CASE
           WHEN IN_CT_GRADE IS NULL THEN CT_GRADE
           ELSE IN_CT_GRADE
           END
    INTO V_CT_GRADE
    FROM CUSTOMER_TBL
    WHERE CT_ID = IN_CT_ID
    ;
    ------------------
    
    --고객테이블 UPDATE
    UPDATE CUSTOMER_TBL
    SET CT_NAME = V_CT_NAME,
        CT_BIRTH = V_CT_BIRTH,
        CT_REGION = V_CT_REGION,
        CT_GENDER = V_CT_GENDER,
        CT_C_NUM = V_CT_C_NUM,
        CT_POINT = V_CT_POINT,
        CT_GRADE = V_CT_GRADE
    WHERE CT_ID = IN_CT_ID
    ;
  
  END PROC_UPDATE_CUSTOMER_TBL
  ;
  --고객테이블 UPDATE 프로시저 끝
  
  --고객테이블 DELETE 프로시저 시작
  PROCEDURE PROC_DELETE_CUSTOMER_TBL
  (
    IN_CT_ID        IN       VARCHAR2
  )
  AS
  BEGIN
  
    /* 이후 예약신청및 매출 포인트에서 고객 아이디를 숨기는 로직 필요 */
    
    UPDATE CUSTOMER_TBL
    SET   CT_SHOW = 'N'
    WHERE CT_ID = IN_CT_ID
    ;
    
  END PROC_DELETE_CUSTOMER_TBL
  ;
  --고객테이블 DELETE 프로시저 끝
  
/* 고객(CUSTOMER_TBL)테이블 프로시저 시작 */
END PKG_CUSTOMER_TBL;