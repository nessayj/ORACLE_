/* 230223 THU */

CREATE TABLE DEPT_TCL
    AS SELECT * FROM DEPT;

SELECT * FROM DEPT_TCL;

INSERT INTO DEPT_TCL VALUES(50, 'DATABASE', 'SEOUL');

UPDATE DEPT_TCL SET LOC = 'BUSAN'
        WHERE DEPTNO = 40;

DELETE FROM DEPT_TCL WHERE DNAME = 'RESEARCH';

COMMIT;

DESC EMP;

/* DDL ���� Ŀ�ǵ�
 * CREATE - ���̺� ����
 * ALTER -  ���̺� ����(ADD, RENAME, MODIFY, DROP)
 * TRUNCATE - ���̺� ������ ����
 * DROP - ���̺� ����
 */

/* ���̺� �ڷ����� �����Ͽ� ���� �����ϴ� ��� */

CREATE TABLE EMP_DOL (
    EMPNO      NUMBER(4),
    ENAME      VARCHAR2(10),
    JOB        VARCHAR2(9),
    MGR        NUMBER(4),
    HIREDATE   DATE,
    SAL        NUMBER(7, 2),  -- �ڸ��� 7�ڸ� �Ҽ��� ���� 2�ڸ��ǹ�
    COMM       NUMBER(7, 2),
    DEPTNO     NUMBER(2)
);

SELECT * FROM EMP_DOL;

/* ���� ���̺��� �� ������ �����͸� �����Ͽ� �� ���̺� �����ϱ� */

CREATE TABLE DEPT_DDL
    AS SELECT * FROM DEPT;
    
SELECT * FROM DEPT_DDL;

/* ���� ���̺��� �� ������ �����Ͽ� �� ���̺� �����ϱ� */

CREATE TABLE DET_DDL_TMP
    AS SELECT * FROM DEPT
    WHERE 1 != 1;

CREATE TABLE EMPDEPT_DDL
    AS SELECT E.EMPNO, E.ENAME, E.JOB, E.MGR, E.HIREDATE,
    E.SAL, E.COMM, D.DEPTNO, D.DNAME, D.LOC
    FROM EMP E, DEPT D
    WHERE 1 != 1;

SELECT * FROM DET_DDL_TMP;

SELECT * FROM EMPDEPT_DDL;


/* ���̺��� �����ϴ� ALTER */
-- ���̺��� �� ���� �߰� �Ǵ� ����, ���� �ڷ����� ���� ���� ���� ���� 

CREATE TABLE EMP_ALTER AS SELECT * FROM EMP;

SELECT * FROM EMP_ALTER;

-- ���̺��� �� �߰� : ADD - �߰� �� ���� ���� �࿡�� NULL��(�⺻��)���� �Է� ��

ALTER TABLE EMP_ALTER
    ADD HP VARCHAR2(20);
    
-- �� �̸� ���� : RENAME

ALTER TABLE EMP_ALTER
    RENAME COLUMN HP TO TEL;

-- ���� �ڷ����� ���� :  MODIFY, �ڷ��� ���� �� �̹� �ش� �÷��� ���� ���� �����Ѵٸ� ����� �� �� ����
-- ������ �ڷ����� ũ�⺸�� ũ�� �����ϴ°� ���� �ȵ�, �۰� ����ÿ��� ���Ե� �����Ϳ� ������ ����

ALTER TABLE EMP_ALTER
    MODIFY EMPNO NUMBER(5);

DESC EMP_ALTER; -- �ڷ��� �� �� ����

-- Ư�� ���� ���� �� �� : DROP ; ���� �־ ���� ����

ALTER TABLE EMP_ALTER
    DROP COLUMN TEL;

ALTER TABLE EMP_ALTER
    DROP COLUMN MGR; 
    
/* ���̺� �̸��� �����ϴ� RENAME */

RENAME DET_DDL_TMP TO DEPT_DDL_TMP;

/* ���̺��� �����͸� �����ϴ� TRUNCATE */
-- ���̺��� ��� �����͸� �����ϴ� ���, ���̺� ������ ������ ���� ������, ROLLBACK �Ұ�

