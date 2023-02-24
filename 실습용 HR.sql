/* 230216 */
/* �ǽ��� HR �������� */
-- Q1) EMPLOYEES ���̺��� King�� ������ �ҹ��ڷ� �˻��ϰ� �����ȣ, ����, ������(�ҹ��ڷ�),�μ���ȣ�� ����϶�.
SELECT * FROM EMPLOYEES;
SELECT EMPLOYEE_ID �����ȣ, CONCAT(FIRST_NAME, CONCAT(' ', LAST_NAME)) AS ����, LOWER(JOB_ID) ������, DEPARTMENT_ID AS �μ���ȣ
    FROM EMPLOYEES;
-- Q2) EMPLOYEES ���̺��� King�� ������ �빮�ڷ� �˻��ϰ� �����ȣ, ����, ������(�빮�ڷ�),�μ���ȣ�� ����϶�.
SELECT EMPLOYEE_ID �����ȣ, CONCAT(FIRST_NAME, CONCAT(' ', LAST_NAME)) AS ����, UPPER(JOB_ID) ������, DEPARTMENT_ID �μ���ȣ
    FROM EMPLOYEES;
-- Q3) DEPARTMENTS ���̺��� (�μ���ȣ�� �μ��̸�), �μ��̸��� ��ġ��ȣ�� ���Ͽ� ����ϵ��� �϶�.
SELECT * FROM DEPARTMENTS;
SELECT DEPARTMENT_ID �μ���ȣ, DEPARTMENT_NAME �μ��̸�, CONCAT(DEPARTMENT_NAME, CONCAT('  ', LOCATION_ID)) AS "�μ��̸�+��ġ��ȣ"
    FROM DEPARTMENTS;
-- Q4) EMPLOYEES ���̺��� �̸��� ù ���ڰ� ��K�� ���� ũ�� ��Y������ ���� ����� ������
-- �����ȣ, �̸�, ����, �޿�, �μ���ȣ�� ����϶�.
-- �� �̸������� �����Ͽ���(����������).
SELECT EMPLOYEE_ID �����ȣ,FIRST_NAME �̸�, JOB_ID ����, SALARY �޿�, DEPARTMENT_ID �μ���ȣ
    FROM EMPLOYEES
    WHERE FIRST_NAME > 'K' AND FIRST_NAME < 'Y'
    ORDER BY FIRST_NAME;
-- Q5) EMPLOYEES ���̺��� 20�� �μ� �� �̸��� ���� �� �޿��� �ڸ����� 
-- �����ȣ, �̸�, �̸��� �ڸ���(LENGTH), �޿�, �޿��� �ڸ����� ����϶�.
-- LENGTHB�� BYTE ȥ������ ����!
SELECT EMPLOYEE_ID �����ȣ, FIRST_NAME �̸�, 
    LENGTH(FIRST_NAME) AS "�̸��� �ڸ���",
    SALARY �޿�, 
    LENGTH(SALARY) AS "�޿��� �ڸ���"
    FROM EMPLOYEES
    WHERE DEPARTMENT_ID = 20;
-- Q6) EMPLOYEES ���̺��� �̸� �� ��e������ ��ġ�� ����϶�.
SELECT FIRST_NAME �̸�,
    INSTR(FIRST_NAME, 'e', 1) AS "e�� ��ġ"
    FROM EMPLOYEES;    
-- Q7) EMPLOYEES ���̺��� �μ���ȣ�� 80�� ����� �޿��� 30���� ���� �������� ���Ͽ� ����϶�.
SELECT FIRST_NAME �̸�, DEPARTMENT_ID �μ���ȣ, SALARY �޿�, MOD(SALARY, 30) "������"
    FROM EMPLOYEES
    WHERE DEPARTMENT_ID = 80;
-- Q8) EMPLOYEES ���̺��� ������� �ٹ��� ���� ���� ���� �ΰ��� ����Ͽ���.
-- �� �ٹ� �ϼ��� ���� ��� ������ ����Ͽ���.
-- ��¥�� ���̸� ���ϰ� �̸� 7�� ������ �ٹ� ��
-- ��¥�� ���̸� ���ϰ� �̸� 7�� ���� �������� �ϼ�
SELECT * FROM EMPLOYEES;
SELECT CONCAT(FIRST_NAME, CONCAT(' ', LAST_NAME)) �̸�, HIRE_DATE �Ի���,
    TO_CHAR(TRUNC(MONTHS_BETWEEN(SYSDATE, HIRE_DATE)/4)) || '��' || TO_CHAR(TRUNC(MOD(MONTHS_BETWEEN(SYSDATE, HIRE_DATE)/4, 7))) || '��' as "�ٹ� ��/��"
FROM EMPLOYEES
ORDER BY  TO_CHAR(TRUNC(MONTHS_BETWEEN(SYSDATE, HIRE_DATE)/4));
    
-- Q9) EMPLOYEES ���̺��� �μ� 50���� �޿� �տ� $�� �����ϰ� 3�ڸ����� ,�� ����϶�
SELECT CONCAT(FIRST_NAME, CONCAT(' ', LAST_NAME)) �̸�,  TO_CHAR(SALARY, '$999,999') �޿�, DEPARTMENT_ID �μ���ȣ
    FROM EMPLOYEES
    WHERE DEPARTMENT_ID = 50;
-- Q10) EMPLOYEES ���̺��� �μ����� �ο���, ��� �޿�, �����޿�, �ְ� �޿�, �޿��� ���� ���Ͽ� ���
-- Q11) EMPLOYEES ���̺��� 30�� �μ� �� �̸��� ��� ������ �����Ͽ� ���
-- Q12) EMPLOYEES ���̺��� ������ �޿��� ����� 10000 �̻��� ������ ���ؼ� ������,��� �޿�, �޿��� ���� ���Ͽ� ���
-- Q13) EMPLOYEES ���̺��� �μ� �ο��� 4���� ���� �μ��� �μ���ȣ, �ο���, �޿��� ���� ���Ͽ� ���