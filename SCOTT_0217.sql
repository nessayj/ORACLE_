/* 230217 FRI */

/* ROLLUP �Լ��� ������ �׷�ȭ */
-- ����� ���� �ұ׷���� ��׷��� ������ �� �׷캰 ����� ����ϰ� �������� �� ������ ����� ���
SELECT DEPTNO, JOB, COUNT(*), MAX(SAL), SUM(SAL), AVG(SAL)
    FROM EMP
    GROUP BY ROLLUP (DEPTNO, JOB);

/* ���տ����� : �� �� �̻��� ���� ����� �ϳ��� �����ϴ� ������ */
-- UNION : ������, �ߺ�����
-- UNION ALL : ������, �ߺ����� ����
-- MINUS : ������
-- INTERSECT : ������

-- UNION : ������, �ߺ�����
-- UNION ALL : ������, �ߺ����� ����
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

-- INTERSECT : ������; �� ���� �������� ��� ���ԵǾ� �ִ� �����͸� ǥ��
SELECT EMPNO, ENAME, SAL
    FROM EMP
    WHERE SAL > 1000
INTERSECT
SELECT EMPNO, ENAME, SAL
    FROM EMP
    WHERE SAL < 2000;

-- MINUS : ������; ���� ������ ������� ���� ������ ����� �� ��
SELECT EMPNO, ENAME, SAL
    FROM EMP
MINUS
SELECT EMPNO, ENAME, SAL
    FROM EMP
    WHERE SAL > 2000;

/*JOIN */
-- JOIN �� �� �̻��� ���̺��� �����͸� �����ͼ� �����ϴµ� ���Ǵ� SQL�� ���
-- ���̺��� �ĺ� ���� PRIMARY KEY�� ���̺� �� ���밪�� FORIEGN KEY ���� ����Ͽ� ����
-- INNER JOIN : �� ���̺��� ��ġ�ϴ� �����͸� ����
-- LEFT JOIN : �������̺��� ��� �����Ϳ� ������ �����Ϳ��� ��ġ�ϴ� ������ ����
-- RIGHT JOIN : ������ ���̺��� ��� �����Ϳ� ���� ���̺��� ��ġ�ϴ� ������ ����

-- �ΰ��� ���̺��� ��翭�� ���յǾ� ������ �� * ������ �� ��ŭ�� ����� ǥ��(ī�׽þ� ��)
SELECT *
    FROM EMP, DEPT;

SELECT *
    FROM EMP, DEPT 
    WHERE EMP.DEPTNO = DEPT.DEPTNO;

/* ���̺� ��Ī �ֱ� */
--  ���� ���̺� ��ο� �����ϴ� ���� ���ؼ��� ���̺� �̸��� ����ؾ���; �ߺ����� ���� ���� ��Ī�� �������� �ʾƵ� ��

SELECT E.EMPNO, E.ENAME, E.JOB, E.DEPTNO, D.DNAME, D.LOC
    FROM EMP E, DEPT D
    WHERE E.DEPTNO = D.DEPTNO;
 
/* � ���� */
-- ���̺��� ������ �Ŀ� ��� ���� �� ���̺��� Ư�� ���� ��ġ�� �����͸� �������� �����ϴ� ���
 
-- ANSI ���� ������� ����
-- ����ū 9i ������ ����Ŭ ���θ� ����� �� �־�����, ����Ŭ 10g ���ʹ� ANSI������ �߰��� ��밡��
-- �������� �������ִ°� �� ���̱� ������ �������� ���� �� ����
SELECT EMPNO, ENAME, E.DEPTNO, DNAME
    FROM EMP E JOIN DEPT D 
    ON E.DEPTNO = D.DEPTNO
    WHERE E.JOB = 'MANAGER';
    
-- EMP�� DEPT���̺��� �����ϰ� �޿��� 3000�̻��� ������� ���(�����ȣ, �̸�, �޿�, �Ի���, �μ���ȣ, �μ��̸�)
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

-- EMP���̺� ��Ī�� E��, DEPT���̺� ��Ī�� D�� �Ͽ� ������ ���� � ������ ���� ��,
-- �޿��� 2500�����̰� �����ȣ�� 9999 ������ ����� ������ ��µǵ��� �ۼ�
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

/* �� ���� */
-- ���� ���� �ƴ� �ٸ� ������ ����Ͽ� ���� �� �� ���Ǹ鼭 ���� ������ ����
SELECT * FROM EMP;
SELECT * FROM SALGRADE;

-- �޿��� ���� ����� ǥ�� �ϱ� ���ؼ��� �޿��� �ݾ��� ��ġ �� �� �����Ƿ�, �ּҿ� �ִ� �޿� ���̿� �־�� ��
-- �̷���� BETWEEN A AND B �����ڸ� ����ϸ� ó�� ����
SELECT ENAME, SAL, GRADE
    FROM EMP E JOIN SALGRADE S
    ON SAL BETWEEN LOSAL AND HISAL;

