/* 230220 MON */

/* ANSI JOIN */
-- 동등조인 : NATURAL JOIN, JOIN ~ USING, JOIN ~ ON
/* NATURAL JOIN : 동등 조인과 비슷하지만 WHERE조건절 없이 조인 */
-- 두 테이블의 동일한 이름(컬럼 또는 열)을 갖는 컬럼은 모두 조인 됨
-- DEPTNO 열이 양쪽 테이블에 모두 존재

SELECT EMPNO, ENAME, DNAME
    FROM EMP NATURAL JOIN DEPT;

-- 일반적인 공동 조인의 경우 아래의 쿼리문이 에러가 발생 함; DEPTNO가 어디 소속인지 모호성이 발생하기 때문에
SELECT EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO, DNAME, LOC
    FROM EMP NATURAL JOIN DEPT
    ORDER BY DEPTNO, EMPNO;


/* JOIN ~ USING : 기존의 등가 조인을 대신하는 조인 방식 */
-- FROM TABLE1 JOIN TABLE2 USING (기준열)
SELECT EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO,DNAME, LOC
    FROM EMP JOIN DEPT USING(DEPTNO)
    WHERE SAL >= 3000
    ORDER BY DEPTNO, EMPNO;
    
/* JOIN ~ ON : 가장 범용성 있는 JOIN ~ ON 키워드를 사용하는 조인 방식 */
-- FROM TABLE1 JOIN TABLE2 ON(조인 조건식)
SELECT EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, E.DEPTNO, DNAME, LOC -- 출력할때에 중복 값은 어떤 값기준이 되는지 꼭 넣어줘야함
    FROM EMP E JOIN DEPT D 
    ON E.DEPTNO = D.DEPTNO
    WHERE SAL <= 3000
    ORDER BY E.DEPTNO, EMPNO;

/* ANSI OUTER JOIN */
-- LEFT OUTER JOIN : 왼쪽 테이블 기준으로 오른쪽 테이블의 모든 행이 출력 됨

-- ORACLE
SELECT EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, E.DEPTNO, DNAME, LOC
    FROM EMP E, DEPT D
    WHERE E.DEPTNO = D.DEPTNO(+); -- 오른쪽에 채워 넣어라
    
-- ANSI
SELECT EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, E.DEPTNO, DNAME, LOC
    FROM EMP E LEFT OUTER JOIN DEPT D
    ON E.DEPTNO = D.DEPTNO;

-- RIGHT OUTER JOIN : 오른쪽 테이블 기준으로 왼쪽 테이블의 모든 행이 출력
-- ORACLE
SELECT EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, E.DEPTNO, DNAME, LOC
    FROM EMP E, DEPT D
    WHERE E.DEPTNO(+) = D.DEPTNO;

-- ANSI
SELECT EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, E.DEPTNO, DNAME, LOC
    FROM EMP E RIGHT OUTER JOIN DEPT D
    ON E.DEPTNO = D.DEPTNO;

/* 연습 문제 */
-- 1. 급여(SAL)가 2000 초과인 사원들의 부서 정보, 사원 정보를 부서번호, 부서이름, 사원이름, 급여 표시
-- 오라클 문법과 ANSI 문법으로 표시(NATURAL, JOIN ~ USING, JOIN ~ ON)
-- ORACLE
SELECT E.DEPTNO, DNAME, ENAME, SAL
    FROM EMP E, DEPT D
    WHERE E.DEPTNO = D.DEPTNO
    AND SAL > 2000;
-- NATURAL
SELECT DEPTNO, DNAME, ENAME, SAL
    FROM EMP NATURAL JOIN DEPT
    WHERE SAL > 2000;
-- JOIN ~ USING
SELECT DEPTNO, DNAME, ENAME, SAL
    FROM EMP JOIN DEPT USING(DEPTNO)
    WHERE SAL >2000;
-- JOIN ~ ON
SELECT E.DEPTNO, DNAME, ENAME, SAL
    FROM EMP E JOIN DEPT D
    ON E.DEPTNO = D.DEPTNO
    WHERE SAL > 2000;
    
-- 2.각 부서별 부서번호, 부서이름, 평균 급여, 최대 급여, 최소 급여, 사원수 출력
-- 오라클 문법과 ANSI 문법으로 표시(NATURAL, JOIN ~ USING, JOIN ~ ON)
-- ORACLE
SELECT E.DEPTNO, DNAME, TRUNC(AVG(SAL)) AS 평균급여, MAX(SAL) 최대급여, MIN(SAL) 최소급여, COUNT(*) 사원수
    FROM EMP E, DEPT D
    WHERE E.DEPTNO = D.DEPTNO
    GROUP BY E.DEPTNO, DNAME;
       

