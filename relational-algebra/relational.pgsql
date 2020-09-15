SELECT * FROM person;
SELECT * FROM car;

/*Producto Cartesiano, is like INNER JOIN*/
SELECT person.car_uid AS person_car_uid, car.car_uid AS car_car_uid
from person INNER JOIN car 
ON person.car_uid=car.car_uid;
