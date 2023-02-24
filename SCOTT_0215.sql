/* 230215 WED */
SELECT JOB,
    SUBSTR(JOB, -LENGTH(JOB)), -- JOB�� ���̴� 5�̰� 5�� ���� ������ ���ϸ� �ڿ��� ���� �������� Ŀ���鼭 
    SUBSTR(JOB, -LENGTH(JOB), 1),
    SUBSTR(JOB, -3)
    FROM EMP;

-- REPLACE : Ư�� ���ڿ� �����Ϳ� ���Ե� ���ڸ� �ٸ� ���ڷ� ��ü �� �� ��� (�ڹ��� ������ ����)
-- ��ü�� ���ڿ��� ���� ������ ������ ȿ��
SELECT '010-5006-4146' AS ��������,
    REPLACE('010-5006-4146', '-', ' ') AS "�������� ��������",
    REPLACE('010-5006-4146', '-') AS "�����»���"
    FROM DUAL;
    
-- LPAD / RPAD : ������ ���� ĭ ���� �����ϰ� ĭ �� ��ŭ ��ĭ�� Ư�� ���ڷ� ä��� ���
SELECT LPAD('ORACLE', 10, '+') FROM DUAL;
SELECT RPAD('ORACLE', 10, '+') FROM DUAL;
SELECT 'ORACLE',
    LPAD('ORACLE', 10, '#') AS LPAD_1,
    RPAD('ORACLE', 10, '*') AS RPAD_1,
    LPAD('ORACLE', 10) AS LPAD_2, -- �������� ��ĭ ä��
    RPAD('ORACLE', 10) AS RPAD_2
    FROM DUAL;
    
-- �������� ���ڸ��� *ǥ�÷� ����ϱ�
SELECT
    RPAD('971225-', 14, '*') AS RPAD_JUMIN,
    RPAD('010-5006-', 13, '*') AS RPAD_PHONE
    FROM DUAL;
    
-- �� ���ڿ��� ��ġ�� CONCAT �Լ�
SELECT CONCAT(EMPNO, ENAME),
    CONCAT(EMPNO, CONCAT(' : ', ENAME)) -- ��ø���
    FROM EMP
    WHERE ENAME = 'JAMES';
    
-- TRIM/LTRIM/RTRIM : ���ڿ� ������ Ư�� ���ڸ� ����� ���ػ��
SELECT '[' || TRIM(' _ORANGE_ ') || ']' AS TRIM,
    '[' || LTRIM(' _ORANGE_ ') || ']' AS LTRIM,
    '[' || LTRIM('<_ORANGE_>', '_<') || ']' AS LTRIM_2, -- Ư�����ڸ� ����µ� ������ ��縸 ������ �� �κ��� ������(������ ���� �ʾƵ� ��)
    '[' || RTRIM(' _ORANGE_ ') || ']' AS RTRIM,
    '[' || RTRIM('<_ORANGE_>', '>_') || ']' AS RTRIM_2
    FROM DUAL;
    
SELECT LTRIM('             HEATHER               ') FROM DUAL; --  �յ� ������ ���� �� �� �����ϰ� ��밡��

/* ��¥ ����Ÿ�� �ٷ�� ��¥ �Լ� */
SELECT SYSDATE FROM DUAL;

SELECT SYSDATE AS NOW,
    SYSDATE-1 AS YESTERDAY, -- �ü������ �о�� �ð� �������� 1���� �� = ����
    SYSDATE+1 AS TOMORROW  -- �ü������ �о�� �ð� �������� 1���� ���� = ����
    FROM DUAL;
    
/* �� ���� ������ ��¥�� ���ϴ� ADD_MONTHS �Լ� */
-- Ư�� ��¥�� ������ ���� �� ���� ��¥ �����͸� ��ȯ �ϴ� �Լ�
-- ADD_MONTHS(��¥ ������, ���� ���� ��)
SELECT SYSDATE,
    ADD_MONTHS(SYSDATE, 3)
    FROM DUAL;

