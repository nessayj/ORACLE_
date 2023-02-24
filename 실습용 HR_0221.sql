/* 230221 TUE */
/* �������� : HR ���� �������� ���� */

-- 1. EMPLOYEES ���̺��� 100�� �μ��� �ּұ޿����� �ּ� �޿��� ���� �ٸ� ��� �μ��� ���
SELECT * FROM EMPLOYEES;

SELECT DEPARTMENT_ID, MIN(SALARY)
    FROM EMPLOYEES
    GROUP BY DEPARTMENT_ID
    HAVING MIN(SALARY) > (SELECT MIN(SALARY)
                            FROM EMPLOYEES
                            WHERE DEPARTMENT_ID = 100);
-- 2. EMPLOYEES�� DEPARTMENTS���̺��� ������ SA_MAN ����� ������ ����, ����, �μ���, �ٹ��� ���
SELECT * FROM DEPARTMENTS;
SELECT E.FIRST_NAME, E.JOB_ID, D.LOCATION_ID, D.DEPARTMENT_ID
    FROM EMPLOYEES E JOIN DEPARTMENTS D
    ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
    WHERE E.JOB_ID = 'SA_MAN';

-- 3. EMPLOYEES ���̺��� (���� ���� ���)�� ���� MANAGER�� �����ȣ ���
SELECT MANAGER_ID, COUNT(*)
    FROM EMPLOYEES
    GROUP BY MANAGER_ID
    HAVING COUNT(*) IN (SELECT MAX(COUNT(*)
                             FROM EMPLOYEES
                             GROUP BY MANAGER_ID);

-- 4. EMPLOYEES ���̺��� (���� ���� ����� �����ִ� �μ� ��ȣ)�� ����� ���
SELECT DEPARTMENT_ID, COUNT(*)
    FROM EMPLOYEES
    GROUP BY DEPARTMENT_ID
    HAVING COUNT(*) IN (SELECT MAX(COUNT(DEPARTMENT_ID)
                             FROM EMPLOYEES
                             GROUP BY DEPARTMENT_ID);
                             
-- 5. ����(JOB)���� �ּұ޿��� �޴� ����� ������ �����ȣ, �̸�, ����, �μ��� ���(�������� ��������)
-- IN �����ڸ� ����� JOB_ID�� �޿��� �ش� JOB_ID �� �ּ� �޿��� ��ġ�ϴ� ������ ���͸�
SELECT  EMPLOYEE_ID, FIRST_NAME, JOB_ID, D.DEPARTMENT_ID, D.DEPARTMENT_NAME
    FROM EMPLOYEES E JOIN DEPARTMENTS D
    ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
    WHERE SALARY < ANY (SELECT MIN(SALARY) FROM EMPLOYEES GROUP BY JOB_ID)
    ORDER BY JOB_ID DESC;
    
SELECT  EMPLOYEE_ID, FIRST_NAME, JOB_ID, D.DEPARTMENT_ID, D.DEPARTMENT_NAME
    FROM EMPLOYEES E JOIN DEPARTMENTS D
    ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
    WHERE (JOB_ID, SALARY) IN (SELECT JOB_ID, MIN(SALARY)
                                    FROM EMPLOYEES
                                    GROUP BY JOB_ID);
    
-- 6. EMPLOYEES ���̺��� ( 50�� �μ��� �ְ�޿�)�� �޴� ������� ���� �޿��� �޴� ����� �����ȣ, �̸�, ����, �Ի�����, �޿�, �μ���ȣ ���
-- �� ,50���� ����
SELECT EMPLOYEE_ID, FIRST_NAME, JOB_ID, HIRE_DATE, SALARY, DEPARTMENT_ID
    FROM EMPLOYEES
    WHERE DEPARTMENT_ID != 50
    AND SALARY > (SELECT MAX(SALARY)
                            FROM EMPLOYESS
                            WHERE DEPARTMENT_ID = 50);
