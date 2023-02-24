/* 230215 WED */
SELECT JOB,
    SUBSTR(JOB, -LENGTH(JOB)), -- JOB의 길이는 5이고 5에 대한 음수를 취하면 뒤에서 부터 음수값이 커지면서 
    SUBSTR(JOB, -LENGTH(JOB), 1),
    SUBSTR(JOB, -3)
    FROM EMP;

-- REPLACE : 특정 문자열 데이터에 포함된 문자를 다른 문자로 대체 할 때 사용 (자바의 문법과 유사)
-- 대체할 문자열을 넣지 않으면 삭제의 효과
SELECT '010-5006-4146' AS 변경이전,
    REPLACE('010-5006-4146', '-', ' ') AS "하이픈을 공백으로",
    REPLACE('010-5006-4146', '-') AS "하이픈삭제"
    FROM DUAL;
    
-- LPAD / RPAD : 공간에 대한 칸 수를 지정하고 칸 수 만큼 빈칸을 특정 문자로 채우는 기능
SELECT LPAD('ORACLE', 10, '+') FROM DUAL;
SELECT RPAD('ORACLE', 10, '+') FROM DUAL;
SELECT 'ORACLE',
    LPAD('ORACLE', 10, '#') AS LPAD_1,
    RPAD('ORACLE', 10, '*') AS RPAD_1,
    LPAD('ORACLE', 10) AS LPAD_2, -- 공백으로 빈칸 채움
    RPAD('ORACLE', 10) AS RPAD_2
    FROM DUAL;
    
-- 개인정보 뒷자리를 *표시로 출력하기
SELECT
    RPAD('971225-', 14, '*') AS RPAD_JUMIN,
    RPAD('010-5006-', 13, '*') AS RPAD_PHONE
    FROM DUAL;
    
-- 두 문자열을 합치는 CONCAT 함수
SELECT CONCAT(EMPNO, ENAME),
    CONCAT(EMPNO, CONCAT(' : ', ENAME)) -- 중첩사용
    FROM EMP
    WHERE ENAME = 'JAMES';
    
-- TRIM/LTRIM/RTRIM : 문자열 내에서 특정 문자를 지우기 위해사용
SELECT '[' || TRIM(' _ORANGE_ ') || ']' AS TRIM,
    '[' || LTRIM(' _ORANGE_ ') || ']' AS LTRIM,
    '[' || LTRIM('<_ORANGE_>', '_<') || ']' AS LTRIM_2, -- 특정문자르 지우는데 문자의 모양만 맞으면 그 부분이 지워짐(순서가 맞지 않아도 됨)
    '[' || RTRIM(' _ORANGE_ ') || ']' AS RTRIM,
    '[' || RTRIM('<_ORANGE_>', '>_') || ']' AS RTRIM_2
    FROM DUAL;
    
SELECT LTRIM('             HEATHER               ') FROM DUAL; --  앞뒤 공백을 지울 때 더 간단하게 사용가능

/* 날짜 데이타를 다루는 날짜 함수 */
SELECT SYSDATE FROM DUAL;

SELECT SYSDATE AS NOW,
    SYSDATE-1 AS YESTERDAY, -- 운영체제에서 읽어온 시간 정보에서 1일을 뺌 = 어제
    SYSDATE+1 AS TOMORROW  -- 운영체제에서 읽어온 시간 정보에서 1일을 더함 = 내일
    FROM DUAL;
    
/* 몇 개월 이후의 날짜를 구하는 ADD_MONTHS 함수 */
-- 특정 날짜에 지정한 개월 수 이후 날짜 데이터를 반환 하는 함수
-- ADD_MONTHS(날짜 데이터, 더할 개월 수)
SELECT SYSDATE,
    ADD_MONTHS(SYSDATE, 3)
    FROM DUAL;

/* 실습 문제 */
-- 입사 10주년이 되는 사원에대해 사원번호, 이름, 입사일, 10주년 경과된 날짜 출력 
SELECT EMPNO 사원번호, ENAME 이름, HIREDATE 입사일, ADD_MONTHS(HIREDATE, 120) AS "10주년"
    FROM EMP;

-- 현재 시간과 8개월 이후 시간 출력
SELECT SYSDATE AS 현재날짜,
    ADD_MONTHS(SYSDATE, 8) AS "8개월후"
    FROM DUAL;
    
