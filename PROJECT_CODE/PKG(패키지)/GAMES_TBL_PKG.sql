-------------------------------------------------PKG_GAMES_TBL 헤드시작
create or replace NONEDITIONABLE PACKAGE PKG_GAME AS 
----------------------------------------------------------
   /*GAME_TBL 업무로직 시작*/
   --CRUD    CREATE, RETRIVE, UPDATE, DELETE

----- GAME_TBL 수정과 등록
  PROCEDURE PROC_MOD_GAME
  (
   IN_G_ID          IN      VARCHAR2,
   IN_G_NAME           IN       VARCHAR2,
   IN_G_MAKER          IN      VARCHAR2,
   IN_G_RELEASE       IN       DATE,
   IN_G_SALES_PRICE    IN       NUMBER, --판매
   IN_G_SUPPLY_PRICE     IN       NUMBER, --공급 가격 
   IN_G_GENRE          IN       VARCHAR2, 
   IN_G_SHOW           IN        VARCHAR2
  );

----- GAME_TBL 삭제
  PROCEDURE PROC_DEL_GAME
  (
   IN_G_ID    IN  VARCHAR2
  
  );

----- GAME_TBL 조회
  PROCEDURE PROC_SEL_GAME
  (
   IN_G_ID          IN      VARCHAR2,
   IN_G_NAME           IN       VARCHAR2,
   IN_G_MAKER          IN      VARCHAR2,
   IN_G_RELEASE       IN       DATE,
   IN_G_SALES_PRICE    IN       NUMBER,
   IN_G_SUPPLY_PRICE     IN       NUMBER,
   IN_G_GENRE          IN       VARCHAR2, 
   IN_G_SHOW           IN        VARCHAR2,
   O_CUR             OUT    SYS_REFCURSOR
  );
  
  /*GAME_TBL 업무로직 끝*/
END PKG_GAME;
-------------------------------------------------PKG_GAMES_TBL 헤드끝

-------------------------------------------------PKG_GAMES_TBL 바디시작

create or replace NONEDITIONABLE PACKAGE BODY PKG_GAME AS
----------------------------------------------------------
   /*GAME_TBL 업무로직 시작*/
   --CRUD    CREATE, RETRIVE, UPDATE, DELETE

----- GAME_TBL 수정과 등록
  PROCEDURE PROC_MOD_GAME
  (
   IN_G_ID          IN      VARCHAR2,
   IN_G_NAME           IN       VARCHAR2,
   IN_G_MAKER          IN      VARCHAR2,
   IN_G_RELEASE       IN       DATE,
   IN_G_SALES_PRICE    IN       NUMBER, --판매
   IN_G_SUPPLY_PRICE     IN       NUMBER, --공급 가격 
   IN_G_GENRE          IN       VARCHAR2, 
   IN_G_SHOW           IN        VARCHAR2
  ) 
  AS
  
  V_NEW_G_ID            CHAR(4);
  
  BEGIN
    
   SELECT 'G' || TO_CHAR(TO_NUMBER(SUBSTR(NVL(MAX(G_ID),'G000'),2)) + 1, 'FM000')
   INTO V_NEW_G_ID
   FROM GAMES_TBL
   ;
      
      
   MERGE INTO GAMES_TBL
   USING DUAL
   ON(G_ID = IN_G_ID)
   WHEN MATCHED THEN
      UPDATE SET G_NAME = IN_G_NAME,
               G_MAKER = IN_G_MAKER,
               G_RELEASE = IN_G_RELEASE,
               G_SALES_PRICE = IN_G_SALES_PRICE,
               G_SUPPLY_PRICE = IN_G_SUPPLY_PRICE,
               G_GENRE = IN_G_GENRE,
               G_SHOW = IN_G_SHOW
      
      
   WHEN NOT MATCHED THEN
      INSERT (G_ID, G_NAME, G_MAKER, G_RELEASE , G_SALES_PRICE, G_SUPPLY_PRICE , G_GENRE, G_SHOW) 
      VALUES(V_NEW_G_ID, IN_G_NAME, IN_G_MAKER, IN_G_RELEASE, IN_G_SALES_PRICE, IN_G_SUPPLY_PRICE ,IN_G_GENRE, IN_G_SHOW)
      ;
   
   
  END PROC_MOD_GAME;
  
  ----- GAME_TBL 삭제
  PROCEDURE PROC_DEL_GAME
  (
   IN_G_ID    IN  VARCHAR2  
  )
  AS
  
  BEGIN
  
   UPDATE GAMES_TBL
   SET G_SHOW = 'N'
   WHERE G_ID = IN_G_ID
   ;
   
   
   DELETE FROM GAMES_TBL T1
   WHERE NOT EXISTS
      (
         SELECT 1 FROM SALES_TBL
         WHERE G_ID = T1.G_ID
      )
   AND G_ID = IN_G_ID
   ; 
   
  END PROC_DEL_GAME;

----- GAME_TBL 조회
  PROCEDURE PROC_SEL_GAME
  (
   IN_G_ID          IN      VARCHAR2,
   IN_G_NAME           IN       VARCHAR2,
   IN_G_MAKER          IN      VARCHAR2,
   IN_G_RELEASE       IN       DATE,
   IN_G_SALES_PRICE    IN       NUMBER, --판매
   IN_G_SUPPLY_PRICE     IN       NUMBER, --공급 가격 
   IN_G_GENRE          IN       VARCHAR2, 
   IN_G_SHOW           IN        VARCHAR2, -- 'Y' -- 'N'
   O_CUR             OUT    SYS_REFCURSOR
  )
  AS
  
  BEGIN
   
   OPEN O_CUR FOR
   SELECT G_ID, G_NAME, G_MAKER, G_RELEASE, G_SALES_PRICE, G_SUPPLY_PRICE , G_GENRE , G_SHOW FROM GAMES_TBL
   WHERE G_ID LIKE '%' || IN_G_ID || '%'
   AND G_NAME LIKE '%' || IN_G_NAME || '%'
   AND G_MAKER LIKE '%' || IN_G_MAKER || '%'
   AND G_RELEASE LIKE '%' || IN_G_RELEASE || '%'
   AND G_SALES_PRICE LIKE '%' || IN_G_SALES_PRICE || '%'
   AND G_SUPPLY_PRICE LIKE '%' || IN_G_SUPPLY_PRICE || '%'
   AND G_GENRE LIKE '%' || IN_G_GENRE || '%'
   AND G_SHOW =  CASE WHEN IN_G_SHOW = 'N'  THEN 'N'
            ELSE 'Y'
            END 
            
   ;
   
  END PROC_SEL_GAME;
  

   /*GAME_TBL 업무로직 끝*/ 
END PKG_GAME;

-------------------------------------------------PKG_GAMES_TBL 바디끝