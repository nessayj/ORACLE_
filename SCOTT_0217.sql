/* 230217 FRI */

/* ROLLUP 함수를 적용한 그룹화 */
-- 명시한 열을 소그룹부터 대그룹의 순서로 각 그룹별 결과를 출력하고 마지막에 총 데이터 결과를 출력
SELECT DEPTNO, JOB, COUNT(*), MAX(SAL), SUM(SAL), AVG(SAL)
    FROM EMP
    GROUP BY ROLLUP (DEPTNO, JOB);

/* 집합연산자 : 두 개 이상의 쿼리 결과를 하나로 결합하는 연산자 */
-- UNION : 합집합, 중복제거
-- UNION ALL : 합집합, 중복제거 안함
-- MINUS : 차집합
-- INTERSECT : 교집합

-- UNION : 합집합, 중복제거
-- UNION ALL : 합집합, 중복제거 안함
SELECT EMPNO, ENAME, SAL, DEPTNO
    FROM EMP
    WHERE DEPTNO = 10
UNION
SELECT EMPNO, ENAME, SAL, DEPTNO
    FROM EMP
    WHERE DEPTNO = 20;

SELECT EMPNO, ENAME, SAL, DEPTNO
    FROM EMP
    WHERE DEPTNO = 10
UNION ALL
SELECT EMPNO, ENAME, SAL, DEPTNO
    FROM EMP
    WHERE ENAME = 'FORD';

-- INTERSECT : 교집합; 두 개의 쿼리문에 모두 포함되어 있는 데이터를 표시
SELECT EMPNO, ENAME, SAL
    FROM EMP
    WHERE SAL > 1000
INTERSECT
SELECT EMPNO, ENAME, SAL
    FROM EMP
    WHERE SAL < 2000;

-- MINUS : 차집합; 앞의 쿼리문 결과에서 뒤의 쿼리문 결과를 뺀 것
SELECT EMPNO, ENAME, SAL
    FROM EMP
MINUS
SELECT EMPNO, ENAME, SAL
    FROM EMP
    WHERE SAL > 2000;

/*JOIN */
-- JOIN 두 개 이상의 테이블에서 데이터를 가져와서 연결하는데 사용되는 SQL의 기능
-- 테이블의 식별 값인 PRIMARY KEY와 테이블 간 공통값인 FORIEGN KEY 값을 사용하여 조인
-- INNER JOIN : 두 테이블에서 일치하는 데이터만 선택
-- LEFT JOIN : 왼쪽테이블의 모든 데이터와 오른쪽 데이터에서 일치하는 데이터 선택
-- RIGHT JOIN : 오른쪽 테이블의 모든 데이터와 왼쪽 테이블에서 일치하는 데이터 선택

-- 두개의 테이블의 모든열에 결합되어 데이터 수 * 데이터 수 만큼의 결과가 표시(카테시안 곱)
SELECT *
    FROM EMP, DEPT;

SELECT *
    FROM EMP, DEPT 
    WHERE EMP.DEPTNO = DEPT.DEPTNO;

/* 테이블에 별칭 주기 */
--  양쪽 테이블 모두에 존재하는 열에 대해서는 테이블 이름을 명시해야함; 중복되지 않은 값은 별칭을 지정하지 않아도 됨

SELECT E.EMPNO, E.ENAME, E.JOB, E.DEPTNO, D.DNAME, D.LOC
    FROM EMP E, DEPT D
    WHERE E.DEPTNO = D.DEPTNO;
 
/* 등가 조인 */
-- 테이블을 연결한 후에 출력 행을 각 테이블의 특정 열에 일치한 데이터를 기준으로 선정하는 방식
 
-- ANSI 조인 방식으로 연결
-- 오라큰 9i 까지는 오라클 조인만 사용할 수 있었으나, 오라클 10g 부터는 ANSI조인을 추가로 사용가능
-- 조건절이 나눠져있는게 잘 보이기 때문에 가독성이 조금 더 좋음
SELECT EMPNO, ENAME, E.DEPTNO, DNAME
    FROM EMP E JOIN DEPT D 
    ON E.DEPTNO = D.DEPTNO
    WHERE E.JOB = 'MANAGER';
    