/* 두 날짜간의 개월 수 차이를 구하는 MONTHS_BETWEEN 함수 */
SELECT EMPNO, ENAME, HIREDATE, SYSDATE,
    MONTHS_BETWEEN(HIREDATE, SYSDATE) AS MONTH1,
    MONTHS_BETWEEN(SYSDATE, HIREDATE) AS MONTH2,
    TRUNC(MONTHS_BETWEEN(SYSDATE, HIREDATE)) AS MONTH3
FROM EMP;

/* 돌아오는 요일, 달의 마지막 날짜를 구하는 NEXT_DAY, LAST_DAY 함수 */
-- NEXT_DAY(날짜데이터, 요일문자): 날짜 기준으로 돌아오는 요일의 날짜를 출력
-- LAST_DAY(날짜데이터) : 날짜가 속한 달의 마지막 날짜를 출력
SELECT SYSDATE,
    NEXT_DAY(SYSDATE, '월요일'), --'월'만 넣어도 됨
    LAST_DAY(SYSDATE)
FROM DUAL;

-- 날짜를 반올림, 버림을 하는 ROUND, TRUNC함수
SELECT EMPNO, ENAME, HIREDATE, SYSDATE,
    ROUND(MONTHS_BETWEEN(SYSDATE, HIREDATE)) AS MONTH1
    FROM EMP;

SELECT ENAME, HIREDATE, 
    ROUND(MONTHS_BETWEEN(SYSDATE, HIREDATE) /12)
    FROM EMP;
    
-- 날짜 정보를 추출하는 함수
SELECT EXTRACT(YEAR FROM DATE '1998-03-07')
    FROM DUAL;
    
SELECT *
    FROM EMP
    WHERE EXTRACT(MONTH FROM HIREDATE) = 12;
    
SELECT EXTRACT(MONTH FROM SYSDATE) FROM DUAL; -- 현재 몇월인지 추출

/* 자료형을 변환하는 형 변환 함수 */
-- 오라클도 자바와 마찬가지로 명시적형변환과 묵시적형변환이 있음
-- 자동(묵시적) 형변환 : 숫자와 문자 자료형의 연산은 자동으로 숫자로 변환(자바와 다른점)
SELECT EMPNO, ENAME, EMPNO + '500'
    FROM EMP;
    
SELECT EMPNO, ENAME, EMPNO + 'ABC' -- INVALID NUMBER 에러가 발생
    FROM EMP;
    
/* 날짜, 숫자를 문자로 변환하는 TO_CHAR 함수 */
-- TO_CHAR 함수는 날짜, 숫자 데이터를 문자 데이터로 변환해 주는 함수; 주로 날짜 데이터를 문자 데이터로 변환시 자주 사용
-- TO_CHAR(날짜데이터, 출력되기를 원하는 문자 형태)
SELECT TO_CHAR(SYSDATE, 'YYYY/MM/DD HH24:MI:SS') AS "현재 날짜와 시간" FROM DUAL;

-- 다양한 형식으로 출력하기
SELECT SYSDATE,
    TO_CHAR(SYSDATE, 'CC') AS 세기,
    TO_CHAR(SYSDATE, 'YY') AS 연도,
    TO_CHAR(SYSDATE, 'YYYY/MM/DD AM HH:MI:SS') AS "년/월/일 시:분:초", -- AM/PM 아무거나 넣어도 됨
    TO_CHAR(SYSDATE, 'Q') AS 쿼터,
    TO_CHAR(SYSDATE, 'DD') AS 일,
    TO_CHAR(SYSDATE, 'DDD') AS 경과일,
    TO_CHAR(SYSDATE, 'HH') AS "12시간제",
    TO_CHAR(SYSDATE, 'HH12') AS "12시간제",
    TO_CHAR(SYSDATE, 'HH24') AS "24시간제",
    TO_CHAR(SYSDATE, 'W') AS 몇주차
FROM DUAL;

