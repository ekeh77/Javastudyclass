  CREATE TABLE REVIEW_TBL
  (
        RV_ID                            CHAR(5)                           PRIMARY KEY,
        S_ID                            CHAR(4)                             NOT NULL,
        RV_SCORE                NUMBER(1,0)                         NOT NULL, 
        RV_DATE                     DATE                                    NOT NULL, 
        RV_COMMENT          VARCHAR2(200)                DEFAULT NULL, 
        RV_SHOW                     VARCHAR2(20)                DEFAULT 'Y'                 NOT NULL
  )