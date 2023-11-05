--  Выберите самый дорогой и самый дешевый объект.

USE cd;

SELECT
  (SELECT facility 
     FROM facilities
     WHERE initialoutlay = (SELECT MAX(initialoutlay) 
                              FROM facilities)
  ) as 'Дорогой',
  (SELECT facility 
     FROM facilities 
     WHERE initialoutlay = (SELECT MIN(initialoutlay)
                              FROM facilities)
  ) as 'Эконом';
