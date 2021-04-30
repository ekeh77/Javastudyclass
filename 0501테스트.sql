CREATE TABLE CUSTOMER_TBL
(
    CT_ID       CHAR(5)                         PRIMARY KEY, -- CUSTOMER�� ID
    CT_NAME     VARCHAR2(30)                    NOT NULL,    -- CUSTOMER�� �̸�
    CT_BIRTH    VARCHAR2(24)                    NOT NULL,    -- CUSTOMER�� �������
    CT_REGION   CHAR(6)                         NOT NULL,    -- CUSTOMER�� ����
    CT_GENDER   CHAR(1)                         NOT NULL,    -- CUSTOMER�� ����
    CT_C_NUM    VARCHAR2(33)                    NOT NULL,    -- CUSTOMER�� ��ȭ��ȣ
    CT_POINT    NUMBER(10)      DEFAULT 0       NULL,        -- CUSTOMER�� ����Ʈ
    CT_GRADE    VARCHAR2(30)                    NULL,        -- CUSTOMER�� ���
    CT_SHOW     CHAR(1)         DEFAULT 'Y'     NOT NULL     -- CUSTOMER�� ��������
);

CREATE TABLE APPLY_TBL
(
    A_ID        CHAR(4)                    NOT NULL,   -- ��û ID
    A_INDEX     NUMBER(7)                  NOT NULL,   -- ��û �ε���
    G_R_ID      CHAR(5)                    NOT NULL,   -- ������� ID
    CT_ID        CHAR(5)                   NOT NULL,   -- �� ID
    S_DATE      DATE                       NOT NULL,   -- ��û ��¥
    PY_ID       CHAR(5)                    NOT NULL,   -- ������ ������� ID
    A_SHOW      CHAR(1)    DEFAULT 'Y'     NOT NULL    -- ��û���̺��ǻ�������
);