/* ���� ���� */
-- Q1) �����ȣ�� 7499�� ����� �̸�, �Ի��� �μ���ȣ ���
SELECT ENAME, HIREDATE, DEPTNO
    FROM EMP
    WHERE EMPNO = 7499;

-- Q2) �̸��� ALLEN�� ����� ��� ���� ���
SELECT *
    FROM EMP
    WHERE ENAME = 'ALLEN';
    
-- Q3) �̸��� K���� ū ���ڷ� �����ϴ� ����� ��� ���� ���
SELECT *
    FROM EMP
    WHERE ENAME >= 'K';
    
-- Q4) �Ի����� 81�� 4�� 2�� ���� �ʰ�, 82�� 12�� 9�� ���� ��������� �̸�, �޿�, �μ���ȣ ���
SELECT ENAME, SAL, DEPTNO, HIREDATE
    FROM EMP
    WHERE HIREDATE > '1981/04/02'
        AND HIREDATE < '1982/12/09';
        
-- Q5) �޿��� 1600���� ũ�� 3000���� ��������� �̸�, ����, �޿��� ���
SELECT ENAME, JOB, SAL
    FROM EMP
    WHERE SAL > 1600 AND SAL < 3000;
    
-- Q6) �Ի����� 81�� �̿ܿ� �Ի��� ����� ��� ���� ���
SELECT *
    FROM EMP
    WHERE EXTRACT(YEAR FROM HIREDATE) != 1981;

-- Q7) ������ MANAGER�� SALESMAN�� ����� ��� ���� ���
SELECT *
    FROM EMP
    WHERE JOB = 'MANAGER' OR JOB = 'SALESMAN';
    
SELECT *
    FROM EMP
    WHERE JOB IN ('MANAGER','SALESMAN');
    
-- Q8) �μ��� 20��, 30���� ������ ��� ����� �̸�, �����ȣ, �μ���ȣ ���
SELECT ENAME, EMPNO, DEPTNO
    FROM EMP
    WHERE DEPTNO != 20 AND DEPTNO != 30;

SELECT ENAME, EMPNO, DEPTNO
    FROM EMP
    WHERE DEPTNO NOT IN(20,30);    
    
-- Q9) �̸��� S�� �����ϴ� ����� �����ȣ, �̸�, �μ���ȣ ���
SELECT EMPNO, ENAME, DEPTNO
    FROM EMP
    WHERE ENAME LIKE 'S%';
    
-- Q10) ó�����ڴ� �������, �� ��° ���ڰ� A�� ����� ��� ���� ���
SELECT *
    FROM EMP
    WHERE ENAME LIKE '_A%';
    
-- Q11) Ŀ�̼��� NULL�� �ƴ� ����� ������� ���
SELECT *
    FROM EMP
    WHERE COMM IS NOT NULL;
    
-- Q12) �̸��� J�� �����ϰ� ���������ڰ� S�� ����� ��� ���� ���
SELECT *
    FROM EMP
    WHERE ENAME LIKE 'J%S';
    
-- Q13) �޿��� 1500 �̻��̰�, �μ���ȣ�� 30���� ��� �� ������ MANAGER�� ����� ��� ���� ���
SELECT *
    FROM EMP
    WHERE SAL >= 1500 AND DEPTNO = 30 AND JOB = 'MANAGER';
    
-- Q14) ��� ����� �̸�, �޿�, Ŀ�̼�, �Ѿ�(�޿�+Ŀ�̼�)�� ���Ͽ� �Ѿ��� ���� ������ ���
-- ��, Ŀ�̼��� NULL�� ����� 0���� ����
SELECT ENAME, SAL, NVL(COMM,0) Ŀ�̼�, SAL+NVL(COMM,0) AS �Ѿ�
    FROM EMP
    ORDER BY SAL+NVL(COMM,0); -- ORDER BY�� ��Ī���� �������൵ ���� = ORDER BY "�Ѿ�";
    
-- Q15) 10�� �μ��� ��� ������� �޿��� 13%�� ���ʽ��� �����ϱ�� �Ͽ���.
-- 10���μ� ������� �̸�, �޿�, ���ʽ�, �μ���ȣ ���
SELECT ENAME, SAL, ROUND(SAL*1.13, 1) AS ���ʽ�, DEPTNO
    FROM EMP
    WHERE DEPTNO = 10;

