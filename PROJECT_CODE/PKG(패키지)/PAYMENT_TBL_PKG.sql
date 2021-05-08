--------------------------------------PKG_PAYMENT_TBL 헤드 시작
create or replace NONEDITIONABLE PACKAGE PKG_PAYMENT_TBL AS 

        PROCEDURE PROC_SELECT_PAYMENT
        (
                IN_PY_NAME                      VARCHAR2,
                IN_GROUP_NUM                    NUMBER,
                IN_PARENT_PY_ID                 VARCHAR2,
                O_CUR               OUT         SYS_REFCURSOR
        );

        PROCEDURE PROC_DELETE_PAYMENT
        (
                IN_PY_ID                        VARCHAR2
        );

      --결제방식테이블 UPDATE 프로시저 시작
        PROCEDURE PROC_UPDATE_PAYMENT_TBL
      (
        IN_PY_ID            IN                  VARCHAR2,
        IN_PY_NAME          IN                  VARCHAR2,
        IN_GROUP_NUM        IN                  NUMBER,
        IN_PY_LVL           IN                  NUMBER,
        IN_PY_SEQ           IN                  NUMBER,
        IN_PY_DC_PER        IN                  NUMBER,
        IN_PARENT_PY_ID     IN                  VARCHAR2
        );
      --결제방식테이블 UPDATE 프로시저 끝

        PROCEDURE PROC_INSERT_PAYMENT
        (
                IN_PY_NAME                 VARCHAR2,
                IN_GROUP_NUM               NUMBER,                
                IN_PY_LVL                  NUMBER,
                IN_PY_SEQ                  NUMBER,
                IN_PC_DC_PER               NUMBER,
                IN_PARENT_PY_ID            VARCHAR2
        );

END PKG_PAYMENT_TBL;

--------------------------------------PKG_PAYMENT_TBL 헤드 끝

--------------------------------------PKG_PAYMENT_TBL 바디 시작

