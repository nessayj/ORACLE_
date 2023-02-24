/* 230214 TUE */
SELECT *
    FROM EMP
    WHERE JOB = 'MANAGER' 
        OR JOB = 'SALESMAN'
        OR JOB = 'CLERK';
        
/* IN 연산자 : 특정열에 포함된 데이터를 여러개 조회할때 활용 */
SELECT *
    FROM EMP
    WHERE JOB IN('MANAGER', 'SALESMAN', 'CLERK');

/* IN 연산자를 사용하여 부서번호가 10번과 20번인 사원의 사원번호, 이름, 입사일, 급여출력 */
SELECT EMPNO 사원번호, ENAME 이름, HIREDATE 입사일, SAL 급여
    FROM EMP
    WHERE DEPTNO IN(10, 20);

/* 등가 비교연산자와 AND 연산자 */
SELECT *
    FROM EMP
    WHERE JOB != 'MANAGER' 
        AND JOB <> 'SALESMAN'
        AND JOB ^= 'CLERK';
        
/* 범위지정 연산자 : 일정 범위를 지정하는 BETWEEN 연산자 */
-- 급여가 2000에서 3000사이에 있는 사원 표시
SELECT *
    FROM EMP 
    WHERE SAL >= 2000
        AND SAL <= 3000;

/* BETWEEN 2000 AND 3000 => 2000이상 3000이하와 같은 뜻 */
SELECT *
    FROM EMP
    WHERE SAL BETWEEN 2000 AND 3000;

/* BETWEEN절을 사용해서 급여가 1000에서 2500 사이이고 부서가(IN 사용) 10, 30인 사원을 출력 */
SELECT *
    FROM EMP
    WHERE SAL BETWEEN 1000 AND 2500
        AND DEPTNO IN(10, 30);

/* BETWEEN절을 사용해서 급여가 1000에서 2500 사이이고 부서가 10, 20 아닌 사원 출력 */
SELECT *
    FROM EMP
    WHERE SAL BETWEEN 1000 AND 2500
        AND DEPTNO NOT IN(10, 20);
        
/* BETWEEN절을 사용해서 사원번호가 7000에서 7999사이이고, 입사일이 81년 5월 1일 이후인 사원 출력 */
SELECT *
    FROM EMP
    WHERE EMPNO BETWEEN 7000 AND 7999
        AND HIREDATE > '81/05/01';
        
/* 1980년이 아닌 해에 입사한 사원 출력*/
SELECT *
    FROM EMP
    WHERE NOT HIREDATE BETWEEN '80/01/01' 
        AND '80/12/31';

-- EXTRACT 절을 사용하여 특정 조건만 보일 수 있도록 하는 것        
SELECT *
    FROM EMP
    WHERE EXTRACT(YEAR FROM HIREDATE) != 1980;

/* LIKE 절은 일부 문자열이 포함되어 있는지 여부를 확인 할 때 사용 */
-- % 길이와 상관없이(찾고자하는 특정문자의 위치가 어디든) 모든 문자 데이터를 의미
-- _ 문자 한 자를 의미

SELECT *
    FROM EMP
    WHERE ENAME LIKE '%S%'; 

SELECT *
    FROM EMP
    WHERE ENAME LIKE 'S____'; -- 문자의 위치만큼, 단어의 길이만큼 언더바(_)를 넣어줘야함

SELECT *
    FROM EMP
    WHERE ENAME LIKE '_L%';
    
/* 이름에 AM이 포함되어 있는 사원 출력 */
SELECT *
    FROM EMP
    WHERE ENAME LIKE '%AM%';

/* 이름에 AM이 포함되어 있지 않은 사원 출력 */
SELECT *
    FROM EMP
    WHERE NOT ENAME LIKE '%AM%';

/* 와일드카드 문자가 데이터 일부일 경우 */
INSERT INTO 
    EMP VALUES(9998, 'TEST_PP', 'SALESMAN', 7698, TO_DATE('23-02-14', 'YY-MM-DD'), 2000, 1000, 30); -- 자료삽입

SELECT * FROM EMP;

SELECT *
    FROM EMP
    WHERE ENAME LIKE '____\_%' ESCAPE '\'; -- \다음에 오는 %는 우리가 찾는 문자 '\' 제어문자

DELETE FROM EMP
    WHERE ENAME = 'TEST%PP'; -- 테이블에서 해당하는 이름의 자료삭제
    
