SELECT * FROM person;
SELECT * FROM car;
/*
INSERT INTO car (car_uid, make, model, price)
values (uuid_generate_v4(), 'Land Rover', 'Sterling 2000', 23659.38);
*/

/*Cartesian product and Selection operation,  INNER JOIN*/
SELECT *
from person JOIN car 
ON person.car_uid=car.car_uid;

SELECT *
from person INNER JOIN car 
ON person.car_uid=car.car_uid;

/* Natural combination (Natural Join) */
SELECT *
from person INNER JOIN car 
ON person.car_uid=car.car_uid;

/* Natural combination  (Left OUTER JOIN) */
SELECT *
from person LEFT JOIN car 
ON person.car_uid=car.car_uid;


/* Natural combination (Rigth OUTER JOIN) */
SELECT *
from person RIGHT JOIN car 
ON person.car_uid=car.car_uid;


/* Natural combination (Full OUTER JOIN) */
SELECT *
FROM person FULL OUTER JOIN car 
ON person.car_uid=car.car_uid;


/*Agragation functions*/

/*COUNT*/
SELECT count(car_uid)
FROM person;

SELECT count(person_uid)
FROM person;

/*SUM*/
SELECT sum(price)
FROM car;

/*AVG*/

/*create table integernumber (
    id BIGSERIAL not NULL PRIMARY KEY,
    number SMALLINT
);
INSERT INTO integernumber values (5);
INSERT INTO integernumber values (10);
INSERT INTO integernumber (number) values (6);*/

SELECT sum(number)
FROM integernumber;

SELECT count(number)
FROM integernumber;

SELECT avg(number)
FROM integernumber;

/*MIN*/
SELECT * from integernumber;

SELECT min(number)
FROM integernumber;

/*MAX*/
SELECT max(number) FROM integernumber;

/*Restricción con Distinct*/
SELECT * from country;
SELECT name_of_country from country;
SELECT DISTINCT name_of_country from country;
SELECT count(DISTINCT name_of_country) from country;

/*COUNT with "*" like argument */
SELECT count(*) from country;
