/* 230220 MON */

/* ANSI JOIN */
-- �������� : NATURAL JOIN, JOIN ~ USING, JOIN ~ ON
/* NATURAL JOIN : ���� ���ΰ� ��������� WHERE������ ���� ���� */
-- �� ���̺��� ������ �̸�(�÷� �Ǵ� ��)�� ���� �÷��� ��� ���� ��
-- DEPTNO ���� ���� ���̺� ��� ����

SELECT EMPNO, ENAME, DNAME
    FROM EMP NATURAL JOIN DEPT;

-- �Ϲ����� ���� ������ ��� �Ʒ��� �������� ������ �߻� ��; DEPTNO�� ��� �Ҽ����� ��ȣ���� �߻��ϱ� ������
SELECT EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO, DNAME, LOC
    FROM EMP NATURAL JOIN DEPT
    ORDER BY DEPTNO, EMPNO;


/* JOIN ~ USING : ������ � ������ ����ϴ� ���� ��� */
-- FROM TABLE1 JOIN TABLE2 USING (���ؿ�)
SELECT EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO,DNAME, LOC
    FROM EMP JOIN DEPT USING(DEPTNO)
    WHERE SAL >= 3000
    ORDER BY DEPTNO, EMPNO;
    
/* JOIN ~ ON : ���� ���뼺 �ִ� JOIN ~ ON Ű���带 ����ϴ� ���� ��� */
-- FROM TABLE1 JOIN TABLE2 ON(���� ���ǽ�)
SELECT EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, E.DEPTNO, DNAME, LOC -- ����Ҷ��� �ߺ� ���� � �������� �Ǵ��� �� �־������
    FROM EMP E JOIN DEPT D 
    ON E.DEPTNO = D.DEPTNO
    WHERE SAL <= 3000
    ORDER BY E.DEPTNO, EMPNO;

/* ANSI OUTER JOIN */
-- LEFT OUTER JOIN : ���� ���̺� �������� ������ ���̺��� ��� ���� ��� ��

-- ORACLE
SELECT EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, E.DEPTNO, DNAME, LOC
    FROM EMP E, DEPT D
    WHERE E.DEPTNO = D.DEPTNO(+); -- �����ʿ� ä�� �־��
    
-- ANSI
SELECT EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, E.DEPTNO, DNAME, LOC
    FROM EMP E LEFT OUTER JOIN DEPT D
    ON E.DEPTNO = D.DEPTNO;

-- RIGHT OUTER JOIN : ������ ���̺� �������� ���� ���̺��� ��� ���� ���
-- ORACLE
SELECT EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, E.DEPTNO, DNAME, LOC
    FROM EMP E, DEPT D
    WHERE E.DEPTNO(+) = D.DEPTNO;

-- ANSI
SELECT EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, E.DEPTNO, DNAME, LOC
    FROM EMP E RIGHT OUTER JOIN DEPT D
    ON E.DEPTNO = D.DEPTNO;

/* ���� ���� */
-- 1. �޿�(SAL)�� 2000 �ʰ��� ������� �μ� ����, ��� ������ �μ���ȣ, �μ��̸�, ����̸�, �޿� ǥ��
-- ����Ŭ ������ ANSI �������� ǥ��(NATURAL, JOIN ~ USING, JOIN ~ ON)
-- ORACLE
SELECT E.DEPTNO, DNAME, ENAME, SAL
    FROM EMP E, DEPT D
    WHERE E.DEPTNO = D.DEPTNO
    AND SAL > 2000;
-- NATURAL
SELECT DEPTNO, DNAME, ENAME, SAL
    FROM EMP NATURAL JOIN DEPT
    WHERE SAL > 2000;
-- JOIN ~ USING
SELECT DEPTNO, DNAME, ENAME, SAL
    FROM EMP JOIN DEPT USING(DEPTNO)
    WHERE SAL >2000;
-- JOIN ~ ON
SELECT E.DEPTNO, DNAME, ENAME, SAL
    FROM EMP E JOIN DEPT D
    ON E.DEPTNO = D.DEPTNO
    WHERE SAL > 2000;
    
-- 2.�� �μ��� �μ���ȣ, �μ��̸�, ��� �޿�, �ִ� �޿�, �ּ� �޿�, ����� ���
-- ����Ŭ ������ ANSI �������� ǥ��(NATURAL, JOIN ~ USING, JOIN ~ ON)
-- ORACLE
SELECT E.DEPTNO, DNAME, TRUNC(AVG(SAL)) AS ��ձ޿�, MAX(SAL) �ִ�޿�, MIN(SAL) �ּұ޿�, COUNT(*) �����
    FROM EMP E, DEPT D
    WHERE E.DEPTNO = D.DEPTNO
    GROUP BY E.DEPTNO, DNAME;
       

