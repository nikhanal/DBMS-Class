CREATE TABLE
    tbl_Employee (
        employee_name VARCHAR(255) NOT NULL,
        street VARCHAR(255) NOT NULL,
        city VARCHAR(255) NOT NULL,
        PRIMARY KEY(employee_name)
    );
 
 
CREATE TABLE
    tbl_Works (
        employee_name VARCHAR(255) NOT NULL,
        FOREIGN KEY (employee_name) REFERENCES tbl_Employee(employee_name),
        company_name VARCHAR(255),
        salary DECIMAL(10, 2)
    );
 
CREATE TABLE
    tbl_Company (
        company_name VARCHAR(255) NOT NULL,
        city VARCHAR(255),
        PRIMARY KEY(company_name)
    );
 
CREATE TABLE
    tbl_Manages (
        employee_name VARCHAR(255) NOT NULL,
        FOREIGN KEY (employee_name) REFERENCES tbl_Employee(employee_name),
        manager_name VARCHAR(255)
    );
 
INSERT INTO
    tbl_Employee (employee_name, street, city)
VALUES (
        'Alice Williams',
        '321 Maple St',
        'Houston'
    ), (
        'Sara Davis',
        '159 Broadway',
        'New York'
    ), (
        'Mark Thompson',
        '235 Fifth Ave',
        'New York'
    ), (
        'Ashley Johnson',
        '876 Market St',
        'Chicago'
    ), (
        'Emily Williams',
        '741 First St',
        'Los Angeles'
    ), (
        'Michael Brown',
        '902 Main St',
        'Houston'
    ), (
        'Samantha Smith',
        '111 Second St',
        'Chicago'
    );
 
INSERT INTO
    tbl_Employee (employee_name, street, city)
VALUES (
        'Patrick',
        '123 Main St',
        'New Mexico'
    );
 
INSERT INTO
    tbl_Works (
        employee_name,
        company_name,
        salary
    )
VALUES (
        'Patrick',
        'Pongyang Corporation',
        500000
    );
 
INSERT INTO
    tbl_Works (
        employee_name,
        company_name,
        salary
    )
VALUES (
        'Sara Davis',
        'First Bank Corporation',
        82500.00
    ), (
        'Mark Thompson',
        'Small Bank Corporation',
        78000.00
    ), (
        'Ashley Johnson',
        'Small Bank Corporation',
        92000.00
    ), (
        'Emily Williams',
        'Small Bank Corporation',
        86500.00
    ), (
        'Michael Brown',
        'Small Bank Corporation',
        81000.00
    ), (
        'Samantha Smith',
        'Small Bank Corporation',
        77000.00
    );
 
INSERT INTO
    tbl_Company (company_name, city)
VALUES (
        'Small Bank Corporation', 'Chicago'), 
        ('ABC Inc', 'Los Angeles'), 
        ('Def Co', 'Houston'), 
        ('First Bank Corporation','New York'), 
        ('456 Corp', 'Chicago'), 
        ('789 Inc', 'Los Angeles'), 
        ('321 Co', 'Houston'),
        ('Pongyang Corporation','Chicago'
    );
 
INSERT INTO
    tbl_Manages(employee_name, manager_name)
VALUES 
    ('Mark Thompson', 'Emily Williams'),
    ('Michael Brown', 'Jane Doe'),
    ('Alice Williams', 'Emily Williams'),
    ('Samantha Smith', 'Sara Davis'),
    ('Patrick', 'Jane Doe');
 
SELECT * FROM tbl_Employee;
SELECT * FROM tbl_Works;
SELECT * FROM tbl_Manages;



SELECT manager_name,count(employee_name) AS Count FROM tbl_Manages GROUP BY (manager_name);

SELECT manager_name FROM tbl_Manages GROUP BY (manager_name) HAVING Count(employee_name)>1

-- Update the value of salary to 1000 where employee name= John Smith and company_name = First Bank Corporation
UPDATE tbl_Works
SET salary = '1000'
WHERE
    employee_name = 'John Smith'
AND company_name = 'First Bank Corporation';
 

-- Find the names of all employees who work for First Bank Corporation.
SELECT employee_name FROM tbl_Works WHERE company_name = 'First Bank Corporation';

-- Find the names and cities of residence of all employees who work for First Bank Cor- poration.
SELECT tbl_Works.employee_name,tbl_Employee.city FROM tbl_Works, tbl_Employee WHERE company_name = 'Small Bank Corporation' AND tbl_Employee.employee_name=tbl_Works.employee_name;


SELECT employee_name,city FROM tbl_Employee WHERE employee_name IN (SELECT employee_name FROM tbl_Works WHERE company_name = 'Small Bank Corporation');

--  Find the names, street addresses, and cities of residence of all employees who work for First Bank Corporation and earn more than $10,000.
SELECT tbl_Works.employee_name,tbl_Employee.city FROM tbl_Works, tbl_Employee WHERE company_name = 'Small Bank Corporation' AND salary>10000 AND tbl_Employee.employee_name=tbl_Works.employee_name;

-- Find all employees in the database who live in the same cities as the companies for which they work.
SELECT tbl_Employee.employee_name 
FROM tbl_Works, tbl_Employee,tbl_Company 
WHERE tbl_Employee.city = tbl_Company.city 
AND tbl_Company.company_name = tbl_Works.company_name 
AND tbl_Works.employee_name = tbl_Employee.employee_name;

SELECT tbl_Employee.employee_name,street,city,company_name,salary
FROM tbl_Employee
CROSS JOIN tbl_Works
WHERE tbl_Employee.employee_name = tbl_Works.employee_name

SELECT tbl_Employee.employee_name,street,city,company_name,salary
FROM tbl_Employee
LEFT JOIN tbl_Works
ON tbl_Employee.employee_name = tbl_Works.employee_name

-- Find the names and cities of residence of all 
-- employees who work for First Bank Cor- poration.
SELECT tbl_Employee.employee_name,street,city,company_name,salary
FROM tbl_Employee
JOIN tbl_Works
On tbl_Employee.employee_name = tbl_Works.employee_name AND company_name='Small Bank Corporation'


-- Find all employees in the database who do not work for First Bank Corporation.
SELECT tbl_Employee.employee_name,street,city,company_name,salary
FROM tbl_Employee
JOIN tbl_Works
On tbl_Employee.employee_name = tbl_Works.employee_name AND company_name!='First Bank Corporation'

-- Find all employees in the database who earn more than each employee 
-- of Small Bank Corporation.
SELECT employee_name FROM tbl_Works WHERE salary>(SELECT MAX(salary) FROM tbl_Works WHERE company_name = 'Small Bank Corporation')

-- Find all employees who earn more than the average salary of all 
-- employees of their company.


SELECT t1.employee_name FROM tbl_Employee t1 JOIN tbl_Works w1 
ON t1.employee_name = w1.employee_name WHERE w1.salary > 
(SELECT AVG(salary) FROM tbl_Works w2 WHERE w2.company_name = w1.company_name);

-- Find the company that has the most employees.
SELECT TOP 1 tbl_Works.company_name, COUNT(employee_name) AS employee_count FROM tbl_Works GROUP BY company_name ORDER BY employee_count DESC 