-- EMP와 DEPT테이블을 조인하고 급여가 3000이상인 사원정보 출력(사원번호, 이름, 급여, 입사일, 부서번호, 부서이름)
-- ANSI
SELECT EMPNO, ENAME, SAL, HIREDATE, E.DEPTNO, D.DEPTNO, DNAME
    FROM EMP E JOIN DEPT D
    ON E.DEPTNO = D.DEPTNO
    WHERE SAL >= 3000;
-- ORACLE    
SELECT EMPNO, ENAME, SAL, HIREDATE, E.DEPTNO, D.DEPTNO, DNAME
    FROM EMP E, DEPT D
    WHERE E.DEPTNO = D.DEPTNO
    AND SAL >= 3000;

-- EMP테이블 별칭을 E로, DEPT테이블 별칭을 D로 하여 다음과 같이 등가 조인을 했을 때,
-- 급여가 2500이하이고 사원번호가 9999 이하인 사원의 정보가 출력되도록 작성
-- ANSI
SELECT EMPNO, ENAME, SAL, E.DEPTNO, D.DEPTNO, DNAME
    FROM EMP E JOIN DEPT D
    ON E.DEPTNO = D.DEPTNO
    WHERE SAL <= 2500 AND EMPNO <= 9999;
    
-- ORACLE
SELECT EMPNO, ENAME, SAL, E.DEPTNO, D.DEPTNO, DNAME
    FROM EMP E, DEPT D
    WHERE E.DEPTNO = D.DEPTNO
    AND SAL <= 2500 AND EMPNO <= 9999;

/* 비등가 조인 */
-- 동일 열이 아닌 다른 조건을 사용하여 조인 할 때 사용되면서 자주 사용되지 않음
SELECT * FROM EMP;
SELECT * FROM SALGRADE;

-- 급여에 대한 등급을 표시 하기 위해서는 급여의 금액이 일치 할 수 없으므로, 최소와 최대 급여 사이에 있어야 함
-- 이런경우 BETWEEN A AND B 연산자를 사용하면 처리 가능
SELECT ENAME, SAL, GRADE
    FROM EMP E JOIN SALGRADE S
    ON SAL BETWEEN LOSAL AND HISAL;

/* 연습 문제 */
-- Q1) 사원번호가 7499인 사원의 이름, 입사일 부서번호 출력
SELECT ENAME, HIREDATE, DEPTNO
    FROM EMP
    WHERE EMPNO = 7499;

-- Q2) 이름이 ALLEN인 사원의 모든 정보 출력
SELECT *
    FROM EMP
    WHERE ENAME = 'ALLEN';
    
-- Q3) 이름이 K보다 큰 글자로 시작하는 사원의 모든 정보 출력
SELECT *
    FROM EMP
    WHERE ENAME >= 'K';
    
-- Q4) 입사일이 81년 4월 2일 보다 늦고, 82년 12월 9일 보다 빠른사원의 이름, 급여, 부서번호 출력
SELECT ENAME, SAL, DEPTNO, HIREDATE
    FROM EMP
    WHERE HIREDATE > '1981/04/02'
        AND HIREDATE < '1982/12/09';
        
-- Q5) 급여가 1600보다 크고 3000보다 작은사원의 이름, 직무, 급여를 출력
SELECT ENAME, JOB, SAL
    FROM EMP
    WHERE SAL > 1600 AND SAL < 3000;
    
-- Q6) 입사일이 81년 이외에 입사한 사원의 모든 정보 출력
SELECT *
    FROM EMP
    WHERE EXTRACT(YEAR FROM HIREDATE) != 1981;

-- Q7) 직업이 MANAGER과 SALESMAN인 사원의 모든 정보 출력
SELECT *
    FROM EMP
    WHERE JOB = 'MANAGER' OR JOB = 'SALESMAN';
    
SELECT *
    FROM EMP
    WHERE JOB IN ('MANAGER','SALESMAN');
    
