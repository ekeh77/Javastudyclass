
--아래의 데이터를 분석하고
--학생들은 반드시 6과목 시험을 쳐야 한다.
--국어와 수학은 두개의 시험중 1개의 시험만 골라서 치면된다.
--시험을 치지 않은 과목은 0점 처리한다.

CREATE TABLE STUDENTS
(
    SID     CHAR(4)         NOT NULL  PRIMARY KEY,
    SNAME   VARCHAR2(30)    NOT NULL,
    STEL    VARCHAR2(20)    NOT NULL,
    SADDR   VARCHAR2(10)    NOT NULL,
    SGENDER CHAR(1)         NOT NULL, 
    SAGE     NUMBER(3)       NOT NULL
);

    INSERT INTO STUDENTS VALUES('S001', '김돌우', '01077778888', '부산', 'M', 24);
    INSERT INTO STUDENTS VALUES('S002', '박영익', '01055556666', '울산', 'M', 27);
    INSERT INTO STUDENTS VALUES('S003', '도소욱', '01088887777', '부산', 'M', 28);
    INSERT INTO STUDENTS VALUES('S004', '정미주', '01055554444', '부산', 'F', 22);
    INSERT INTO STUDENTS VALUES('S005', '김기윤', '01077775555', '창원', 'M', 21);
    INSERT INTO STUDENTS VALUES('S006', '이효진', '01066669999', '창원', 'F', 25);
    INSERT INTO STUDENTS VALUES('S007', '강신욱', '01044447777', '부산', 'M', 23);
    INSERT INTO STUDENTS VALUES('S008', '박범식', '01099998888', '울산', 'M', 27);
    INSERT INTO STUDENTS VALUES('S009', '여인순', '01051477787', '부산', 'F', 31);
    INSERT INTO STUDENTS VALUES('S010', '최순애', '01078974444', '김해', 'F', 32);
    
    
CREATE TABLE PROFESSORS
(
    PID     CHAR(4)         NOT NULL  PRIMARY KEY,
    PNAME   VARCHAR2(30)    NOT NULL,
    PTEL    VARCHAR2(20)    NOT NULL,
    PADDR   VARCHAR2(10)    NOT NULL,
    PGENDER CHAR(1)         NOT NULL,
    BIRTH   VARCHAR2(8)     NOT NULL
);
    
    INSERT INTO PROFESSORS VALUES('P001','최국일','01099996566','부산','M','19730804');
    INSERT INTO PROFESSORS VALUES('P002','경승수','01077148888','부산','M','19710109');
    INSERT INTO PROFESSORS VALUES('P003','박수연','01055414444','부산','F','19780214');
    INSERT INTO PROFESSORS VALUES('P004','김경순','01024147784','울산','F','19801222');
    INSERT INTO PROFESSORS VALUES('P005','박수걸','01074145887','울산','M','19770505');
    INSERT INTO PROFESSORS VALUES('P006','도인중','01021444444','창원','M','19781128');
    INSERT INTO PROFESSORS VALUES('P007','이수영','01057414414','김해','F','19800107');
    INSERT INTO PROFESSORS VALUES('P008','이국중','01092417984','창원','M','19730309');
    INSERT INTO PROFESSORS VALUES('P009','박도우','01092417984','김해','M','19801009');
    INSERT INTO PROFESSORS VALUES('P010','이연수','01092417984','부산','F','19820509');
    
CREATE TABLE SUBJECTS
(
    SUBID     CHAR(4)         NOT NULL PRIMARY KEY,
    SNAME   VARCHAR2(30)    NOT NULL,
    GRADE   NUMBER(3)       NOT NULL               --학점
);

    INSERT INTO SUBJECTS VALUES('S001','국어',3);
    INSERT INTO SUBJECTS VALUES('S002','수학',3);
    INSERT INTO SUBJECTS VALUES('S003','영어',3);
    INSERT INTO SUBJECTS VALUES('S004','과학',2);
    INSERT INTO SUBJECTS VALUES('S005','사회',2);
    INSERT INTO SUBJECTS VALUES('S006','음악',1);
    
    
