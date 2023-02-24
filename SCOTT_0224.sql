/* 230224 FRI */
/* 데이터 사전 */
-- 오라클 데이터베이스 테이블은 사용자 테이블과 데이터 사전으로 나누어 짐
-- 데이터 사전에는 데이터베이스 메모리, 성능, 사용자, 권한, 객체 등 오라클
-- 데이터베이스 운영에 중요한 데이터가 보관 되어 있습니다.
-- 데이터 사전 정보에 접근하거나 변경하는 등의 작업을 할 수 없고 오로지 정보 열람만 가능

SELECT * FROM DICT;
SELECT * FROM DICTIONARY;

-- 사용자가 소유한 객체 정보가 보관되어있음
SELECT TABLE_NAME FROM USER_TABLES; 

-- ALL_접두어를 가진 데이터 사전은 오라클데이터베이스에 접속해 있는 사용자가 소유한 객체 및 다른 사용자가 소유한 객체 중 사용이 허락되어 있는 객체정보
SELECT OWNER, TABLE_NAME
    FROM ALL_TABLES;

-- DBA_접두어를 가진 데이터 사전은 데이터베이스관리 권한을 가진 사용자만 조회할 수 있는 테이블로서 SCOTT 계정으로는 조회 불가능
SELECT * FROM DBA_TABLES; -- 존재여부도 알려주지 않음

/* 인덱스 */
--  오라클 데이터베이스에서 데이터 검색 성능의 향상을 위해 테이블 열에 사용하는 객체
SELECT ROWID FROM EMP;

SELECT * FROM USER_INDEXES;

/* 인덱스 생성 */
-- 오라클 데이터베이스에서 자동으로 생성해 주는 인덱스 외에 사용자가 직접 인덱스를 만들 때 사용
CREATE INDEX IDX_EMP_SAL ON EMP(SAL);

-- 생성된 인덱스 확인하기
SELECT * FROM USER_IND_COLUMNS;

-- 복합 인덱스 생성하기 : 두 개 이상의 컬럼으로 인덱스 생성 (최대 32개가지 가능)
CREATE INDEX IDX_EMP_TUPLE ON EMP(JOB, DEPTNO);

-- 유니크 (UNIQUE) 인덱스 생성 : 유니크 (UNIQUE) 인덱스를 생성하면 인덱스 지정된 컬럼은 해당 테이블에서 유일한 값이어야 함.
-- 꼭 필요한 경우가 아니면 사용하지 말 것
CREATE UNIQUE INDEX IDX_RMP_UK ON EMP(EMPNO, MGR);

-- 인덱스 삭제 : DROP
DROP INDEX IDX_EMP_SAL;

/* VIEW */
-- 가상테이블
-- 뷰는 하나 이상의 테이블을 조회하는 SELECT문을 저장한 객체
-- 뷰는 복잡한 쿼리를 단순화 할 수 있음
-- 사용자에게 필요한 정보만 접근하도록 접근을 제한 할 수 있음

CREATE VIEW VW_EMP20
    AS (SELECT EMPNO, ENAME, JOB, DEPTNO
            FROM EMP
            WHERE DEPTNO = 20);
            
SELECT * FROM VW_EMP20;

/* 단순 뷰 생성 하기 */
-- 단순 뷰는 단일 테이블에 필요한 컬럼을 나열 한 것 (GROUP BY, UNION 사용하지 않음)
-- 단순 뷰는 SELECT, INSERT, UPDATE, DELETE를 자유롭게 사용 간으
CREATE VIEW V_EMP
    AS (SELECT EMPNO, ENAME, JOB, HIREDATE
            FROM EMP);

SELECT * FROM V_EMP;

DROP VIEW VW_EMP20;

/* 인라인뷰를 사용한 TOP-N SQL 문 */
-- TOP-N 쿼리란 데이터베이스에서 가장 큰 N개의 값을 검색하는 쿼리를 의미
SELECT ROWNUM, E.*
    FROM EMP E;

-- 인라인뷰 (서브쿼리 이용)
SELECT ROWNUM, E.*
    FROM (SELECT *
            FROM EMP E
            ORDER BY SAL DESC) E;
            
-- 인라인뷰로 TOP-N 추출하기
SELECT ROWNUM, E.*
    FROM (SELECT *
            FROM EMP E
            ORDER BY SAL DESC) E
    WHERE ROWNUM <= 3;
    
/* VIEW를 통한 DML문 실행 */
CREATE  VIEW EMP_COPY_VIEW
    AS SELECT EMPNO, ENAME, DEPTNO
    FROM EMP;
    
SELECT * FROM EMP_COPY_VIEW;

INSERT INTO EMP_COPY_VIEW VALUES(9999, '연쥬', 20);

UPDATE EMP_COPY_VIEW 
    SET DEPTNO = 30 
    WHERE DEPTNO = 20;
    
   