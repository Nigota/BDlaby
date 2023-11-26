/*Создайте список объектов с общим доходом менее 1000.
Создайте выходную таблицу, состоящую 
из названия объекта и дохода, отсортированного по доходу.
Помните, что для гостей и участников действуют разные цены!*/

USE cd;

SELECT facility, 
       IFNULL(
        SUM(IF(b.memid = 0, f.guestcost * b.slots, f.membercost * b.slots)), 0
        ) AS income
  FROM facilities f
    LEFT JOIN bookings b ON b.facid = f.facid
  GROUP BY f.facility
  HAVING income < 1000
  ORDER BY income;
