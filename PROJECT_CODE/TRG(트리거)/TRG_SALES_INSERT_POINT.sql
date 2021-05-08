create or replace NONEDITIONABLE TRIGGER TRG_SALES_INSERT_POINT 
AFTER INSERT ON SALES_TBL 
REFERENCING OLD AS O NEW AS N 
FOR EACH ROW 
BEGIN
   IF :N.S_USE_POINT = 0
                THEN
                        INSERT INTO POINT_TBL
                        (PT_ID, S_ID, CT_ID, PT_SCORE, PT_SAVE_USE, PT_DATE, PT_SHOW)
                        VALUES
                        (FUNC_SALES_INSERT_PT_ID(), :N.S_ID, :N.CT_ID, :N.S_PROFIT * (:N.S_GET_POINT / 100), 'S', SYSDATE, 'Y')
                        ;
                ELSE       
                
                        INSERT INTO POINT_TBL
                        (PT_ID, S_ID, CT_ID, PT_SCORE, PT_SAVE_USE, PT_DATE, PT_SHOW)
                        VALUES
                        (FUNC_SALES_INSERT_PT_ID(), :N.S_ID, :N.CT_ID, :N.S_USE_POINT, 'U', SYSDATE, 'Y')
                        ;
                
                        INSERT INTO POINT_TBL
                        (PT_ID, S_ID, CT_ID, PT_SCORE, PT_SAVE_USE, PT_DATE, PT_SHOW)
                        VALUES
                        (FUNC_SALES_INSERT_PT_ID(), :N.S_ID, :N.CT_ID, :N.S_PROFIT * (:N.S_GET_POINT / 100), 'S', SYSDATE, 'Y')
                        ;
                        
                END IF;
END;