--------------------------------------------PKG_RESERVATION_GAMES_TBL 헤드시작
create or replace NONEDITIONABLE PACKAGE PKG_RESERVATION_GAMES_TBL AS 
        
        PROCEDURE PROC_SELECT_RESERVATION
        (
                IN_G_ID                                 VARCHAR2,
                IN_G_NAME                               VARCHAR2,
                IN_G_MAKER                              VARCHAR2,
                IN_G_GENRE                              VARCHAR2,
                IN_G_R_BEGINDATE                        DATE,
                IN_G_R_RELEASE                          DATE,
                IN_G_R_DISCOUNT_PER                     NUMBER,
                IN_G_R_SUPPLY_PRICE                     NUMBER,
                IN_G_R_SALES_PRICE                      NUMBER,
                IN_G_R_SHOW                             VARCHAR,
                O_CUR                   OUT             SYS_REFCURSOR
        );

        PROCEDURE PROC_DELETE_RESERVATION
        (
                IN_G_ID                                 VARCHAR2
        );

        PROCEDURE PROC_UPDATE_RESERVATION
        (
                IN_G_ID                                 VARCHAR2,
                IN_G_NAME                               VARCHAR2,
                IN_G_MAKER                              VARCHAR2,
                IN_G_GENRE                              VARCHAR2,
                IN_G_R_BEGINDATE                        DATE,
                IN_G_R_RELEASE                          DATE,
                IN_G_R_DISCOUNT_PER                     NUMBER,
                IN_G_R_SUPPLY_PRICE                     NUMBER,
                IN_G_R_SALES_PRICE                      NUMBER
        );

        PROCEDURE PROC_INSERT_RESERVATION
        (
                IN_G_NAME                               VARCHAR2,
                IN_G_MAKER                              VARCHAR2,
                IN_G_GENRE                              VARCHAR2,
                IN_G_R_REGINDATE                        DATE,
                IN_G_R_RELEASE                          DATE,
                IN_G_R_SUPPLY_PRICE                     NUMBER,
                IN_G_R_SALES_PRICE                      NUMBER
        );
        
        PROCEDURE PROC_REFRESH_RESERVATION
        (
                BUTTON                                  VARCHAR2
        );

END PKG_RESERVATION_GAMES_TBL;
--------------------------------------------PKG_RESERVATION_GAMES_TBL 헤드끝

--------------------------------------------PKG_RESERVATION_GAMES_TBL 바디시작

