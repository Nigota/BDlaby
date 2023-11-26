/*Выберите процент использования объектов по месяцам, 
упорядочив по возрастанию*/

USE cd;

WITH slots as (
  SELECT facility, SUM(book.slots) as rent_count,
      MONTH(book.starttime) as month
    FROM facilities as fac
      JOIN bookings as book ON book.facid = fac.facid
    GROUP BY fac.facid, month
)
SELECT s1.facility, CONCAT(ROUND(s1.rent_count / SUM(s2.rent_count) * 100, 1), '%') as usability,
    s1.month
  FROM slots as s1
    JOIN slots as s2 ON s1.month = s2.month
  GROUP BY s1.facility, s1.rent_count, s1.month
  ORDER BY CAST(usability as FLOAT) ASC;