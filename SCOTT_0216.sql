/* 230216 THU */
/* 다중행 함수 */
SELECT SUM(SAL) FROM EMP; -- 전체에대한 급여 합
SELECT DEPTNO, SUM(SAL)
    FROM EMP
    GROUP BY DEPTNO; -- DEPTNO 각 부서에 해당하는 SAL의 합계로 나누어짐

SELECT JOB, AVG(SAL)
    FROM EMP
    GROUP BY JOB;   
    
SELECT JOB, COUNT(*)
    FROM EMP
    GROUP BY JOB; -- COUNT(*) *을 찍으면 전부 다 얼만큼씩 있는지 데이터 개수 반환

SELECT JOB, MAX(SAL)
    FROM EMP
    GROUP BY JOB; -- 그룹별로 급여가 제일 높은사람이 누군지
    
SELECT JOB, MIN(SAL)
    FROM EMP
    GROUP BY JOB; -- 그룹별로 급여가 제일 낮은 사람이 누군지
    
/* 합계 구하는 SUM 함수 */
-- DISTINCT : 중복제거
-- ALL : 사용하지 않아도 기본적으로 ALL 특성을 가짐
SELECT SAL FROM EMP;
SELECT SUM(DISTINCT SAL) AS 중복제거, SUM(ALL SAL) AS 전부, SUM(SAL) AS 기본
    FROM EMP;

SELECT SUM(SAL), SUM(COMM) FROM EMP; 

SELECT COUNT(*) FROM EMP;
SELECT COUNT(COMM) FROM EMP; -- COMM이 NULL이 아닌 사원의 수

SELECT COUNT(COMM)
    FROM EMP
    WHERE COMM IS NOT NULL; -- 위의 식과 결과 동일

-- 부서 번호가 20인 사원 중 입사일이 가장 최근인 사원
SELECT MAX(HIREDATE)
    FROM EMP
    WHERE DEPTNO = 20;
    
/* GROUP BY : 하나의 결과를 특정열을 묶어서 출력하는 것을 그룹화라고 함 */
-- 이때 출력해야 할 대상 열 지정을 GROUP BY로 수행
SELECT TRUNC(AVG(SAL))
    FROM EMP; -- EMP테이블에 대한 전체에대한 평균
    
SELECT TRUNC(AVG(SAL)), DEPTNO
    FROM EMP
    GROUP BY DEPTNO;

SELECT TRUNC(AVG(SAL))
    FROM EMP
    WHERE DEPTNO = 10; --기존의 WHERE절로 했을 때는 각각의 부서번호대로 식을 구해줘야함

/* 부서 번호 및 직책별 평균 급여로 정렬하기 */
SELECT DEPTNO, JOB, AVG(SAL)
    FROM EMP
    GROUP BY DEPTNO, JOB
    ORDER BY AVG(SAL);

SELECT DEPTNO, JOB, AVG(SAL)
    FROM EMP
    GROUP BY DEPTNO, JOB
    ORDER BY DEPTNO, JOB;
    
/* GROUP BY 절을 사용하여 부서 번호별 평균 추가 수당을 출력 */
SELECT NVL(AVG(COMM), 0), DEPTNO
    FROM EMP
    GROUP BY DEPTNO;

/* 부서코드, 급여 합계, 부서 평균, 부서 코드 순 정렬 */
SELECT DEPTNO, SUM(SAL) 합계, FLOOR(AVG(SAL)) 평균, COUNT(*) "인원 수"
    FROM EMP 
    GROUP BY DEPTNO
    ORDER BY DEPTNO;
    
/* HAVING 절 : GROUP BY절 내에서만 사용 */
-- 그룹화 된 값의범위를 제한하는 용도로 사용
SELECT DEPTNO, JOB, AVG(SAL)
    FROM EMP
    GROUP BY DEPTNO,JOB
        HAVING AVG(SAL) >= 2000
    ORDER BY DEPTNO, JOB;

/* WHERE 절과 HAVING 절을 모두 사용하는 경우 */    
SELECT DEPTNO, JOB, AVG(SAL)
    FROM EMP -- 첫 번째 수행 : 12~13개 행이 있음
    WHERE SAL <= 3000 -- 일반적인 조건절(GROUP 묶기 전에 사용가능)
    GROUP BY DEPTNO, JOB
        HAVING AVG(SAL) >= 2000
    ORDER BY DEPTNO, JOB;

/* 연습문제 */
-- Q1) HVING절을 사용하여 EMP테이블의 부서별 직책 평균급여가 500 이상인 사원들의 부서번호, 직책, 부서별 직책의 평균급여가 출력
SELECT DEPTNO 부서번호, JOB 직책, AVG(SAL) 평균급여
    FROM EMP
    GROUP BY DEPTNO, JOB
        HAVING AVG(SAL) >= 500;

-- Q2) EMP테이블을 이용하여 부서번호, 평균급여, 최고급여, 최저급여, 사원수를 출력
-- 단, 평균급여를 출력 할 때는 소수점 제외하고 부서번호 별로 출력
SELECT DEPTNO 부서번호, TRUNC(AVG(SAL)) 평균급여, MAX(SAL) 최고급여, MIN(SAL) 최저급여, COUNT(*) 사원수
    FROM EMP
    GROUP BY DEPTNO
    ORDER BY DEPTNO;

-- Q3) EMP테이블을 이용하여 같은 직책에 종사하는 사원이 3명 이상인 직책과 인원을 출력
SELECT JOB, COUNT(JOB)
    FROM EMP
    GROUP BY JOB
        HAVING COUNT(JOB) >= 3;

-- Q4) 사원들의 입사 연도를 기준으로 부서별로 몇 명이 입사했는지 출력
SELECT  EXTRACT(YEAR FROM HIREDATE) 입사년도, DEPTNO 부서, COUNT(HIREDATE) 사원수
    FROM EMP
    GROUP BY DEPTNO, EXTRACT(YEAR FROM HIREDATE)
    ORDER BY EXTRACT(YEAR FROM HIREDATE), DEPTNO;

-- TO_CHAR(HIDRATE, YYYY)

-- Q5) 추가 수당을 받는 사원 수와 받지 않는 사원수를 출력 (O, X로 표기 필요)
SELECT NVL2(COMM, 'O', 'X') 추가수당여부, COUNT(COMM) 사원수
    FROM EMP
    GROUP BY NVL2(COMM, 'O', 'X');
        
    
-- Q6) 각 부서의 입사 연도별 사원 수, 최고 급여, 급여 합, 평균 급여를 출력
SELECT DEPTNO "부서", EXTRACT(YEAR FROM HIREDATE) 입사년도,  COUNT(HIREDATE) "입사 연도별 사원수", MAX(SAL) "최고 급여", SUM(SAL) "급여 합", ROUND(AVG(SAL), 1) "평균 급여"
    FROM EMP
    GROUP BY EXTRACT(YEAR FROM HIREDATE), DEPTNO
    ORDER BY DEPTNO;
