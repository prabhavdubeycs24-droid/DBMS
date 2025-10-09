create database IF NOT exists Insurances;
use insurances ; 
CREATE TABLE Insurances.person (
	driver_id varchar(10) primary key ,
    name varchar(20),
    address varchar(30)
);
INSERT INTO person(driver_id , name , address)
VALUES 
	("A01","sejal","RK nagar"),
    ("A02","aditya","lalbagh"),
    ("A03","aksh","Nehru colony"),
    ("A04","aakash","vidya nagar"),
    ("A05","advit","sagar colony");
select * from person ; 
    
CREATE TABLE CAR (
    reg_num VARCHAR(10) PRIMARY KEY,
    model VARCHAR(10),
    year INT
);
INSERT INTO CAR 
VALUES
	('KA01AB1234', 'Hyundai', 2019),
	('KA01CD5678', 'Honda', 2018),
	('KA02EF9012', 'Maruti', 2020),
	('KA03GH3456', 'Tata', 2021),
	('KA04IJ7890', 'Toyota', 2017);

SELECT *  FROM  CAR ; 
CREATE TABLE ACCIDENT (
    report_num INT PRIMARY KEY,
    accident_date DATE,
    location VARCHAR(50)
);
INSERT INTO ACCIDENT 
VALUES 
	(101, '2022-05-01', 'MG Road'),
	(102, '2022-06-15', 'Lalbagh'),
	(103, '2022-07-20', 'Indira Nagar'),
	(104, '2022-08-05', 'Nehru Colony'),
	(105, '2022-09-10', 'KR Market');

SELECT * FROM ACCIDENT ; 
CREATE TABLE OWNS (
    driver_id VARCHAR(10),
    reg_num VARCHAR(15),
    PRIMARY KEY (driver_id, reg_num),
    FOREIGN KEY (driver_id) REFERENCES PERSON(driver_id),
    FOREIGN KEY (reg_num) REFERENCES CAR(reg_num)
);
INSERT INTO OWNS
VALUES
	('A01', 'KA01AB1234'),
	('A02', 'KA01CD5678'),
	('A03', 'KA02EF9012'),
	('A04', 'KA03GH3456'),
	('A05', 'KA04IJ7890');
SELECT * FROM OWNS ; 
CREATE TABLE PARTICIPATED (
    driver_id VARCHAR(10),
    reg_num VARCHAR(15),
    report_num INT,
    damage_amount INT,
    PRIMARY KEY (driver_id, reg_num, report_num),
    FOREIGN KEY (driver_id) REFERENCES PERSON(driver_id),
    FOREIGN KEY (reg_num) REFERENCES CAR(reg_num),
    FOREIGN KEY (report_num) REFERENCES ACCIDENT(report_num)
);
INSERT INTO PARTICIPATED 
VALUES
	('A01', 'KA01AB1234', 101, 10000),
	('A02', 'KA01CD5678', 102, 30000),
	('A03', 'KA02EF9012', 103, 15000),
	('A04', 'KA03GH3456', 104, 25000),
	('A05', 'KA04IJ7890', 105, 40000);
SELECT * FROM PARTICIPATED ; 

SELECT * FROM insurances.CAR ORDER BY YEAR asc;
SELECT COUNT(*) FROM insurances.CAR where model = "Maruti" ; 
SELECT COUNT(*) FROM insurances.CAR WHERE YEAR = 2018 ;
SELECT * FROM insurances.participated order by damage_amount desc;
SELECT avg(damage_amount) FROM insurances.participated;
delete FROM insurances.participated where damage_amount < (select * from ( select avg(damage_amount) from insurances.participated) as a );    
select * from insurances.participated;
select name from insurances.person p1 , insurances.participated p2 where p1.driver_id = p2.driver_id and p2.damage_amount > (select * from ( select avg(damage_amount) from insurances.participated) as a);
select max(damage_amount) from insurances.participated ;