-- PostgreSQL
/*
create table person (
    id BIGSERIAL not NULL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    gender VARCHAR(6) NOT NULL,
    date_of_birth DATE NOT NULL,
    country_of_birth VARCHAR(150),
    email VARCHAR(150)
)

-- inserting records into tables
INSERT INTO person (
    first_name,
    last_name,
    gender,
    date_of_birth
) VALUES ('Anne', 'Smith', 'FEMALE', date '1988-01-09')


INSERT INTO person (
    first_name,
    last_name,
    gender,
    date_of_birth,
    email
) VALUES ('Jake', 'Jones', 'MALE', date '1990-01-10', 'jake@gmail.com')

-- generate multiple 

-- Select from
SELECT * from person;
SELECT first_name,last_name,email from person;
SELECT email from person;

-- Order by (ASC,DESC)

select * from person order by country_of_birth DESC;
select * from person order by country_of_birth ASC;
select * from person order by email ASC;
select * from person order by email DESC;


-- Distinct
SELECT country_of_birth from person;
SELECT country_of_birth from person order by country_of_birth;
SELECT DISTINCT country_of_birth from person;
SELECT DISTINCT country_of_birth from person order by country_of_birth;
SELECT DISTINCT country_of_birth from person order by country_of_birth DESC;

-- where clause and AND
SELECT * from person WHERE gender = 'Female';
SELECT * from person WHERE gender = 'Male';

SELECT * from person WHERE gender = 'Male' AND country_of_birth = 'Poland';
SELECT * from person WHERE gender = 'Male' AND (country_of_birth = 'Poland' OR country_of_birth = 'China');

SELECT * from person WHERE gender = 'Male' AND (country_of_birth = 'Poland' OR country_of_birth = 'China') 
AND last_name = 'Learmond';

-- Comparison Operators
SELECT 1 = 1;
SELECT 2 <= 1;
SELECT 1 >= 1;
SELECT 1 <> 1; -- no equal
SELECT 'dios' <> 'DIOS';
SELECT 'DIOS' <> 'DIOS';
SELECT 'DIOS' = 'DIOS';

-- Limit, offset, and Fecth
select * from person OFFSET 5 LIMIT 10;
SELECT * from person OFFSET 10 FETCH FIRST 5 ROW ONLY;
SELECT * from person OFFSET 10 FETCH FIRST ROW ONLY; -- getting the next one

-- IN
SELECT * from person WHERE country_of_birth = 'Colombia' OR
country_of_birth = 'Venezuela' OR country_of_birth = 'Brazil';

SELECT * from person WHERE country_of_birth in ('Venezuela', 'Colombia', 'Brazil');

-- BETWEEN
SELECT * from person WHERE date_of_birth
BETWEEN date '2020-01-01' AND date '2020-05-01';

-- LIKE, ILIKE
SELECT * from person WHERE email LIKE '%@google.com';
SELECT * from person WHERE email LIKE '%@google.%';
SELECT * from person WHERE email LIKE 'g_____@%';
-- ILIKE ignore the case sensitive
SELECT * FROM person WHERE country_of_birth LIKE 'p%';
SELECT * FROM person WHERE country_of_birth ILIKE 'p%';

-- GROUP BY
SELECT country_of_birth, count(*) from person GROUP BY country_of_birth
ORDER BY country_of_birth;

-- HAVING (count() is a aggregate function, you can see in Postgre documentation)
SELECT country_of_birth, count(*) from person GROUP BY country_of_birth HAVING count(*) > 40
ORDER BY count DESC;

-- MAX() MIN() AVG()
SELECT max(price) from car;
SELECT min(price) from car;
SELECT avg(price) from car;
SELECT round(avg(price)) from car;
SELECT make, min(price) from car GROUP BY make;
SELECT make, round(sum(price)) from car GROUP BY make;

-- arithmeric OPERATORs
SELECT 10^2;
SELECT 10 + 2 * 5;
SELECT 20 / 5 + 2;
SELECT 5 + 5 + 8 - 8 * 8;
SELECT 5!;
SELECT 10 % 2;
SELECT 20 % 5;

-- arithmeric OPERATORs round
SELECT id, make, model, price, round(price * .10,2), round(price - (price * .10),2) from car;

-- ALIAS
SELECT id, make, model, price AS original_price, round(price * .10,2) AS ten_percent,
round(price - (price * .10),2) AS price_with_discount from car;

-- COALESCE
SELECT (NULL, NULL, NULL, 'hello world');
SELECT (NULL, NULL, NULL, NULL);
SELECT COALESCE(NULL, NULL, NULL, 'hello world');
SELECT COALESCE(NULL, NULL, NULL, NULL);

SELECT COALESCE(email,'No Email') from person;

-- NULLIF
SELECT NULLIF(email, NULL) AS email from person;
SELECT NULLIF(NULL, '(none)');

-- Timestamps And Dates
SELECT now();
SELECT now()::DATE;
SELECT now()::TIME;
SELECT now()::timestamp;

-- Adding And Subtracting With Dates
SELECT NOW() + INTERVAL '1 YEAR';
SELECT NOW() + INTERVAL '1 DAY';
SELECT NOW() + INTERVAL '1 MONTH';
SELECT NOW()::DATE + INTERVAL '1 MONTH';
SELECT NOW()::DATE - INTERVAL '1 YEAR';

-- Extracting Fields from Timestamp
SELECT EXTRACT(YEAR from now());
SELECT EXTRACT(MONTH from now());
SELECT EXTRACT(DAY from now());
SELECT EXTRACT(CENTURY from now());

-- AGE FUNCTION
SELECT id,first_name,last_name,date_of_birth, age(now()::DATE, date_of_birth) AS duration from person;

SELECT to_char(age('2017-01-01','2011-06-24'),'Y-MM-DD');

-- Understanding primary key
--> ALTER TABLE person DROP CONSTRAINT person_pkey;

SELECT * from person WHERE id = 1;
-- without CONSTRAINTS
INSERT INTO person (
    id,
    first_name,
    last_name,
    gender,
    date_of_birth,
    country_of_birth,
    email
) VALUES (1, 'Anne', 'Smith', 'FEMALE', date '1988-01-09', 'Colombia', 'dominio@gmail.com');
-- new insert (BIGSERIAL keep works, but Primary key doesnt work)
INSERT INTO person (
    first_name,
    last_name,
    gender,
    date_of_birth,
    country_of_birth,
    email
) VALUES ('Anne', 'Smith', 'FEMALE', date '1988-01-09', 'Colombia', 'dominio@gmail.com');

SELECT * FROM person ORDER BY id DESC;

-- Filter NULL values
SELECT id, email from person WHERE email IS NULL;

-- Adding Primary KEY
-- ALTER TABLE person ADD PRIMARY KEY (id);
-- SELECT * from person WHERE id = 1;
-- DELETE FROM person WHERE id = 1;
INSERT INTO person (
    id,
    first_name,
    last_name,
    gender,
    date_of_birth,
    country_of_birth,
    email
) VALUES (1, 'Anne', 'Smith', 'FEMALE', date '1988-01-09', 'Colombia', 'dominio@gmail.com');

-- Unique CONSTRAINT
SELECT email, count(*) from person GROUP by email;
-- check duplicate email
SELECT email, count(*) from person GROUP by email HAVING count(*) > 1;
--DELETE from person WHERE id = 1000;
--SELECT * from person WHERE email = 'dominio@gmail.com';
--ALTER TABLE person ADD UNIQUE (email);
INSERT INTO person (
    first_name,
    last_name,
    gender,
    date_of_birth,
    country_of_birth,
    email
) VALUES ('Anne', 'Smith', 'Female', date '1988-01-09', 'Colombia', 'dominio@gmail.com');
-- We cant add new row with 'dominio@gmail.com'

-- Check CONSTRAINTS
SELECT * from person;
INSERT INTO person (
    first_name,
    last_name,
    gender,
    date_of_birth,
    country_of_birth,
    email
) VALUES ('Danna', 'Smith', 'NUEVO', date '1988-01-09', 'Colombia', 'cartagena@gmail.com');

-- ALTER TABLE person ADD CONSTRAINT gender_constraint CHECK (gender = 'Female' OR gender = 'Male');

SELECT DISTINCT gender from person;

SELECT * from person WHERE gender in ('NUEVO', 'FEMALE');

DELETE from person WHERE id in (1, 1002);

-- DELETE rows
DELETE from person;
SELECT * from person WHERE country_of_birth = 'Venezuela';
DELETE from person WHERE country_of_birth = 'Venezuela';

-- UPDATE rows
SELECT * from person;
UPDATE person SET email = 'selie@gmail.com' WHERE id = 1005;
SELECT * from person WHERE id = 1005;
UPDATE person SET first_name = 'Seliene', last_name = 'Lozzano' WHERE id = 1005;

-- Handling exeptions (ON CONFLICT (<colum>) DO NOTHING)
SELECT * from person WHERE id = 1028;

INSERT INTO person(id, first_name, last_name, gender, date_of_birth, email, country_of_birth)
VALUES(1028, 'Paquito', 'Ponting', 'Male', DATE '2019-11-10', 'correo@gmail.com.co', 'Colombia')
ON CONFLICT (id) DO NOTHING;

-- ON CONFLICT DO UPDATE
SELECT * FROM person WHERE id = 1018;
INSERT INTO person(id, first_name, last_name, gender, date_of_birth, email, country_of_birth)
VALUES(1018, 'Hiram', 'Esteban', 'Male', DATE '2020-06-12', 'hyorkf@gmail.com', 'Slovakia')
ON CONFLICT (id) 
DO UPDATE SET email = EXCLUDED.email, last_name = EXCLUDED.last_name;

-- Updating Foreign Keys Columms
-- person and car tables
SELECT * from person;
UPDATE person SET car_id = 2 WHERE id = 1;
UPDATE person SET car_id = 1 WHERE id = 2;
UPDATE person SET car_id = 5 WHERE id = 3;

-- INNER JOIN
SELECT * from person JOIN car ON person.car_id = car.id;

SELECT car.id, car.make, car.model, car.price
FROM person JOIN car ON person.car_id = car.id;

------- LEFT JOIN -------
SELECT * from person;
SELECT * from car;
-- get null values from the car_id columm
SELECT * from person LEFT JOIN car
ON person.car_id=car.id;
-- get persons which don't have a car
SELECT * from person LEFT JOIN car
ON person.car_id=car.id WHERE car.id is NULL;
-- other way
SELECT * from person LEFT JOIN car
ON person.car_id=car.id WHERE car.* is NULL;

------- Deleting Records With Foreign Keys -------
SELECT * from person;
SELECT * from car;
-- inserting tow new records into the tables person and car
INSERT INTO person(id, first_name, last_name, gender, date_of_birth, email, country_of_birth)
VALUES(9000, 'Mark', 'Anthony', 'Male', DATE '1990-08-03', 'mark@gmail.com', 'Colombia');

INSERT INTO car(make, model, price)
VALUES('GMC', 'Acadia v2', '25562.69');

-- adding foreign key
UPDATE person SET car_id = 3 WHERE id = 9000;

-- try delete the car with id = 3
DELETE FROM car WHERE id = 3;
--ERROR:  update or delete on table "car" violates foreign key constraint "person_car_id_fkey" on table "person"
--DETAIL:  Key (id)=(3) is still referenced from table "person".

-- first you must delete or update record in the person table with the id = 9000
DELETE FROM person WHERE id = 9000;

-- now, you can delete the car with id = 3
DELETE FROM car WHERE id = 3;

------- Exporting Query Results to CSV -------
-- executed from CLI on linx

------- Serial and Sequences -------
SELECT * FROM person;
SELECT * from person_id_seq;
-- you can use the netxval function for know the next value
SELECT * from nextval('person_id_seq'::regclass);
-- Alter seque
ALTER SEQUENCE person_id_seq RESTART WITH 3;

------- Extensions
SELECT * from pg_available_extensions;
*/
------- Understanding UUID Data Type
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
SELECT uuid_generate_v4();

------- UUID as Primary Key
-- first, create tables using UUID
-- second, run some query
SELECT * from person;
SELECT * from car;
-- add car_uid into the person table
UPDATE person set car_uid = '1efec62b-d538-4ced-960e-cda081f35c93'
WHERE person_uid = '7f987c90-9e39-49dc-b333-7a438e6b2892';

UPDATE person set car_uid = '9568d55c-22b2-4031-bc70-741faf0b0e89'
WHERE person_uid = 'c247d974-4b98-411d-a388-fd318b319d1d';
-- now, check if UUID is working
SELECT * from person
INNER JOIN car ON person.car_uid=car.car_uid;

SELECT * from person
LEFT JOIN car ON person.car_uid=car.car_uid;