-- 특정 언어에 맞춰서 날짜 출력하기 NLS : NATIONAL LANGUAGE SUPPORT
SELECT SYSDATE,
    TO_CHAR(SYSDATE, 'MM') AS MM,
    TO_CHAR(SYSDATE, 'MON', 'NLS_DATE_LANGUAGE = KOREAN') AS MON_KR,
    TO_CHAR(SYSDATE, 'MON', 'NLS_DATE_LANGUAGE = JAPANESE') AS MON_JP,
    TO_CHAR(SYSDATE, 'MON', 'NLS_DATE_LANGUAGE = ENGLISH') AS MON_EN,
    TO_CHAR(SYSDATE, 'MONTH', 'NLS_DATE_LANGUAGE = KOREAN') AS MON_KR,
    TO_CHAR(SYSDATE, 'MONTH', 'NLS_DATE_LANGUAGE = JAPANESE') AS MON_JP,
    TO_CHAR(SYSDATE, 'MONTH', 'NLS_DATE_LANGUAGE = ENGLISH') AS MON_EN
FROM DUAL;

SELECT SYSDATE,
    TO_CHAR(SYSDATE, 'MM') AS MM,
    TO_CHAR(SYSDATE, 'DD') AS DD,
    TO_CHAR(SYSDATE, 'DY', 'NLS_DATE_LANGUAGE = KOREAN') AS DY_KR,
    TO_CHAR(SYSDATE, 'DY', 'NLS_DATE_LANGUAGE = JAPANESE') AS DY_JP,
    TO_CHAR(SYSDATE, 'DY', 'NLS_DATE_LANGUAGE = ENGLISH') AS DY_EN,
    TO_CHAR(SYSDATE, 'DAY', 'NLS_DATE_LANGUAGE = KOREAN') AS DAY_KR,
    TO_CHAR(SYSDATE, 'DAY', 'NLS_DATE_LANGUAGE = JAPANESE') AS DAY_JP,
    TO_CHAR(SYSDATE, 'DAY', 'NLS_DATE_LANGUAGE = ENGLISH') AS DAY_EN
FROM DUAL;

SELECT SYSDATE,
    TO_CHAR(SYSDATE, 'HH24:MI:SS') AS HH24MISS,
    TO_CHAR(SYSDATE, 'HH12:MI:SS AM') AS HHMISS_AM,
    TO_CHAR(SYSDATE, 'HH:MI:SS P.M.') AS HHMISS_PM
FROM DUAL;

-- 숫자 데이터 형식을 지정하여 출력
-- 9 : 숫자의 한 자리를 의미하고 빈 자리를 채우지 않음
-- 0 : 빈 자리를 0으로 채움
-- $ : 달러 표시를 붙임
-- L : 지역 화페 단위를 표시
-- . : 소수점 표시
-- 9나 0으로 넣어준 부분은 모두 다 채워짐(자리수가됨)
SELECT SAL,
    TO_CHAR(SAL, '$999,999') AS SAL_$, -- 1000자리를 넘어가면 ,를 찍겠다는 의미이고, 단위보다 작으면 빈 자리를 채우지 않고 숫자표시
    TO_CHAR(SAL, 'L999,999') AS SAL_L, -- 지역 화폐 표시, 천단위에 , 추가
    TO_CHAR(SAL, '999,999.00') AS SAL_1, -- 소수점 이하 2자리 표시
    TO_CHAR(SAL, '$000,999,999.00') AS SAL_2, -- 빈자리를 0으로 채움
    TO_CHAR(SAL, '000999999.99') AS SAL_3, -- 소수점이 있다면 두자리까지 찍힘
    TO_CHAR(SAL, '999,999,00') AS SAL_4 -- 두자리에 , 가 찍힘
FROM EMP;
    
/* TO_NUMBER : 숫자타입의 문자열을 숫자로 형변환; 숫자타입의 문자열은 자동형변환이 일어나기 때문에 쓸 일이 별로 없음*/
SELECT TO_NUMBER('1300') - TO_NUMBER('1500'),
    '1300' + 1500
FROM DUAL;
-- 위의 것과 같아요
SELECT '1300' - '1500',
    '1300' + 1500
FROM DUAL;
   
/* TO_DATE : 문자열로 명시된 날짜로 변환하는 함수 */
SELECT TO_DATE('230317', 'YY/MM/DD') FROM DUAL; -- DATE타입으로 바뀌는 것

SELECT TO_CHAR(SYSDATE, 'YY/MM/DD') FROM DUAL; -- 문자타입으로 바뀌는 것
-- 위의 두개의 결과가 같아보여도 타입이 다름

