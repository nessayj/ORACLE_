/* 230214 TUE */
SELECT *
    FROM EMP
    WHERE JOB = 'MANAGER' 
        OR JOB = 'SALESMAN'
        OR JOB = 'CLERK';
        
/* IN ������ : Ư������ ���Ե� �����͸� ������ ��ȸ�Ҷ� Ȱ�� */
SELECT *
    FROM EMP
    WHERE JOB IN('MANAGER', 'SALESMAN', 'CLERK');

/* IN �����ڸ� ����Ͽ� �μ���ȣ�� 10���� 20���� ����� �����ȣ, �̸�, �Ի���, �޿���� */
SELECT EMPNO �����ȣ, ENAME �̸�, HIREDATE �Ի���, SAL �޿�
    FROM EMP
    WHERE DEPTNO IN(10, 20);

/* � �񱳿����ڿ� AND ������ */
SELECT *
    FROM EMP
    WHERE JOB != 'MANAGER' 
        AND JOB <> 'SALESMAN'
        AND JOB ^= 'CLERK';
        
/* �������� ������ : ���� ������ �����ϴ� BETWEEN ������ */
-- �޿��� 2000���� 3000���̿� �ִ� ��� ǥ��
SELECT *
    FROM EMP 
    WHERE SAL >= 2000
        AND SAL <= 3000;

/* BETWEEN 2000 AND 3000 => 2000�̻� 3000���Ͽ� ���� �� */
SELECT *
    FROM EMP
    WHERE SAL BETWEEN 2000 AND 3000;

/* BETWEEN���� ����ؼ� �޿��� 1000���� 2500 �����̰� �μ���(IN ���) 10, 30�� ����� ��� */
SELECT *
    FROM EMP
    WHERE SAL BETWEEN 1000 AND 2500
        AND DEPTNO IN(10, 30);

/* BETWEEN���� ����ؼ� �޿��� 1000���� 2500 �����̰� �μ��� 10, 20 �ƴ� ��� ��� */
SELECT *
    FROM EMP
    WHERE SAL BETWEEN 1000 AND 2500
        AND DEPTNO NOT IN(10, 20);
        
/* BETWEEN���� ����ؼ� �����ȣ�� 7000���� 7999�����̰�, �Ի����� 81�� 5�� 1�� ������ ��� ��� */
SELECT *
    FROM EMP
    WHERE EMPNO BETWEEN 7000 AND 7999
        AND HIREDATE > '81/05/01';
        
/* 1980���� �ƴ� �ؿ� �Ի��� ��� ���*/
SELECT *
    FROM EMP
    WHERE NOT HIREDATE BETWEEN '80/01/01' 
        AND '80/12/31';

-- EXTRACT ���� ����Ͽ� Ư�� ���Ǹ� ���� �� �ֵ��� �ϴ� ��        
SELECT *
    FROM EMP
    WHERE EXTRACT(YEAR FROM HIREDATE) != 1980;

/* LIKE ���� �Ϻ� ���ڿ��� ���ԵǾ� �ִ��� ���θ� Ȯ�� �� �� ��� */
-- % ���̿� �������(ã�����ϴ� Ư�������� ��ġ�� ����) ��� ���� �����͸� �ǹ�
-- _ ���� �� �ڸ� �ǹ�

SELECT *
    FROM EMP
    WHERE ENAME LIKE '%S%'; 

SELECT *
    FROM EMP
    WHERE ENAME LIKE 'S____'; -- ������ ��ġ��ŭ, �ܾ��� ���̸�ŭ �����(_)�� �־������

SELECT *
    FROM EMP
    WHERE ENAME LIKE '_L%';
    
/* �̸��� AM�� ���ԵǾ� �ִ� ��� ��� */
SELECT *
    FROM EMP
    WHERE ENAME LIKE '%AM%';

/* �̸��� AM�� ���ԵǾ� ���� ���� ��� ��� */
SELECT *
    FROM EMP
    WHERE NOT ENAME LIKE '%AM%';

/* ���ϵ�ī�� ���ڰ� ������ �Ϻ��� ��� */
INSERT INTO 
    EMP VALUES(9998, 'TEST_PP', 'SALESMAN', 7698, TO_DATE('23-02-14', 'YY-MM-DD'), 2000, 1000, 30); -- �ڷ����

SELECT * FROM EMP;

SELECT *
    FROM EMP
    WHERE ENAME LIKE '____\_%' ESCAPE '\'; -- \������ ���� %�� �츮�� ã�� ���� '\' �����

DELETE FROM EMP
    WHERE ENAME = 'TEST%PP'; -- ���̺��� �ش��ϴ� �̸��� �ڷ����
    
