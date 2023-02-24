/* 사원 정보 테이블 */
DESC EMP;
/* 보너스 테이블 */
DESC BONUS;
/* 급여 정보 테이블 */
DESC SALGRADE;

/* SELECT문은 데이터베이스에 저장된 데이터를 조회하는데 사용하는 구문 */
/* SELECT [조회할 열.......] FROM 조회할 테이블 */
SELECT * FROM EMP;
SELECT EMPNO, ENAME, HIREDATE FROM EMP;

/* 사원번호와 부서번호만 나오도록 쿼리문 작성하기 */
SELECT EMPNO, DEPTNO FROM EMP;

/* 별칭(ALIAS) 사용 하기 */
-- 단일행에 대한 주석
SELECT EMPNO "번호", ENAME "이름" FROM EMP;
SELECT EMPNO 번호, ENAME 이름 FROM EMP;
SELECT EMPNO AS 번호, ENAME AS 이름 FROM EMP;

SELECT ENAME, SAL, SAL*12+COMM, COMM FROM EMP;
SELECT ENAME, SAL, SAL*12+COMM AS "연 봉", COMM FROM EMP;

SHOW USER; -- 현재 USER를 표시, 오라클 전용 커맨드
SELECT * FROM TAB; -- 전체계정에대해 테이블 확인

/* 중복 제거 (DISTINCT) */
/* : 데이터를 조회할 때 값이 중복 되는 행이 여러 개 조회되는데, 값이 중복되는 행을 한개씩만 선택하고자 할 때 사용하는 키워드 */
SELECT DISTINCT DEPTNO FROM EMP;
SELECT DISTINCT JOB, DEPTNO FROM EMP; -- 두가지 조건에 대한 중복제거

/* 컬럼값 계산하는 산술 연산자(+, -, *, /) : 자료형이 숫자인 컬럼값들을 계산한 값을 조회하고자 할 때 사용 */
SELECT ENAME, SAL, SAL * 12 AS "연 봉"
FROM EMP;

/* 연습 문제 : JOB열에 대한 중복제거 */
SELECT DISTINCT JOB FROM EMP;

/* WHERE 구문  : 데이터를 조회할 때 사용자가 원하는 조건에 맞는 데이터만 조회하고 싶을 때 사용하는 것*/
/* SELSEC FROM WHERE 순서대로 */
SELECT * FROM EMP; -- * 모든데이터를 볼 때 넣음
SELECT *
    FROM EMP
    WHERE DEPTNO = 10; -- SQL에서 같은지 비교하는 연산자는 =

/* WHERE 구문을 사용해 사원번호가 7500 보다 큰 사람만 골라서 사원번호, 사원이름, 입사일, 부서번호 출력하기 */
SELECT EMPNO, ENAME, HIREDATE, DEPTNO
    FROM EMP
    WHERE EMPNO > 7500;
    
/* 급여가 2500 이상의 사원 번호, 이름, 직무, 급여를 출력 */
SELECT EMPNO, ENAME, JOB, SAL
    FROM EMP
    WHERE SAL >= 2500;
    
/* 산술 연산자 : +, -, *, /  */
SELECT *
    FROM EMP
    WHERE SAL * 12 = 36000;

/* 비교연산자 : >, >=, <, <= */
-- 보너스가 500 이상인 사람만 출력
SELECT *
    FROM EMP
    WHERE COMM >= 500;
    
DESC EMP;
/* 입사일이 81년 1월 1일 이후인 사람을 모두 출력 */
SELECT * FROM EMP;
SELECT * 
    FROM EMP
    WHERE HIREDATE < '81/01/01'; -- 날짜를 비교하거나 문자열을 비교 할 때는 작음따옴표('')로 감싸줘야함.

SELECT *
    FROM EMP
    WHERE JOB = 'SALESMAN';

/* 논리연산자 : AND, OR, NOT */
-- 급여가 2500과 같거나 크고 부서가 20번인 사람을 출력
SELECT *
    FROM EMP
    WHERE SAL >= 2500 AND DEPTNO = 20; 

-- 급여가 2500이상이거나 부서가 20번인 사람을 출력
SELECT *
    FROM EMP
    WHERE SAL >= 2500 OR DEPTNO = 20;
    
-- 급여가 2500이상이고 부서도 20번부서이고, 입사일이 82년 1월 1일 이전 입사자 출력
SELECT *
    FROM EMP
    WHERE SAL >= 2500 AND DEPTNO = 20 AND HIREDATE < '82/01/01';

-- 급여가 2000이상이고 직업이 MANAGER인 사원인 사원번호, 이름, 직책, 급여, 부서번호를 출력 
SELECT EMPNO 사원번호, ENAME 이름, JOB 직책, SAL 급여, DEPTNO 부서번호
    FROM EMP
    WHERE SAL >= 2000 AND JOB = 'MANAGER';

-- 부정의 연산자 사용하기 : NOT, !=, ^=, <>
-- 급여가 2500 이상이고, 직책이 SALESMAN이 아닌사람만 출력
SELECT *
    FROM EMP
    WHERE SAL >= 2500 AND JOB != 'SALESMAN'; -- = NOT JOB = 'SALESMAN'