TRUNCATE TABLE EMP_ALTER;

/* ���̺��� �����ϴ� DROP */

DROP TABLE EMP_ALTER;

/* ���� ���� */

-- 1. EMP_HW ���̺� �����
CREATE TABLE EMP_HW (
    EMPNO       NUMBER(4),
    ENAME       VARCHAR2(10),
    JOB         VARCHAR2(9),
    MGR         NUMBER(4),
    HIREDATE    DATE,
    SAL         NUMBER(7, 2),
    COMM        NUMBER(7, 2),
    DEPTNO      NUMBER(2)
);

-- 2. EMP_HW ���̺� BIGO���� �߰� �ϱ�. BIGO���� �ڷ����� ������ ���ڿ��̰�, ���̴� 20

ALTER TABLE EMP_HW
    ADD BIGO VARCHAR2(20);

-- 3. EMP_HW ���̺��� BIGO�� ũ�⸦ 30���� ����

ALTER TABLE EMP_HW
    MODIFY BIGO VARCHAR2(30);

-- 4. EMP_HW ���̺��� BIGO �� �̸��� REMARK�� ����

ALTER TABLE EMP_HW
    RENAME COLUMN BIGO TO REMARK;
    
-- 5. EMP_HW ���̺� EMP ���̺��� �����͸� ��� ����. REMAKE ���� NULL�� ����.

INSERT INTO EMP_HW
    SELECT EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO, NULL
    FROM EMP;
    
-- 6. EMP_HW ���̺� ����

DROP TABLE EMP_HW;

/* ���� ���� */
-- ���̺� ���� �� �����͸� �����ϴ� Ư���� ��Ģ�� �ǹ� ��
-- ���ǿ� ���� �ʴ� ������ ���� �Ұ�

/* ���� ������� �ʴ� NOT NULL */
-- ���� ���� �������� �ߺ� ���δ� ������� NULL���� ������� ���� (�ݵ�� ���� �ԷµǾ�� ��)

CREATE TABLE TABLE_NOTNULL(
    LOGIN_ID        VARCHAR2(20) NOT NULL, -- ������ ������ ���;� ��
    LOGIN_PWD       VARCHAR2(20) NOT NULL,
    TEL             VARCHAR2(20)
);

DESC TABLE_NOTNULL; 

INSERT INTO TABLE_NOTNULL (LOGIN_ID, LOGIN_PWD, TEL) VALUES('����', 'A12345', '010-2345-6789');
INSERT INTO TABLE_NOTNULL (LOGIN_ID, LOGIN_PWD, TEL) VALUES('����', 'A123456', NULL); 

SELECT * FROM TABLE_NOTNULL;

/* �ߺ����� �ʴ� �� : UNIQUE */
-- ���� ���� �� �������� �ߺ��� ������� ����

CREATE TABLE TABLE_UNIQUE (
    LOGIN_ID            VARCHAR2(20) UNIQUE,
    LOGIN_PWD           VARCHAR2(20) NOT NULL,
    TEL                 VARCHAR2(20)
);

INSERT INTO TABLE_UNIQUE (LOGIN_ID, LOGIN_PWD, TEL) VALUES('����', 'A12345', '010-2345-6789');
INSERT INTO TABLE_UNIQUE (LOGIN_ID, LOGIN_PWD, TEL) VALUES(NULL, 'A123456', NULL); 

SELECT * FROM TABLE_UNIQUE;

/* PRIMARY KEY */
-- UNIQUE Ư���� NOT NULLƯ���� ��� ������ ����

CREATE TABLE TABLE_PK (
    LOGIN_ID             VARCHAR2(20) PRIMARY KEY,
    LOGIN_PWD            VARCHAR2(20) NOT NULL,
    TEL                  VARCHAR2(20)
);

INSERT INTO TABLE_PK (LOGIN_ID, LOGIN_PWD, TEL) VALUES('����', 'A12345', '010-2345-6789');
INSERT INTO TABLE_PK (LOGIN_ID, LOGIN_PWD, TEL) VALUES('���', 'A123456', NULL); 

