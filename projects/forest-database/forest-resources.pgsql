
/*Create database*/
SELECT * from  pg_roles;

CREATE DATABASE forest
WITH 
   ENCODING = 'UTF8'
   OWNER = carrenolg
   CONNECTION LIMIT = 100;

/*Create domains*/
CREATE DOMAIN Gender AS CHAR (6) CHECK (VALUE IN ('Man','Woman'));
CREATE DOMAIN Status AS CHAR (8) CHECK (VALUE IN ('Approved','Reprobe'));
CREATE DOMAIN IdType AS CHAR (3) CHECK (VALUE IN ('RUT','NIT'));

/*Create table*/
CREATE TABLE class (
   code CHARACTER(15) NOT NULL,
   name CHARACTER(15) NOT NULL,
   value MONEY NOT NULL,
   Description TEXT NOT NULL,
   CONSTRAINT PK_CodeClass PRIMARY KEY (code)
);

CREATE TABLE species (
   code CHARACTER(15) NOT NULL,
   commoName CHARACTER(45) NOT NULL,
   scientificName CHARACTER(45) NOT NULL,
   filiation CHARACTER(45) NOT NULL,
   gender CHARACTER(45) NOT NULL,
   codeClass CHARACTER(15) NOT NULL,
   CONSTRAINT PK_SpeciesCode PRIMARY KEY (code),
   CONSTRAINT FK_Class_Species FOREIGN KEY (codeClass)
   REFERENCES Class (code)
   MATCH SIMPLE
   ON UPDATE NO ACTION
   ON DELETE NO ACTION
);

CREATE TABLE district (
   code INTEGER NOT NULL,
   name CHARACTER(30) NOT NULL,
   CONSTRAINT PK_District PRIMARY KEY (code)
);

CREATE TABLE person (
   identification INTEGER NOT NULL,
   typeIdentification idtype DEFAULT 'RUT' NOT NULL,
   firstName CHARACTER(25) NOT NULL,
   lastName CHARACTER(25) NOT NULL,
   telephone INTEGER NOT NULL,
   CONSTRAINT PK_PersonIdentification PRIMARY KEY (identification)
);

CREATE TABLE legal (
   identification INTEGER NOT NULL,
   typeIdentification idtype DEFAULT 'NIT' NOT NULL,
   businessName CHARACTER(100) NOT NULL,
   address CHARACTER(100) NOT NULL,
   codedDistrict INTEGER NOT NULL,
   identificationPerson INTEGER NOT NULL,
   CONSTRAINT PK_LegalIdentification PRIMARY KEY (identification),
   CONSTRAINT FK_District_Legal FOREIGN KEY (codedDistrict)
   REFERENCES district (code) MATCH SIMPLE
   ON UPDATE NO ACTION
   ON DELETE NO ACTION,
   CONSTRAINT FK_Person_Legal FOREIGN KEY (identificationPerson)
   REFERENCES person (identification) MATCH SIMPLE
   ON UPDATE NO ACTION
   ON DELETE NO ACTION
);

SELECT * FROM legal;

CREATE TABLE legal_phones (
   legal_id INTEGER NOT NULL,
   phone_number INTEGER NOT NULL,
   CONSTRAINT PK_Legal_Phone PRIMARY KEY (legal_id, phone_number),
   CONSTRAINT FK_Legal_Legal_Phone FOREIGN KEY (legal_id)
   REFERENCES legal (identification) MATCH SIMPLE
   ON UPDATE NO ACTION
   ON DELETE NO ACTION
 );

SELECT * FROM legal_phones;

CREATE TABLE employee (
   identification INTEGER NOT NULL,
   gender Gender DEFAULT 'Woman'NOT NULL,
   blood_type CHARACTER(3) NOT NULL,
   CONSTRAINT PK_Employee PRIMARY KEY (identification),
   CONSTRAINT FK_Person_Employee FOREIGN KEY (identification)
   REFERENCES person (identification) MATCH SIMPLE
   ON UPDATE NO ACTION
   ON DELETE NO ACTION
);

SELECT * FROM employee;

CREATE TABLE engineer (
   identification INTEGER NOT NULL,
   profesional_card CHARACTER(25) NOT NULL,
   CONSTRAINT PK_Engineer PRIMARY KEY (identification),
   CONSTRAINT FK_Person_Engineer FOREIGN KEY (identification)
   REFERENCES Person (identification) MATCH SIMPLE
   ON UPDATE NO ACTION
   ON DELETE NO ACTION
);

SELECT * FROM engineer;

