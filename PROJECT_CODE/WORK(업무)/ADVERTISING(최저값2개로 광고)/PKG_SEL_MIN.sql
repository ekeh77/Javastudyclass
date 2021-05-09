--------------------------------------AD 헤드 시작
create or replace NONEDITIONABLE PACKAGE PKG_SEL_MIN 
AS 

 PROCEDURE PROC_SEL_SALES_MIN
  (
   IN_G_ID      IN      VARCHAR2,
   IN_S_PROFIT    IN    NUMBER,
   O_CUR         OUT    SYS_REFCURSOR
  );
  

 PROCEDURE PROC_SEL_COUNT_MIN
  (
   IN_G_ID      IN      VARCHAR2,
   IN_S_PROFIT    IN    NUMBER,
   O_CUR         OUT    SYS_REFCURSOR
  );


END PKG_SEL_MIN;
--------------------------------------AD 헤드 끝

--------------------------------------AD 바디 시작
create or replace NONEDITIONABLE PACKAGE BODY PKG_SEL_MIN AS

  PROCEDURE PROC_SEL_SALES_MIN
  (
   IN_G_ID      IN      VARCHAR2,
   IN_S_PROFIT    IN    NUMBER,
   O_CUR         OUT    SYS_REFCURSOR
  ) 
  AS
  BEGIN
       OPEN O_CUR FOR
      SELECT G_ID, 최저매출순위 
      FROM (
         SELECT  G_ID ,SUM(S_PROFIT),
               RANK () OVER(ORDER BY SUM(S_PROFIT) ASC)  AS 최저매출순위
         FROM SALES_TBL
         GROUP BY G_ID
         )
      WHERE 최저매출순위 = 1
      ;
  END PROC_SEL_SALES_MIN;

  PROCEDURE PROC_SEL_COUNT_MIN
  (
   IN_G_ID      IN      VARCHAR2,
   IN_S_PROFIT    IN    NUMBER,
   O_CUR         OUT    SYS_REFCURSOR
  ) AS
  BEGIN
    -- 횟수 기준
      OPEN O_CUR FOR
      SELECT G_ID, 최저판매횟수순위
      FROM (
            SELECT  G_ID , COUNT(*),
                  RANK () OVER(ORDER BY COUNT(*) ASC)  AS 최저판매횟수순위
            FROM SALES_TBL
            GROUP BY G_ID
            )
      WHERE 최저판매횟수순위 = 1
      ;
  END PROC_SEL_COUNT_MIN;

END PKG_SEL_MIN;
--------------------------------------AD 바디 끝