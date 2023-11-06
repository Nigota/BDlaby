--  Выберите самый дорогой и самый дешевый объект.

USE cd;

SELECT facility, IF(mini = initialoutlay, "Дешевый", "Дорогой") as "Стоимость"
  FROM facilities, (SELECT MIN(initialoutlay) as mini, MAX(initialoutlay) as maxi FROM facilities) as m1
  WHERE initialoutlay IN (mini, maxi);
