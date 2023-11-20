/*
Для каждого дня августа 2012 года рассчитайте скользящее среднее
общего дохода за предыдущие 15 дней. Вывод должен содержать столбцы даты и дохода,
отсортированные по дате. Не забудьте учесть возможность того, что в день будет нулевой доход
*/

USE cd;

WITH tmp AS (
  SELECT DATE_FORMAT(b.starttime, '%m %d') as dayMonth,
      SUM(IF(b.memid = 0, f.guestcost, f.membercost) * b.slots) AS income,
      ROUND(AVG( SUM(IF(b.memid = 0, f.guestcost, f.membercost) * b.slots) ) OVER w) AS roll_avg
    FROM bookings AS b
      JOIN facilities AS f ON b.facid = f.facid
    WHERE MONTH(b.starttime) IN (7, 8)
    GROUP BY dayMonth
    WINDOW w AS (
      ORDER BY DATE_FORMAT(b.starttime, '%m %d') ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
    )
    ORDER BY dayMonth)
SELECT * FROM tmp WHERE SUBSTRING(dayMonth, 1, 2) = '08';
