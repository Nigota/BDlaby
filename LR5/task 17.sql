/*
Классифицируйте объекты на группы одинакового размера 
(высокие, средние и низкие в зависимости от их доходов). 
Упорядочите по классификации и названию объекта.
*/

USE cd;

WITH rank_table AS (
    SELECT b.facid, f.facility,
        SUM(
            IF(b.memid = 0, f.guestcost, f.membercost) * b.slots
        ) - f.monthlymaintenance * COUNT(DISTINCT MONTH(b.starttime)) AS income,
        DENSE_RANK() OVER(
            ORDER BY SUM(IF(b.memid = 0, f.guestcost, f.membercost) * b.slots
                    ) - f.monthlymaintenance * COUNT(DISTINCT MONTH(b.starttime)) DESC) AS ranking
    FROM bookings AS b
        JOIN facilities AS f ON b.facid = f.facid
    GROUP BY b.facid
    )
SELECT facility,
  CASE
    WHEN ranking <= maxi / 3 THEN "Высокий доход"
    WHEN maxi / 3 < ranking AND ranking <= maxi / 3 * 2 THEN "Средний доход"
    ELSE "Низкий доход"
  END AS grp
  FROM rank_table, (SELECT MAX(ranking) as maxi FROM rank_table) as tmp;
