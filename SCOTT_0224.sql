/* 230224 FRI */
/* ������ ���� */
-- ����Ŭ �����ͺ��̽� ���̺��� ����� ���̺�� ������ �������� ������ ��
-- ������ �������� �����ͺ��̽� �޸�, ����, �����, ����, ��ü �� ����Ŭ
-- �����ͺ��̽� ��� �߿��� �����Ͱ� ���� �Ǿ� �ֽ��ϴ�.
-- ������ ���� ������ �����ϰų� �����ϴ� ���� �۾��� �� �� ���� ������ ���� ������ ����

SELECT * FROM DICT;
SELECT * FROM DICTIONARY;

-- ����ڰ� ������ ��ü ������ �����Ǿ�����
SELECT TABLE_NAME FROM USER_TABLES; 

-- ALL_���ξ ���� ������ ������ ����Ŭ�����ͺ��̽��� ������ �ִ� ����ڰ� ������ ��ü �� �ٸ� ����ڰ� ������ ��ü �� ����� ����Ǿ� �ִ� ��ü����
SELECT OWNER, TABLE_NAME
    FROM ALL_TABLES;

-- DBA_���ξ ���� ������ ������ �����ͺ��̽����� ������ ���� ����ڸ� ��ȸ�� �� �ִ� ���̺�μ� SCOTT �������δ� ��ȸ �Ұ���
SELECT * FROM DBA_TABLES; -- ���翩�ε� �˷����� ����

/* �ε��� */
--  ����Ŭ �����ͺ��̽����� ������ �˻� ������ ����� ���� ���̺� ���� ����ϴ� ��ü
SELECT ROWID FROM EMP;

SELECT * FROM USER_INDEXES;

/* �ε��� ���� */
-- ����Ŭ �����ͺ��̽����� �ڵ����� ������ �ִ� �ε��� �ܿ� ����ڰ� ���� �ε����� ���� �� ���
CREATE INDEX IDX_EMP_SAL ON EMP(SAL);

-- ������ �ε��� Ȯ���ϱ�
SELECT * FROM USER_IND_COLUMNS;

-- ���� �ε��� �����ϱ� : �� �� �̻��� �÷����� �ε��� ���� (�ִ� 32������ ����)
CREATE INDEX IDX_EMP_TUPLE ON EMP(JOB, DEPTNO);

-- ����ũ (UNIQUE) �ε��� ���� : ����ũ (UNIQUE) �ε����� �����ϸ� �ε��� ������ �÷��� �ش� ���̺��� ������ ���̾�� ��.
-- �� �ʿ��� ��찡 �ƴϸ� ������� �� ��
CREATE UNIQUE INDEX IDX_RMP_UK ON EMP(EMPNO, MGR);

-- �ε��� ���� : DROP
DROP INDEX IDX_EMP_SAL;

/* VIEW */
-- �������̺�
-- ��� �ϳ� �̻��� ���̺��� ��ȸ�ϴ� SELECT���� ������ ��ü
-- ��� ������ ������ �ܼ�ȭ �� �� ����
-- ����ڿ��� �ʿ��� ������ �����ϵ��� ������ ���� �� �� ����

CREATE VIEW VW_EMP20
    AS (SELECT EMPNO, ENAME, JOB, DEPTNO
            FROM EMP
            WHERE DEPTNO = 20);
            
SELECT * FROM VW_EMP20;

/* �ܼ� �� ���� �ϱ� */
-- �ܼ� ��� ���� ���̺� �ʿ��� �÷��� ���� �� �� (GROUP BY, UNION ������� ����)
-- �ܼ� ��� SELECT, INSERT, UPDATE, DELETE�� �����Ӱ� ��� ����
CREATE VIEW V_EMP
    AS (SELECT EMPNO, ENAME, JOB, HIREDATE
            FROM EMP);

SELECT * FROM V_EMP;

DROP VIEW VW_EMP20;

/* �ζ��κ並 ����� TOP-N SQL �� */
-- TOP-N ������ �����ͺ��̽����� ���� ū N���� ���� �˻��ϴ� ������ �ǹ�
SELECT ROWNUM, E.*
    FROM EMP E;

-- �ζ��κ� (�������� �̿�)
SELECT ROWNUM, E.*
    FROM (SELECT *
            FROM EMP E
            ORDER BY SAL DESC) E;
            
-- �ζ��κ�� TOP-N �����ϱ�
SELECT ROWNUM, E.*
    FROM (SELECT *
            FROM EMP E
            ORDER BY SAL DESC) E
    WHERE ROWNUM <= 3;
    
/* VIEW�� ���� DML�� ���� */
CREATE  VIEW EMP_COPY_VIEW
    AS SELECT EMPNO, ENAME, DEPTNO
    FROM EMP;
    
SELECT * FROM EMP_COPY_VIEW;

INSERT INTO EMP_COPY_VIEW VALUES(9999, '����', 20);

UPDATE EMP_COPY_VIEW 
    SET DEPTNO = 30 
    WHERE DEPTNO = 20;
    
   