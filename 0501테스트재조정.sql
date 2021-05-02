
create or replace NONEDITIONABLE PACKAGE PKG_APPLY_TBL AS 

  /* ��û(APPLY_TBL)���̺� ���ν��� ���� */
  
   --��û���̺� SELECT ���ν��� ����
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
   --��û���̺� SELECT ���ν��� ��
  
  --��û���̺� INSERT ���ν��� ����
  PROCEDURE PROC_INSERT_APPLY_TBL
  (
    IN_G_R_ID       IN      VARCHAR2,
    IN_CT_ID        IN      VARCHAR2,
    IN_PY_ID        IN      VARCHAR2
  );
  --��û���̺� INSERT ���ν��� ��
  
  --��û���̺� UPDATE ���ν��� ����
  PROCEDURE PROC_UPDATE_APPLY_TBL
  (
    IN_A_ID         IN      VARCHAR2,
    IN_A_INDEX      IN      VARCHAR2,
    IN_G_R_ID       IN      VARCHAR2
  );
  --��û���̺� UPDATE ���ν��� ��
  
  --��û���̺� DELETE ���ν��� ����
  PROCEDURE PROC_DELETE_APPLY_TBL
  (
    IN_A_ID       IN      VARCHAR2,
    IN_A_INDEX    IN      VARCHAR2
  );
  --��û���̺� DELETE ���ν��� ��
  
  /* ��û(APPLY_TBL)���̺� ���ν��� �� */
END PKG_APPLY_TBL;

--------------------------------------------------

create or replace NONEDITIONABLE PACKAGE BODY PKG_APPLY_TBL AS

/* ��û(APPLY_TBL)���̺� ���ν��� ���� */
  
   --��û���̺� SELECT ���ν��� ����
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
    --���ǿ� �ش��ϰ��� ������ ã�� �ƴϸ� �׳� ROW�� ã������ ����
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
 --��û���̺� SELECT ���ν��� ��
  
   --��û���̺� INSERT ���ν��� ����
  PROCEDURE PROC_INSERT_APPLY_TBL
  (
    IN_G_R_ID       IN      VARCHAR2,
    IN_CT_ID        IN      VARCHAR2,
    IN_PY_ID        IN      VARCHAR2
  )
  AS
    V_NEW_A_ID          CHAR(4);    --��û ID����
    V_NEW_A_INDEX        NUMBER(7);  --��û INDEX����
  BEGIN
    
    --���ο� ��û ID ����
    SELECT 'A' || TO_CHAR(TO_NUMBER(SUBSTR(NVL(MAX(A_ID),'A000'),2)) +1,'FM000')
    INTO V_NEW_A_ID
    FROM APPLY_TBL
    ;
    
    --INDEX�� ������ ���Ӱ� ���� ù ���Ŷ�� 1 ���� ���Ӱ� ���� �ι�° ���Ž� 2�� ������ �ϱ�
    
    SELECT NVL(MAX(A_INDEX),0)
    INTO V_NEW_A_INDEX
    FROM APPLY_TBL
    WHERE G_R_ID = IN_G_R_ID AND CT_ID = IN_CT_ID
    ;
    
    IF V_NEW_A_INDEX != 0 THEN --���� ���ӹ� ���� ù ���Ű� �ƴ� ���
    
    INSERT INTO APPLY_TBL(A_ID, A_INDEX, G_R_ID, CT_ID, S_DATE, PY_ID, A_SHOW)
    VALUES (V_NEW_A_ID, V_NEW_A_INDEX + 1, IN_G_R_ID, IN_CT_ID, SYSDATE, IN_PY_ID, 'Y')
    ;
    
    ELSE --���� ���ӹ� ���� ù ������ ���
    
    INSERT INTO APPLY_TBL(A_ID, A_INDEX, G_R_ID, CT_ID, S_DATE, PY_ID, A_SHOW)
    VALUES (V_NEW_A_ID, 1, IN_G_R_ID, IN_CT_ID, SYSDATE, IN_PY_ID, 'Y')
    ;
    
    END IF
    ;
    
    
  END PROC_INSERT_APPLY_TBL;
  --��û���̺� INSERT ���ν��� ��
  
  --��û���̺� UPDATE ���ν��� ���� > ��������Ͽ� ����Ѱ�� �������̺�� �̵�
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
  
    -- ����������� �����´� 
    SELECT G_DATE
    INTO V_GAME_DATE
    FROM GAME_TBL
    WHERE G_ID = IN_G_R_ID
    ;
    
    -- SALES_TBL�� SID�� ���Ѵ�
    SELECT 'S' || TO_CHAR(TO_NUMBER(NVL(MAX(S_ID), 'S000'))+1,'FM000')
    INTO V_NEW_S_ID
    FROM SALES_TBL
    ;
    
    --APPLY DATA�� ������������ ����
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
    
    --���糯¥�� ����������� ��
    IF  TO_DATE(V_GAME_DATE) >= SYSDATE THEN
    
        INSERT INTO SALES_TBL(S_ID, S_INDEX, G_ID, CT_ID, S_DATE, PY_ID)
        VALUES (V_NEW_S_ID, 1, V_APPLY_G_ID, V_APPLY_CT_ID, SYSDATE, V_APPLY_PY_ID)
        ;
    
    END IF;
    
  END
  ;
  --��û���̺� UPDATE ���ν��� ��
  
   --��û���̺� DELETE ���ν��� ���� > ��û ��ҿ� ���� �ǹ�
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
  --��û���̺� DELETE ���ν��� ��
  
  /* ��û(APPLY_TBL)���̺� ���ν��� �� */

END PKG_APPLY_TBL;