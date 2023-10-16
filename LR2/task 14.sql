--  Выберите самый дорогой и самый дешевый объект.

USE cd;

SELECT 
    MAX(monthlymaintenance) as 'MAX facility cost', 
    MIN(monthlymaintenance) as 'MIN facility cost' 
FROM facilities;
