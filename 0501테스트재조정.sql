
create or replace NONEDITIONABLE PACKAGE PKG_APPLY_TBL AS 

  /* 신청(APPLY_TBL)테이블 프로시저 시작 */
  
   --신청테이블 SELECT 프로시저 시작
   PROCEDURE PROC_SELECT_APPLY_TBL
   (
    IN_A_ID         IN      VARCHAR2,
    IN_A_INDEX      IN      VARCHAR2,
    IN_G_R_ID       IN      VARCHAR2,
    IN_CT_ID        IN      VARCHAR2,
    IN_S_DATE       IN      VARCHAR2,
    IN_PY_ID        IN      VARCHAR2,
    IN_A_SHOW       IN      VARCHAR2,
    O_CUR           OUT      SYS_REFCURSOR
   );  
   --신청테이블 SELECT 프로시저 끝
  
  --신청테이블 INSERT 프로시저 시작
  PROCEDURE PROC_INSERT_APPLY_TBL
  (
    IN_G_R_ID       IN      VARCHAR2,
    IN_CT_ID        IN      VARCHAR2,
    IN_PY_ID        IN      VARCHAR2
  );
  --신청테이블 INSERT 프로시저 끝
  
  --신청테이블 UPDATE 프로시저 시작
  PROCEDURE PROC_UPDATE_APPLY_TBL
  (
    IN_A_ID         IN      VARCHAR2,
    IN_A_INDEX      IN      VARCHAR2,
    IN_G_R_ID       IN      VARCHAR2
  );
  --신청테이블 UPDATE 프로시저 끝
  
  --신청테이블 DELETE 프로시저 시작
  PROCEDURE PROC_DELETE_APPLY_TBL
  (
    IN_A_ID       IN      VARCHAR2,
    IN_A_INDEX    IN      VARCHAR2
  );
  --신청테이블 DELETE 프로시저 끝
  
  /* 신청(APPLY_TBL)테이블 프로시저 끝 */
END PKG_APPLY_TBL;

--------------------------------------------------

create or replace NONEDITIONABLE PACKAGE BODY PKG_APPLY_TBL AS

