/*Выберите количество аренд объектов клуба в каждый месяц.*/

USE cd;

SELECT facility, SUM(book.slots) as rent_count,
    MONTH(book.starttime) as month
  FROM facilities as fac
    JOIN bookings as book ON book.facid = fac.facid
  GROUP BY fac.facid, month;
