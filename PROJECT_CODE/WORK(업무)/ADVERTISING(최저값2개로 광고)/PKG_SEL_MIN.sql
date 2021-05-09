--------------------------------------AD ��� ����
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
--------------------------------------AD ��� ��

--------------------------------------AD �ٵ� ����
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
      SELECT G_ID, ����������� 
      FROM (
         SELECT  G_ID ,SUM(S_PROFIT),
               RANK () OVER(ORDER BY SUM(S_PROFIT) ASC)  AS �����������
         FROM SALES_TBL
         GROUP BY G_ID
         )
      WHERE ����������� = 1
      ;
  END PROC_SEL_SALES_MIN;

  PROCEDURE PROC_SEL_COUNT_MIN
  (
   IN_G_ID      IN      VARCHAR2,
   IN_S_PROFIT    IN    NUMBER,
   O_CUR         OUT    SYS_REFCURSOR
  ) AS
  BEGIN
    -- Ƚ�� ����
      OPEN O_CUR FOR
      SELECT G_ID, �����Ǹ�Ƚ������
      FROM (
            SELECT  G_ID , COUNT(*),
                  RANK () OVER(ORDER BY COUNT(*) ASC)  AS �����Ǹ�Ƚ������
            FROM SALES_TBL
            GROUP BY G_ID
            )
      WHERE �����Ǹ�Ƚ������ = 1
      ;
  END PROC_SEL_COUNT_MIN;

END PKG_SEL_MIN;
--------------------------------------AD �ٵ� ��