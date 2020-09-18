
/* create table 'weight'*/
create table weight (
    id BIGSERIAL not NULL PRIMARY KEY,
    full_name VARCHAR(50) NOT NULL,
    gender VARCHAR(6) NOT NULL,
    date_of_test DATE NOT NULL,
    value SMALLINT NOT NULL
)

SELECT * from weight WHERE full_name like '%Gio%'

/* pull data */
INSERT INTO weight(full_name, gender, date_of_test, value)
VALUES('Giovanny Carreño', 'Male', DATE '2020-09-01', 76.6);

INSERT INTO weight(full_name, gender, date_of_test, value)
VALUES('Luis Carreño', 'Male', DATE '2020-09-01', 66.4);

INSERT INTO weight(full_name, gender, date_of_test, value)
VALUES('Danna Carreño', 'Female', DATE '2020-09-01', 65.5);

INSERT INTO weight(full_name, gender, date_of_test, value)
VALUES('Marlene Ortiz', 'Female', DATE '2020-09-01', 84.4);

SELECT * from person;
