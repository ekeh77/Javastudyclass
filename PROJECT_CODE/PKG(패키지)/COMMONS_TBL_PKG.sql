----------------------------------------------PKG_COMMONS_TBL 헤드시작
create or replace NONEDITIONABLE PACKAGE PKG_COMMONS AS 
----------------------------------------------------------
   /*COMMONS_TBL 업무로직 시작*/
   --CRUD CREATE, RETRIVE, UPDATE, DELETE

----- COMMONS_TBL INSERT, UPDATE
  PROCEDURE PROC_INS_UP_COMMONS
  (
         IN_CMS_ID                IN     VARCHAR2,
           IN_CMS_NAME              IN     VARCHAR2,
           IN_CMS_LVL               IN       NUMBER,
           IN_CMS_SEQ               IN        NUMBER,
         IN_PARENT_CMS_ID        IN       VARCHAR2,
           IN_GROUP_NUM               IN       NUMBER  
  );

----- COMMONS_TBL DELETE

  PROCEDURE PROC_DEL_COMMONS
  (
   IN_CMS_ID          IN      VARCHAR2,
   IN_CMS_LVL        IN     NUMBER,
   IN_CMS_SEQ        IN     NUMBER
  );

----- COMMONS_TBL SELECT

  PROCEDURE PROC_SEL_COMMONS
  (
   IN_CMS_ID           IN     VARCHAR2,
   IN_CMS_NAME        IN     VARCHAR2,
   IN_CMS_LVL        IN     NUMBER,
   IN_CMS_SEQ        IN     NUMBER,
   IN_PARENT_CMS_ID     IN       VARCHAR2,
   IN_GROUP_NUM        IN       NUMBER,
   O_CUR            OUT     SYS_REFCURSOR
  );

   /*COMMONS_TBL 업무로직 끝*/
END PKG_COMMONS;
----------------------------------------------PKG_COMMONS_TBL 헤드끝
----------------------------------------------PKG_COMMONS_TBL 바디시작

create or replace NONEDITIONABLE PACKAGE BODY PKG_COMMONS AS
----------------------------------------------------------
   /*COMMONS_TBL 업무로직 시작*/
   --CRUD CREATE, RETRIVE, UPDATE, DELETE