-- Q8) 부서가 20번, 30번을 제외한 모든 사원의 이름, 사원번호, 부서번호 출력
SELECT ENAME, EMPNO, DEPTNO
    FROM EMP
    WHERE DEPTNO != 20 AND DEPTNO != 30;

SELECT ENAME, EMPNO, DEPTNO
    FROM EMP
    WHERE DEPTNO NOT IN(20,30);    
    
-- Q9) 이름이 S로 시작하는 사원의 사원번호, 이름, 부서번호 출력
SELECT EMPNO, ENAME, DEPTNO
    FROM EMP
    WHERE ENAME LIKE 'S%';
    
-- Q10) 처음글자는 관계없고, 두 번째 글자가 A인 사원의 모든 정보 출력
SELECT *
    FROM EMP
    WHERE ENAME LIKE '_A%';
    
-- Q11) 커미션이 NULL이 아닌 사원의 모든정보 출력
SELECT *
    FROM EMP
    WHERE COMM IS NOT NULL;
    
-- Q12) 이름이 J로 시작하고 마지막글자가 S인 사원의 모든 정보 출력
SELECT *
    FROM EMP
    WHERE ENAME LIKE 'J%S';
    
-- Q13) 급여가 1500 이상이고, 부서번호가 30번인 사원 중 직무가 MANAGER인 사원의 모든 정보 출력
SELECT *
    FROM EMP
    WHERE SAL >= 1500 AND DEPTNO = 30 AND JOB = 'MANAGER';
    
-- Q14) 모든 사원의 이름, 급여, 커미션, 총액(급여+커미션)을 구하여 총액이 많은 순서로 출력
-- 단, 커미션이 NULL인 사원도 0으로 포함
SELECT ENAME, SAL, NVL(COMM,0) 커미션, SAL+NVL(COMM,0) AS 총액
    FROM EMP
    ORDER BY SAL+NVL(COMM,0); -- ORDER BY는 별칭으로 지정해줘도 가능 = ORDER BY "총액";
    
-- Q15) 10번 부서의 모든 사원에게 급여의 13%를 보너스로 지불하기로 하였다.
-- 10번부서 사원들의 이름, 급여, 보너스, 부서번호 출력
SELECT ENAME, SAL, ROUND(SAL*1.13, 1) AS 보너스, DEPTNO
    FROM EMP
    WHERE DEPTNO = 10;

-- Q16) 모든 사원에 대해 입사한 날로부터 60일이 지난 후의 '월요일'에 대한 년, 월, 일을 구하여 
-- 이름, 입사일, 60일 후의 '월요일'날짜 출력
SELECT ENAME, HIREDATE, TO_CHAR(NEXT_DAY((HIREDATE + 60), '월요일'), 'YYYY-MM-DD') AS "60일 후"
    FROM EMP;
    
-- Q17) 이름의 글자수가 6자 이상인 사원의이름을 앞에서 3자만 구하여 소문자로 이름만 출력
SELECT LOWER(SUBSTR(ENAME,1,3))
    FROM EMP
    WHERE LENGTH(ENAME) = 6;

-- Q18) 사원들의 사원번호와 급여, 커미션, 연봉((COMM+SAL)*12)를 연봉이 많은 순서로 출력
SELECT EMPNO, SAL, NVL(COMM,0), ((NVL(COMM,0)+SAL)*12) AS 연봉
    FROM EMP
    ORDER BY ((NVL(COMM,0)+SAL)*12);
    
-- Q19) 모든사원들의 입사한 년/월/일
SELECT TO_CHAR(HIREDATE, 'YYYY"년"MM"월"DD"일"') 입사일
    FROM EMP;

-- Q20) 10번 부서에 대해 급여의 평균 값, 최대 값, 최소 값, 인원 수를 출력
SELECT DEPTNO, TRUNC(AVG(SAL)), MAX(SAL), MIN(SAL), COUNT(*)
    FROM EMP
    GROUP BY DEPTNO
        HAVING DEPTNO = 10;
        
SELECT TRUNC(AVG(SAL)), MAX(SAL), MIN(SAL), COUNT(*)
    FROM EMP
    WHERE DEPTNO = 10;
        
