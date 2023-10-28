-- Выбрать объекты, которые платны для членов клуба, но стоимость 
-- использование не превышает 1/50 от стоимость месячного обслуживания 
-- (monthlymaintenance).

USE cd;

SELECT * FROM facilities WHERE membercost != 0 AND monthlymaintenance / 50 >= membercost;