/* 신청(APPLY_TBL)테이블 프로시저 시작 */
  
   --신청테이블 SELECT 프로시저 시작
  PROCEDURE PROC_SELECT_APPLY_TBL
   (
    IN_A_ID         IN      VARCHAR2,
    IN_A_INDEX      IN      VARCHAR2,
    IN_G_R_ID       IN      VARCHAR2,
    IN_CT_ID        IN      VARCHAR2,
    IN_S_DATE       IN      VARCHAR2,
    IN_PY_ID        IN      VARCHAR2,
    IN_A_SHOW       IN      VARCHAR2,
    O_CUR           OUT      SYS_REFCURSOR
   ) AS
  BEGIN
    
    OPEN O_CUR FOR
    SELECT *
    FROM APPLY_TBL
    --조건에 해당하것을 넣으면 찾고 아니면 그냥 ROW를 찾기위한 조건
    WHERE A_ID = '%' || IN_A_ID || '%'
    AND   A_INDEX = '%' || IN_A_INDEX || '%' 
    AND   G_R_ID = '%' || IN_G_R_ID || '%' 
    AND   CT_ID = '%' || IN_CT_ID || '%' 
    AND   S_DATE = '%' || IN_S_DATE || '%' 
    AND   PY_ID = '%' || IN_PY_ID || '%' 
    AND   A_SHOW = CASE WHEN IN_A_SHOW = 'N' THEN 'N'
                   ELSE 'Y'
                   END
    ;
    
  END PROC_SELECT_APPLY_TBL;
 --신청테이블 SELECT 프로시저 끝
  
   --신청테이블 INSERT 프로시저 시작
  PROCEDURE PROC_INSERT_APPLY_TBL
  (
    IN_G_R_ID       IN      VARCHAR2,
    IN_CT_ID        IN      VARCHAR2,
    IN_PY_ID        IN      VARCHAR2
  )
  AS
    V_NEW_A_ID          CHAR(4);    --신청 ID변수
    V_NEW_A_INDEX        NUMBER(7);  --신청 INDEX변수
  BEGIN
    
    --새로운 신청 ID 생성
    SELECT 'A' || TO_CHAR(TO_NUMBER(SUBSTR(NVL(MAX(A_ID),'A000'),2)) +1,'FM000')
    INTO V_NEW_A_ID
    FROM APPLY_TBL
    ;
    
    --INDEX를 생성시 게임과 고객이 첫 구매라면 1 같은 게임과 고객이 두번째 구매시 2를 나오게 하기
    
    SELECT NVL(MAX(A_INDEX),0)
    INTO V_NEW_A_INDEX
    FROM APPLY_TBL
    WHERE G_R_ID = IN_G_R_ID AND CT_ID = IN_CT_ID
    ;
    
    IF V_NEW_A_INDEX != 0 THEN --같은 게임및 고객이 첫 구매가 아닐 경우
    
    INSERT INTO APPLY_TBL(A_ID, A_INDEX, G_R_ID, CT_ID, S_DATE, PY_ID, A_SHOW)
    VALUES (V_NEW_A_ID, V_NEW_A_INDEX + 1, IN_G_R_ID, IN_CT_ID, SYSDATE, IN_PY_ID, 'Y')
    ;
    
    ELSE --같은 게임및 고객이 첫 구매일 경우
    
    INSERT INTO APPLY_TBL(A_ID, A_INDEX, G_R_ID, CT_ID, S_DATE, PY_ID, A_SHOW)
    VALUES (V_NEW_A_ID, 1, IN_G_R_ID, IN_CT_ID, SYSDATE, IN_PY_ID, 'Y')
    ;
    
    END IF
    ;
    
    
  END PROC_INSERT_APPLY_TBL;
  --신청테이블 INSERT 프로시저 끝
  
  --신청테이블 UPDATE 프로시저 시작 > 게임출시일에 출시한경우 구매테이블로 이동
  PROCEDURE PROC_UPDATE_APPLY_TBL
  (
    IN_A_ID         IN      VARCHAR2,
    IN_A_INDEX      IN      VARCHAR2,
    IN_G_R_ID       IN      VARCHAR2
  )
  AS
  
    V_GAME_DATE     VARCHAR2(24);
    V_NEW_S_ID      CHAR(4);
    V_APPLY_G_ID    CHAR(4);
    V_APPLY_CT_ID    CHAR(5);
    V_APPLY_PY_ID    CHAR(5);
    
  BEGIN
  
    -- 게임출시일을 가져온다 
    SELECT G_DATE
    INTO V_GAME_DATE
    FROM GAME_TBL
    WHERE G_ID = IN_G_R_ID
    ;
    
    -- SALES_TBL의 SID를 구한다
    SELECT 'S' || TO_CHAR(TO_NUMBER(NVL(MAX(S_ID), 'S000'))+1,'FM000')
    INTO V_NEW_S_ID
    FROM SALES_TBL
    ;
    
    --APPLY DATA를 가져오기위한 구문
    SELECT G_ID
    INTO V_APPLY_G_ID
    FROM APPLY_TBL
    WHERE A_ID = IN_A_ID
    AND A_INDEX = IN_A_INDEX
    ;
    
    SELECT CT_ID
    INTO V_APPLY_CT_ID
    FROM APPLY_TBL
    WHERE A_ID = IN_A_ID
    AND A_INDEX = IN_A_INDEX
    ;
    
    SELECT PY_ID
    INTO V_APPLY_PY_ID
    FROM APPLY_TBL
    WHERE A_ID = IN_A_ID
    AND A_INDEX = IN_A_INDEX
    ;
    
    --현재날짜와 게임출시일을 비교
    IF  TO_DATE(V_GAME_DATE) >= SYSDATE THEN
    
        INSERT INTO SALES_TBL(S_ID, S_INDEX, G_ID, CT_ID, S_DATE, PY_ID)
        VALUES (V_NEW_S_ID, 1, V_APPLY_G_ID, V_APPLY_CT_ID, SYSDATE, V_APPLY_PY_ID)
        ;
    
    END IF;
    
  END
  ;
  --신청테이블 UPDATE 프로시저 끝
  
   --신청테이블 DELETE 프로시저 시작 > 신청 취소와 같은 의미
  PROCEDURE PROC_DELETE_APPLY_TBL
  (
    IN_A_ID       IN      VARCHAR2,
    IN_A_INDEX    IN      VARCHAR2
  )
  AS
  BEGIN
    
    UPDATE APPLY_TBL
    SET A_SHOW = 'N'
    WHERE A_ID = IN_A_ID
    AND A_INDEX = IN_A_INDEX
    ;
    
  END PROC_DELETE_APPLY_TBL;
  --신청테이블 DELETE 프로시저 끝
  
  /* 신청(APPLY_TBL)테이블 프로시저 끝 */

END PKG_APPLY_TBL;