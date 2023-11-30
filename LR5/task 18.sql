/*
Для каждого дня августа 2012 года рассчитайте скользящее среднее
общего дохода за предыдущие 15 дней. Вывод должен содержать столбцы даты и дохода,
отсортированные по дате. Не забудьте учесть возможность того, что в день будет нулевой доход
*/

USE cd;

SET @start_date = '2012-08-01', @end_date = '2012-08-31';

WITH RECURSIVE dArray(dateDay) AS (
  SELECT @start_date as dateDay
  UNION ALL
  SELECT DATE_ADD(dateDay, INTERVAL 1 day)
    FROM dArray
    WHERE dateDay < @end_date
)
SELECT dateDay,
    IFNULL(SUM(
      CASE
        WHEN (DATE(book.starttime) != dateDay) THEN 0
        WHEN (book.memid = 0) THEN fac.guestcost * book.slots
        ELSE fac.membercost * book.slots
      END
    ), 0) as income,
    IFNULL(ROUND(SUM(
        IF(
            book.memid = 0,
            fac.guestcost,
            fac.membercost
        ) * book.slots
    ) / 15), 0) as avg_roll
  FROM dArray
    LEFT JOIN cd.bookings as book ON DATE_ADD(dateDay, INTERVAL -14 day) <= DATE(book.starttime) AND DATE(book.starttime) <= dateDay
    LEFT JOIN cd.facilities as fac ON book.facid = fac.facid
  GROUP BY dateDay;