create or replace NONEDITIONABLE PACKAGE BODY PKG_RESERVATION_GAMES_TBL AS

  PROCEDURE PROC_SELECT_RESERVATION
        (
                IN_G_ID                                 VARCHAR2,
                IN_G_NAME                               VARCHAR2,
                IN_G_MAKER                              VARCHAR2,
                IN_G_GENRE                              VARCHAR2,
                IN_G_R_BEGINDATE                        DATE,
                IN_G_R_RELEASE                          DATE,
                IN_G_R_DISCOUNT_PER                     NUMBER,
                IN_G_R_SUPPLY_PRICE                     NUMBER,
                IN_G_R_SALES_PRICE                      NUMBER,
                IN_G_R_SHOW                             VARCHAR,
                O_CUR                   OUT             SYS_REFCURSOR
        ) AS
  BEGIN
        
            IF IN_G_ID IS NULL 
            AND IN_G_NAME IS NULL 
            AND IN_G_MAKER IS NULL 
            AND IN_G_GENRE IS NULL 
            AND IN_G_R_BEGINDATE IS NULL 
            AND IN_G_R_RELEASE IS NULL 
            AND IN_G_R_DISCOUNT_PER IS NULL 
            AND IN_G_R_SUPPLY_PRICE IS NULL
            AND IN_G_R_SALES_PRICE IS NULL
            AND IN_G_R_SHOW IS NULL
            
            THEN
                OPEN O_CUR FOR
                SELECT T1.G_ID, T1.G_NAME, T2.CMS_NAME, T3.CMS_NAME, T1.G_R_BEGINDATE, T1.G_R_RELEASE, T1.G_R_DISCOUNT_PER, T1.G_R_SUPPLY_PRICE, T1.G_R_SALES_PRICE
                FROM RESERVATION_GAMES_TBL T1, COMMONS_TBL T2, COMMONS_TBL T3
                WHERE T1.G_MAKER = T2.CMS_ID
                    AND T1.G_GENRE = T3.CMS_ID
                ;
            ELSE
                OPEN O_CUR FOR
                SELECT T1.G_ID, T1.G_NAME, T2.CMS_NAME, T3.CMS_NAME, T1.G_R_BEGINDATE, T1.G_R_RELEASE, T1.G_R_DISCOUNT_PER, T1.G_R_SUPPLY_PRICE, T1.G_R_SALES_PRICE, T1.G_R_SHOW
                FROM RESERVATION_GAMES_TBL T1, COMMONS_TBL T2, COMMONS_TBL T3
                WHERE T1.G_MAKER = T2.CMS_ID
                    AND T1.G_GENRE = T3.CMS_ID
                    AND G_ID LIKE             '%' || IN_G_ID || '%'
                    AND G_NAME LIKE           '%' || IN_G_NAME || '%'
                    AND G_MAKER LIKE          '%' || IN_G_MAKER || '%'
                    AND G_GENRE LIKE          '%' || IN_G_GENRE || '%'
                    AND G_R_BEGINDATE LIKE    '%' || IN_G_R_BEGINDATE || '%'
                    AND G_R_RELEASE LIKE      '%' || IN_G_R_RELEASE || '%'
                    AND G_R_DISCOUNT_PER LIKE '%' || IN_G_R_DISCOUNT_PER || '%'
                    AND G_R_SUPPLY_PRICE LIKE '%' || IN_G_R_SUPPLY_PRICE || '%'
                    AND G_R_SALES_PRICE LIKE  '%' || IN_G_R_SALES_PRICE || '%'
                    AND G_R_SHOW = 
                        CASE WHEN IN_G_R_SHOW IS NULL THEN 'Y'
                        ELSE 'N'
                        END
                    ;
                    
            END IF;
            

  END PROC_SELECT_RESERVATION;

  PROCEDURE PROC_DELETE_RESERVATION
        (
                IN_G_ID         VARCHAR2
        ) AS
        
        V_G_NAME            VARCHAR2(200);
        
  BEGIN
  
        SELECT G_NAME
        INTO V_G_NAME
        FROM RESERVATION_GAMES_TBL
        WHERE G_ID = IN_G_ID
        ;
        
        -- G_R_SHOW의 값을 'N'으로 변경한다.
        UPDATE RESERVATION_GAMES_TBL
        SET G_R_SHOW = 'N'
        WHERE G_ID = IN_G_ID
        ;
        
        -- SALE_APPLYS_TBL에서 A_SHOW의 값을 'N'으로 변경한다.
        UPDATE SALE_APPLYS_TBL
        SET A_SHOW = 'N'
        WHERE G_ID = IN_G_ID
        ;
        
        --GAME_TBL의 G_SHOW의 값을 'Y'로 변경한다.
        UPDATE GAMES_TBL
        SET G_SHOW = 'Y'
        WHERE G_NAME = V_G_NAME
        ;
        
  END PROC_DELETE_RESERVATION;

  PROCEDURE PROC_UPDATE_RESERVATION
        (
                IN_G_ID                          VARCHAR2,
                IN_G_NAME                        VARCHAR2,
                IN_G_MAKER                       VARCHAR2,
                IN_G_GENRE                       VARCHAR2,
                IN_G_R_BEGINDATE                 DATE,
                IN_G_R_RELEASE                   DATE,
                IN_G_R_DISCOUNT_PER              NUMBER,
                IN_G_R_SUPPLY_PRICE              NUMBER,
                IN_G_R_SALES_PRICE               NUMBER
        ) AS
        
                V_G_NAME                        VARCHAR2(200);
                V_G_MAKER                       CHAR(6);
                V_G_GENRE                       CHAR(6);
                V_G_R_BEGINDATE                 DATE;
                V_G_R_RELEASE                   DATE;
                V_G_R_DISCOUNT_PER              NUMBER;
                V_G_R_SUPPLY_PRICE              NUMBER;
                V_G_R_SALES_PRICE               NUMBER;
        
  BEGIN
        -- IN_G_NAME에 입력값이 없다면 원래의 값을 적용하고, 입력값이 있다면 입력값을 적용한다.
        IF IN_G_NAME IS NULL
                THEN
                        SELECT G_NAME
                        INTO V_G_NAME
                        FROM RESERVATION_GAMES_TBL
                        WHERE G_ID = IN_G_ID
                        ;
                ELSE
                        V_G_NAME := IN_G_NAME;
                END IF;
                
        -- IN_G_MAKER에 입력값이 없다면 원래의 값을 적용하고, 입력값이 있다면 입력값을 적용한다.                
        IF IN_G_MAKER IS NULL
                THEN
                        SELECT G_MAKER
                        INTO V_G_MAKER
                        FROM RESERVATION_GAMES_TBL
                        WHERE G_ID = IN_G_ID
                        ;
                ELSE
                        V_G_MAKER := IN_G_MAKER;
                END IF;
                
        -- IN_G_GENRE에 입력값이 없다면 원래의 값을 적용하고, 입력값이 있다면 입력값을 적용한다.                                
        IF IN_G_GENRE IS NULL
                THEN
                        SELECT G_GENRE
                        INTO V_G_GENRE
                        FROM RESERVATION_GAMES_TBL
                        WHERE G_ID = IN_G_ID
                        ;
                ELSE
                        V_G_GENRE := IN_G_GENRE;
                END IF;
                
        -- IN_G_R_BEGINDATE에 입력값이 없다면 원래의 값을 적용하고, 입력값이 있다면 입력값을 적용한다.                
        IF IN_G_R_BEGINDATE IS NULL
                THEN
                        SELECT G_R_BEGINDATE
                        INTO V_G_R_BEGINDATE
                        FROM RESERVATION_GAMES_TBL
                        WHERE G_ID = IN_G_ID
                        ;
                ELSE
                        V_G_R_BEGINDATE := IN_G_R_BEGINDATE;
                END IF;

        -- IN_G_R_RELEASE에 입력값이 없다면 원래의 값을 적용하고, 입력값이 있다면 입력값을 적용한다.                
        IF IN_G_R_RELEASE IS NULL
                THEN
                        SELECT G_R_RELEASE
                        INTO V_G_R_RELEASE
                        FROM RESERVATION_GAMES_TBL
                        WHERE G_ID = IN_G_ID
                        ;
                ELSE
                        V_G_R_RELEASE := IN_G_R_RELEASE;
                END IF;
                
        -- IN_G_R_DISCOUNT_PER에 입력값이 없다면 원래의 값을 적용하고, 입력값이 있다면 입력값을 적용한다.                                
        IF IN_G_R_DISCOUNT_PER IS NULL
                THEN
                        SELECT G_R_DISCOUNT_PER
                        INTO V_G_R_DISCOUNT_PER
                        FROM RESERVATION_GAMES_TBL
                        WHERE G_ID = IN_G_ID
                        ;
                ELSE
                        V_G_R_DISCOUNT_PER := IN_G_R_DISCOUNT_PER;
                END IF;
                
        -- IN_G_R_SUPPLY_PRICE에 입력값이 없다면 원래의 값을 적용하고, 입력값이 있다면 입력값을 적용한다.                                
        IF IN_G_R_SUPPLY_PRICE IS NULL
                THEN
                        SELECT G_R_SUPPLY_PRICE
                        INTO V_G_R_SUPPLY_PRICE
                        FROM RESERVATION_GAMES_TBL
                        WHERE G_ID = IN_G_ID
                        ;
                ELSE
                        V_G_R_SUPPLY_PRICE := IN_G_R_SUPPLY_PRICE;
                END IF;
                
        -- IN_G_R_SALES_PRICE에 입력값이 없다면 원래의 값을 적용하고, 입력값이 있다면 입력값을 적용한다.                                
        IF IN_G_R_SALES_PRICE IS NULL
                THEN
                        SELECT G_R_SALES_PRICE
                        INTO V_G_R_SALES_PRICE
                        FROM RESERVATION_GAMES_TBL
                        WHERE G_ID = IN_G_ID
                        ;
                ELSE
                        V_G_R_SALES_PRICE := IN_G_R_SALES_PRICE;
                END IF;
                
        -- 적용된 값을 가지고 IN_G_ID의 데이터를 업데이트한다.
        UPDATE RESERVATION_GAMES_TBL
        SET G_NAME = V_G_NAME, 
                G_MAKER = V_G_MAKER, 
                G_GENRE = V_G_GENRE, 
                G_R_BEGINDATE = V_G_R_BEGINDATE, 
                G_R_RELEASE = V_G_R_RELEASE, 
                G_R_DISCOUNT_PER = V_G_R_DISCOUNT_PER, 
                G_R_SUPPLY_PRICE = V_G_R_SUPPLY_PRICE, 
                G_R_SALES_PRICE = V_G_R_SALES_PRICE
        WHERE G_ID = IN_G_ID
        ;
                

  END PROC_UPDATE_RESERVATION;

   PROCEDURE PROC_INSERT_RESERVATION
        (
                IN_G_NAME                   VARCHAR2,
                IN_G_MAKER                  VARCHAR2,
                IN_G_GENRE                  VARCHAR2,
                IN_G_R_REGINDATE            DATE,
                IN_G_R_RELEASE              DATE,
                IN_G_R_SUPPLY_PRICE         NUMBER,
                IN_G_R_SALES_PRICE          NUMBER
        ) AS
        
        V_G_ID_1              CHAR(4);
        V_G_ID_2              CHAR(4);
        
  BEGIN
  
        -- RESERVATION_GAMES_TBL에 들어갈 새로운 G_ID를 부여한다.
        SELECT 'G' || TO_CHAR(TO_NUMBER(SUBSTR(NVL(MAX(G_ID), 'G000'), 2)) + 1, 'FM000')
        INTO V_G_ID_1
        FROM RESERVATION_GAMES_TBL
        ;
        
        -- GAMES_TBL에 들어갈 새로운 G_ID를 부여한다.
        SELECT 'G' || TO_CHAR(TO_NUMBER(SUBSTR(NVL(MAX(G_ID), 'G000'), 2)) + 1, 'FM000')
        INTO V_G_ID_2
        FROM GAMES_TBL
        ;
        
        -- 새로운 게임 데이터를 RESERVATION_GAMES_TBL에 삽입한다.
        INSERT INTO RESERVATION_GAMES_TBL
        (G_ID, G_NAME, G_MAKER, G_GENRE, G_R_BEGINDATE, G_R_RELEASE, G_R_SUPPLY_PRICE, G_R_SALES_PRICE)
        VALUES
        (V_G_ID_1, IN_G_NAME, IN_G_MAKER, IN_G_GENRE, IN_G_R_REGINDATE, IN_G_R_RELEASE, IN_G_R_SUPPLY_PRICE, IN_G_R_SALES_PRICE)
        ;
        
        -- 새로운 게임 데이터를 GAMES_TBL에 삽입한다. G_SHOW는 'N'으로 한다.
        INSERT INTO GAMES_TBL
        (G_ID, G_NAME, G_MAKER, G_RELEASE, G_SALES_PRICE, G_SUPPLY_PRICE, G_GENRE, G_SHOW)
        VALUES
        (V_G_ID_2, IN_G_NAME, IN_G_MAKER, IN_G_R_RELEASE, IN_G_R_SALES_PRICE, IN_G_R_SUPPLY_PRICE, IN_G_GENRE, 'N')
        ;

  END PROC_INSERT_RESERVATION;
  
    PROCEDURE PROC_REFRESH_RESERVATION
    (
        BUTTON          VARCHAR2
    )
    AS
    
    BEGIN
        
        UPDATE RESERVATION_GAMES_TBL
        SET G_R_SHOW = 'N'
        WHERE G_R_RELEASE < SYSDATE
        ;
        
        
        UPDATE GAMES_TBL
        SET G_SHOW = 'Y'
        WHERE G_RELEASE < SYSDATE
        ;
    
    END PROC_REFRESH_RESERVATION;

END PKG_RESERVATION_GAMES_TBL;

--------------------------------------------PKG_RESERVATION_GAMES_TBL 바디끝