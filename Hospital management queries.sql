CREATE DATABASE LifeCareHospital;
USE LifeCareHospital;

CREATE TABLE Departments (
dept_id INT PRIMARY KEY,
dept_name VARCHAR(100) UNIQUE,
floor_no INT NOT NULL
);

CREATE TABLE Doctors (
doc_id INT PRIMARY KEY,
doc_name VARCHAR(100),
specialization VARCHAR(100),
salary double,
dept_id INT,
experience INT DEFAULT 0,
FOREIGN KEY (dept_id) REFERENCES Departments(dept_id)
);

CREATE TABLE Patients (
patient_id INT PRIMARY KEY,
patient_name VARCHAR(100),
age INT,
gender varchar(10),
city VARCHAR(100),
admission_date DATE DEFAULT (CURRENT_DATE)
);

CREATE TABLE Appointments (
appointment_id INT PRIMARY KEY,
patient_id INT,
doctor_id INT,
appointment_date DATE,
consultation_fee double,
FOREIGN KEY (patient_id) REFERENCES Patients(patient_id),
FOREIGN KEY (doctor_id) REFERENCES Doctors(doc_id)
);

CREATE TABLE Treatments (
treatment_id INT PRIMARY KEy,
appointment_id INT,
treatment_name VARCHAR(100),
treatment_cost double,
FOREIGN KEY (appointment_id) REFERENCES Appointments(appointment_id)
);

INSERT INTO Departments VALUES
(1,'Cardiology', 2),
(2,'Neurology', 3),
(3,'Orthopaedics', 1),
(4,'Pediatrics', 4),
(5,'Radiology', 5);

INSERT INTO Doctors VALUES
(1,'Dr. A Sharma','Cardiologist', 180000, 1, 12),
(2,'Dr. B Verma','Cardiologist', 150000, 1, 9),
(3,'Dr. C Singh','Neurologist', 140000, 2, 8),
(4,'Dr. D Gupta','Neurologist', 130000, 2, 6),
(5,'Dr. E Nair','Orthopaedist', 120000, 3, 7),
(6,'Dr. F Kumar','Orthopaedist', 110000, 3, 5),
(7,'Dr. G Menon','Pediatrician', 100000, 4, 4),
(8,'Dr. H Iyer','Radiologist', 125000, 5, 6);



INSERT INTO Patients (patient_id,patient_name, age, gender, city)  VALUES
(1,'Anita Roy', 34, 'Female', 'Bangalore'),
(2,'Suman Patel', 28, 'Female', 'Mumbai'),
(3,'Rahul Sharma', 45, 'Male', 'Delhi'),
(4,'Priya Kapoor', 60, 'Female', 'Bangalore'),
(5,'Vikram Singh', 52, 'Male', 'Chennai'),
(6,'Neha Joshi', 29, 'Female', 'Bangalore'),
(7,'Arun Das', 40, 'Male', 'Kolkata'),
(8,'Meera Shah', 22, 'Female', 'Mumbai'),
(9,'Ravi Kumar', 33, 'Male', 'Delhi'),
(10,'Sneha Nair', 27, 'Female', 'Bangalore');

INSERT INTO Appointments (appointment_id,patient_id, doctor_id, appointment_date, consultation_fee) VALUES
(1,1,1, CURDATE(), 500.00),
(2,2,3, CURDATE(), 550.00),
(3,3,1, CURDATE(), 600.00),
(4,4,2, CURDATE(), 520.00),
(5,5,4, CURDATE(), 580.00),
(6,6,5, CURDATE(), 480.00),
(7,7,6, CURDATE(), 510.00),
(8,8,7, CURDATE(), 490.00),
(9,9,8, CURDATE(), 620.00),
(10,10,2, CURDATE(), 535.00),
(11,1,3, CURDATE(), 570.00),
(12,2,4, CURDATE(), 550.00),
(13,5,1, CURDATE(), 590.00),
(14,9,2, CURDATE(), 600.00),
(15,3,7, CURDATE(), 520.00);