/* �ǽ� ���� */
-- �Ի� 10�ֳ��� �Ǵ� ��������� �����ȣ, �̸�, �Ի���, 10�ֳ� ����� ��¥ ��� 
SELECT EMPNO �����ȣ, ENAME �̸�, HIREDATE �Ի���, ADD_MONTHS(HIREDATE, 120) AS "10�ֳ�"
    FROM EMP;

-- ���� �ð��� 8���� ���� �ð� ���
SELECT SYSDATE AS ���糯¥,
    ADD_MONTHS(SYSDATE, 8) AS "8������"
    FROM DUAL;
    
/* �� ��¥���� ���� �� ���̸� ���ϴ� MONTHS_BETWEEN �Լ� */
SELECT EMPNO, ENAME, HIREDATE, SYSDATE,
    MONTHS_BETWEEN(HIREDATE, SYSDATE) AS MONTH1,
    MONTHS_BETWEEN(SYSDATE, HIREDATE) AS MONTH2,
    TRUNC(MONTHS_BETWEEN(SYSDATE, HIREDATE)) AS MONTH3
FROM EMP;

/* ���ƿ��� ����, ���� ������ ��¥�� ���ϴ� NEXT_DAY, LAST_DAY �Լ� */
-- NEXT_DAY(��¥������, ���Ϲ���): ��¥ �������� ���ƿ��� ������ ��¥�� ���
-- LAST_DAY(��¥������) : ��¥�� ���� ���� ������ ��¥�� ���
SELECT SYSDATE,
    NEXT_DAY(SYSDATE, '������'), --'��'�� �־ ��
    LAST_DAY(SYSDATE)
FROM DUAL;

-- ��¥�� �ݿø�, ������ �ϴ� ROUND, TRUNC�Լ�
SELECT EMPNO, ENAME, HIREDATE, SYSDATE,
    ROUND(MONTHS_BETWEEN(SYSDATE, HIREDATE)) AS MONTH1
    FROM EMP;

SELECT ENAME, HIREDATE, 
    ROUND(MONTHS_BETWEEN(SYSDATE, HIREDATE) /12)
    FROM EMP;
    
-- ��¥ ������ �����ϴ� �Լ�
SELECT EXTRACT(YEAR FROM DATE '1998-03-07')
    FROM DUAL;
    
SELECT *
    FROM EMP
    WHERE EXTRACT(MONTH FROM HIREDATE) = 12;
    
SELECT EXTRACT(MONTH FROM SYSDATE) FROM DUAL; -- ���� ������� ����

/* �ڷ����� ��ȯ�ϴ� �� ��ȯ �Լ� */
-- ����Ŭ�� �ڹٿ� ���������� ���������ȯ�� ����������ȯ�� ����
-- �ڵ�(������) ����ȯ : ���ڿ� ���� �ڷ����� ������ �ڵ����� ���ڷ� ��ȯ(�ڹٿ� �ٸ���)
SELECT EMPNO, ENAME, EMPNO + '500'
    FROM EMP;
    
SELECT EMPNO, ENAME, EMPNO + 'ABC' -- INVALID NUMBER ������ �߻�
    FROM EMP;
    
/* ��¥, ���ڸ� ���ڷ� ��ȯ�ϴ� TO_CHAR �Լ� */
-- TO_CHAR �Լ��� ��¥, ���� �����͸� ���� �����ͷ� ��ȯ�� �ִ� �Լ�; �ַ� ��¥ �����͸� ���� �����ͷ� ��ȯ�� ���� ���
-- TO_CHAR(��¥������, ��µǱ⸦ ���ϴ� ���� ����)
SELECT TO_CHAR(SYSDATE, 'YYYY/MM/DD HH24:MI:SS') AS "���� ��¥�� �ð�" FROM DUAL;

