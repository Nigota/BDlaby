/*Классифицируйте объекты на группы одинакового размера
(высокие, средние и низкие в зависимости от их доходов). 
Упорядочите по классификации и названию объекта.
Примечание: используйте функцию деления на группы ntile.*/

USE cd;

WITH sum_table AS (
    SELECT b.facid, f.facility,
        SUM(
            IF(b.memid = 0, f.guestcost, f.membercost) * b.slots
        ) - f.monthlymaintenance * COUNT(DISTINCT MONTH(b.starttime)) AS income
    FROM bookings AS b
        JOIN facilities AS f ON b.facid = f.facid
    GROUP BY b.facid
    )
SELECT facility, income,
  CASE 
    WHEN NTILE(3) OVER (ORDER BY income DESC) = 1 THEN 'Высокий доход'
    WHEN NTILE(3) OVER (ORDER BY income DESC) = 2 THEN 'Средний доход'
    WHEN NTILE(3) OVER (ORDER BY income DESC) = 3 THEN 'Низкий доход'
  END AS incomegroup
  FROM sum_table;