---- COMMONS_TBL INSERT, UPDATE    
   PROCEDURE PROC_INS_UP_COMMONS
   (
           IN_CMS_ID                IN     VARCHAR2,
           IN_CMS_NAME              IN     VARCHAR2,
           IN_CMS_LVL               IN     NUMBER,
           IN_CMS_SEQ               IN     NUMBER,
         IN_PARENT_CMS_ID        IN       VARCHAR2,
           IN_GROUP_NUM               IN     NUMBER  

    )
  AS
   V_CMS_ID       CHAR(6);
  ----------
   V_CMS_LVL                NUMBER(3);
   V_CMS_SEQ               NUMBER(3);
   V_PARENT_CMS_ID         VARCHAR2(20); -- 기존
   V_GROUP_NUM            NUMBER(3);
   --V_G_PARENT_CMS_ID       VARCHAR2(20);  -- group 값으로 잡아옴
   
  BEGIN
      
   SELECT COUNT(*)
   INTO V_CMS_ID
   FROM COMMONS_TBL
   WHERE CMS_ID = IN_CMS_ID
   ;
   

   
   IF V_CMS_ID = 0 THEN ----- insert -- CMS_ID가 없다면 새로 생성한다
      
      if IN_CMS_LVL = 1 and IN_PARENT_CMS_ID is null then  
      
            SELECT 'CMS' || TO_CHAR(TO_NUMBER(SUBSTR(NVL(MAX(CMS_ID),'CMS000'),4)) + 1, 'FM000')
            INTO V_CMS_ID
            FROM COMMONS_TBL
            ;
            
             --제일 위쪽 부모없는 부분 추가될때
            UPDATE COMMONS_TBL
            SET CMS_SEQ = CMS_SEQ + 1
            WHERE CMS_SEQ >= IN_CMS_SEQ
            AND CMS_LVL = IN_CMS_LVL
            ;
            
            INSERT INTO COMMONS_TBL
            (CMS_ID, CMS_NAME, CMS_LVL, CMS_SEQ, PARENT_CMS_ID, GROUP_NUM)
            VALUES
            (V_CMS_ID, IN_CMS_NAME, IN_CMS_LVL , IN_CMS_SEQ, IN_PARENT_CMS_ID, IN_GROUP_NUM)
            ;
            
         else
           -- 그 밑 다른부분 
            SELECT 'CMS' || TO_CHAR(TO_NUMBER(SUBSTR(NVL(MAX(CMS_ID),'CMS000'),4)) + 1, 'FM000')
            INTO V_CMS_ID
            FROM COMMONS_TBL
            ;
            
            --새로 추가되는 값이 들어갈때 밀리는 SEQ값을 수정해줌 
            UPDATE COMMONS_TBL
            SET CMS_SEQ = CMS_SEQ + 1
            WHERE CMS_SEQ >= IN_CMS_SEQ
            AND CMS_LVL = IN_CMS_LVL
            ;
            
            INSERT INTO COMMONS_TBL
            (CMS_ID, CMS_NAME, CMS_LVL, CMS_SEQ, PARENT_CMS_ID, GROUP_NUM)
            VALUES
            (V_CMS_ID, IN_CMS_NAME, IN_CMS_LVL , IN_CMS_SEQ, IN_PARENT_CMS_ID, IN_GROUP_NUM)
            ;
         end if;
         
  ELSE  -- 있으면 수정한다 
  -------------------------------  update 

   -- 내가 넣은 CMS_ID의  LVL,  SEQ, PARENT_CMS_ID, GROUP_NUM 값들을 변수에 저장한다
   
      SELECT CMS_LVL  -- 기존 LVL 값
      INTO V_CMS_LVL
      FROM COMMONS_TBL
      WHERE CMS_ID = IN_CMS_ID
      ;
      
      SELECT CMS_SEQ  -- 기존 SEQ 값
      INTO V_CMS_SEQ
      FROM COMMONS_TBL
      WHERE CMS_ID = IN_CMS_ID
      ;
      
      SELECT PARENT_CMS_ID -- 기존 PARENT 값 
      INTO V_PARENT_CMS_ID
      FROM COMMONS_TBL
      WHERE CMS_ID = IN_CMS_ID
      ;
      
      SELECT GROUP_NUM  -- 기존 GROUP_NUM 값 
      INTO V_GROUP_NUM
      FROM COMMONS_TBL
      WHERE CMS_ID = IN_CMS_ID
      ;
      
      IF V_CMS_LVL = IN_CMS_LVL AND V_CMS_SEQ < IN_CMS_SEQ AND V_GROUP_NUM = IN_GROUP_NUM THEN 
      -- 같은 레벨에서의 SEQ UPDATE
         --3->5
         UPDATE COMMONS_TBL 
         SET CMS_SEQ = CMS_SEQ - 1
         WHERE CMS_SEQ > V_CMS_SEQ AND CMS_SEQ <= IN_CMS_SEQ --기존에 가진 SEQ
         AND CMS_LVL = IN_CMS_LVL
         AND GROUP_NUM = IN_GROUP_NUM
         ;
         
      ELSE
         
         --5->3
         UPDATE COMMONS_TBL 
         SET CMS_SEQ = CMS_SEQ +1
         WHERE CMS_SEQ >= IN_CMS_SEQ AND CMS_SEQ < V_CMS_SEQ 
         AND CMS_LVL = IN_CMS_LVL
         AND GROUP_NUM = IN_GROUP_NUM
         ;
                           
      END IF;
      
      ------- 다른 레벨에서의 SEQ UPDATE -----------
      --------------------------------------------
            
      IF  V_CMS_LVL > IN_CMS_LVL -- AND V_GROUP_NUM = IN_GROUP_NUM 
         AND V_CMS_SEQ < IN_CMS_SEQ OR V_CMS_SEQ > IN_CMS_SEQ
         
         THEN
         
         -- LVL3이 2로 이동하고 SEQ가 3LVL 4SEQ-->2LVL 3SEQ
            -- 새로 들어간 LVL에서 같거나 큰 SEQ값을 하나씩 늘려줌
         UPDATE COMMONS_TBL
         SET CMS_SEQ = CMS_SEQ + 1
         WHERE CMS_SEQ >= IN_CMS_SEQ
         AND CMS_LVL = IN_CMS_LVL
         --AND GROUP_NUM = IN_GROUP_NUM  ----?
         ;
            -- 빠져나온 LVL의 SEQ값을 하나씩 줄여줌 +  GROUP으로 묶여있음
         UPDATE COMMONS_TBL
         SET CMS_SEQ = CMS_SEQ -1
         WHERE CMS_SEQ > V_CMS_SEQ
         AND CMS_LVL = V_CMS_LVL
         AND GROUP_NUM = V_GROUP_NUM
         ;
      
      ELSE 
         
         --LVL2이 3로 이동하고 SEQ가 2LVL 3SEQ-->3LVL 4SEQ
            -- 새로 들어간 LVL에서 같거나 큰 SEQ값을 하나씩 늘려줌
         UPDATE COMMONS_TBL
         SET CMS_SEQ = CMS_SEQ + 1
         WHERE CMS_SEQ >= IN_CMS_SEQ
         AND CMS_LVL = IN_CMS_LVL
         --AND GROUP_NUM = IN_GROUP_NUM  ----?
         ;
         
         
      END IF;
      
      
   -- 데이터를 입력
      UPDATE COMMONS_TBL
      SET CMS_NAME = IN_CMS_NAME,
         CMS_LVL = IN_CMS_LVL,
         CMS_SEQ = IN_CMS_SEQ,
         PARENT_CMS_ID = IN_PARENT_CMS_ID,
         GROUP_NUM = IN_GROUP_NUM      
      WHERE CMS_ID = IN_CMS_ID 
      ;
      
      
     --------------------------------------------------------  
  END IF; 
  
  END PROC_INS_UP_COMMONS;
   
  
