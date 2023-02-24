/* 230216 THU */
/* ������ �Լ� */
SELECT SUM(SAL) FROM EMP; -- ��ü������ �޿� ��
SELECT DEPTNO, SUM(SAL)
    FROM EMP
    GROUP BY DEPTNO; -- DEPTNO �� �μ��� �ش��ϴ� SAL�� �հ�� ��������

SELECT JOB, AVG(SAL)
    FROM EMP
    GROUP BY JOB;   
    
SELECT JOB, COUNT(*)
    FROM EMP
    GROUP BY JOB; -- COUNT(*) *�� ������ ���� �� ��ŭ�� �ִ��� ������ ���� ��ȯ

SELECT JOB, MAX(SAL)
    FROM EMP
    GROUP BY JOB; -- �׷캰�� �޿��� ���� ��������� ������
    
SELECT JOB, MIN(SAL)
    FROM EMP
    GROUP BY JOB; -- �׷캰�� �޿��� ���� ���� ����� ������
    
/* �հ� ���ϴ� SUM �Լ� */
-- DISTINCT : �ߺ�����
-- ALL : ������� �ʾƵ� �⺻������ ALL Ư���� ����
SELECT SAL FROM EMP;
SELECT SUM(DISTINCT SAL) AS �ߺ�����, SUM(ALL SAL) AS ����, SUM(SAL) AS �⺻
    FROM EMP;

SELECT SUM(SAL), SUM(COMM) FROM EMP; 

SELECT COUNT(*) FROM EMP;
SELECT COUNT(COMM) FROM EMP; -- COMM�� NULL�� �ƴ� ����� ��

SELECT COUNT(COMM)
    FROM EMP
    WHERE COMM IS NOT NULL; -- ���� �İ� ��� ����

-- �μ� ��ȣ�� 20�� ��� �� �Ի����� ���� �ֱ��� ���
SELECT MAX(HIREDATE)
    FROM EMP
    WHERE DEPTNO = 20;
    
/* GROUP BY : �ϳ��� ����� Ư������ ��� ����ϴ� ���� �׷�ȭ��� �� */
-- �̶� ����ؾ� �� ��� �� ������ GROUP BY�� ����
SELECT TRUNC(AVG(SAL))
    FROM EMP; -- EMP���̺� ���� ��ü������ ���
    
SELECT TRUNC(AVG(SAL)), DEPTNO
    FROM EMP
    GROUP BY DEPTNO;

SELECT TRUNC(AVG(SAL))
    FROM EMP
    WHERE DEPTNO = 10; --������ WHERE���� ���� ���� ������ �μ���ȣ��� ���� ���������

/* �μ� ��ȣ �� ��å�� ��� �޿��� �����ϱ� */
SELECT DEPTNO, JOB, AVG(SAL)
    FROM EMP
    GROUP BY DEPTNO, JOB
    ORDER BY AVG(SAL);

SELECT DEPTNO, JOB, AVG(SAL)
    FROM EMP
    GROUP BY DEPTNO, JOB
    ORDER BY DEPTNO, JOB;
    
/* GROUP BY ���� ����Ͽ� �μ� ��ȣ�� ��� �߰� ������ ��� */
SELECT NVL(AVG(COMM), 0), DEPTNO
    FROM EMP
    GROUP BY DEPTNO;

/* �μ��ڵ�, �޿� �հ�, �μ� ���, �μ� �ڵ� �� ���� */
SELECT DEPTNO, SUM(SAL) �հ�, FLOOR(AVG(SAL)) ���, COUNT(*) "�ο� ��"
    FROM EMP 
    GROUP BY DEPTNO
    ORDER BY DEPTNO;
    
/* HAVING �� : GROUP BY�� �������� ��� */
-- �׷�ȭ �� ���ǹ����� �����ϴ� �뵵�� ���
SELECT DEPTNO, JOB, AVG(SAL)
    FROM EMP
    GROUP BY DEPTNO,JOB
        HAVING AVG(SAL) >= 2000
    ORDER BY DEPTNO, JOB;

/* WHERE ���� HAVING ���� ��� ����ϴ� ��� */    
SELECT DEPTNO, JOB, AVG(SAL)
    FROM EMP -- ù ��° ���� : 12~13�� ���� ����
    WHERE SAL <= 3000 -- �Ϲ����� ������(GROUP ���� ���� ��밡��)
    GROUP BY DEPTNO, JOB
        HAVING AVG(SAL) >= 2000
    ORDER BY DEPTNO, JOB;

/* �������� */
-- Q1) HVING���� ����Ͽ� EMP���̺��� �μ��� ��å ��ձ޿��� 500 �̻��� ������� �μ���ȣ, ��å, �μ��� ��å�� ��ձ޿��� ���
SELECT DEPTNO �μ���ȣ, JOB ��å, AVG(SAL) ��ձ޿�
    FROM EMP
    GROUP BY DEPTNO, JOB
        HAVING AVG(SAL) >= 500;

-- Q2) EMP���̺��� �̿��Ͽ� �μ���ȣ, ��ձ޿�, �ְ�޿�, �����޿�, ������� ���
-- ��, ��ձ޿��� ��� �� ���� �Ҽ��� �����ϰ� �μ���ȣ ���� ���
SELECT DEPTNO �μ���ȣ, TRUNC(AVG(SAL)) ��ձ޿�, MAX(SAL) �ְ�޿�, MIN(SAL) �����޿�, COUNT(*) �����
    FROM EMP
    GROUP BY DEPTNO
    ORDER BY DEPTNO;

-- Q3) EMP���̺��� �̿��Ͽ� ���� ��å�� �����ϴ� ����� 3�� �̻��� ��å�� �ο��� ���
SELECT JOB, COUNT(JOB)
    FROM EMP
    GROUP BY JOB
        HAVING COUNT(JOB) >= 3;

-- Q4) ������� �Ի� ������ �������� �μ����� �� ���� �Ի��ߴ��� ���
SELECT  EXTRACT(YEAR FROM HIREDATE) �Ի�⵵, DEPTNO �μ�, COUNT(HIREDATE) �����
    FROM EMP
    GROUP BY DEPTNO, EXTRACT(YEAR FROM HIREDATE)
    ORDER BY EXTRACT(YEAR FROM HIREDATE), DEPTNO;

-- TO_CHAR(HIDRATE, YYYY)

-- Q5) �߰� ������ �޴� ��� ���� ���� �ʴ� ������� ��� (O, X�� ǥ�� �ʿ�)
SELECT NVL2(COMM, 'O', 'X') �߰����翩��, COUNT(COMM) �����
    FROM EMP
    GROUP BY NVL2(COMM, 'O', 'X');
        
    
-- Q6) �� �μ��� �Ի� ������ ��� ��, �ְ� �޿�, �޿� ��, ��� �޿��� ���
SELECT DEPTNO "�μ�", EXTRACT(YEAR FROM HIREDATE) �Ի�⵵,  COUNT(HIREDATE) "�Ի� ������ �����", MAX(SAL) "�ְ� �޿�", SUM(SAL) "�޿� ��", ROUND(AVG(SAL), 1) "��� �޿�"
    FROM EMP
    GROUP BY EXTRACT(YEAR FROM HIREDATE), DEPTNO
    ORDER BY DEPTNO;