-- �پ��� �������� ����ϱ�
SELECT SYSDATE,
    TO_CHAR(SYSDATE, 'CC') AS ����,
    TO_CHAR(SYSDATE, 'YY') AS ����,
    TO_CHAR(SYSDATE, 'YYYY/MM/DD AM HH:MI:SS') AS "��/��/�� ��:��:��", -- AM/PM �ƹ��ų� �־ ��
    TO_CHAR(SYSDATE, 'Q') AS ����,
    TO_CHAR(SYSDATE, 'DD') AS ��,
    TO_CHAR(SYSDATE, 'DDD') AS �����,
    TO_CHAR(SYSDATE, 'HH') AS "12�ð���",
    TO_CHAR(SYSDATE, 'HH12') AS "12�ð���",
    TO_CHAR(SYSDATE, 'HH24') AS "24�ð���",
    TO_CHAR(SYSDATE, 'W') AS ������
FROM DUAL;

-- Ư�� �� ���缭 ��¥ ����ϱ� NLS : NATIONAL LANGUAGE SUPPORT
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

-- ���� ������ ������ �����Ͽ� ���
-- 9 : ������ �� �ڸ��� �ǹ��ϰ� �� �ڸ��� ä���� ����
-- 0 : �� �ڸ��� 0���� ä��
-- $ : �޷� ǥ�ø� ����
-- L : ���� ȭ�� ������ ǥ��
-- . : �Ҽ��� ǥ��
-- 9�� 0���� �־��� �κ��� ��� �� ä����(�ڸ�������)
SELECT SAL,
    TO_CHAR(SAL, '$999,999') AS SAL_$, -- 1000�ڸ��� �Ѿ�� ,�� ��ڴٴ� �ǹ��̰�, �������� ������ �� �ڸ��� ä���� �ʰ� ����ǥ��
    TO_CHAR(SAL, 'L999,999') AS SAL_L, -- ���� ȭ�� ǥ��, õ������ , �߰�
    TO_CHAR(SAL, '999,999.00') AS SAL_1, -- �Ҽ��� ���� 2�ڸ� ǥ��
    TO_CHAR(SAL, '$000,999,999.00') AS SAL_2, -- ���ڸ��� 0���� ä��
    TO_CHAR(SAL, '000999999.99') AS SAL_3, -- �Ҽ����� �ִٸ� ���ڸ����� ����
    TO_CHAR(SAL, '999,999,00') AS SAL_4 -- ���ڸ��� , �� ����
FROM EMP;
    
/* TO_NUMBER : ����Ÿ���� ���ڿ��� ���ڷ� ����ȯ; ����Ÿ���� ���ڿ��� �ڵ�����ȯ�� �Ͼ�� ������ �� ���� ���� ����*/
SELECT TO_NUMBER('1300') - TO_NUMBER('1500'),
    '1300' + 1500
FROM DUAL;
-- ���� �Ͱ� ���ƿ�
SELECT '1300' - '1500',
    '1300' + 1500
FROM DUAL;
   
/* TO_DATE : ���ڿ��� ��õ� ��¥�� ��ȯ�ϴ� �Լ� */
SELECT TO_DATE('230317', 'YY/MM/DD') FROM DUAL; -- DATEŸ������ �ٲ�� ��

SELECT TO_CHAR(SYSDATE, 'YY/MM/DD') FROM DUAL; -- ����Ÿ������ �ٲ�� ��
-- ���� �ΰ��� ����� ���ƺ����� Ÿ���� �ٸ�

SELECT *
    FROM EMP
    WHERE HIREDATE < TO_DATE(SYSDATE, 'YY/MM/DD'); 
SELECT *
    FROM EMP
    WHERE HIREDATE < TO_CHAR(SYSDATE, 'YY/MM/DD');
-- DATEŸ���� DATEŸ���̳� ����Ÿ������ ���ص� ��� ���� --

SELECT *
    FROM EMP
    WHERE HIREDATE < TO_DATE('1981/01/01', 'YYYY/MM/DD');
SELECT *
    FROM EMP
    WHERE HIREDATE < TO_CHAR('1981/01/01', 'YYYY/MM/DD'); -- ��¥�� �����־� ���Ҷ��� TO_CHAR�� ���ڿ��̱� ������ �񱳰� �ȵ�
    

/* 1981�� 6�� 1�� ���Ŀ� �Ի��� ��� ���� ��� */
SELECT *
    FROM EMP
    WHERE HIREDATE > TO_DATE('1981/06/01', 'YYYY/MM/DD');
    
