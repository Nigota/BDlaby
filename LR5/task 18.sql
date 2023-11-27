/*
Для каждого дня августа 2012 года рассчитайте скользящее среднее
общего дохода за предыдущие 15 дней. Вывод должен содержать столбцы даты и дохода,
отсортированные по дате. Не забудьте учесть возможность того, что в день будет нулевой доход
*/

USE cd;

SET @start_date = '2012-07-15', @end_date = '2012-08-31';

START TRANSACTION;

DELETE FROM bookings AS b
  WHERE MONTH(b.starttime) = 8 AND DAY(b.starttime) BETWEEN 2 AND 20;

WITH RECURSIVE dArray(dateDay) AS (
    SELECT @start_date as dateDay
    UNION ALL
    SELECT DATE_ADD(dateDay, INTERVAL 1 day) FROM dArray WHERE dateDay < @end_date
  )
SELECT DATE_FORMAT(dr.dateDay, '%m %d') as dayMonth,
    SUM(
      CASE
        WHEN b.memid IS NULL THEN 0
        WHEN b.memid = 0 THEN f.guestcost * b.slots
        ELSE f.membercost * b.slots
      END) AS income,
    ROUND(AVG( 
      SUM(
        CASE
          WHEN b.memid IS NULL THEN 0
          WHEN b.memid = 0 THEN f.guestcost * b.slots
          ELSE f.membercost * b.slots
        END)  
      ) OVER w) AS roll_avg
  FROM dArray AS dr
    LEFT JOIN bookings AS b ON DATE_FORMAT(b.starttime, '%m %d') = DATE_FORMAT(dr.dateDay, '%m %d')
    LEFT JOIN facilities AS f ON b.facid = f.facid
  GROUP BY dayMonth
  WINDOW w AS (
    ORDER BY DATE_FORMAT(dr.dateDay, '%m %d') ROWS BETWEEN 14 PRECEDING AND CURRENT ROW
  )
  ORDER BY dayMonth;
ROLLBACK;