/* IS NULL */
-- NULL : 0이 아니고 빈공간도 아님을 의미. 즉, 미 확정된 값
-- 연산 및 비교, 할당이 안됨
SELECT *
    FROM EMP
    WHERE COMM = NULL; -- NULL은 값을 비교할 수 없음

SELECT *
    FROM EMP
    WHERE COMM IS NULL;
    
SELECT *
    FROM EMP
    WHERE COMM IS NOT NULL;
    
/* MGR이 있는 사원만 출력 */
SELECT *
    FROM EMP
    WHERE MGR IS NOT NULL;
    
/* ORDER BY 절 : 특정 컬럼(열)의 데이터를 기준으로 오름차순이나 내림차순으로 정렬하는 기능을 하는 절 */
-- 반드시 가장 마지막에 기술되어야 하며, 남발하면 좋지 않음.
-- 오름차순 : ASC / 내림차순 : DESC
SELECT *
    FROM EMP
    ORDER BY SAL DESC; -- 기본적으로 오름차순(ASC)

/* 사원번호 기준으로 오름차순 정렬 */
SELECT *
    FROM EMP
    ORDER BY EMPNO;

/* 급여 기준으로 오름차순; 급여가 같은경우에는 이름 기준 */
SELECT *
    FROM EMP
    ORDER BY SAL, ENAME;
    
/* 급여 기준으로 오름차순; 급여가 같은 경우 이름을 내림차순 기준 */
SELECT *
    FROM EMP
    ORDER BY SAL, ENAME DESC; 
    
/* 별칭 사용과 ORDER BY */
SELECT EMPNO 사원번호, ENAME 사원명, SAL 월급, HIREDATE 입사일
    FROM EMP
    ORDER BY 월급 DESC, 사원명 ASC;
    
/* 연결 연산자(||) : SELECT 조회시 컬럼 사이에 특정한 문자를 넣고 싶을 때 사용하는 연산자 */
SELECT ENAME || 'S JOB IS ' || JOB AS EMPLOYEE
    FROM EMP;

/* 실습문제 */
/* 없는 VALUE 추가 */
INSERT INTO EMP VALUES(7876, 'ADAMS', 'CLERK', 7788, TO_DATE('23-05-87', 'DD-MM-YY'), 1100, NULL, 20);

/* EX1) EMP 테이블을 사용하여 사원이름이 S로 끝나는 사원데이터를 모두 출력 */
SELECT *
    FROM EMP
    WHERE ENAME LIKE '%S';

/* EX2) EMP 테이블을 사용하여 30번 부서에서 근무하고 있는 사원중에 직책이 SALESMAN인 사원의 사원번호, 이름, 지책, 급여, 부서번호 출력 */
SELECT EMPNO 사원번호, ENAME 이름, JOB 직책, SAL 급여, DEPTNO 부서번호
    FROM EMP
    WHERE JOB = 'SALESMAN' AND DEPTNO = 30;
    
/* EX3) EMP 테이블을 사용하여 20번, 30번 부서에서 근무하고 있는 사원 중 급여가 2000초과인 사원을 두가지 방식을 사용하여 사원번호, 이름, 급여, 부서번호를 출력 */
-- 집합연산자를 사용하지 않는 방식
-- 집합연산자를 사용한 방식
SELECT EMPNO 사원번호, ENAME 이름, SAL 급여, DEPTNO 부서번호
    FROM EMP
    WHERE SAL > 2000
        AND DEPTNO IN(20, 30);

SELECT EMPNO 사원번호, ENAME 이름, SAL 급여, DEPTNO 부서번호
    FROM EMP
    WHERE SAL > 2000
        AND DEPTNO = 20 AND DEPTNO = 30;
        
/* EX4) NOT BETWEEN A AND B 연산자를 쓰지않고, 급여 열 값이 2000이상 3000이하 범위 이외의 값을 가진 데이터만 출력 */
SELECT *
    FROM EMP
    WHERE SAL < 2000 OR SAL > 3000;
    
/* EX5) 사원 이름에 E가 포함되어 있는 30번 부서의 사원 중 급여가 1000~2000 사이가 아닌 사원이름, 사원번호, 급여, 부서번호 출력 */
SELECT  EMPNO 사원번호, ENAME 사원이름, SAL 급여, DEPTNO 부서번호
    FROM EMP
    WHERE ENAME LIKE '%E%'
        AND DEPTNO = 30 
        AND SAL NOT BETWEEN 1000 AND 2000;