-- Q16) ��� ����� ���� �Ի��� ���κ��� 60���� ���� ���� '������'�� ���� ��, ��, ���� ���Ͽ� 
-- �̸�, �Ի���, 60�� ���� '������'��¥ ���
SELECT ENAME, HIREDATE, TO_CHAR(NEXT_DAY((HIREDATE + 60), '������'), 'YYYY-MM-DD') AS "60�� ��"
    FROM EMP;
    
-- Q17) �̸��� ���ڼ��� 6�� �̻��� ������̸��� �տ��� 3�ڸ� ���Ͽ� �ҹ��ڷ� �̸��� ���
SELECT LOWER(SUBSTR(ENAME,1,3))
    FROM EMP
    WHERE LENGTH(ENAME) = 6;

-- Q18) ������� �����ȣ�� �޿�, Ŀ�̼�, ����((COMM+SAL)*12)�� ������ ���� ������ ���
SELECT EMPNO, SAL, NVL(COMM,0), ((NVL(COMM,0)+SAL)*12) AS ����
    FROM EMP
    ORDER BY ((NVL(COMM,0)+SAL)*12);
    
-- Q19) ��������� �Ի��� ��/��/��
SELECT TO_CHAR(HIREDATE, 'YYYY"��"MM"��"DD"��"') �Ի���
    FROM EMP;

-- Q20) 10�� �μ��� ���� �޿��� ��� ��, �ִ� ��, �ּ� ��, �ο� ���� ���
SELECT DEPTNO, TRUNC(AVG(SAL)), MAX(SAL), MIN(SAL), COUNT(*)
    FROM EMP
    GROUP BY DEPTNO
        HAVING DEPTNO = 10;
        
SELECT TRUNC(AVG(SAL)), MAX(SAL), MIN(SAL), COUNT(*)
    FROM EMP
    WHERE DEPTNO = 10;
        
-- Q21) �����ȣ�� ¦���� ������� ��� ���� ���
SELECT *
    FROM EMP
    WHERE MOD(EMPNO, 2) = 0;

-- Q22) �� �μ��� ���� ������ ���� ����� �ο����� ���Ͽ� �μ���ȣ, ����, �ο��� ���
SELECT DEPTNO, JOB, COUNT(*)
    FROM EMP
    GROUP BY DEPTNO, JOB;
    
-- Q23) EMP�� DEPT���̺��� �����Ͽ� ������� ���� �μ���ȣ, �μ��̸�, ����̸�, �޿� ���
SELECT D.DEPTNO, DNAME, ENAME, SAL
    FROM EMP E JOIN DEPT D
    ON E.DEPTNO = D.DEPTNO
ORDER BY DEPTNO, SAL DESC;
    
-- Q24) �̸��� 'ALLEN'�� ����� �μ���ȣ, �μ��̸�, ����̸�, �޿� ���
SELECT D.DEPTNO, DNAME, ENAME, SAL
    FROM EMP E JOIN DEPT D
    ON E.DEPTNO = D.DEPTNO
    WHERE ENAME = 'ALLEN';

-- Q25) 'ALLEN'�� ������ ���� ����� �̸�, �μ� �̸�, �޿�, �μ���ġ ���
SELECT D.DEPTNO, DNAME, ENAME, SAL
    FROM EMP E JOIN DEPT D
    ON E.DEPTNO = D.DEPTNO
    WHERE JOB = (SELECT JOB
                        FROM EMP
                        WHERE ENAME = 'ALLEN');

-- Q26) ��������� ��� �޿����� ���� �޴� ������� �����ȣ�� �̸� ���
SELECT EMPNO, ENAME
    FROM EMP
    WHERE SAL > (SELECT AVG(SAL)
                        FROM EMP);
    
-- Q27) �μ��� ��� �޿��� 2000���� ���� �μ� ������� �μ���ȣ ���
SELECT DEPTNO
    FROM EMP
    GROUP BY DEPTNO
        HAVING AVG(SAL) <= 2000;

/* ��ü ���� : ���� ���̺��� �� �� ����ϴ� �� */
SELECT E1.EMPNO, E1.ENAME, E1.MGR,
        E2.EMPNO AS MGR_EMPNO,
        E2.ENAME AS MGR_ENAME
        FROM EMP E1 JOIN EMP E2
        ON E1.MGR = E2.EMPNO;

/*��������(INNER JOIN) �Ǵ� ���� ���� - �� ���� �÷�(��)�� ���� ������ ��ȸ �Ұ�; ���� �� ���� ��� �־�� ��ȸ ����*/        
/* �ܺ�����(OUTER JOIN) : ���� ���ΰ� �ٸ��� ������� ���� ���� ��ȸ ���� */ 

-- RIGHT OUTER JOIN : ������ ���̺��� �÷����� �������� ����(���� ���� ��� NULL�� ���)
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
    
-- LEFT OUTER JOIN : ���� ���̺��� �÷����� �������� ����(������ ���� ��� NULL�� ���)
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