CREATE TABLE EMAMS
(
    PID        CHAR(4)          NOT NULL,
    SUBID      CHAR(4)          NOT NULL,
    ENAME      VARCHAR2(30)     NOT NULL
);

    INSERT INTO EMAMS VALUES('P001','S001','국어1 시험');
    INSERT INTO EMAMS VALUES('P002','S001','국어2 시험');
    INSERT INTO EMAMS VALUES('P003','S002','수학1 시험');
    INSERT INTO EMAMS VALUES('P004','S002','수학2 시험');
    INSERT INTO EMAMS VALUES('P005','S003','영어 시험');
    INSERT INTO EMAMS VALUES('P006','S004','과학 시험');
    INSERT INTO EMAMS VALUES('P007','S005','사회 시험');
    INSERT INTO EMAMS VALUES('P008','S006','음악 시험');
    
CREATE TABLE SCORES
(
    SID         CHAR(4)             NOT NULL,
    PID         CHAR(4)             NOT NULL,
    SUBID       CHAR(4)             NOT NULL,
    SCIDX       NUMBER(5)           NOT NULL,
    SCORE       NUMBER(5,2)         NOT NULL
);

    --김돌우
    INSERT INTO EXAMS VALUES('S001', 'P001', 'S001', 1, 91.12);
    INSERT INTO EXAMS VALUES('S001', 'P003', 'S002', 1, 78.67);                             
    INSERT INTO EXAMS VALUES('S001', 'P005', 'S003', 1, 86.45);
    INSERT INTO EXAMS VALUES('S001', 'P006', 'S004', 1, 80.67);
    INSERT INTO EXAMS VALUES('S001', 'P007', 'S005', 1, 90);
    INSERT INTO EXAMS VALUES('S001', 'P008', 'S006', 1, 77);
    
    --박영익
    INSERT INTO EXAMS VALUES('S002', 'P002', 'S001', 1, 69);
    INSERT INTO EXAMS VALUES('S002', 'P003', 'S002', 1, 98);                             
    INSERT INTO EXAMS VALUES('S002', 'P005', 'S003', 1, 56);
    INSERT INTO EXAMS VALUES('S002', 'P006', 'S004', 1, 78);
    INSERT INTO EXAMS VALUES('S002', 'P007', 'S005', 1, 87.90);
    INSERT INTO EXAMS VALUES('S002', 'P008', 'S006', 1, 76.20);
    
    --도소욱
    INSERT INTO EXAMS VALUES('S003', 'P002', 'S001', 1, 65.44);
    INSERT INTO EXAMS VALUES('S003', 'P003', 'S002', 1, 78.09);                             
    INSERT INTO EXAMS VALUES('S003', 'P006', 'S004', 1, 88);
    INSERT INTO EXAMS VALUES('S003', 'P007', 'S005', 1, 56);
    INSERT INTO EXAMS VALUES('S003', 'P008', 'S006', 1, 78);

    --정미주
    INSERT INTO EXAMS VALUES('S004', 'P002', 'S001', 1, 90);
    INSERT INTO EXAMS VALUES('S004', 'P004', 'S002', 1, 77);                             
    INSERT INTO EXAMS VALUES('S004', 'P005', 'S003', 1, 90);
    INSERT INTO EXAMS VALUES('S004', 'P006', 'S004', 1, 94);
    INSERT INTO EXAMS VALUES('S004', 'P007', 'S005', 1, 76.44);
    INSERT INTO EXAMS VALUES('S004', 'P008', 'S006', 1, 87.45);
    
    --김기윤
    INSERT INTO EXAMS VALUES('S005', 'P001', 'S001', 1, 77.45);
    INSERT INTO EXAMS VALUES('S005', 'P004', 'S002', 1, 99);                             
    INSERT INTO EXAMS VALUES('S005', 'P005', 'S003', 1, 87);
    INSERT INTO EXAMS VALUES('S005', 'P006', 'S004', 1, 78);
    

    --이효진
    INSERT INTO EXAMS VALUES('S006', 'P001', 'S001', 1, 77);
    INSERT INTO EXAMS VALUES('S006', 'P004', 'S002', 1, 65);                             
    INSERT INTO EXAMS VALUES('S006', 'P005', 'S003', 1, 54);
    INSERT INTO EXAMS VALUES('S006', 'P006', 'S004', 1, 77.44);
    INSERT INTO EXAMS VALUES('S006', 'P007', 'S005', 1, 80.87);
    INSERT INTO EXAMS VALUES('S006', 'P008', 'S006', 1, 98);
    
    
    --강신욱
    INSERT INTO EXAMS VALUES('S008', 'P002', 'S001', 1, 90);
    INSERT INTO EXAMS VALUES('S008', 'P004', 'S002', 1, 88.67);                             
    INSERT INTO EXAMS VALUES('S008', 'P005', 'S003', 1, 67.56);
    INSERT INTO EXAMS VALUES('S008', 'P006', 'S004', 1, 90);
    INSERT INTO EXAMS VALUES('S008', 'P007', 'S005', 1, 71.11);
    INSERT INTO EXAMS VALUES('S008', 'P008', 'S006', 1, 87.45);
    
    --박범식
    INSERT INTO EXAMS VALUES('S009', 'P001', 'S001', 1, 65);
    INSERT INTO EXAMS VALUES('S009', 'P004', 'S002', 1, 56.67);                             
    INSERT INTO EXAMS VALUES('S009', 'P005', 'S003', 1, 77);
    INSERT INTO EXAMS VALUES('S009', 'P006', 'S004', 1, 82);
    INSERT INTO EXAMS VALUES('S009', 'P007', 'S005', 1, 83.09);
    INSERT INTO EXAMS VALUES('S009', 'P008', 'S006', 1, 93);
    
    --여인순
    INSERT INTO EXAMS VALUES('S001', 'P001', 'S001', 1, 56);
    INSERT INTO EXAMS VALUES('S001', 'P004', 'S002', 1, 97);                             
    INSERT INTO EXAMS VALUES('S001', 'P005', 'S003', 1, 57);
    INSERT INTO EXAMS VALUES('S001', 'P006', 'S004', 1, 90);
    INSERT INTO EXAMS VALUES('S001', 'P007', 'S005', 1, 76);
    INSERT INTO EXAMS VALUES('S001', 'P008', 'S006', 1, 84);
    
    --최순애
    INSERT INTO EXAMS VALUES('S001', 'P001', 'S001', 1, 78);
    INSERT INTO EXAMS VALUES('S001', 'P003', 'S002', 1, 89);                             
    INSERT INTO EXAMS VALUES('S001', 'P006', 'S004', 1, 78.56);
    INSERT INTO EXAMS VALUES('S001', 'P007', 'S005', 1, 80.88);
    INSERT INTO EXAMS VALUES('S001', 'P008', 'S006', 1, 98);
    
    
    --1. 각 교수별 시험출제 현황 리스트를 보여주세요
    --(교수이름, 과목명, 시험명)
    
    --2. 지역별 학생수 리스트를 보여주세요
    
    --3. 지역별 교수숫자 리스트를 보여주세요
    
    --4  국어시험 1을 국어시험으로 치른 학생 리스트를 보여주세요
    
    --5. 부산에 사는 학생들의 영어시험 평균과 총점을 리스트로 보여주세요
    
    --6. 남자 교수님들이 출제한 시험의 총점과 평균을 구해주세요
    
    --7. 각 학생별로 시험을 치룬 과목수를 리스트로 보여주세요
    
    --8. 1980년대생 교수들이 출제한 과목을 리스트로 보여주세요
    
    --9. 시험출제를 하지 않은 교수를 보여주세요
    
    --10. 여자교수님들이 출제한 시험의 총점과 평균을 구해주세요
    
    --11. 20대 여학생이 치른 시험의 총점과 평균을 구해주세요
    
    --12. 각 지역별로 학생들의 총점과 평균을 구해주세요
    
    --13. 각 과목(시험아님)별로 평균점수를 구해주세요
    
    --14. 모든학생들의 총점과 평균 점수를 보여주세요
    
    --15. 각 교수별로 출제한 시험의 평균 점수를 보여주세요
    
    --16. 시험별로 시험을 치르지 않은 학생 리스트를 보여주세요
    
    --17. 평균점수가 가장 높은 시험의 가장높은 점수를 받은 학생을 찾아주세요
    
    --18. 평균점수가 가장 낮은 시험의 가장낮은 점수를 받은 학생을 찾아주세요
    
    --19. 60점미만이면 재시험이라고 하면 재시험을 쳐야 하는 시험과 학생수를 보여주세요
    
    --20. 가장 평균이 높은 시험을 출제한 교수가 사는 지역에 살고 있는 학생리스트를 보여주세요