/* IS NULL */
-- NULL : 0�� �ƴϰ� ������� �ƴ��� �ǹ�. ��, �� Ȯ���� ��
-- ���� �� ��, �Ҵ��� �ȵ�
SELECT *
    FROM EMP
    WHERE COMM = NULL; -- NULL�� ���� ���� �� ����

SELECT *
    FROM EMP
    WHERE COMM IS NULL;
    
SELECT *
    FROM EMP
    WHERE COMM IS NOT NULL;
    
/* MGR�� �ִ� ����� ��� */
SELECT *
    FROM EMP
    WHERE MGR IS NOT NULL;
    
/* ORDER BY �� : Ư�� �÷�(��)�� �����͸� �������� ���������̳� ������������ �����ϴ� ����� �ϴ� �� */
-- �ݵ�� ���� �������� ����Ǿ�� �ϸ�, �����ϸ� ���� ����.
-- �������� : ASC / �������� : DESC
SELECT *
    FROM EMP
    ORDER BY SAL DESC; -- �⺻������ ��������(ASC)

/* �����ȣ �������� �������� ���� */
SELECT *
    FROM EMP
    ORDER BY EMPNO;

/* �޿� �������� ��������; �޿��� ������쿡�� �̸� ���� */
SELECT *
    FROM EMP
    ORDER BY SAL, ENAME;
    
/* �޿� �������� ��������; �޿��� ���� ��� �̸��� �������� ���� */
SELECT *
    FROM EMP
    ORDER BY SAL, ENAME DESC; 
    
/* ��Ī ���� ORDER BY */
SELECT EMPNO �����ȣ, ENAME �����, SAL ����, HIREDATE �Ի���
    FROM EMP
    ORDER BY ���� DESC, ����� ASC;
    
/* ���� ������(||) : SELECT ��ȸ�� �÷� ���̿� Ư���� ���ڸ� �ְ� ���� �� ����ϴ� ������ */
SELECT ENAME || 'S JOB IS ' || JOB AS EMPLOYEE
    FROM EMP;

/* �ǽ����� */
/* ���� VALUE �߰� */
INSERT INTO EMP VALUES(7876, 'ADAMS', 'CLERK', 7788, TO_DATE('23-05-87', 'DD-MM-YY'), 1100, NULL, 20);

/* EX1) EMP ���̺��� ����Ͽ� ����̸��� S�� ������ ��������͸� ��� ��� */
SELECT *
    FROM EMP
    WHERE ENAME LIKE '%S';

/* EX2) EMP ���̺��� ����Ͽ� 30�� �μ����� �ٹ��ϰ� �ִ� ����߿� ��å�� SALESMAN�� ����� �����ȣ, �̸�, ��å, �޿�, �μ���ȣ ��� */
SELECT EMPNO �����ȣ, ENAME �̸�, JOB ��å, SAL �޿�, DEPTNO �μ���ȣ
    FROM EMP
    WHERE JOB = 'SALESMAN' AND DEPTNO = 30;
    
/* EX3) EMP ���̺��� ����Ͽ� 20��, 30�� �μ����� �ٹ��ϰ� �ִ� ��� �� �޿��� 2000�ʰ��� ����� �ΰ��� ����� ����Ͽ� �����ȣ, �̸�, �޿�, �μ���ȣ�� ��� */
-- ���տ����ڸ� ������� �ʴ� ���
-- ���տ����ڸ� ����� ���
SELECT EMPNO �����ȣ, ENAME �̸�, SAL �޿�, DEPTNO �μ���ȣ
    FROM EMP
    WHERE SAL > 2000
        AND DEPTNO IN(20, 30);

SELECT EMPNO �����ȣ, ENAME �̸�, SAL �޿�, DEPTNO �μ���ȣ
    FROM EMP
    WHERE SAL > 2000
        AND DEPTNO = 20 AND DEPTNO = 30;
        
/* EX4) NOT BETWEEN A AND B �����ڸ� �����ʰ�, �޿� �� ���� 2000�̻� 3000���� ���� �̿��� ���� ���� �����͸� ��� */
SELECT *
    FROM EMP
    WHERE SAL < 2000 OR SAL > 3000;
    
/* EX5) ��� �̸��� E�� ���ԵǾ� �ִ� 30�� �μ��� ��� �� �޿��� 1000~2000 ���̰� �ƴ� ����̸�, �����ȣ, �޿�, �μ���ȣ ��� */
SELECT  EMPNO �����ȣ, ENAME ����̸�, SAL �޿�, DEPTNO �μ���ȣ
    FROM EMP
    WHERE ENAME LIKE '%E%'
        AND DEPTNO = 30 
        AND SAL NOT BETWEEN 1000 AND 2000;