create or replace NONEDITIONABLE PACKAGE BODY PKG_PAYMENT_TBL AS

  PROCEDURE PROC_SELECT_PAYMENT
        (
                IN_PY_NAME                      VARCHAR2,
                IN_GROUP_NUM                    NUMBER,
                IN_PARENT_PY_ID                 VARCHAR2,
                O_CUR               OUT         SYS_REFCURSOR
        ) 
  AS
    
  BEGIN
        
        IF IN_PARENT_PY_ID = 'PY001' THEN
            OPEN O_CUR FOR
            SELECT *
            FROM PAYMENT_TBL
            WHERE GROUP_NUM LIKE '%'|| IN_GROUP_NUM ||'%'
            ;
        ELSE
            OPEN O_CUR FOR
            SELECT *
            FROM PAYMENT_TBL
            WHERE PY_ID LIKE '%'|| IN_PY_NAME ||'%'
            ;
        END IF
        ;
       
        
        /*
        
        -- 검색한 로우의 PY_ID를 가져온다
        SELECT PARENT_PY_ID
        INTO V_PARENT_PY_ID
        FROM PAYMENT_TBL
        WHERE PY_NAME IS NULL 
        ;
        
        -- 검색한 로우의 GROUP_NUM을 가져온다
        SELECT GROUP_NUM
        INTO V_GROUP_NUM
        FROM PAYMENT_TBL
        WHERE PY_NAME =  IN_PY_NAME
        ; 
        
       
        -- 카드, 현금, 모바일을 검색할때는 해당 카테고리 전체를 나타낸다.
        -- 특정 이름을 검색할때는 해당 지불방식을 나타낸다.

            
        IF V_PARENT_PY_ID = 'PY001'
                THEN
                        OPEN O_CUR FOR                
                        SELECT *
                        FROM PAYMENT_TBL
                        WHERE GROUP_NUM = V_GROUP_NUM
                        ;
                ELSIF IN_PY_NAME IS NULL THEN
                        OPEN O_CUR FOR                
                        SELECT *
                        FROM PAYMENT_TBL
                        ;
                ELSE
                        OPEN O_CUR FOR  
                        SELECT * 
                        FROM PAYMENT_TBL
                        WHERE PY_NAME LIKE '%' || IN_PY_NAME || '%'
                        ;
                END IF;
          */      
  END PROC_SELECT_PAYMENT;

  PROCEDURE PROC_DELETE_PAYMENT
        (
                IN_PY_ID                    VARCHAR2
        ) AS

                V_GROUP_NUM                 NUMBER;
                V_PY_LVL                    NUMBER;
                V_PY_SEQ                    NUMBER;

  BEGIN

        -- 삭제하는 데이터의 GROUP_NUM
        SELECT GROUP_NUM
        INTO V_GROUP_NUM
        FROM PAYMENT_TBL
        WHERE PY_ID = IN_PY_ID
        ;

        -- 삭제하는 데이터의 PY_LVL
        SELECT PY_LVL
        INTO V_PY_LVL
        FROM PAYMENT_TBL
        WHERE PY_ID = IN_PY_ID
        ;

        -- 삭제하는 데이터의 PY_SEQ
        SELECT PY_SEQ
        INTO V_PY_SEQ
        FROM PAYMENT_TBL
        WHERE PY_ID = IN_PY_ID
        ;

        -- IN_PY_ID에 입력된 데이터를 삭제한다.
        DELETE PAYMENT_TBL
        WHERE PY_ID = IN_PY_ID
        ;

        -- 삭제하는 데이터보다 시퀀스 값이 큰 데이터의 시퀀스 값을 1씩 줄인다.
        UPDATE PAYMENT_TBL
        SET PY_SEQ = PY_SEQ - 1
        WHERE GROUP_NUM = V_GROUP_NUM
                AND PY_LVL = V_PY_LVL
                AND PY_SEQ > V_PY_SEQ
        ;

  END PROC_DELETE_PAYMENT;

    PROCEDURE PROC_UPDATE_PAYMENT_TBL
  (
    IN_PY_ID            IN      VARCHAR2,
    IN_PY_NAME          IN      VARCHAR2,
    IN_GROUP_NUM        IN      NUMBER,
    IN_PY_LVL           IN      NUMBER,
    IN_PY_SEQ           IN      NUMBER,
    IN_PY_DC_PER        IN      NUMBER,
    IN_PARENT_PY_ID     IN     VARCHAR2
  ) 
  AS
    V_PY_NAME       VARCHAR(30);
    V_PY_GROUP_NUM  NUMBER(2);
    V_PY_LVL        NUMBER(2);
    V_PY_SEQ        NUMBER(2);
    V_PY_DC_PER     NUMBER(3);
    V_PARENT_PY_ID  VARCHAR(15);
    
    -----------업데이트전에 값을 가져가는 변수
    V_OLD_PY_GROUP_NUM  NUMBER(2);
    V_OLD_PY_LVL        NUMBER(2);
    V_OLD_PY_SEQ        NUMBER(2);
    
  BEGIN
    
    --NULL값을 넣으면 들어가있었던 값을 넣고 아니면 바꾸는 값을 넣는다
    SELECT CASE WHEN IN_PY_NAME IS NULL THEN PY_NAME
           ELSE IN_PY_NAME
           END
    INTO V_PY_NAME
    FROM PAYMENT_TBL
    WHERE PY_ID = IN_PY_ID
    ;
    
    SELECT CASE WHEN IN_GROUP_NUM IS NULL THEN GROUP_NUM
           ELSE IN_GROUP_NUM
           END
    INTO V_PY_GROUP_NUM
    FROM PAYMENT_TBL
    WHERE PY_ID = IN_PY_ID
    ;
    
    SELECT CASE WHEN IN_PY_LVL IS NULL THEN PY_LVL
           ELSE IN_PY_LVL
           END
    INTO V_PY_LVL
    FROM PAYMENT_TBL
    WHERE PY_ID = IN_PY_ID
    ;
    
    SELECT CASE WHEN IN_PY_SEQ IS NULL THEN PY_SEQ
           ELSE IN_PY_SEQ
           END
    INTO V_PY_SEQ
    FROM PAYMENT_TBL
    WHERE PY_ID = IN_PY_ID
    ;
    
    SELECT CASE WHEN IN_PY_DC_PER IS NULL THEN PY_DC_PER
           ELSE IN_PY_DC_PER
           END
    INTO V_PY_DC_PER
    FROM PAYMENT_TBL
    WHERE PY_ID = IN_PY_ID
    ;
    
    SELECT CASE WHEN IN_PARENT_PY_ID IS NULL THEN PARENT_PY_ID
           ELSE IN_PARENT_PY_ID
           END
    INTO V_PARENT_PY_ID
    FROM PAYMENT_TBL
    WHERE PY_ID = IN_PY_ID
    ;
    
    --업데이트전 값을 가져온다
    
    SELECT GROUP_NUM
    INTO V_OLD_PY_GROUP_NUM
    FROM PAYMENT_TBL
    WHERE PY_ID = IN_PY_ID
    ;
    
    SELECT PY_LVL
    INTO V_OLD_PY_LVL
    FROM PAYMENT_TBL
    WHERE PY_ID = IN_PY_ID
    ;
    
    SELECT PY_SEQ
    INTO V_OLD_PY_SEQ
    FROM PAYMENT_TBL
    WHERE PY_ID = IN_PY_ID
    ;
    
    
    --같은 레벨일 경우 순서만 바꾼다는 의미이다
    
    IF V_PY_LVL = V_OLD_PY_LVL AND V_PY_GROUP_NUM = V_OLD_PY_GROUP_NUM  THEN
        
        IF  V_PY_SEQ >= V_OLD_PY_SEQ THEN
        
        UPDATE PAYMENT_TBL
        SET PY_SEQ = PY_SEQ - 1
        WHERE PY_LVL = V_PY_LVL
        AND GROUP_NUM = V_PY_GROUP_NUM
        AND PY_SEQ <= V_PY_SEQ
        ;
        
        UPDATE PAYMENT_TBL
        SET PY_NAME  =    V_PY_NAME,
        PY_SEQ       =    V_PY_SEQ,
        PY_DC_PER    =    V_PY_DC_PER
        WHERE PY_ID = IN_PY_ID
        ;
        
        ----최저값을 0으로 만들지 않기위한 명령
        
        UPDATE PAYMENT_TBL
        SET PY_SEQ = 1
        WHERE PY_SEQ = 0
        AND PY_LVL = V_PY_LVL
        AND GROUP_NUM = V_PY_GROUP_NUM
        ;
        
        ELSE 
        
        UPDATE PAYMENT_TBL
        SET PY_SEQ = PY_SEQ + 1
        WHERE PY_LVL = V_PY_LVL
        AND GROUP_NUM = V_PY_GROUP_NUM
        AND PY_SEQ <= V_PY_SEQ
        ;
        
        UPDATE PAYMENT_TBL
        SET PY_NAME  =    V_PY_NAME,
        PY_SEQ       =    V_PY_SEQ,
        PY_DC_PER    =    V_PY_DC_PER
        WHERE PY_ID = IN_PY_ID
        ;
        
        END IF;
        
    ELSE -- 레벨이 다른경우 이전에 있었던 레벨의 시퀀스를 조정해줘야함
        
        UPDATE PAYMENT_TBL
        SET PY_SEQ = PY_SEQ + 1
        WHERE PY_LVL = V_PY_LVL
        AND GROUP_NUM = V_PY_GROUP_NUM
        AND PY_SEQ >= V_PY_SEQ
        ;
    
        UPDATE PAYMENT_TBL
        SET PY_NAME  =    V_PY_NAME,
        GROUP_NUM    =    V_PY_GROUP_NUM,
        PY_LVL       =    V_PY_LVL,
        PY_SEQ       =    V_PY_SEQ,
        PY_DC_PER    =    V_PY_DC_PER,
        PARENT_PY_ID =    V_PARENT_PY_ID
        WHERE PY_ID = IN_PY_ID
        ;
        
        UPDATE PAYMENT_TBL
        SET PY_SEQ = PY_SEQ -1
        WHERE PY_LVL = V_OLD_PY_LVL
        AND GROUP_NUM = V_OLD_PY_GROUP_NUM
        AND PY_SEQ >= V_OLD_PY_SEQ
        ;
    
    END IF;
  END PROC_UPDATE_PAYMENT_TBL;

  PROCEDURE PROC_INSERT_PAYMENT
        (
                IN_PY_NAME                 VARCHAR2,
                IN_GROUP_NUM               NUMBER,                
                IN_PY_LVL                  NUMBER,
                IN_PY_SEQ                  NUMBER,
                IN_PC_DC_PER               NUMBER,
                IN_PARENT_PY_ID            VARCHAR2
        ) 
        AS

        V_PY_ID                 CHAR(5);
        V_CHK_GROUP_NUM         NUMBER(1);

        BEGIN

                -- 새로운 PY_ID를 부여한다.
                SELECT 'PY' || TO_CHAR(TO_NUMBER(SUBSTR(NVL(MAX(PY_ID), 'PY000'), 3)) + 1, 'FM000')
                INTO V_PY_ID
                FROM PAYMENT_TBL
                ;

                SELECT COUNT(*)
                INTO V_CHK_GROUP_NUM
                FROM PAYMENT_TBL
                WHERE GROUP_NUM = IN_GROUP_NUM
                ;

                -- 시퀀스 값이 중간에 삽입된다면, 시퀀스 값을 조정해주자.
                -- 삽입되는 시퀀스 값보다 크거나 같은 값에 +1 해주어야 겹치지 않음.
                UPDATE PAYMENT_TBL
                SET PY_SEQ = PY_SEQ + 1
                WHERE GROUP_NUM = IN_GROUP_NUM
                        AND PY_LVL = IN_PY_LVL
                        AND PY_SEQ >= IN_PY_SEQ;



                -- 새로운 데이터를 삽입한다.
                INSERT INTO PAYMENT_TBL
                (PY_ID, PY_NAME, GROUP_NUM, PY_LVL, PY_SEQ, PY_DC_PER, PARENT_PY_ID)
                VALUES
                (V_PY_ID, IN_PY_NAME, IN_GROUP_NUM, IN_PY_LVL, IN_PY_SEQ, IN_PC_DC_PER, IN_PARENT_PY_ID)
                ;

  END PROC_INSERT_PAYMENT;

END PKG_PAYMENT_TBL;

--------------------------------------PKG_PAYMENT_TBL 바디 끝