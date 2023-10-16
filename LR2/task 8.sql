-- Выбрать имена объектов с их качественной стоимостью 
-- (качественной стоимостью == ‘дешевый’ если monthlymaintenance < 100 и 
-- ‘дорогой’ в противном случае

USE cd;

SELECT facility, IF (monthlymaintenance < 100, 'дешевый', 'дорогой') AS qq FROM facilities;