-- NATURAL
SELECT E.DEPTNO, DNAME, TRUNC(AVG(SAL)) AS ��ձ޿�, MAX(SAL) �ִ�޿�, MIN(SAL) �ּұ޿�, COUNT(*) �����
    FROM EMP NATURAL JOIN DEPT
    GROUP BY E.DEPTNO, DNAME;

-- JOIN ~ USING
SELECT E.DEPTNO, DNAME, TRUNC(AVG(SAL)) AS ��ձ޿�, MAX(SAL) �ִ�޿�, MIN(SAL) �ּұ޿�, COUNT(*) �����
    FROM EMP JOIN DEPT USING(DEPTNO)
    GROUP BY E.DEPTNO, DNAME;
    
-- JOIN ~ ON
SELECT E.DEPTNO, DNAME, TRUNC(AVG(SAL)) AS ��ձ޿�, MAX(SAL) �ִ�޿�, MIN(SAL) �ּұ޿�, COUNT(*) �����
    FROM EMP E JOIN DEPT D
    ON E.DEPTNO = D.DEPTNO
    GROUP BY E.DEPTNO, DNAME;
    
-- 3. ��� �μ� ������ ��� ������ �μ���ȣ, �μ��̸�, �����ȣ, ����̸�, ��å, �޿��� ��� �̸������� ���
-- ����Ŭ ������ ANSI OUTER ��������ǥ��
-- ORACLE
SELECT D.DEPTNO, DNAME, EMPNO, ENAME, JOB, SAL
    FROM EMP E , DEPT D
    WHERE E.DEPTNO(+) = D.DEPTNO
    ORDER BY D.DEPTNO, ENAME;

-- ANSI OUTER JOIN
SELECT D.DEPTNO, DNAME, EMPNO, ENAME, JOB, SAL
    FROM EMP E RIGHT OUTER JOIN DEPT D
    ON E.DEPTNO = D.DEPTNO
    ORDER BY D.DEPTNO, ENAME;
    
/* �������� */
-- SQL �� �ȿ� �ۼ��ϴ� ���� SELECT���� �ǹ�; �ַ� WHERE ������ ���
-- ���������� �ݵ��� ��ȣ(��������) �ȿ� �־� ǥ�� ��
-- ����� �̸����� ����� ���� �μ� ��ȣ�� ã��(��������)
-- ���� �������� �μ� �̸��� �μ� ��ȣ�� ���ؼ� ���ϴ� ����� ã��
SELECT DNAME 
    FROM DEPT
    WHERE DEPTNO = (SELECT DEPTNO
                        FROM EMP
                        WHERE ENAME = 'KING');

/* ���� ������ �̿��� 'JONES'�� �޿����� ���� �޿��� �޴� ��� ���� ��� */
SELECT *
    FROM EMP
    WHERE SAL > (SELECT SAL
                        FROM EMP
                        WHERE ENAME = 'JONES');

/* ���� ������ Ư¡ */
-- ��ȸ ����� �����ʿ� ���̸� ()�ȿ� ��� ���
-- ��κ��� ��� ORDER BY ���� ����� �� ����
-- ���� ������ ���� ���������� ����� ���� �ڷ����̰ų� ���� ������ �����ؾ� ��
-- ���������� ���������� �����ڿ� �Բ� ��ȣ �ۿ��ϴ� ��Ŀ� ���� ������ ���� ������ ������ ���� ����

/* ��������(������ ��������) */
-- ���������� ����ؼ� EMP���̺��� ������� �߿��� ����̸��� ALLEN�� ����� �߰� ���� ���� ���� �߰� ������ �޴� ������� ���
SELECT *
    FROM EMP
    WHERE COMM > (SELECT COMM
                        FROM EMP
                        WHERE ENAME = 'ALLEN');

SELECT *
    FROM EMP
    WHERE HIREDATE < (SELECT HIREDATE 
                            FROM EMP
                            WHERE ENAME = 'JAMES');

-- 20�� �μ��� ���� ��� �� ��ü ����� ��ձ޿����� ���� �޿��� �޴� ��������� �ҼӺμ������� ��ȸ
SELECT EMPNO, ENAME, D.DEPTNO, DNAME, SAL
    FROM EMP E, DEPT D
    WHERE E.DEPTNO = D.DEPTNO
    AND E.DEPTNO = 20
    AND E.SAL > (SELECT AVG(SAL)
                        FROM EMP);

