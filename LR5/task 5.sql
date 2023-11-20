/*Рассчитайте количество аренд каждого из объектов клуба за сентябрь 2012 года.*/
USE cd;
SELECT facility, sum(b.slots) AS 'Количество аренд' 
  FROM facilities f 
    JOIN bookings AS b ON b.facid = f.facid 
  WHERE DATE(b.starttime) >= '2012-09-01' AND DATE(b.starttime) <= '2012-09-30'
  GROUP BY f.facid;