/* NVL �Լ� */
-- NVL (�����Ϳ�, ���� �����Ͱ� NULL�� ��� ��ȯ�� ������)
SELECT EMPNO, ENAME, SAL, COMM,
    NVL(COMM, 0),
    SAL*12+NVL(COMM,0)
    FROM EMP;

/* NVL2([NULL���� ���θ� �˻��� ������ �Ǵ� ��(�ʼ�)],
[�� �����Ͱ� NULL�� �ƴ� ��� ��ȯ�� ������ �Ǵ� ����(�ʼ�)],
[�� �����Ͱ� NULL�� ��� ��ȯ�� ������ �Ǵ� ����(�ʼ�)]) */

SELECT EMPNO, ENAME, COMM,
    NVL2(COMM, 'O', 'X') AS "NULL ���� ǥ��",
    NVL2(COMM, SAL*12+COMM, SAL*12) AS "���� ���"
FROM EMP;

-- NULLIF : �� ���� ���Ͽ� �������� �ƴ����� ���� ��� ��ȯ
-- ������ NULL ��ȯ, �������� ������ ù ��° ���� ��ȯ

SELECT NULLIF(10, 10), NULLIF('A', 'B') FROM DUAL;

/* DECODE : �־��� �����Ϳ��� ���� ���� ���� ��ġ�ϴ� ���� ����ϰ� ��ġ�ϴ� ���� ������ �⺻�� ��� */
-- ���ǹ� �Ǵ� SWITCH���� ����
SELECT EMPNO, ENAME, JOB, SAL,
    DECODE(JOB,
        'MANAGER', SAL*1.1,
        'SALESMAN', SAL*1.05,
        'ANALYST', SAL,
        SAL*1.03) AS "�޿��λ�"
FROM EMP;

/* CASE ��: �־��� ������ ���� ���� ���� ��ġ�ϴ� ���� ����ϰ� ��ġ�ϴ� ���� ������ �⺻�� ��� */
SELECT EMPNO, ENAME, JOB, SAL,
    CASE JOB
        WHEN 'MANAGER' THEN SAL*1.1
        WHEN 'SALESMAN' THEN SAL*1.05
        WHEN 'ANALYST' THEN SAL
        ELSE SAL*1.03
    END AS "�޿��λ�"
FROM EMP;

-- �� ���� ���� ��°��� �޶����� CASE��, IF ELSE ���� ����
SELECT EMPNO, ENAME, COMM,
    CASE 
        WHEN COMM IS NULL THEN '�ش���� ����' -- THEN������ ""��ſ� ''�� ����ؾ���
        WHEN COMM = 0 THEN '���� ����'
        WHEN COMM > 0 THEN '���� : ' || COMM
    END AS "���� ǥ��"
FROM EMP;


/* �ǽ� ���� */
-- EX1) EMPNO������ EMP���̺��� ����̸��� �ټ����� �̻��̸� �������� �̸��� ��������� ���, MASKING_EMPNO������ �����ȣ �� ���ڸ� �� ���ڸ��� *��ȣ�� ���
-- MASKING_ENAME ������ ����̸��� ù ���ڸ� �����ְ� ������ ���� �� ��ŭ * ��ȣ�� ���
SELECT EMPNO, REPLACE(EMPNO,SUBSTR(EMPNO,3,4),'**') MASKING_EMPNO, ENAME, REPLACE(ENAME, SUBSTR(ENAME,2),'****') MASKING_ENAME
    FROM EMP
    WHERE LENGTH(ENAME) >= 5 AND LENGTH(ENAME) < 6;
-- EX2) EMP���̺��� ������� �� ��� �ٹ��ϼ��� 21.5���Դϴ�. �Ϸ� �ٹ��ð��� 8�ð����� ������ �� ������� �Ϸ�޿�(DAY_PAY)�� �ñ�(TIME_PAY)�� ����Ͽ� ����� ���
-- �� �Ϸ� �޿��� �Ҽ��� �� ��° �ڸ����� ������, �ñ��� �� ��° �Ҽ������� �ݿø�
SELECT EMPNO, ENAME, SAL, TRUNC(SAL / 21.5, 2) AS DAY_PAY, ROUND((SAL /21.5)/8, 1) AS TIME_PAY
    FROM EMP;
