/*Выведите все объектов клуба, если они содержат 
в названии слово  ‘Tennis’ в произвольном регистре.*/

USE cd;

SELECT facility AS 'Объекты'
  FROM facilities
  WHERE facility LIKE '%tennis%';