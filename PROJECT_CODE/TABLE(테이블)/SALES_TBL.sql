CREATE TABLE SALES_TBL
   (   
       S_ID CHAR(4 BYTE), 
        G_ID CHAR(4 BYTE), 
        CT_ID CHAR(5 BYTE), 
        S_DATE DATE, 
        PY_ID CHAR(5 BYTE), 
        S_GET_POINT NUMBER(2,0) DEFAULT 5, 
        S_USE_POINT NUMBER(6,0), 
        S_PROFIT NUMBER(7,0), 
        S_SHOW CHAR(1 BYTE) DEFAULT 'Y', 
        S_W_PURCHASE VARCHAR2(3 BYTE) DEFAULT NULL
   );
   
  ALTER TABLE "SALES_TBL" MODIFY ("S_PROFIT" NOT NULL ENABLE);
  ALTER TABLE "SALES_TBL" MODIFY ("S_SHOW" NOT NULL ENABLE);
  ALTER TABLE "SALES_TBL" MODIFY ("S_ID" NOT NULL ENABLE);
  ALTER TABLE "SALES_TBL" MODIFY ("S_GET_POINT" NOT NULL ENABLE);
  ALTER TABLE "SALES_TBL" MODIFY ("G_ID" NOT NULL ENABLE);
  ALTER TABLE "SALES_TBL" MODIFY ("CT_ID" NOT NULL ENABLE);
  ALTER TABLE "SALES_TBL" MODIFY ("S_DATE" NOT NULL ENABLE);
  ALTER TABLE "SALES_TBL" MODIFY ("PY_ID" NOT NULL ENABLE);
  ALTER TABLE "SALES_TBL" ADD CONSTRAINT "SALES_TBL_PK" PRIMARY KEY ("S_ID");



INSERT INTO SALES_TBL(S_ID, G_ID, CT_ID, S_DATE, PY_ID, S_GET_POINT, S_USE_POINT, S_PROFIT, S_SHOW, S_W_PURCHASE)
VALUES('S001','G001','CT001','21/05/07','PY006',5,0,20370,'Y', NULL);

INSERT INTO SALES_TBL(S_ID, G_ID, CT_ID, S_DATE, PY_ID, S_GET_POINT, S_USE_POINT, S_PROFIT, S_SHOW, S_W_PURCHASE)
VALUES('S002','G002','CT003','21/05/07','PY006',5,5000,20220,'Y', NULL);

INSERT INTO SALES_TBL(S_ID, G_ID, CT_ID, S_DATE, PY_ID, S_GET_POINT, S_USE_POINT, S_PROFIT, S_SHOW, S_W_PURCHASE)
VALUES('S003','G003','CT011','21/05/07','PY014',5,0,30400,'Y', NULL);

INSERT INTO SALES_TBL(S_ID, G_ID, CT_ID, S_DATE, PY_ID, S_GET_POINT, S_USE_POINT, S_PROFIT, S_SHOW, S_W_PURCHASE)
VALUES('S004','G009','CT005','21/05/07','PY017',5,0,43245,'Y', NULL);

INSERT INTO SALES_TBL(S_ID, G_ID, CT_ID, S_DATE, PY_ID, S_GET_POINT, S_USE_POINT, S_PROFIT, S_SHOW, S_W_PURCHASE)
VALUES('S005','G005','CT002','21/05/07','PY017',5,5000,115,'Y', NULL);

INSERT INTO SALES_TBL(S_ID, G_ID, CT_ID, S_DATE, PY_ID, S_GET_POINT, S_USE_POINT, S_PROFIT, S_SHOW, S_W_PURCHASE)
VALUES('S006','G010','CT006','21/05/07','PY013',5,0,20370,'Y', NULL);

INSERT INTO SALES_TBL(S_ID, G_ID, CT_ID, S_DATE, PY_ID, S_GET_POINT, S_USE_POINT, S_PROFIT, S_SHOW, S_W_PURCHASE)
VALUES('S007','G004','CT003','21/05/07','PY013',5,1000,33920,'Y', NULL);

INSERT INTO SALES_TBL(S_ID, G_ID, CT_ID, S_DATE, PY_ID, S_GET_POINT, S_USE_POINT, S_PROFIT, S_SHOW, S_W_PURCHASE)
VALUES('S008','G007','CT010','21/05/07','PY008',5,0,42680,'Y', NULL);

INSERT INTO SALES_TBL(S_ID, G_ID, CT_ID, S_DATE, PY_ID, S_GET_POINT, S_USE_POINT, S_PROFIT, S_SHOW, S_W_PURCHASE)
VALUES('S009','G009','CT012','21/05/07','PY013',5,0,43710,'Y', NULL);

INSERT INTO SALES_TBL(S_ID, G_ID, CT_ID, S_DATE, PY_ID, S_GET_POINT, S_USE_POINT, S_PROFIT, S_SHOW, S_W_PURCHASE)
VALUES('S010','G001','CT002','21/05/07','PY013',5,3000,16950,'Y', NULL);


SELECT * FROM SALES_TBL;
--COMMIT;
