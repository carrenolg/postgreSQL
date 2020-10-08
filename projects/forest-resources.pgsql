
/*Create database*/
SELECT * from  pg_roles;
SELECT * from  pg_domain;

CREATE DATABASE forest 
WITH 
   ENCODING = 'UTF8'
   OWNER = carrenolg
   CONNECTION LIMIT = 100;

/*Create domains*/
CREATE DOMAIN Gender AS CHAR (6) CHECK (VALUE IN ('Man','Woman'));
CREATE DOMAIN Status AS CHAR (8) CHECK (VALUE IN ('Approved','Reprobe'));
CREATE DOMAIN IdType AS CHAR (3) CHECK (VALUE IN ('RUT','NIT'));
