/*Sentencias de modificación*/

-- ADD

ALTER TABLE weight
ADD COLUMN time_of_test TIME;

SELECT * FROM weight;
UPDATE weight SET time_of_test = '08:00 PM'
WHERE date_of_test > date('2020-08-01 00:00:00');

-- DROP
ALTER TABLE companies
DROP COLUMN area;

SELECT * FROM companies;

-- RENAME
ALTER TABLE  clients
RENAME COLUMN pid TO personal_id;

SELECT * FROM clients;


/*SQL - DML*/

-- SELECT
SELECT * FROM person;
SELECT person_uid, car_uid FROM person;

SELECT first_name AS "First name",
last_name AS "Last name",
gender AS "Gender",
email AS "Email"
FROM person;

-- Filters WHERE
SELECT * FROM person
WHERE gender = 'Male';

SELECT * FROM student
WHERE country_of_birth = 'Colombia';

SELECT * FROM integernumber
WHERE number > 6;

SELECT * FROM integernumber
WHERE number <= 6;

SELECT * FROM movies
WHERE genre = 'Drama';

SELECT * FROM movies
WHERE price < 5 AND genre = 'Drama';

/*Cartesian product*/
SELECT * from car;
SELECT * from person;
-- OHHH, I did't know it
SELECT * from car, person;

SELECT car.car_uid, person.car_uid
FROM car, person;

/*ALIAS en columnas y tablas*/
SELECT car_table.car_uid AS "UID CAR",
person_table.car_uid AS "UID PERSON"
FROM car AS car_table, person AS person_table
WHERE car_table.car_uid = person_table.car_uid;

/*UNION*/
SELECT * FROM movies WHERE price < 8.0
UNION
SELECT * FROM movies WHERE price < 5.0;

/*MINUS (Diferencia)*/
SELECT car_uid FROM car
EXCEPT
SELECT car_uid FROM person;

/*INTERSECT*/
SELECT car_uid FROM car
INTERSECT
SELECT car_uid FROM person;

/*Unión natural*/ 
SELECT *
FROM car INNER JOIN person
ON person.car_uid=car.car_uid;

/*Unión natural (Left)*/ 
SELECT *
FROM car LEFT JOIN person
ON person.car_uid=car.car_uid;

/*Unión natural (Rigth)*/ 
SELECT *
FROM car RIGHT JOIN person
ON person.car_uid=car.car_uid;

/*Unión natural (ALL JOIN)*/ 
SELECT *
FROM car FULL OUTER JOIN person
ON person.car_uid=car.car_uid;


/*Unión natural (Interna)*/ 
SELECT *
FROM car INNER JOIN person
ON person.car_uid=car.car_uid;


/*Funciones de agrupación*/
-- GROUP BY
-- ORDER BY
SELECT language,
count(language) AS Count,
avg(price) AS media,
min(price) AS min_price,
max(price) AS "max_price"
FROM movies
GROUP BY language
ORDER BY media ASC;


/*SUB-Query*/

SELECT alfa.*
FROM (
    SELECT
    title AS "movie_title",
    genre AS "movie_genre",
    price AS "movie_price"
    FROM movies WHERE genre = 'Comedy'
) AS alfa
WHERE alfa.movie_price > 5.0;

-- Sub-query II
SELECT alfa.*
FROM (
    SELECT *,
    price AS "movie_price"
    FROM movies WHERE genre = 'Comedy'
) AS alfa
WHERE alfa.movie_price > 5.0;


/*Operadores especiales*/
-- IN
-- ANY
-- ALL
SELECT * FROM movies
WHERE genre IN ('Comedy', 'Drama', 'Sci-Fi');

SELECT * FROM movies
WHERE genre = ANY (
    SELECT genre FROM movies WHERE currency = 'Dollar'
);

SELECT * FROM movies
WHERE price > ALL (
    SELECT price FROM movies WHERE currency = 'Euro'
);

SELECT * FROM movies
WHERE price > ALL   (
    SELECT price FROM movies WHERE currency = 'Euro'
);

/*INSERT*/








