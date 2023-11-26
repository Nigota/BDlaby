/*Составьте список объектов вместе с их общим доходом. 
Выходная таблица должна состоять из названия объекта и доходов, 
отсортированных по доходам. 
Помните, что для гостей и участников действуют разные цены!*/

USE cd;

SELECT facility, 
       IFNULL(
        SUM(IF(b.memid = 0, f.guestcost * b.slots, f.membercost * b.slots)), 0
        ) AS income
  FROM facilities f
    LEFT JOIN bookings b ON b.facid = f.facid
  GROUP BY f.facility 
  ORDER BY income;