----- COMMONS_TBL DELETE

  PROCEDURE PROC_DEL_COMMONS
  (
   IN_CMS_ID          IN      VARCHAR2,
   IN_CMS_LVL        IN     NUMBER,
   IN_CMS_SEQ        IN     NUMBER
  )
  AS
  
  BEGIN
   
   DELETE FROM COMMONS_TBL
   WHERE CMS_ID = IN_CMS_ID
   ;
   
   UPDATE COMMONS_TBL
   SET CMS_SEQ = CMS_SEQ - 1
   WHERE CMS_SEQ > IN_CMS_SEQ
   AND CMS_LVL = IN_CMS_LVL
   ;
  
  END PROC_DEL_COMMONS;

----- COMMONS_TBL SELECT

  PROCEDURE PROC_SEL_COMMONS
  (
   IN_CMS_ID           IN     VARCHAR2,
   IN_CMS_NAME        IN     VARCHAR2,
   IN_CMS_LVL           IN     NUMBER,
   IN_CMS_SEQ        IN     NUMBER,
   IN_PARENT_CMS_ID     IN       VARCHAR2,
   IN_GROUP_NUM        IN       NUMBER,
   O_CUR            OUT     SYS_REFCURSOR
  )
  AS
  
  BEGIN
   
   OPEN O_CUR FOR
   SELECT CMS_ID, CMS_NAME, CMS_LVL, CMS_SEQ, NVL(PARENT_CMS_ID, '(NULL)'), GROUP_NUM FROM COMMONS_TBL
   WHERE CMS_ID LIKE '%' || IN_CMS_ID || '%'
   AND CMS_NAME LIKE '%' || IN_CMS_NAME || '%'
   AND CMS_LVL LIKE '%' || IN_CMS_LVL || '%'
   AND CMS_SEQ LIKE '%' || IN_CMS_SEQ || '%'
   AND NVL(PARENT_CMS_ID, 0) LIKE '%' || IN_PARENT_CMS_ID || '%'
   AND GROUP_NUM LIKE '%' || IN_GROUP_NUM || '%'
   ;
   
  END PROC_SEL_COMMONS;
  
   /*COMMONS_TBL 업무로직 끝*/
END PKG_COMMONS;

----------------------------------------------PKG_COMMONS_TBL 바디끝