-- EX3) EMP ���̺��� ������� �Ի����� �������� 3������ ���� �� ù �����Ͽ� �������� ��.
-- ������� �������� �Ǵ� ��¥(R_JOB)�� YYYY-MM-DD�������� ���. ��, �߰������� ���� ����� �߰� ������ N/A�� ���
SELECT EMPNO, ENAME, HIREDATE, TO_CHAR(ADD_MONTHS(HIREDATE, 3), 'YYYY/MM/DD') AS R_JOB, REPLACE(COMM,'NULL','N/A') COMM
    FROM EMP;

-- EX4) EMP���̺��� ������� ������� ���ӻ���� �����ȣ(MGR)�� ������ ���� ������ �������� ��ȯ�ؼ� CHG_MGR���� ���
-- �����ȣ �������� ������� : 0000
-- �� ���ڸ��� 75�� ��� : 5555
-- �� ���ڸ��� 76�� ��� : 6666
-- �� ���ڸ��� 77�� ��� : 7777
-- �� ���ڸ��� 78�� ��� : 8888
-- �� �� ���ӻ�� �����ȣ�� ��� : ���� ���ӻ���� �����ȣ �״�� ���
SELECT EMPNO, ENAME, MGR,
    CASE 
        WHEN MGR IS NULL THEN '0000'
        WHEN MGR ;
        
 /* SCOTT ���� ���� */
-- Q1) ���� ��¥�� ���� ���� ��ȸ
SELECT SYSDATE FROM DUAL;

-- Q2) EMP���̺��� ���, �����, �޿���ȸ( ��, �޿� 100���������� ���� ��� ó���ϰ� ���� �������� ����)
SELECT EMPNO, ENAME, TRUNC(SAL, -2) SAL
    FROM EMP
    ORDER BY SAL;
    
-- Q3) EMP���̺��� �����ȣ�� Ȧ���� ����� ��ȸ
SELECT EMPNO / 2 !=0 AS EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO 
    FROM EMP;
-- Q4) EMP���̺��� �����, �Ի��� ��ȸ(��, �Ի����� �⵵�� ���� �и� �����ؼ� ���)
SELECT ENAME, HIREDATE
    FROM EMP; 
-- Q5) EMP���̺��� 9���� �Ի��� ������ ������ȸ
SELECT *
    FROM EMP
    WHERE EXTRACT(MONTH FROM HIREDATE) = 9;
-- Q6) EMP���̺��� 81�⵵�� �Ի��� ������ȸ
SELECT EXTRACT(YEAR FORM DATE HIREDATE) = '1981'
    FROM EMP;
-- Q7) EMP���̺��� �̸��� 'E'�� ������ ���� ��ȸ
SELECT *
    FROM EMP
    WHERE ENAME LIKE '%E';
-- Q8) EMP���̺��� �̸��� �� ��° ���ڰ� 'R'�� ������ ���� ��ȸ
SELECT *
    FROM EMP
    WHERE ENAME LIKE '__R%';
-- Q9) EMP���̺��� ���, �����, �Ի���, �Ի��Ϸκ��� 40�� �Ǵ� ��¥ ��ȸ
SELECT EMPNO, ENAME, HIREDATE, ADD_MONTHS(HIREDATE, 12*40) AS "40�ֳ�"
    FROM EMP;
-- Q10) EMP���̺��� �Ի��Ϸκ��� 38�� �̻� �ٹ��� ������ ���� ��ȸ
SELECT *
    FROM EMP
    WHERE  MONTHS_BETWEEN(SYSDATE, HIREDATE) >= 38*12;
    
-- Q11) ���� ��¥���� �⵵�� ����
SELECT EXTRACT(YEAR FORM SYSDATE) FROM DUAL;

SELECT HIREDATE, (EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM HIREDATE)) �ٹ����,  TRUNC(MONTHS_BETWEEN(SYSDATE, HIREDATE) /12 -1) AS "�Լ���"
    FROM EMP;