/* EX6) 추가수당이 존재하지 않고 상급자가 있고 직책이 MANAGER, CLERK인 사원중에서 사원이름의 두번째 글자가 L이 아닌 사원 정보를 출력 */
SELECT *
    FROM EMP
    WHERE (COMM IS NULL OR COMM = 0) 
        AND MGR IS NOT NULL
        AND JOB IN ('MANAGER', 'CLERK')
        AND NOT ENAME LIKE '_L%';

/*연습문제 PART2*/
/* EX1) EMP 테이블에서 COMM의 값이 NULL이 아닌 정보로 조회 */
SELECT *
    FROM EMP
    WHERE COMM IS NOT NULL;
    
/* EX2) EMP 테이블에서 커미션을 받지 못하는 직원 조회 */
SELECT *
    FROM EMP
    WHERE COMM IS NULL OR COMM = 0;

/* EX3) EMP 테이블에서 관리자가 없는 직원 정보 조회 */
SELECT *
    FROM EMP
    WHERE MGR IS NULL;
    
/* EX4) EMP 테이블에서 급여를 많이 받는 직원 순으로 조회 */
SELECT *
    FROM EMP
    ORDER BY SAL DESC;
    
/* EX5) EMP테이블에서 급여가 같은 경우 커미션을 내림차순 정렬 조회 */
SELECT *
    FROM EMP
    ORDER BY SAL DESC, COMM DESC;
    
/* EX6) EMP 테이블에서 사원번호, 사원명, 직급, 입사일 조회 (단, 입사일을 오름차순 정렬 처리) */
SELECT EMPNO 사원번호, ENAME 사원명, JOB 직급, HIREDATE 입사일
    FROM EMP
    ORDER BY HIREDATE; -- 컬럼의 순서(위의 셀렉트 옆에 있는 조회 순서대로)를 입력해도 정렬가능
    
/* EX7) EMP 테이블에서 사원번호, 사원명 조회 (사원번호 기준 내림차순 정렬) */
SELECT EMPNO 사원번호, ENAME 사원명
    FROM EMP
    ORDER BY EMPNO DESC;

/* EX8) EMP 테이블에서 사번, 입사일, 사원명, 급여 조회 (부서번호가 빠른 순으로, 같은 부서번호일 때는 최근 입사일 순으로 처리) */
SELECT EMPNO 사번, HIREDATE 입사일, ENAME 사원명, SAL 급여, DEPTNO 부서번호
    FROM EMP
    ORDER BY DEPTNO, HIREDATE  DESC;


/* 함수 : 오라클에서는 내장함수와 사용자가 필요에 의해서 직접 정의한 사용자 정의함수로 나누어짐 */
-- 함수는 단일행 함수와 다중행 함수(집계 함수)로 나뉨
-- DUAL 테이블 : SYS 계정에서 제공하는 테이블로 함수나 계산식을 테이블 탐조 없이 실행해보기 위한 DUMMY 테이블
/* 숫자 함수 */
/* 단일행 함수 */
-- ABS 절대값 함수
SELECT -10, ABS(-10) FROM EMP;
SELECT -10, ABS(-10) FROM DUAL; -- DUAL로 해야 값이 하나만 나옴
-- ROUND 반올림 함수
SELECT ROUND(1234.5678) AS ROUND FROM DUAL; -- 반올림자리 지정하지 않으면 정수값
SELECT ROUND(1234.5678, 0) ROUND_0 FROM DUAL; -- 위의것과 동일
SELECT ROUND(1234.5678, 1) ROUND_1,
    ROUND(1234.5678, 2) ROUND_2,
    ROUND(1234.5678, 3) ROUND_3
    FROM DUAL; -- 숫자만큼 보여지도록 반올림(숫자 +1 자리에서 반올림)

SELECT ROUND(1234.5678, -1) ROUND_MINUS1,
    ROUND(1234.5678, -2) ROUND_MINUS2,
    ROUND(1234.5678, -3) ROUND_MINUS3
    FROM DUAL; -- -숫자 자리에서 반올림 그리고 그 숫자자리이하는 모두 0으로 바뀜
    
-- TRUNC : 버림을 한 결과를 반환하는 함수
SELECT TRUNC(1234.5678, 1) TRUNC_1,
    TRUNC(1234.5678, 2) TRUNC_2,
    TRUNC(1234.5678, 3) TRUNC_3
    FROM DUAL; -- 위의 결과와 같은 자리에서 버림
    