/* EX6) �߰������� �������� �ʰ� ����ڰ� �ְ� ��å�� MANAGER, CLERK�� ����߿��� ����̸��� �ι�° ���ڰ� L�� �ƴ� ��� ������ ��� */
SELECT *
    FROM EMP
    WHERE (COMM IS NULL OR COMM = 0) 
        AND MGR IS NOT NULL
        AND JOB IN ('MANAGER', 'CLERK')
        AND NOT ENAME LIKE '_L%';

/*�������� PART2*/
/* EX1) EMP ���̺��� COMM�� ���� NULL�� �ƴ� ������ ��ȸ */
SELECT *
    FROM EMP
    WHERE COMM IS NOT NULL;
    
/* EX2) EMP ���̺��� Ŀ�̼��� ���� ���ϴ� ���� ��ȸ */
SELECT *
    FROM EMP
    WHERE COMM IS NULL OR COMM = 0;

/* EX3) EMP ���̺��� �����ڰ� ���� ���� ���� ��ȸ */
SELECT *
    FROM EMP
    WHERE MGR IS NULL;
    
/* EX4) EMP ���̺��� �޿��� ���� �޴� ���� ������ ��ȸ */
SELECT *
    FROM EMP
    ORDER BY SAL DESC;
    
/* EX5) EMP���̺��� �޿��� ���� ��� Ŀ�̼��� �������� ���� ��ȸ */
SELECT *
    FROM EMP
    ORDER BY SAL DESC, COMM DESC;
    
/* EX6) EMP ���̺��� �����ȣ, �����, ����, �Ի��� ��ȸ (��, �Ի����� �������� ���� ó��) */
SELECT EMPNO �����ȣ, ENAME �����, JOB ����, HIREDATE �Ի���
    FROM EMP
    ORDER BY HIREDATE; -- �÷��� ����(���� ����Ʈ ���� �ִ� ��ȸ �������)�� �Է��ص� ���İ���
    
/* EX7) EMP ���̺��� �����ȣ, ����� ��ȸ (�����ȣ ���� �������� ����) */
SELECT EMPNO �����ȣ, ENAME �����
    FROM EMP
    ORDER BY EMPNO DESC;

/* EX8) EMP ���̺��� ���, �Ի���, �����, �޿� ��ȸ (�μ���ȣ�� ���� ������, ���� �μ���ȣ�� ���� �ֱ� �Ի��� ������ ó��) */
SELECT EMPNO ���, HIREDATE �Ի���, ENAME �����, SAL �޿�, DEPTNO �μ���ȣ
    FROM EMP
    ORDER BY DEPTNO, HIREDATE  DESC;


/* �Լ� : ����Ŭ������ �����Լ��� ����ڰ� �ʿ信 ���ؼ� ���� ������ ����� �����Լ��� �������� */
-- �Լ��� ������ �Լ��� ������ �Լ�(���� �Լ�)�� ����
-- DUAL ���̺� : SYS �������� �����ϴ� ���̺�� �Լ��� ������ ���̺� Ž�� ���� �����غ��� ���� DUMMY ���̺�
/* ���� �Լ� */
/* ������ �Լ� */
-- ABS ���밪 �Լ�
SELECT -10, ABS(-10) FROM EMP;
SELECT -10, ABS(-10) FROM DUAL; -- DUAL�� �ؾ� ���� �ϳ��� ����
-- ROUND �ݿø� �Լ�
SELECT ROUND(1234.5678) AS ROUND FROM DUAL; -- �ݿø��ڸ� �������� ������ ������
SELECT ROUND(1234.5678, 0) ROUND_0 FROM DUAL; -- ���ǰͰ� ����
SELECT ROUND(1234.5678, 1) ROUND_1,
    ROUND(1234.5678, 2) ROUND_2,
    ROUND(1234.5678, 3) ROUND_3
    FROM DUAL; -- ���ڸ�ŭ ���������� �ݿø�(���� +1 �ڸ����� �ݿø�)

SELECT ROUND(1234.5678, -1) ROUND_MINUS1,
    ROUND(1234.5678, -2) ROUND_MINUS2,
    ROUND(1234.5678, -3) ROUND_MINUS3
    FROM DUAL; -- -���� �ڸ����� �ݿø� �׸��� �� �����ڸ����ϴ� ��� 0���� �ٲ�
    
-- TRUNC : ������ �� ����� ��ȯ�ϴ� �Լ�
SELECT TRUNC(1234.5678, 1) TRUNC_1,
    TRUNC(1234.5678, 2) TRUNC_2,
    TRUNC(1234.5678, 3) TRUNC_3
    FROM DUAL; -- ���� ����� ���� �ڸ����� ����
    
