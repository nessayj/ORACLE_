/* 230221 TUE */
/* 연습문제 : HR 계정 서브쿼리 문제 */

-- 1. EMPLOYEES 테이블에서 100번 부서의 최소급여보다 최소 급여가 많은 다른 모든 부서를 출력
SELECT * FROM EMPLOYEES;

SELECT DEPARTMENT_ID, MIN(SALARY)
    FROM EMPLOYEES
    GROUP BY DEPARTMENT_ID
    HAVING MIN(SALARY) > (SELECT MIN(SALARY)
                            FROM EMPLOYEES
                            WHERE DEPARTMENT_ID = 100);
-- 2. EMPLOYEES과 DEPARTMENTS테이블에서 업무가 SA_MAN 사원의 정보를 성명, 업무, 부서명, 근무지 출력
SELECT * FROM DEPARTMENTS;
SELECT E.FIRST_NAME, E.JOB_ID, D.LOCATION_ID, D.DEPARTMENT_ID
    FROM EMPLOYEES E JOIN DEPARTMENTS D
    ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
    WHERE E.JOB_ID = 'SA_MAN';

-- 3. EMPLOYEES 테이블에서 (가장 많은 사원)을 갖는 MANAGER의 사원번호 출력
SELECT MANAGER_ID, COUNT(*)
    FROM EMPLOYEES
    GROUP BY MANAGER_ID
    HAVING COUNT(*) IN (SELECT MAX(COUNT(*)
                             FROM EMPLOYEES
                             GROUP BY MANAGER_ID);

-- 4. EMPLOYEES 테이블에서 (가장 많은 사원이 속해있는 부서 번호)와 사원수 출력
SELECT DEPARTMENT_ID, COUNT(*)
    FROM EMPLOYEES
    GROUP BY DEPARTMENT_ID
    HAVING COUNT(*) IN (SELECT MAX(COUNT(DEPARTMENT_ID)
                             FROM EMPLOYEES
                             GROUP BY DEPARTMENT_ID);
                             
-- 5. 직업(JOB)별로 최소급여를 받는 사원의 정보를 사원번호, 이름, 업무, 부서명 출력(직업별로 내림차순)
-- IN 연산자를 사용해 JOB_ID와 급여가 해당 JOB_ID 중 최소 급여와 일치하는 직원만 필터링
SELECT  EMPLOYEE_ID, FIRST_NAME, JOB_ID, D.DEPARTMENT_ID, D.DEPARTMENT_NAME
    FROM EMPLOYEES E JOIN DEPARTMENTS D
    ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
    WHERE SALARY < ANY (SELECT MIN(SALARY) FROM EMPLOYEES GROUP BY JOB_ID)
    ORDER BY JOB_ID DESC;
    
SELECT  EMPLOYEE_ID, FIRST_NAME, JOB_ID, D.DEPARTMENT_ID, D.DEPARTMENT_NAME
    FROM EMPLOYEES E JOIN DEPARTMENTS D
    ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
    WHERE (JOB_ID, SALARY) IN (SELECT JOB_ID, MIN(SALARY)
                                    FROM EMPLOYEES
                                    GROUP BY JOB_ID);
    
-- 6. EMPLOYEES 테이블에서 ( 50번 부서의 최고급여)를 받는 사원보다 많은 급여를 받는 사원의 사원번호, 이름, 업무, 입사일자, 급여, 부서번호 출력
-- 단 ,50번은 제외
SELECT EMPLOYEE_ID, FIRST_NAME, JOB_ID, HIRE_DATE, SALARY, DEPARTMENT_ID
    FROM EMPLOYEES
    WHERE DEPARTMENT_ID != 50
    AND SALARY > (SELECT MAX(SALARY)
                            FROM EMPLOYESS
                            WHERE DEPARTMENT_ID = 50);