SELECT * FROM TABLE_PK;

/* FOREIGN KEY(�ܷ�Ű) �����ϱ� */
-- ���� �ٸ� ���̺� ���踦 �����ϴµ� ����ϴ� ���� ����

CREATE TABLE DEPT_FK (
    DEPTNO          NUMBER(2) CONSTRAINT DEPTFK_DEPTNO_PK PRIMARY KEY, -- PRIMARY KEY�� ��Ī(����Ŭ�� �����ϴ� ���̺��� �̸�)�� �־���
    DNAME           VARCHAR(14),
    LOC             VARCHAR(13)
);

CREATE TABLE EMP_FK(
    EMPNO           NUMBER(4) CONSTRAINT EMPFK_EMPNO_PK PRIMARY KEY,
    ENAME           VARCHAR2(10),
    JOB             VARCHAR2(9),
    MGR             NUMBER(4),
    HIREDATE        DATE,
    SAL             NUMBER(7, 2),
    COMM            NUMBER(7, 2),
    DEPTNO          NUMBER(2) CONSTRAINT EMPFK_DEPTNO_FK REFERENCES DEPT_FK (DEPTNO) -- REFERENCES �����ϴ� Ű�� ����
);

INSERT INTO DEPT_FK VALUES(10, 'PALACE', 'SEOUL'); -- ���� ����� ��� �� -> ���� ���� ������

INSERT INTO EMP_FK VALUES(9999, '����', 'KING', NULL, '1990-03-17', 10000, 1000, 10);  -- DEPTNO�� �μ��� DEPT_FK�� �����ϰ� �ֱ� ������ �μ���ȣ ���� ����� ��� ��
-- ���� �� ������ ���� EMP_FK�� �ڷḦ ������ DEPT_FK�� �ڷḦ ���� �� ���� -> �ܷ�Ű ���� ������

SELECT * FROM EMP_FK;
SELECT * FROM DEPT_FK;

/* ������ ���¿� ������ ���ϴ� CHECK */

CREATE TABLE TABLE_CHECK(
    LOGIN_ID         VARCHAR2(20) CONSTRAINT TBLCK_LOGINID_PK PRIMARY KEY,
    LOGIN_PWD        VARCHAR2(20) CONSTRAINT TBLCK_LOGINPWD_PK CHECK (LENGTH(LOGIN_PWD) > 3), -- (FRONTEND) �Է� ���� �� ���� üũ�ϴ°� �� ����
    TEL              VARCHAR2(20)
);

INSERT INTO TABLE_CHECK VALUES('������', 'A154', '010-4643-2292');

/* �⺻���� �����ϴ� DEFAULT */

CREATE TABLE TABLE_DEFAULT (
     LOGIN_ID         VARCHAR2(20) CONSTRAINT TBCLK2_LOGINID_PK PRIMARY KEY,
     LOGIN_PWD        VARCHAR2(20) DEFAULT '1234',
     TEL              VARCHAR2(20)
);

INSERT INTO TABLE_DEFAULT VALUES('������', NULL, '010-1234-5678'); -- NULL�� ���� ������ NULL������ ��(DEFAULT ���� ���� ����)
INSERT INTO TABLE_DEFAULT (LOGIN_ID, TEL) VALUES ('���쿬��', '010-7039-1849');

SELECT * FROM TABLE_DEFAULT;

/* �������� �������� */
-- 1. PRODUCT ���̺� ����

CREATE TABLE PRODUCT (
    PRODUCT_ID      NUMBER(20) PRIMARY KEY,
    PRDUCT_NAME     VARCHAR2(20) NOT NULL,
    REG_DATE        DATE
);

-- 2. PRODUCT ���̺� ������ ����

INSERT INTO PRODUCT VALUES (1, 'COMPUTER', '21/01/02');
INSERT INTO PRODUCT VALUES (2, 'SMARTPHONE', '22/02/03');
INSERT INTO PRODUCT VALUES (3, 'TELEVISOIN', '22/07/01');

-- 3. PRODUCT ���̺� �� �߰�

ALTER TABLE PRODUCT
    ADD WEIGHT NUMBER CHECK (WEIGHT >= 0);

ALTER TABLE PRODUCT
    ADD PRICE NUMBER CHECK (PRICE >= 0);
    
SELECT * FROM PRODUCT;

/* �������� 2 */

-- CUSTOMER TABLE �߰�

CREATE TABLE CUSTOMER_TABLE (
    CUSTOM_ID           NUMBER PRIMARY KEY,
    USER_NAME           VARCHAR(12) NOT NULL,
    PHONE               VARCHAR(20),
    EMAIL               VARCHAR(20),
    REG_DATE            DATE DEFAULT '1900/01/01'
);

-- �� ���̺� �߰�

ALTER TABLE CUSTOMER_TABLE 
    ADD AGE NUMBER CHECK( AGE >= 1 AND AGE <=199);

ALTER TABLE CUSTOMER_TABLE
    ADD SEX VARCHAR2(1) CHECK ( SEX = 'M' OR SEX = 'F');

ALTER TABLE CUSTOMER_TABLE
    ADD BIRTH_DATE  DATE;
    
-- ���� ���� �߰��ϱ�
-- 1. ��ȭ��ȣ�� �����ؾ� �Ѵ�.
-- 2. �̸����� �����ؾ� �Ѵ�.

ALTER TABLE CUSTOMER_TABLE
    MODIFY PHONE UNIQUE;
    
ALTER TABLE CUSTOMER_TABLE
    MODIFY EMAIL UNIQUE;
    
-- �����ϱ�
-- 1. ������ ���� �÷��̸� ���� -> GENDER�� ����
-- 2. ��ȭ��ȣ �̸��� ����  -> MOBILE�� ����
-- 3. �̸��� �������� ũ�⸦ 20���� ����

ALTER TABLE CUSTOMER_TABLE
    RENAME COLUMN SEX TO GENDER;

ALTER TABLE CUSTOMER_TABLE
    RENAME COLUMN PHONE TO MOBILE;
    
ALTER TABLE CUSTOMER_TABLE
    MODIFY USER_NAME VARCHAR(20);
    
-- ������ �߰��ϱ�
-- 10���� ������ �����͸� �߰��Ͽ� ���������� �ݿ��Ǵ��� Ȯ��

SELECT * FROM CUSTOMER_TABLE;

INSERT INTO CUSTOMER_TABLE VALUES ( 1, '����', '123-456-7899', 'GA@123', null ,10, '2000/01/01', 'M');
INSERT INTO CUSTOMER_TABLE VALUES ( 2, '����', '234-5678-9012', 'NA@123', '1983/05/28', 25, '1995/10/01', 'F');
INSERT INTO CUSTOMER_TABLE VALUES ( 3, '�پ�', '123-456-7894', 'DA@123', null ,10, '2000/01/01', 'M');
INSERT INTO CUSTOMER_TABLE VALUES ( 4, '��', '234-5678-9011', 'LA@123', '1983/05/28', 25, '1995/10/01', 'F');
INSERT INTO CUSTOMER_TABLE VALUES ( 5, '����', '123-456-7896', 'MA@123', null ,10, '2000/01/01', 'M');
INSERT INTO CUSTOMER_TABLE VALUES ( 6, '�پ�', '234-5678-9013', 'BA@123', '1983/05/28', 25, '1995/10/01', 'F');
INSERT INTO CUSTOMER_TABLE VALUES ( 7, '�羾', '123-456-7892', 'SA@123', null ,10, '2000/01/01', 'M');
INSERT INTO CUSTOMER_TABLE VALUES ( 8, '�ƾ�', '234-5678-9010', 'A@123', '1983/05/28', 25, '1995/10/01', 'F');
INSERT INTO CUSTOMER_TABLE VALUES ( 9, '�ھ�', '123-456-7897', 'JA@123', null ,10, '2000/01/01', 'M');
INSERT INTO CUSTOMER_TABLE VALUES ( 10, '����', '234-5678-9018, 'CHA@123', '1983/05/28', 25, '1995/10/01', 'F');