SELECT *
    FROM EMP
    WHERE HIREDATE < TO_DATE(SYSDATE, 'YY/MM/DD'); 
SELECT *
    FROM EMP
    WHERE HIREDATE < TO_CHAR(SYSDATE, 'YY/MM/DD');
-- DATE타입을 DATE타입이나 문자타입으로 비교해도 상관 없음 --

SELECT *
    FROM EMP
    WHERE HIREDATE < TO_DATE('1981/01/01', 'YYYY/MM/DD');
SELECT *
    FROM EMP
    WHERE HIREDATE < TO_CHAR('1981/01/01', 'YYYY/MM/DD'); -- 날짜를 직접넣어 비교할때는 TO_CHAR이 문자열이기 때문에 비교가 안됨
    

/* 1981년 6월 1일 이후에 입사한 사원 정보 출력 */
SELECT *
    FROM EMP
    WHERE HIREDATE > TO_DATE('1981/06/01', 'YYYY/MM/DD');
    
/* NVL 함수 */
-- NVL (데이터열, 앞의 데이터가 NULL일 경우 반환할 데이터)
SELECT EMPNO, ENAME, SAL, COMM,
    NVL(COMM, 0),
    SAL*12+NVL(COMM,0)
    FROM EMP;

/* NVL2([NULL인지 여부를 검사할 데이터 또는 열(필수)],
[앞 데이터가 NULL이 아닐 경우 반환할 데이터 또는 계산식(필수)],
[앞 데이터가 NULL일 경우 반환할 데이터 또는 계산식(필수)]) */

SELECT EMPNO, ENAME, COMM,
    NVL2(COMM, 'O', 'X') AS "NULL 여부 표시",
    NVL2(COMM, SAL*12+COMM, SAL*12) AS "연봉 계산"
FROM EMP;

-- NULLIF : 두 값을 비교하여 동일인지 아닌지에 대한 결과 반환
-- 같으면 NULL 반환, 동일하지 않으면 첫 번째 값을 반환

SELECT NULLIF(10, 10), NULLIF('A', 'B') FROM DUAL;

/* DECODE : 주어진 데이터에서 값이 조건 값과 일치하는 값을 출력하고 일치하는 값이 없으면 기본값 출력 */
-- 조건문 또는 SWITCH문과 유사
SELECT EMPNO, ENAME, JOB, SAL,
    DECODE(JOB,
        'MANAGER', SAL*1.1,
        'SALESMAN', SAL*1.05,
        'ANALYST', SAL,
        SAL*1.03) AS "급여인상"
FROM EMP;

/* CASE 문: 주어진 데이터 값이 조건 값과 일치하는 값을 출력하고 일치하는 값이 없으면 기본값 출력 */
SELECT EMPNO, ENAME, JOB, SAL,
    CASE JOB
        WHEN 'MANAGER' THEN SAL*1.1
        WHEN 'SALESMAN' THEN SAL*1.05
        WHEN 'ANALYST' THEN SAL
        ELSE SAL*1.03
    END AS "급여인상"
FROM EMP;

-- 열 값에 따라서 출력값이 달라지는 CASE문, IF ELSE 문과 유사
SELECT EMPNO, ENAME, COMM,
    CASE 
        WHEN COMM IS NULL THEN '해당사항 없음' -- THEN절에는 ""대신에 ''를 사용해야함
        WHEN COMM = 0 THEN '수당 없음'
        WHEN COMM > 0 THEN '수당 : ' || COMM
    END AS "수당 표시"
FROM EMP;


/* 실습 문제 */
-- EX1) EMPNO열에는 EMP테이블에서 사원이름이 다섯글자 이상이며 여섯글자 미만인 사원정보를 출력, MASKING_EMPNO열에는 사원번호 앞 두자리 외 뒷자리를 *기호로 출력
-- MASKING_ENAME 열에는 사원이름의 첫 글자만 보여주고 나머지 글자 수 만큼 * 기호로 출력
SELECT EMPNO, REPLACE(EMPNO,SUBSTR(EMPNO,3,4),'**') MASKING_EMPNO, ENAME, REPLACE(ENAME, SUBSTR(ENAME,2),'****') MASKING_ENAME
    FROM EMP
    WHERE LENGTH(ENAME) >= 5 AND LENGTH(ENAME) < 6;