SELECT TRUNC(1234.5678, -1) TRUNC_MINUS1,
    TRUNC(1234.5678, -2) TRUNC_MINUS2,
    TRUNC(1234.5678, -3) TRUNC_MINUS3
    FROM DUAL; -- ���� ����� ���� �ڸ����� ����
    
-- MOD : �������� �� �� �������� ����ϴ� �Լ�
SELECT MOD(21, 5) FROM DUAL;

-- CEIL : �Ҽ������Ͽ� ���� ������ ������ �ø�
SELECT CEIL(12.001) FROM DUAL;

-- FLOOR : �Ҽ������ϸ� ������ ����
SELECT FLOOR(12.9999) FROM DUAL;

-- POWER : ���� A�� ���� B��ŭ ����
SELECT POWER(3, 4) FROM DUAL;

/* ���� �Լ� : ���ڵ����͸� �����ϰų� ���� �����ͷκ��� Ư������� ����� �� �� ��� */
-- UPPER : �빮�� ����
-- LOWER : �ҹ��� ����
-- INITCAP : ù ���ڸ� �빮�� �������� �ҹ���
SELECT ENAME, UPPER(ENAME), LOWER(ENAME), INITCAP(ENAME)
    FROM EMP;

-- WHERE ���������� ����ϱ�
SELECT *
    FROM EMP
    WHERE UPPER(ENAME) = UPPER('james'); -- = JAVA�� EQUALSIGNORECASE()�� ����

-- UPPER�Լ��� LIKE�� �Բ� ���
SELECT *
    FROM EMP
    WHERE UPPER(ENAME) LIKE UPPER('%ja%');

SELECT INITCAP('yeon joo') AS �̸� FROM DUAL;

/* ����̸� : �빮��, ��å : ù ���ڸ� �빮��, �������� �ҹ��ڷ� �����ϰ� �޿����� ���� ������ ǥ�� */
SELECT UPPER(ENAME) AS �̸�, INITCAP(JOB) AS ��å, SAL AS �޿�
    FROM EMP
    ORDER BY SAL DESC;
    
/* ���ڿ� ���� */
-- LENGTH 
SELECT ENAME, LENGTH(ENAME) AS "�̸��� ���� ��"
    FROM EMP;

/* �̸��� ���̰� 5�� ���ų� ū ����� �̸�, �����ȣ, ��å�� ���� ������ ǥ��, �� ���ʽ� ���� */
SELECT ENAME ����̸�, EMPNO �����ȣ, JOB ��å, SAL*12 AS ����
    FROM EMP
    WHERE LENGTH(ENAME) >= 5
    ORDER BY ���� DESC; 

-- LENGTH : ���ڿ��� ���̸� ��ȯ
-- LENGTHB : ���ڿ��� ����Ʈ �� ��ȯ
SELECT LENGTH('�ѱ�'), LENGTHB('�ѱ�')
    FROM DUAL; -- LENTHB = BYTE�� (����Ŭ���� �ѱ� �� ���� BYTE���� 3)

/* ��å �̸��� 6�� �̻��̰� COMM�� �ִ� ��� ��� */
SELECT *
    FROM EMP
    WHERE LENGTH(JOB) >= 6
    AND COMM IS NOT NULL AND COMM != 0;

/* SUBSTR / SUBSTRB : ��� ���ڿ��̳� �÷��� �ڷῡ�� ������ġ���� ���� ������ŭ ���ڸ� ��ȯ�ϴ� �Լ�, �ε��� ����X */
-- SUBSTR(���ڿ� ������, ������ġ, ����)
SELECT JOB, SUBSTR(JOB, 1, 2), SUBSTR(JOB, 3, 2), SUBSTR(JOB, 5)
    FROM EMP;
SELECT * FROM EMP;


-- SUBSTR �Լ��� �ٸ� �Լ� �Բ� ���
SELECT JOB,
    SUBSTR(JOB, -LENGTH(JOB),2)
    FROM EMP;
    
/* INSTR : ���ڿ� ������ �ȿ� Ư�����ڳ� ���ڿ��� ��� ���ԵǾ� �ִ��� �˰��� �� �� ��� */
SELECT INSTR('HELLO, ORACLE!!', 'L') AS INSTR_1 FROM DUAL;
SELECT INSTR('HELLO, ORACLE!!', 'L', 5) AS INSTR_2 FROM DUAL; -- ã�� ���� ���� ��ġ�� ����
SELECT INSTR('HELLO, ORACLE!!', 'L', 2, 2) AS INSTR_3 FROM DUAL; -- ���� ��ġ���� ã�� ���ڰ� �� ��°���� ����

    
    
    