/* �������� �������� ������ �������� */
-- IN ������ : ���� ������ �����Ͱ� ���������� ��� �� �ϳ��� ��ġ�� �����Ͱ� �ִٸ� TRUE(OR �����ڿ� ���)
SELECT *
    FROM EMP
    WHERE SAL IN (SELECT MAX(SAL)
                    FROM EMP
                    GROUP BY DEPTNO)
    ORDER BY DEPTNO;
    
-- ANY ������ : ���������� �� ������ ���������� ���� �˻� ��� �� �ϳ� �̻� �����Ǹ� TRUE
SELECT *
    FROM EMP
    WHERE SAL > ANY (SELECT SAL
                        FROM EMP
                        WHERE JOB = 'SALESMAN'); -- SALESMAN�� �޿� �� ���� ���� �ݾ׺��� ũ�� �� ����
                        
/* 30�� �μ� ������� �ִ� �޿����� ���� �޿��� �޴� ��� ���� ��� */
SELECT *
    FROM EMP
    WHERE SAL < ANY (SELECT AVG(SAL)
                        FROM EMP
                        WHERE DEPTNO = 30)
    ORDER BY SAL, EMPNO;

-- ALL ������ : ���������� �������� ���������� ���� �˻� ����� ��� ���� ��ġ�ϸ� ��ȯ
SELECT *
    FROM EMP
    WHERE SAL < ALL (SELECT SAL
                        FROM EMP
                        WHERE DEPTNO = 30)
    ORDER BY SAL, EMPNO;
    
SELECT EMPNO, ENAME, SAL
    FROM EMP
    WHERE SAL < ALL(SELECT SAL
                        FROM EMP
                        WHERE JOB = 'MANAGER');
    
-- EXISTS ������ : ���������� ��� ���� �ϳ� �̻� �����ϸ� TRUE, �ƴϸ� FALSE
SELECT *
    FROM EMP
    WHERE EXISTS (SELECT DNAME 
                    FROM DEPT
                    WHERE DEPTNO = 50);

/* ���߿� �������� : ���� ������ ����� �� �� �̻��� �÷����� ��ȯ�Ǿ� ���������� ���� �Ǵ� ������ */
SELECT EMPNO, ENAME, SAL, DEPTNO
    FROM EMP
    WHERE (DEPTNO, SAL) IN (SELECT DEPTNO, SAL
                                FROM EMP
                                WHERE DEPTNO = 30);
                                
SELECT *
    FROM EMP
    WHERE (DEPTNO, SAL) IN (SELECT DEPTNO, MAX(SAL)
                                FROM EMP
                                GROUP BY DEPTNO);
                                
/* FROM ���� ����ϴ� �������� */
-- ���� ������ FROM���� ���� ������ �̿��ϴ� ������� �ٸ� ���δ� �ζ��κ��� ��
-- ���̺��� �ʹ� Ŀ�� �Ϻκи� ����ϰ��� �ϴ� ���
-- ���Ȼ� �����ְ� ���� ���� �����ϰ��� �ϴ� ���

SELECT E.EMPNO, E.ENAME, E.DEPTNO, D.DNAME, D.LOC
    FROM (SELECT * FROM EMP WHERE DEPTNO = 10) E, -- ���� ����
         (SELECT * FROM DEPT) D
    WHERE E.DEPTNO = D.DEPTNO;

-- ���� �����ϰ� �ش� ������ ��������
-- ROWNUM : ����Ŭ���� �Ϸù�ȣ�� �ο��ϱ� ���ؼ� ���Ǵ� ����� (��, ���ȣ �ű��)
SELECT ROWNUM, ENAME, SAL
    FROM (SELECT * FROM EMP ORDER BY SAL DESC)
    WHERE ROWNUM <= 3;

/* SELECT ���� ����ϴ� �������� */
-- SELECT���� ����ϴ� ���� �� ���������� ��Ż�� ���� ����
SELECT EMPNO, ENAME, JOB, SAL,
    (SELECT GRADE FROM SALGRADE 
                WHERE E.SAL BETWEEN LOSAL AND HISAL) AS SALGRADE,
     DEPTNO,
     (SELECT DNAME FROM DEPT
                   WHERE E.DEPTNO = DEPT.DEPTNO) AS DNAME
     FROM EMP E;