-- NATURAL
SELECT E.DEPTNO, DNAME, TRUNC(AVG(SAL)) AS 평균급여, MAX(SAL) 최대급여, MIN(SAL) 최소급여, COUNT(*) 사원수
    FROM EMP NATURAL JOIN DEPT
    GROUP BY E.DEPTNO, DNAME;

-- JOIN ~ USING
SELECT E.DEPTNO, DNAME, TRUNC(AVG(SAL)) AS 평균급여, MAX(SAL) 최대급여, MIN(SAL) 최소급여, COUNT(*) 사원수
    FROM EMP JOIN DEPT USING(DEPTNO)
    GROUP BY E.DEPTNO, DNAME;
    
-- JOIN ~ ON
SELECT E.DEPTNO, DNAME, TRUNC(AVG(SAL)) AS 평균급여, MAX(SAL) 최대급여, MIN(SAL) 최소급여, COUNT(*) 사원수
    FROM EMP E JOIN DEPT D
    ON E.DEPTNO = D.DEPTNO
    GROUP BY E.DEPTNO, DNAME;
    
-- 3. 모든 부서 정보와 사원 정보를 부서번호, 부서이름, 사원번호, 사원이름, 직책, 급여를 사원 이름순으로 출력
-- 오라클 문법과 ANSI OUTER 문법으로표시
-- ORACLE
SELECT D.DEPTNO, DNAME, EMPNO, ENAME, JOB, SAL
    FROM EMP E , DEPT D
    WHERE E.DEPTNO(+) = D.DEPTNO
    ORDER BY D.DEPTNO, ENAME;

-- ANSI OUTER JOIN
SELECT D.DEPTNO, DNAME, EMPNO, ENAME, JOB, SAL
    FROM EMP E RIGHT OUTER JOIN DEPT D
    ON E.DEPTNO = D.DEPTNO
    ORDER BY D.DEPTNO, ENAME;
    
/* 서브쿼리 */
-- SQL 문 안에 작성하는 작은 SELECT문을 의미; 주로 WHERE 절에서 사용
-- 서브쿼리는 반듯이 괄호(서브쿼리) 안에 넣어 표현 함
-- 사원의 이름으로 사원이 속한 부서 번호를 찾음(서브쿼리)
-- 메인 쿼리에서 부서 이름과 부서 번호를 비교해서 원하는 결과를 찾음
SELECT DNAME 
    FROM DEPT
    WHERE DEPTNO = (SELECT DEPTNO
                        FROM EMP
                        WHERE ENAME = 'KING');

/* 서브 쿼리를 이용해 'JONES'의 급여보다 높은 급여를 받는 사원 정보 출력 */
SELECT *
    FROM EMP
    WHERE SAL > (SELECT SAL
                        FROM EMP
                        WHERE ENAME = 'JONES');

/* 서브 쿼리의 특징 */
-- 조회 대상의 오른쪽에 놓이며 ()안에 묶어서 사용
-- 대부분의 경우 ORDER BY 절을 사용할 수 없음
-- 메인 쿼리의 대상과 서브쿼리의 대상은 같은 자료형이거나 같은 개수로 지정해야 함
-- 서브쿼리와 메인쿼리는 연산자와 함께 상호 작용하는 방식에 따라서 단일행 서브 쿼리와 다중행 서브 쿼리

/* 연습문제(단일행 서브쿼리) */
-- 서브쿼리를 사용해서 EMP테이블의 사원정보 중에서 사원이름이 ALLEN인 사원의 추가 수당 보다 많은 추가 수당을 받는 사원정보 출력
SELECT *
    FROM EMP
    WHERE COMM > (SELECT COMM
                        FROM EMP
                        WHERE ENAME = 'ALLEN');

SELECT *
    FROM EMP
    WHERE HIREDATE < (SELECT HIREDATE 
                            FROM EMP
                            WHERE ENAME = 'JAMES');

-- 20번 부서에 속한 사원 중 전체 사원의 평균급여보다 높은 급여를 받는 사원정보와 소속부서정보를 조회
SELECT EMPNO, ENAME, D.DEPTNO, DNAME, SAL
    FROM EMP E, DEPT D
    WHERE E.DEPTNO = D.DEPTNO
    AND E.DEPTNO = 20
    AND E.SAL > (SELECT AVG(SAL)
                        FROM EMP);

