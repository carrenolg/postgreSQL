/*Create database*/
SELECT * from  pg_roles;

CREATE DATABASE belen
WITH 
   ENCODING = 'UTF8'
   OWNER = carrenolg
   CONNECTION LIMIT = 100;

-- To install the uuid-ossp module
CREATE EXTENSION IF NOT EXISTS "uuid-ossp"; 

/*Create table*/
CREATE TABLE priest (
    id uuid DEFAULT uuid_generate_v4 (),
    code CHARACTER(5) NOT NULL UNIQUE,
    first_name VARCHAR NOT NULL,
    last_name VARCHAR NOT NULL,
    eclesial_institution VARCHAR NOT NULL,
    nationality VARCHAR NOT NULL,
    ordenation_date DATE NOT NULL,
    PRIMARY KEY (id)
);

SELECT * FROM priest;