SELECT ENAME, DEPTNO, SAL, (SELECT TRUNC(AVG(SAL)) FROM EMP
                                    WHERE DEPTNO = E.DEPTNO) AS �μ���ձ޿� -- ���ο� �ִ� DEPTNO
        FROM EMP E;  

/* �μ� ��ġ�� NEWYORK�� ��쿡 ����, �ƴϸ� �������� ��ȯ�ϱ� */
SELECT EMPNO, ENAME,
            CASE WHEN DEPTNO = (SELECT DEPTNO
                                    FROM DEPT
                                    WHERE LOC = 'NEW YORK') THEN '����'
            ELSE '����'
            END AS �Ҽ�
        FROM EMP
        ORDER BY �Ҽ� DESC;

/* �������� FROM NOTION */
-- 1. ��ü ��� �� ALLEN�� ���� ��å�� ������� ��� ����, �μ� ���� ���
-- (��å, �����ȣ, ����̸�, �޿�, �μ���ȣ, �μ��̸�)
SELECT JOB, EMPNO, ENAME, SAL, D.DEPTNO, DNAME
    FROM EMP E JOIN DEPT D
    ON E.DEPTNO = D.DEPTNO
    WHERE JOB = (SELECT JOB 
                        FROM EMP
                        WHERE ENAME = 'ALLEN');

-- 2. ��ü ����� ��� �޿����� ���� �޿��� �޴� ������� �������, �μ�����, �޿� ��� ������ ���
-- (�����ȣ, ����̸�, �μ��̸�, �Ի���, �μ���ġ, �޿�, �޿����)
-- ORACLE
SELECT EMPNO, ENAME, DNAME, HIREDATE, LOC, SAL, GRADE �޿����
    FROM EMP E, DEPT D, SALGRADE S
    WHERE E.DEPTNO = D.DEPTNO AND E.SAL BETWEEN S.LOSAL AND S.HISAL
    AND SAL > (SELECT AVG(SAL) FROM EMP)
    ORDER BY E.SAL DESC, EMPNO;

-- ANSI    
SELECT EMPNO, ENAME, DNAME, HIREDATE, LOC, SAL, GRADE �޿����
    FROM EMP E
    JOIN DEPT D ON E.DEPTNO = D.DEPTNO -- �����
    JOIN SALGRADE S ON E.SAL BETWEEN S.LOSAL AND S.HISAL -- ������
    AND SAL > (SELECT AVG(SAL) FROM EMP)
    ORDER BY E.SAL DESC, E.EMPNO;

-- 3. 10�� �μ��� �ٹ��ϴ� ��� �� 30�� �μ����� �������� �ʴ� ��å�� ���� ������� �������, �μ������� ���
-- (�����ȣ, ����̸�, ��å, �μ���ȣ, �μ��̸�, �μ���ġ)
SELECT EMPNO, ENAME, JOB, E.DEPTNO, DNAME, LOC
    FROM EMP E JOIN DEPT D
    ON E.DEPTNO = D.DEPTNO
    WHERE JOB 
        = ANY(SELECT JOB FROM EMP WHERE E.DEPTNO = 10 AND E.DEPTNO !=30);

-- �����
SELECT EMPNO, ENAME, JOB, E.DEPTNO, DNAME, LOC
    FROM EMP E JOIN DEPT D
    ON E.DEPTNO = D.DEPTNO
    WHERE E.DEPTNO = 10
    AND JOB NOT IN (SELECT JOB FROM EMP WHERE DEPTNO = 30);
        
-- 4. ��å�� SALESMAN�� ������� �ְ� �޿����� ���� �޿��� �޴� ������� �������, �޿� ��������� ���
-- (�����ȣ, ����̸�, �޿�, �޿� ���)
-- ��, ���������� Ȱ���� �� ������ �Լ��� ����ϴ� ����� ������� �ʴ� ����� ���� �����ȣ�� �������� �������� ����

-- ������ ��������
SELECT EMPNO, ENAME, SAL, GRADE
    FROM EMP E, SALGRADE S
    WHERE E.SAL BETWEEN S.LOSAL AND S.HISAL
    AND SAL > (SELECT MAX(SAL) FROM EMP WHERE JOB = 'SALESMAN')
    ORDER BY EMPNO;
    
-- ������ ��������
SELECT EMPNO, ENAME, SAL, GRADE
    FROM EMP E, SALGRADE S
    WHERE E.SAL BETWEEN S.LOSAL AND S.HISAL
    AND SAL > ALL (SELECT SAL
                        FROM EMP
                        WHERE JOB = 'SALESMAN')
    ORDER BY EMPNO;