/* 실행결과가 여러개인 다중행 서브쿼리 */
-- IN 연산자 : 메인 쿼리의 데이터가 서브쿼리의 결과 중 하나라도 일치한 데이터가 있다면 TRUE(OR 연산자와 비슷)
SELECT *
    FROM EMP
    WHERE SAL IN (SELECT MAX(SAL)
                    FROM EMP
                    GROUP BY DEPTNO)
    ORDER BY DEPTNO;
    
-- ANY 연산자 : 메인쿼리의 비교 조건이 서브쿼리의 여러 검색 결과 중 하나 이상 만족되면 TRUE
SELECT *
    FROM EMP
    WHERE SAL > ANY (SELECT SAL
                        FROM EMP
                        WHERE JOB = 'SALESMAN'); -- SALESMAN의 급여 중 제일 낮은 금액보다 크면 다 찍힘
                        
/* 30번 부서 사원들의 최대 급여보다 적은 급여를 받는 사원 정보 출력 */
SELECT *
    FROM EMP
    WHERE SAL < ANY (SELECT AVG(SAL)
                        FROM EMP
                        WHERE DEPTNO = 30)
    ORDER BY SAL, EMPNO;

-- ALL 연산자 : 메인쿼리의 비교조건이 서브쿼리의 여러 검색 결과와 모든 값이 일치하면 반환
SELECT *
    FROM EMP
    WHERE SAL < ALL (SELECT SAL
                        FROM EMP
                        WHERE DEPTNO = 30)
    ORDER BY SAL, EMPNO;
    
SELECT EMPNO, ENAME, SAL
    FROM EMP
    WHERE SAL < ALL(SELECT SAL
                        FROM EMP
                        WHERE JOB = 'MANAGER');
    
-- EXISTS 연산자 : 서브쿼리의 결과 값이 하나 이상 존재하면 TRUE, 아니면 FALSE
SELECT *
    FROM EMP
    WHERE EXISTS (SELECT DNAME 
                    FROM DEPT
                    WHERE DEPTNO = 50);

/* 다중열 서브쿼리 : 서브 쿼리의 결과가 두 개 이상의 컬럼으로 반환되어 메인쿼리에 전달 되는 쿼리문 */
SELECT EMPNO, ENAME, SAL, DEPTNO
    FROM EMP
    WHERE (DEPTNO, SAL) IN (SELECT DEPTNO, SAL
                                FROM EMP
                                WHERE DEPTNO = 30);
                                
SELECT *
    FROM EMP
    WHERE (DEPTNO, SAL) IN (SELECT DEPTNO, MAX(SAL)
                                FROM EMP
                                GROUP BY DEPTNO);
                                
/* FROM 절에 사용하는 서브쿼리 */
-- 메인 쿼리의 FROM절을 서브 쿼리로 이용하는 방법으로 다른 말로는 인라인뷰라고 함
-- 테이블이 너무 커서 일부분만 사용하고자 하는 경우
-- 보안상 보여주고 싶은 열을 제한하고자 하는 경우

SELECT E.EMPNO, E.ENAME, E.DEPTNO, D.DNAME, D.LOC
    FROM (SELECT * FROM EMP WHERE DEPTNO = 10) E, -- 행을 제한
         (SELECT * FROM DEPT) D
    WHERE E.DEPTNO = D.DEPTNO;

-- 먼저 정렬하고 해당 개수만 가져오기
-- ROWNUM : 오라클에서 일련번호를 부여하기 위해서 사용되는 예약어 (즉, 행번호 매기기)
SELECT ROWNUM, ENAME, SAL
    FROM (SELECT * FROM EMP ORDER BY SAL DESC)
    WHERE ROWNUM <= 3;

/* SELECT 절에 사용하는 서브쿼리 */
-- SELECT문에 사용하는 단일 행 서브쿼리를 스탈라 서브 쿼리
SELECT EMPNO, ENAME, JOB, SAL,
    (SELECT GRADE FROM SALGRADE 
                WHERE E.SAL BETWEEN LOSAL AND HISAL) AS SALGRADE,
     DEPTNO,
     (SELECT DNAME FROM DEPT
                   WHERE E.DEPTNO = DEPT.DEPTNO) AS DNAME
     FROM EMP E;

