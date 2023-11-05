--  Выберите самый дорогой и самый дешевый объект.

USE cd;

SELECT facility,'MAX facolity cost' AS 'Cost'FROM facilities
WHERE initialoutlay = (SELECT MAX(initialoutlay)  FROM facilities)
UNION 
SELECT facility, 'MIN facility cost' FROM facilities
WHERE initialoutlay = (SELECT MIN(initialoutlay) FROM facilities);