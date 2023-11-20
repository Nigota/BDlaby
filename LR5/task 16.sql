/*
Составьте список трех крупнейших объектов, приносящих доход (включая связи). 
Вывод названия и ранга объекта, отсортированный по рангу и названию объекта.
*/

USE cd;

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
  LIMIT 3;
