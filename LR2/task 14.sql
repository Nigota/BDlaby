--  Выберите самый дорогой и самый дешевый объект.

USE cd;

SELECT
    (SELECT facility FROM facilities ORDER BY monthlymaintenance DESC LIMIT 1) as 'MAX facility cost',
    (SELECT facility FROM facilities ORDER BY monthlymaintenance ASC LIMIT 1) as 'MIN facility cost'