SELECT TRUNC(1234.5678, -1) TRUNC_MINUS1,
    TRUNC(1234.5678, -2) TRUNC_MINUS2,
    TRUNC(1234.5678, -3) TRUNC_MINUS3
    FROM DUAL; -- 위의 결과와 같은 자리에서 버림
    
-- MOD : 나누셈을 한 후 나머지를 출력하는 함수
SELECT MOD(21, 5) FROM DUAL;

-- CEIL : 소수점이하에 수가 있으면 무조건 올림
SELECT CEIL(12.001) FROM DUAL;

-- FLOOR : 소수점이하를 무조건 날림
SELECT FLOOR(12.9999) FROM DUAL;

-- POWER : 정수 A를 정수 B만큼 제곱
SELECT POWER(3, 4) FROM DUAL;

/* 문자 함수 : 문자데이터를 가공하거나 문자 데이터로부터 특정결과를 얻고자 할 때 사용 */
-- UPPER : 대문자 변경
-- LOWER : 소문자 변경
-- INITCAP : 첫 글자만 대문자 나머지는 소문자
SELECT ENAME, UPPER(ENAME), LOWER(ENAME), INITCAP(ENAME)
    FROM EMP;

-- WHERE 조건절에서 사용하기
SELECT *
    FROM EMP
    WHERE UPPER(ENAME) = UPPER('james'); -- = JAVA의 EQUALSIGNORECASE()와 같음

-- UPPER함수와 LIKE절 함께 사용
SELECT *
    FROM EMP
    WHERE UPPER(ENAME) LIKE UPPER('%ja%');

SELECT INITCAP('yeon joo') AS 이름 FROM DUAL;

/* 사원이름 : 대문자, 직책 : 첫 글자만 대문자, 나머지는 소문자로 변경하고 급여가가 높은 순으로 표시 */
SELECT UPPER(ENAME) AS 이름, INITCAP(JOB) AS 직책, SAL AS 급여
    FROM EMP
    ORDER BY SAL DESC;
    
/* 문자열 길이 */
-- LENGTH 
SELECT ENAME, LENGTH(ENAME) AS "이름의 글자 수"
    FROM EMP;

/* 이름의 길이가 5와 같거나 큰 사원의 이름, 사원번호, 직책은 연봉 순으로 표시, 단 보너스 제외 */
SELECT ENAME 사원이름, EMPNO 사원번호, JOB 직책, SAL*12 AS 연봉
    FROM EMP
    WHERE LENGTH(ENAME) >= 5
    ORDER BY 연봉 DESC; 

-- LENGTH : 문자열의 길이를 반환
-- LENGTHB : 문자열의 바이트 수 반환
SELECT LENGTH('한글'), LENGTHB('한글')
    FROM DUAL; -- LENTHB = BYTE값 (오라클에서 한글 한 자의 BYTE값은 3)

/* 직책 이름이 6자 이상이고 COMM이 있는 사원 출력 */
SELECT *
    FROM EMP
    WHERE LENGTH(JOB) >= 6
    AND COMM IS NOT NULL AND COMM != 0;

/* SUBSTR / SUBSTRB : 대상 문자열이나 컬럼의 자료에서 시작위치부터 선택 개수만큼 문자를 반환하는 함수, 인덱스 개념X */
-- SUBSTR(문자열 데이터, 시작위치, 길이)
SELECT JOB, SUBSTR(JOB, 1, 2), SUBSTR(JOB, 3, 2), SUBSTR(JOB, 5)
    FROM EMP;
SELECT * FROM EMP;


-- SUBSTR 함수와 다른 함수 함께 사용
SELECT JOB,
    SUBSTR(JOB, -LENGTH(JOB),2)
    FROM EMP;
    
/* INSTR : 문자열 데이터 안에 특정문자나 문자열이 어디에 포함되어 있는지 알고자 할 때 사용 */
SELECT INSTR('HELLO, ORACLE!!', 'L') AS INSTR_1 FROM DUAL;
SELECT INSTR('HELLO, ORACLE!!', 'L', 5) AS INSTR_2 FROM DUAL; -- 찾을 문자 시작 위치를 지정
SELECT INSTR('HELLO, ORACLE!!', 'L', 2, 2) AS INSTR_3 FROM DUAL; -- 시작 위치에서 찾을 문자가 몇 번째인지 지정

    
    
    