/*Выведите идентификатор объекта, в котором забронировано
наибольшее количество мест (slot).
Убедитесь, что в случае ничьей все результаты привязки будут выведены.
Примечание: используйте функцию ранжирования*/

USE cd;

WITH rank_table AS(
  SELECT facid, slots, RANK() OVER (ORDER BY slots DESC) as self_rank 
    FROM bookings
)
SELECT DISTINCT facid
  FROM rank_table
  WHERE self_rank = 1;