INSERT INTO Treatments (treatment_id,appointment_id, treatment_name, treatment_cost) VALUES
(1,1,'ECG', 3000.00),
(2,2,'MRI Brain', 15000.00),
(3,3,'Angiography', 25000.00),
(4,4,'X-Ray', 1200.00),
(5,5,'Physical Therapy', 8000.00),
(6,6,'Blood Test', 1500.00),
(7,7,'CT Scan', 9000.00),
(8,8,'Ultrasound', 3500.00),
(9,9,'EEG', 7000.00),
(10,10,'MRI Knee', 18000.00),
(11,11,'ECG', 3200.00),
(12,12,'Vaccination', 1200.00),
(13,13,'Surgery Prep', 4000.00),
(14,14,'CT Abdomen', 12000.00),
(15,15,'Physician Visit', 1000.00);


UPDATE Doctors 
SET salary = salary * 1.12 
WHERE dept_id = (SELECT dept_id FROM Departments WHERE dept_name = 'Cardiology');

UPDATE Appointments
SET consultation_fee = consultation_fee + 300
WHERE appointment_date >= DATE('2026-07-01');

UPDATE Doctors SET dept_id = 2 WHERE doc_id = 1;

DELETE FROM Patients
WHERE patient_id NOT IN (SELECT DISTINCT patient_id FROM Appointments);

DELETE FROM Treatments WHERE treatment_cost < 500;

DELETE FROM Appointments WHERE appointment_date < DATE('2026-01-01');

select * from doctors;

select patient_name,gender
from patients 
where gender='female';

select doc_name,salary
from doctors
where salary>120000;

select appointment_id,appointment_date
from appointments
where appointment_date=curdate();

select patient_name,city
from patients
where city='bangalore';

select treatment_name,treatment_cost
from treatments
where treatment_cost>20000;

select doc_name,experience
from doctors
order by experience;

select dept_name
from departments
order by dept_name;

select count(*) from doctors;

select avg(salary) from doctors;

select max(consultation_fee) from appointments;

select min(treatment_cost) from treatments;

select sum(treatment_cost) from treatments;

select patient_name,city
from patients
order by city;

select avg(age) from patients;

select count(*) from appointments;

select doc_name,salary from doctors
where salary > (select avg(salary) from doctors);

select doc_name,salary from doctors
where salary = (select max(salary) from doctors);

SELECT treatment_cost,treatment_name FROM Treatments
WHERE treatment_cost > (SELECT AVG(treatment_cost) FROM Treatments);

select patient_name
from patients
where patient_id in (
select patient_id from appointments order by consultation_fee desc
) limit 1;

select dept_name from departments
where dept_id in
(SELECT dept_id
FROM Doctors
WHERE salary = (SELECT MAX(salary) FROM Doctors))
LIMIT 1;

SELECT patient_name
FROM Patients
WHERE patient_id IN (
    SELECT patient_id
    FROM Appointments
    WHERE doctor_id IN (
        SELECT doc_id
        FROM Doctors
        WHERE dept_id = (
            SELECT dept_id
            FROM Departments
            WHERE dept_name = 'Cardiology'
        )
    )
);

SELECT doc_name
FROM Doctors
WHERE doc_id IN (
    SELECT doctor_id
    FROM Appointments
);

SELECT doc_name
FROM Doctors
WHERE doc_id NOT IN (
    SELECT doctor_id
    FROM Appointments
);

SELECT patient_name
FROM Patients
WHERE patient_id IN (
    SELECT patient_id
    FROM Appointments
    WHERE appointment_id IN (
        SELECT appointment_id
        FROM Treatments
        WHERE treatment_name LIKE 'MRI%'
           OR treatment_name LIKE 'CT%'
    )
);

SELECT dept_name
FROM Departments
WHERE dept_id IN (
    SELECT dept_id
    FROM Doctors
    WHERE salary > 200000
);

SELECT patient_name
FROM Patients
WHERE patient_id IN (
    SELECT patient_id
    FROM Appointments
    WHERE doctor_id = (
        SELECT doc_id
        FROM Doctors
        WHERE salary = (
            SELECT MAX(salary)
            FROM Doctors
        )
    )
);

select dept_name
from departments
where dept_id in (
	select dept_id from doctors
    where doc_id in(
		select doctor_id from appointments
        where appointment_id in(
			select appointment_id from treatments
            where treatment_cost = (
				select max(treatment_cost) from treatments
            )
        )
	)
);

select doc_name
from doctors
where dept_id in(
	select dept_id 
    from doctors
    group by dept_id
    order by avg(salary)
) limit 1;