SELECT ENAME, DEPTNO, SAL, (SELECT TRUNC(AVG(SAL)) FROM EMP
                                    WHERE DEPTNO = E.DEPTNO) AS 부서평균급여 -- 메인에 있는 DEPTNO
        FROM EMP E;  

/* 부서 위치가 NEWYORK인 경우에 본사, 아니면 분점으로 반환하기 */
SELECT EMPNO, ENAME,
            CASE WHEN DEPTNO = (SELECT DEPTNO
                                    FROM DEPT
                                    WHERE LOC = 'NEW YORK') THEN '본사'
            ELSE '분점'
            END AS 소속
        FROM EMP
        ORDER BY 소속 DESC;

/* 연습문제 FROM NOTION */
-- 1. 전체 사원 중 ALLEN과 같은 직책인 사원들의 사원 정보, 부서 정보 출력
-- (직책, 사원번호, 사원이름, 급여, 부서번호, 부서이름)
SELECT JOB, EMPNO, ENAME, SAL, D.DEPTNO, DNAME
    FROM EMP E JOIN DEPT D
    ON E.DEPTNO = D.DEPTNO
    WHERE JOB = (SELECT JOB 
                        FROM EMP
                        WHERE ENAME = 'ALLEN');

-- 2. 전체 사원의 평균 급여보다 높은 급여를 받는 사원들이 사원정보, 부서정보, 급여 등급 정보를 출력
-- (사원번호, 사원이름, 부서이름, 입사일, 부서위치, 급여, 급여등급)
-- ORACLE
SELECT EMPNO, ENAME, DNAME, HIREDATE, LOC, SAL, GRADE 급여등급
    FROM EMP E, DEPT D, SALGRADE S
    WHERE E.DEPTNO = D.DEPTNO AND E.SAL BETWEEN S.LOSAL AND S.HISAL
    AND SAL > (SELECT AVG(SAL) FROM EMP)
    ORDER BY E.SAL DESC, EMPNO;

-- ANSI    
SELECT EMPNO, ENAME, DNAME, HIREDATE, LOC, SAL, GRADE 급여등급
    FROM EMP E
    JOIN DEPT D ON E.DEPTNO = D.DEPTNO -- 등가조인
    JOIN SALGRADE S ON E.SAL BETWEEN S.LOSAL AND S.HISAL -- 비등가조인
    AND SAL > (SELECT AVG(SAL) FROM EMP)
    ORDER BY E.SAL DESC, E.EMPNO;

-- 3. 10번 부서에 근무하는 사원 중 30번 부서에는 존재하지 않는 직책을 가진 사원들의 사원정보, 부서정보를 출력
-- (사원번호, 사원이름, 직책, 부서번호, 부서이름, 부서위치)
SELECT EMPNO, ENAME, JOB, E.DEPTNO, DNAME, LOC
    FROM EMP E JOIN DEPT D
    ON E.DEPTNO = D.DEPTNO
    WHERE JOB 
        = ANY(SELECT JOB FROM EMP WHERE E.DEPTNO = 10 AND E.DEPTNO !=30);

-- 강사님
SELECT EMPNO, ENAME, JOB, E.DEPTNO, DNAME, LOC
    FROM EMP E JOIN DEPT D
    ON E.DEPTNO = D.DEPTNO
    WHERE E.DEPTNO = 10
    AND JOB NOT IN (SELECT JOB FROM EMP WHERE DEPTNO = 30);
        
-- 4. 직책이 SALESMAN인 사람들의 최고 급여보다 높은 급여를 받는 사원들의 사원정보, 급여 등급정보를 출력
-- (사원번호, 사원이름, 급여, 급여 등급)
-- 단, 서브쿼리를 활용할 때 다중행 함수를 사용하는 방법과 사용하지 않는 방법을 통해 사원번호를 기준으로 오름차순 정렬

-- 단일행 서브쿼리
SELECT EMPNO, ENAME, SAL, GRADE
    FROM EMP E, SALGRADE S
    WHERE E.SAL BETWEEN S.LOSAL AND S.HISAL
    AND SAL > (SELECT MAX(SAL) FROM EMP WHERE JOB = 'SALESMAN')
    ORDER BY EMPNO;
    
-- 다중행 서브쿼리
SELECT EMPNO, ENAME, SAL, GRADE
    FROM EMP E, SALGRADE S
    WHERE E.SAL BETWEEN S.LOSAL AND S.HISAL
    AND SAL > ALL (SELECT SAL
                        FROM EMP
                        WHERE JOB = 'SALESMAN')
    ORDER BY EMPNO;