CREATE TABLE state (
   state_number CHARACTER(25) NOT NULL,
   district_code INTEGER NOT NULL,
   state_name CHARACTER(25) NOT NULL,
   area DOUBLE PRECISION NOT NULL,
   CONSTRAINT PK_State PRIMARY KEY (state_number),
   CONSTRAINT FK_District_State FOREIGN KEY (district_code)
   REFERENCES district (code) MATCH SIMPLE
   ON UPDATE NO ACTION
   ON DELETE NO ACTION
);

SELECT * FROM state;

CREATE TABLE application (
   code INTEGER NOT NULL,
   legal_id INTEGER,
   person_id INTEGER,
   employee_id INTEGER NOT NULL,
   date date NOT NULL,
   state_number CHARACTER(25) NOT NULL,
   area DOUBLE PRECISION NOT NULL,
   forest_age INTEGER NOT NULL,
   forest_size DOUBLE PRECISION NOT NULL,
   purpose CHARACTER(25) NOT NULL,
   duration INTEGER NOT NULL,
   app_status Status DEFAULT 'Reprobe' NOT NULL,
   isPerson BOOLEAN,
   CONSTRAINT PK_Application PRIMARY KEY (code),
   CONSTRAINT FK_Person_Employee_Application FOREIGN KEY (employee_id)
   REFERENCES employee (identification) MATCH SIMPLE
   ON UPDATE NO ACTION
   ON DELETE NO ACTION,
   CONSTRAINT FK_State_Application FOREIGN KEY (state_number)
   REFERENCES state (state_number) MATCH SIMPLE
   ON UPDATE NO ACTION
   ON DELETE NO ACTION,
   CONSTRAINT FK_Legal_Application FOREIGN KEY (legal_id)
   REFERENCES legal (identification) MATCH SIMPLE
   ON UPDATE NO ACTION
   ON DELETE NO ACTION,
   CONSTRAINT FK_Person_Application FOREIGN KEY (person_id)
   REFERENCES person (identification) MATCH SIMPLE
   ON UPDATE NO ACTION
   ON DELETE NO ACTION,
   CHECK (
      (legal_id IS NOT NULL AND person_id IS NULL) OR 
      (legal_id IS NULL AND person_id IS NOT NULL)
   )
);

SELECT * FROM application;

CREATE TABLE forestryplan (
   code INTEGER NOT NULL,
   employee_id INTEGER NOT NULL,
   engineer_id INTEGER NOT NULL,
   application_code INTEGER NOT NULL,
   registry_number CHARACTER(25) NOT NULL,
   date date NOT NULL,
   comment TEXT NOT NULL,
   CONSTRAINT PK_forestryplan PRIMARY KEY (code),
   CONSTRAINT FK_Person_Employee_Forestryplan FOREIGN KEY (employee_id)
   REFERENCES employee (identification) MATCH SIMPLE
   ON UPDATE NO ACTION
   ON DELETE NO ACTION,
   CONSTRAINT FK_Person_Engineer_Forestryplan FOREIGN KEY (engineer_id)
   REFERENCES engineer (identification) MATCH SIMPLE
   ON UPDATE NO ACTION
   ON DELETE NO ACTION,
   CONSTRAINT FK_Application_Forestryplan FOREIGN KEY (application_code)
   REFERENCES application (code) MATCH SIMPLE
   ON UPDATE NO ACTION
   ON DELETE NO ACTION
);

SELECT * FROM forestryplan;

CREATE TABLE include (
   forestryplan_code INTEGER NOT NULL,
   species_code CHARACTER(15) NOT NULL,
   quantity DOUBLE PRECISION NOT NULL,
   CONSTRAINT PK_Include PRIMARY KEY (forestryplan_code, species_code),
   CONSTRAINT FK_Forestryplan_Include FOREIGN KEY (forestryplan_code)
   REFERENCES forestryplan (code) MATCH SIMPLE
   ON UPDATE NO ACTION
   ON DELETE NO ACTION,
   CONSTRAINT FK_Species_Include FOREIGN KEY (species_code)
   REFERENCES species (code) MATCH SIMPLE
   ON UPDATE NO ACTION
   ON DELETE NO ACTION
);

SELECT * FROM include;

SELECT * FROM district;

INSERT INTO district (code, name)
values (3, 'Alameda La Victoria');

-- INSERT data into the application table
INSERT INTO person
values (1010,'RUT','Danna', 'Ortiz',6690457);

INSERT INTO employee
values (1010, 'Woman', 'RH+');

INSERT INTO state
values ('S14', 1, 'State 14', 15.5);

INSERT INTO application
values (1, NULL, 1010, 1010, DATE '15-10-2020', 'S14', 15.5, 5, 25.8, 'Renew', 30, 'Reprobe', TRUE);

INSERT INTO engineer
values (1010, 'AC10005');

-- Testing new trigger

INSERT INTO forestryplan
values (1, 1010, 1010, 1, 'REG1005', DATE '15-10-2020', 'New forest plan');
