/*
Для каждого дня августа 2012 года рассчитайте скользящее среднее
общего дохода за предыдущие 15 дней. Вывод должен содержать столбцы даты и дохода,
отсортированные по дате. Не забудьте учесть возможность того, что в день будет нулевой доход
*/

USE cd;

SET @start_date = '2012-08-01', @end_date = '2012-08-31';

WITH
  RECURSIVE dArray(dateDay) AS (
    SELECT @start_date as dateDay
    UNION ALL
    SELECT DATE_ADD(dateDay, INTERVAL 1 day) FROM dArray WHERE dateDay < @end_date
  ),

  rolling_income AS (
    SELECT DATE_FORMAT(b.starttime, '%m %d') as dayMonth,
        SUM(IF(b.memid = 0, f.guestcost, f.membercost) * b.slots) AS income,
        ROUND(AVG( SUM(IF(b.memid = 0, f.guestcost, f.membercost) * b.slots) ) OVER w) AS roll_avg
      FROM bookings AS b
        JOIN facilities AS f ON b.facid = f.facid
      WHERE MONTH(b.starttime) IN (7, 8)
      GROUP BY dayMonth
      WINDOW w AS (
        ORDER BY DATE_FORMAT(b.starttime, '%m %d') ROWS BETWEEN 14 PRECEDING AND CURRENT ROW
      )
      ORDER BY dayMonth)

SELECT dayMonth, IFNULL(income, 0) as income ,IFNULL(roll_avg, 0) as roll_avg
  FROM dArray as DA
    LEFT JOIN rolling_income as RI ON RI.dayMonth = DATE_FORMAT(DA.dateDay, '%m %d')
  WHERE SUBSTRING(dayMonth, 1, 2) = '08';