-- Q21) 사원번호가 짝수인 사원들의 모든 정보 출력
SELECT *
    FROM EMP
    WHERE MOD(EMPNO, 2) = 0;

-- Q22) 각 부서별 같은 직무를 갖는 사원의 인원수를 구하여 부서번호, 직무, 인원수 출력
SELECT DEPTNO, JOB, COUNT(*)
    FROM EMP
    GROUP BY DEPTNO, JOB;
    
-- Q23) EMP와 DEPT테이블을 조인하여 모든사원에 대해 부서번호, 부서이름, 사원이름, 급여 출력
SELECT D.DEPTNO, DNAME, ENAME, SAL
    FROM EMP E JOIN DEPT D
    ON E.DEPTNO = D.DEPTNO
ORDER BY DEPTNO, SAL DESC;
    
-- Q24) 이름이 'ALLEN'인 사원의 부서번호, 부서이름, 사원이름, 급여 출력
SELECT D.DEPTNO, DNAME, ENAME, SAL
    FROM EMP E JOIN DEPT D
    ON E.DEPTNO = D.DEPTNO
    WHERE ENAME = 'ALLEN';

-- Q25) 'ALLEN'과 직무가 같은 사원의 이름, 부서 이름, 급여, 부서위치 출력
SELECT D.DEPTNO, DNAME, ENAME, SAL
    FROM EMP E JOIN DEPT D
    ON E.DEPTNO = D.DEPTNO
    WHERE JOB = (SELECT JOB
                        FROM EMP
                        WHERE ENAME = 'ALLEN');

-- Q26) 모든사원들의 평균 급여보다 많이 받는 사원들의 사원번호와 이름 출력
SELECT EMPNO, ENAME
    FROM EMP
    WHERE SAL > (SELECT AVG(SAL)
                        FROM EMP);
    
-- Q27) 부서별 평균 급여가 2000보다 적은 부서 사원들의 부서번호 출력
SELECT DEPTNO
    FROM EMP
    GROUP BY DEPTNO
        HAVING AVG(SAL) <= 2000;

/* 자체 조인 : 같은 테이블을 두 번 사용하는 것 */
SELECT E1.EMPNO, E1.ENAME, E1.MGR,
        E2.EMPNO AS MGR_EMPNO,
        E2.ENAME AS MGR_ENAME
        FROM EMP E1 JOIN EMP E2
        ON E1.MGR = E2.EMPNO;

/*내부조인(INNER JOIN) 또는 동등 조인 - 한 쪽의 컬럼(열)에 값이 없으면 조회 불가; 비교의 두 값이 모두 있어야 조회 가능*/        
/* 외부조인(OUTER JOIN) : 내부 조인과 다르게 공통되지 않은 열도 조회 가능 */ 

-- RIGHT OUTER JOIN : 오른쪽 테이블의 컬럼수를 기준으로 조인(왼쪽 값이 없어도 NULL로 출력)
-- ANSI
SELECT ENAME, E.DEPTNO, DNAME
    FROM EMP E RIGHT OUTER JOIN DEPT D
    ON E.DEPTNO = D.DEPTNO
    ORDER BY E.DEPTNO;
    
-- ORACLE
SELECT ENAME, E.DEPTNO, DNAME
    FROM EMP E, DEPT D
    WHERE E.DEPTNO(+) = D.DEPTNO
    ORDER BY E.DEPTNO;
    
-- LEFT OUTER JOIN : 왼쪽 테이블의 컬럼수를 기준으로 조인(오른쪽 값이 없어도 NULL로 출력)
-- ANSI
SELECT ENAME, E.DEPTNO, DNAME
    FROM EMP E LEFT OUTER JOIN DEPT D
    ON E.DEPTNO = D.DEPTNO
    ORDER BY E.DEPTNO;

-- ORACLE
SELECT ENAME, E.DEPTNO, DNAME
    FROM EMP E, DEPT D
    WHERE E.DEPTNO = D.DEPTNO(+)
    ORDER BY E.DEPTNO;

