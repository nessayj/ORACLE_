/* 230221 TUE */
/* ������ ���̺� �����ϱ� */
SELECT * FROM DEPT;

CREATE TABLE DEPT_TEMP
    AS SELECT * FROM DEPT; -- DEPT���̺��� ����

SELECT * FROM DEPT_TEMP; 

DROP TABLE DEPT_TEMP; -- DEPT_TEMP ���̺� ����

/* ���̺� �����͸� �߰��ϴ� INSERT �� */
/*
* INSERT INTO ���̺��̸� (��1, ��2, ......) VALUES (���� �ش��ϴ� ������,......)
*/
/* ���̺� �����͸� ����(INSERT)�ϴ� ù ��° ��� : ���̺� ��ϰ� �߰� �� ���� ��� ǥ��  */ 
INSERT INTO DEPT_TEMP(DEPTNO, DNAME, LOC) VALUES (50, 'DATABASE', 'SEOUL');
-- ���� ���� ��� �ؼ� �� �� ���� -> ���������� �ɾ������
DESC DEPT_TEMP;
DELETE FROM DEPT_TEMP
    WHERE DEPTNO = 50; -- �ڷḦ ����
INSERT INTO DEPT_TEMP(LOC, DEPTNO) VALUES('BUSAN', 60); 

INSERT INTO DEPT_TEMP VALUES (70, 'DEVELOPER', 'SUWON'); -- ���̺� ���� �ȳ־� �൵ �� ; 
INSERT INTO DEPT_TEMP VALUES ( 80, 'GUEST', 'INCHEON');

/* ���̺� NULL������ �Է��ϱ� */
INSERT INTO DEPT_TEMP VALUES(90, 'WEB', NULL);
INSERT INTO DEPT_TEMP VALUES(91, 'MOBILE', '');
INSERT INTO DEPT_TEMP(DEPTNO, LOC) VALUES(92, 'ULSAN');

/* EMP TABLE�� ���� ������ �������� ���� */
CREATE TABLE EMP_TEMP
    AS SELECT * FROM EMP
        WHERE 1 != 1; -- ���̺��� �����ϸ鼭 �����ʹ� �����ϰ� ���� ���� �� ���

SELECT * FROM EMP_TEMP;
/* ��¥ �����ʹ� '2020/01/01', '2020-01-01' �Է� ����
* TO_DATE('2021/01/01', 'YYYY/MM/DD')
*/
INSERT INTO EMP_TEMP(EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
        VALUES(9001, '����', '��', NULL, '1990/03/17', 9900, 1000, 10);

INSERT INTO EMP_TEMP(EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
        VALUES(9002, '���긾', '�ո�', NULL, '1964/09/10', 9900, 2000, 10);

INSERT INTO EMP_TEMP(EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
        VALUES(9003, '������', '����', NULL, '1961/04/26', 500, 10, 30);

INSERT INTO EMP_TEMP(EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
        VALUES(9004, '�����', '�վ�', 9002, '1992-12-14', 1000, 100, 20);
        
INSERT INTO EMP_TEMP(EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
        VALUES(9005, '���', '����ü', 9001, TO_DATE('1990/03/17', 'YYYY/MM/DD'), 1000, NULL, 40);
                    
-- COMMIT���ؾ���

/* ���̺� �ִ� ������ �����ϱ� */
/* UPDATE [������ ���̺�] 
* SET  [������ ��....] = [������ ������,.....]
* WHERE ������
*/

SELECT * FROM DEPT_TEMP;

UPDATE DEPT_TEMP SET LOC = 'SEOUL';

UPDATE DEPT_TEMP
    SET LOC = 'BUSAN'
    WHERE DNAME = 'WEB';

UPDATE DEPT_TEMP
    SET DNAME = 'ANDROID', LOC = 'DAEGU'
    WHERE DEPTNO = 60;
    
UPDATE DEPT_TEMP
    SET (DNAME, LOC) = (SELECT DNAME, LOC
                                FROM DEPT
                                WHERE DEPTNO = 40)
    WHERE DEPTNO = 40;
    
/* ���̺� �ִ� ������ �����ϱ� (DELETE) */
CREATE TABLE EMP_TEMP2 AS SELECT * FROM EMP;
SELECT * FROM EMP_TEMP2;

DELETE FROM EMP_TEMP2; -- ���̺� ���� ������ ��ü ����
DROP TABLE EMP_TEMP2; -- ���̺� �� ��ü�� ����

DELETE FROM EMP_TEMP2
    WHERE JOB = 'MANAGER';

-- ���������� �̿��� DELETE 
DELETE FROM EMP_TEMP2
    WHERE EMPNO IN (SELECT E.EMPNO
                        FROM EMP_TEMP2 E, SALGRADE S
                        WHERE E.SAL BETWEEN S.LOSAL AND S.HISAL
                        AND S.GRADE = 3
                        AND DEPTNO = 30);

/* ���� ���� */
/* ���� �����ϴ� ������ ���� SQL���� �����Ͽ� EMP, DEPT, SALGRADE ���̺��� ������ ���̺�� ����
�ϼ���. ���� SQL���� �� ���� �� ���徿 �����մϴ�. */

CREATE TABLE EX_EMP AS SELECT * FROM EMP;
CREATE TABLE EX_DEPT AS SELECT * FROM DEPT;
CREATE TABLE EX_SALGRADE AS SELECT * FROM SALGRADE;

-- 1. EX_DEPT ���̺� 50, 60, 70, 80�� ����ϴ� SQL���� �ۼ��ϼ���.
INSERT INTO EX_DEPT(DEPTNO, DNAME, LOC)
    VALUES(50, 'ORACLE', 'BUSAN');
INSERT INTO EX_DEPT(DEPTNO, DNAME, LOC)
    VALUES(60, 'SQL', 'ILSAN');
INSERT INTO EX_DEPT(DEPTNO, DNAME, LOC)
    VALUES(70, 'SELECT', 'INCHEON');
INSERT INTO EX_DEPT(DEPTNO, DNAME, LOC)
    VALUES(80, 'DML', 'BUNDANG');

SELECT * FROM EX_DEPT;

-- 2. EX_EMP ���̺� ���� 8���� ��������� ����ϴ� SQL���� �ۼ��ϼ���.
INSERT INTO EX_EMP(EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
    VALUES(7201, 'TEST_USER1', 'MANAGER', 7788, '2016/01/02', 4500, NULL, 50);
INSERT INTO EX_EMP(EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
    VALUES(7202, 'TEST_USER2', 'CLERK', 7201, '2016/02/21', 1800, NULL, 50);
INSERT INTO EX_EMP(EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
    VALUES(7203, 'TEST_USER3', 'ANALYST', 7201, '2016/04/11', 3400, NULL, 60);
INSERT INTO EX_EMP(EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
    VALUES(7204, 'TEST_USER4', 'SALESMAN', 7201, '2016/05/31', 2700, 300, 60);
INSERT INTO EX_EMP(EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
    VALUES(7205, 'TEST_USER5', 'CLERK', 7201, '2016/07/20', 2600, NULL, 70);
INSERT INTO EX_EMP(EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
    VALUES(7206, 'TEST_USER6', 'CLERK', 7201, '2016/09/08', 2600, NULL, 70);
INSERT INTO EX_EMP(EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
    VALUES(7207, 'TEST_USER7', 'LECTURER', 7201, '2016/10/28', 2300, NULL, 80);
INSERT INTO EX_EMP(EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
    VALUES(7208, 'TEST_USER8', 'STUDENT', 7201, '2018/03/09', 1200, NULL, 80);

-- 3. EX_EMP�� ���� ��� �� 50�� �μ����� �ٹ��ϴ� ������� ��� �޿����� ���� �޿��� �ް��ִ� ������� 70�� �μ��� �ű�� SQL���� �ۼ��ϼ���.
UPDATE EX_EMP
    SET DEPTNO = 70
    WHERE SAL > (SELECT AVG(SAL)
                    FROM EX_EMP
                    WHERE DEPTNO = 50);

SELECT * FROM EX_EMP;

-- 4. EX_EMP�� ���� ��� ��, 60�� �μ��� ����߿� �Ի����� ���� ���� ������� �ʰ� �Ի��� ����� �޿��� 10%�λ��ϰ� 80�� �μ��� �ű�� SQL���� �ۼ��ϼ���.
UPDATE EX_EMP
    SET DEPTNO = 80, SAL = SAL*1.1
    WHERE HIREDATE > (SELECT MIN(HIREDATE)
                        FROM EX_EMP
                        WHERE DEPTNO = 60);

-- 5. EX_EMP�� ���� ��� ��, �޿� ����� 5�� ����� �����ϴ� SQL���� �ۼ��ϼ���.
SELECT * FROM EX_SALGRADE;

DELETE FROM EX_EMP
    WHERE EMPNO IN (SELECT E.EMPNO
                        FROM EX_EMP E, EX_SALGRADE S
                        WHERE E.SAL BETWEEN S.LOSAL AND S.HISAL
                        AND S.GRADE = 5);
