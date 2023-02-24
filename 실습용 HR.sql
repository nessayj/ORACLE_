/* 230216 */
/* 실습용 HR 연습문제 */
-- Q1) EMPLOYEES 테이블에서 King의 정보를 소문자로 검색하고 사원번호, 성명, 담당업무(소문자로),부서번호를 출력하라.
SELECT * FROM EMPLOYEES;
SELECT EMPLOYEE_ID 사원번호, CONCAT(FIRST_NAME, CONCAT(' ', LAST_NAME)) AS 성명, LOWER(JOB_ID) 담당업무, DEPARTMENT_ID AS 부서번호
    FROM EMPLOYEES;
-- Q2) EMPLOYEES 테이블에서 King의 정보를 대문자로 검색하고 사원번호, 성명, 담당업무(대문자로),부서번호를 출력하라.
SELECT EMPLOYEE_ID 사원번호, CONCAT(FIRST_NAME, CONCAT(' ', LAST_NAME)) AS 성명, UPPER(JOB_ID) 담당업무, DEPARTMENT_ID 부서번호
    FROM EMPLOYEES;
-- Q3) DEPARTMENTS 테이블에서 (부서번호와 부서이름), 부서이름과 위치번호를 합하여 출력하도록 하라.
SELECT * FROM DEPARTMENTS;
SELECT DEPARTMENT_ID 부서번호, DEPARTMENT_NAME 부서이름, CONCAT(DEPARTMENT_NAME, CONCAT('  ', LOCATION_ID)) AS "부서이름+위치번호"
    FROM DEPARTMENTS;
-- Q4) EMPLOYEES 테이블에서 이름의 첫 글자가 ‘K’ 보다 크고 ‘Y’보다 적은 사원의 정보를
-- 사원번호, 이름, 업무, 급여, 부서번호를 출력하라.
-- 단 이름순으로 정렬하여라(사전순정렬).
SELECT EMPLOYEE_ID 사원번호,FIRST_NAME 이름, JOB_ID 업무, SALARY 급여, DEPARTMENT_ID 부서번호
    FROM EMPLOYEES
    WHERE FIRST_NAME > 'K' AND FIRST_NAME < 'Y'
    ORDER BY FIRST_NAME;
-- Q5) EMPLOYEES 테이블에서 20번 부서 중 이름의 길이 및 급여의 자릿수를 
-- 사원번호, 이름, 이름의 자릿수(LENGTH), 급여, 급여의 자릿수를 출력하라.
-- LENGTHB는 BYTE 혼동하지 말자!
SELECT EMPLOYEE_ID 사원번호, FIRST_NAME 이름, 
    LENGTH(FIRST_NAME) AS "이름의 자릿수",
    SALARY 급여, 
    LENGTH(SALARY) AS "급여의 자릿수"
    FROM EMPLOYEES
    WHERE DEPARTMENT_ID = 20;
-- Q6) EMPLOYEES 테이블에서 이름 중 ‘e’자의 위치를 출력하라.
SELECT FIRST_NAME 이름,
    INSTR(FIRST_NAME, 'e', 1) AS "e의 위치"
    FROM EMPLOYEES;    
-- Q7) EMPLOYEES 테이블에서 부서번호가 80인 사람의 급여를 30으로 나눈 나머지를 구하여 출력하라.
SELECT FIRST_NAME 이름, DEPARTMENT_ID 부서번호, SALARY 급여, MOD(SALARY, 30) "나머지"
    FROM EMPLOYEES
    WHERE DEPARTMENT_ID = 80;
-- Q8) EMPLOYEES 테이블에서 현재까지 근무일 수가 몇주 몇일 인가를 출력하여라.
-- 단 근무 일수가 많은 사람 순으로 출력하여라.
-- 날짜의 차이를 구하고 이를 7로 나누면 근무 주
-- 날짜의 차이를 구하고 이를 7로 나눈 나머지가 일수
SELECT * FROM EMPLOYEES;
SELECT CONCAT(FIRST_NAME, CONCAT(' ', LAST_NAME)) 이름, HIRE_DATE 입사일,
    TO_CHAR(TRUNC(MONTHS_BETWEEN(SYSDATE, HIRE_DATE)/4)) || '주' || TO_CHAR(TRUNC(MOD(MONTHS_BETWEEN(SYSDATE, HIRE_DATE)/4, 7))) || '일' as "근무 주/일"
FROM EMPLOYEES
ORDER BY  TO_CHAR(TRUNC(MONTHS_BETWEEN(SYSDATE, HIRE_DATE)/4));
    
-- Q9) EMPLOYEES 테이블에서 부서 50에서 급여 앞에 $를 삽입하고 3자리마다 ,를 출력하라
SELECT CONCAT(FIRST_NAME, CONCAT(' ', LAST_NAME)) 이름,  TO_CHAR(SALARY, '$999,999') 급여, DEPARTMENT_ID 부서번호
    FROM EMPLOYEES
    WHERE DEPARTMENT_ID = 50;
-- Q10) EMPLOYEES 테이블에서 부서별로 인원수, 평균 급여, 최저급여, 최고 급여, 급여의 합을 구하여 출력
-- Q11) EMPLOYEES 테이블에서 30번 부서 중 이름과 담당 업무를 연결하여 출력
-- Q12) EMPLOYEES 테이블에서 업무별 급여의 평균이 10000 이상인 업무에 대해서 업무명,평균 급여, 급여의 합을 구하여 출력
-- Q13) EMPLOYEES 테이블에서 부서 인원이 4명보다 많은 부서의 부서번호, 인원수, 급여의 합을 구하여 출력