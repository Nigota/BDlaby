/*Рассчитайте количество аренд каждого из объектов клуба.*/

USE cd;

SELECT facility, SUM(b.slots) AS 'Количество аренд'
  FROM facilities f 
    JOIN bookings AS b ON b.facid = f.facid
  GROUP BY f.facid;