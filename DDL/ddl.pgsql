
/*Create table*/
create table orders (
    id_order INT,
    id_client INT,
    id_item INT,
    date DATE,
    quantity INT,
    total INT
);

create table client (
    id_client BIGINT,
    first_name VARCHAR(50),
    last_name VARCHAR(50)
);

create table products (
    id_item BIGINT,
    name_item VARCHAR(30),
    price NUMERIC(5,2)
);

create table accounts (
    user_id INTEGER,
    username VARCHAR(30),
    email VARCHAR(30),
    created_on TIMESTAMP,
    last_login TIMESTAMP
);

create table company (
    id_company SMALLSERIAL,
    name_company character(50),
    address character(100)
);

create table departament (
    id_departament SMALLSERIAL,
    name_dep CHARACTER(50),
    id_area INTEGER
);

/*Create primary keys*/
create table ticket (
    id_ticket SERIAL,
    id_movie INTEGER,
    date DATE,
    chair_num CHARACTER(10),
    PRIMARY KEY(id_ticket)
);

create table invoice (
    id_invoce SERIAL,
    id_client BIGINT,
    id_product SMALLINT,
    count INT,
    price DECIMAL,
    PRIMARY KEY(id_invoce, id_client, id_product)
);

/*Create Foreing Key*/
/*Referencing only one column*/
CREATE TABLE products (
    product_no INTEGER PRIMARY KEY,
    product_name TEXT,
    price NUMERIC
);

CREATE TABLE orders (
    order_id INTEGER PRIMARY KEY,
    product_no INTEGER REFERENCES products (product_no),
    quantity INTEGER
);

INSERT INTO products (product_no, product_name, price) VALUES(1, 'Milk', 1.5);
INSERT INTO products (product_no, product_name, price) VALUES(2, 'Tomate', 2.5);
INSERT INTO products (product_no, product_name, price) VALUES(3, 'Chesse', 3.6);

SELECT * FROM products;

INSERT INTO orders (order_id, product_no, quantity) VALUES(101, 3, 2);
INSERT INTO orders (order_id, product_no, quantity) VALUES(102, 3, 2);
INSERT INTO orders (order_id, product_no, quantity) VALUES(103, 1, 5);
INSERT INTO orders (order_id, product_no, quantity) VALUES(104, null, 5);

SELECT * FROM orders;

--ROP TABLE company, departament;
CREATE TABLE companies (
    company_id INTEGER PRIMARY KEY,
    company_name CHARACTER(50),
    area CHARACTER(20)
);

CREATE TABLE departaments (
    depar_id INTEGER PRIMARY KEY,
    depar_name CHARACTER(50),
    company_id INTEGER REFERENCES companies (company_id),
    quantity_employees INTEGER
);

INSERT INTO companies (company_id, company_name, area) VALUES (101, 'Microsoft', 'Tech');
INSERT INTO companies (company_id, company_name, area) VALUES (102, 'Apple', 'Tech');
INSERT INTO companies (company_id, company_name, area) VALUES (103, 'AT&T', 'Cell');
INSERT INTO companies (company_id, company_name, area) VALUES (104, 'Google', 'Tech');

INSERT INTO departaments (depar_id, depar_name, company_id, quantity_employees)
VALUES (1, 'Golang', 104, 54);

INSERT INTO departaments (depar_id, depar_name, company_id, quantity_employees)
VALUES (2, 'Office', 101, 345);

INSERT INTO departaments (depar_id, depar_name, company_id, quantity_employees)
VALUES (3, 'Iphone', 102, 195);

SELECT * FROM companies;
SELECT * FROM departaments;

/*Referencing a group of columns*/
--DROP TABLE invoice, client;
CREATE TABLE clients (
    client_id INTEGER PRIMARY KEY,
    client_name CHARACTER(30),
    PID INTEGER
);

CREATE TABLE invoices (
    date DATE,
    client_id INTEGER REFERENCES clients,
    product_no INTEGER REFERENCES products,
    quantity INTEGER,
    PRIMARY KEY (client_id, product_no)
);

INSERT INTO clients (client_id, client_name) VALUES (0313, 'Luis Carreño Ortiz');

INSERT INTO invoices (date, client_id, product_no, quantity)
VALUES (DATE '2020-09-19', 0313, 3, 5);

INSERT INTO invoices (date, client_id, product_no, quantity)
VALUES (DATE '2020-09-19', 0315, 3, 5);

SELECT * FROM invoices;