-- EX2) EMP테이블에서 사원들의 월 평균 근무일수는 21.5일입니다. 하루 근무시간을 8시간으로 보았을 때 사원들의 하루급여(DAY_PAY)와 시급(TIME_PAY)을 계산하여 결과를 출력
-- 단 하루 급여는 소수점 세 번째 자리에서 버리고, 시급은 두 번째 소수점에서 반올림
SELECT EMPNO, ENAME, SAL, TRUNC(SAL / 21.5, 2) AS DAY_PAY, ROUND((SAL /21.5)/8, 1) AS TIME_PAY
    FROM EMP;
-- EX3) EMP 테이블에서 사원들은 입사일을 기준으로 3개월이 지난 후 첫 월요일에 정직원이 됨.
-- 사원들이 정직원이 되는 날짜(R_JOB)을 YYYY-MM-DD형식으로 출력. 단, 추가수당이 없는 사원의 추가 수당은 N/A로 출력
SELECT EMPNO, ENAME, HIREDATE, TO_CHAR(ADD_MONTHS(HIREDATE, 3), 'YYYY/MM/DD') AS R_JOB, REPLACE(COMM,'NULL','N/A') COMM
    FROM EMP;

-- EX4) EMP테이블의 모든사원을 대상으로 직속상관의 사원번호(MGR)를 다음과 같은 조건을 기준으로 변환해서 CHG_MGR열에 출력
-- 사원번호 존재하지 않을경우 : 0000
-- 앞 두자리가 75인 경우 : 5555
-- 앞 두자리가 76인 경우 : 6666
-- 앞 두자리가 77인 경우 : 7777
-- 앞 두자리가 78인 경우 : 8888
-- 그 외 직속상관 사원번호인 경우 : 본래 직속상관의 사원번호 그대로 출력
SELECT EMPNO, ENAME, MGR,
    CASE 
        WHEN MGR IS NULL THEN '0000'
        WHEN MGR ;
        
 /* SCOTT 계정 문제 */
-- Q1) 오늘 날짜에 대한 정보 조회
SELECT SYSDATE FROM DUAL;

-- Q2) EMP테이블에서 사번, 사원명, 급여조회( 단, 급여 100단위까지의 값만 출력 처리하고 기준 내림차순 정렬)
SELECT EMPNO, ENAME, TRUNC(SAL, -2) SAL
    FROM EMP
    ORDER BY SAL;
    
-- Q3) EMP테이블에서 사원번호가 홀수인 사원들 조회
SELECT EMPNO / 2 !=0 AS EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO 
    FROM EMP;
-- Q4) EMP테이블에서 사원명, 입사일 조회(단, 입사일은 년도와 월을 분리 추출해서 출력)
SELECT ENAME, HIREDATE
    FROM EMP; 
-- Q5) EMP테이블에서 9월에 입사한 직원의 정보조회
SELECT *
    FROM EMP
    WHERE EXTRACT(MONTH FROM HIREDATE) = 9;
-- Q6) EMP테이블에서 81년도에 입사한 직원조회
SELECT EXTRACT(YEAR FORM DATE HIREDATE) = '1981'
    FROM EMP;
-- Q7) EMP테이블에서 이름이 'E'로 끝나는 직원 조회
SELECT *
    FROM EMP
    WHERE ENAME LIKE '%E';
-- Q8) EMP테이블에서 이름의 세 번째 글자가 'R'인 직원의 정보 조회
SELECT *
    FROM EMP
    WHERE ENAME LIKE '__R%';
-- Q9) EMP테이블에서 사번, 사원명, 입사일, 입사일로부터 40년 되는 날짜 조회
SELECT EMPNO, ENAME, HIREDATE, ADD_MONTHS(HIREDATE, 12*40) AS "40주년"
    FROM EMP;
-- Q10) EMP테이블에서 입사일로부터 38년 이상 근무한 직원의 정보 조회
SELECT *
    FROM EMP
    WHERE  MONTHS_BETWEEN(SYSDATE, HIREDATE) >= 38*12;
    
-- Q11) 오늘 날짜에서 년도만 추출
SELECT EXTRACT(YEAR FORM SYSDATE) FROM DUAL;

SELECT HIREDATE, (EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM HIREDATE)) 근무년수,  TRUNC(MONTHS_BETWEEN(SYSDATE, HIREDATE) /12 -1) AS "함수식"
    FROM EMP;