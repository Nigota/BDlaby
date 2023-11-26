/*
Составьте список трех крупнейших объектов, приносящих доход (включая связи). 
Вывод названия и ранга объекта, отсортированный по рангу и названию объекта.
*/

USE cd;

SELECT f.facility,
       DENSE_RANK() OVER(
        ORDER BY SUM(
                     IF(b.memid = 0, f.guestcost, f.membercost) * b.slots
                 ) - f.monthlymaintenance * COUNT(DISTINCT DATE_FORMAT(b.starttime, "%m/%Y")) DESC
       ) AS ranking
  FROM bookings AS b
    JOIN facilities AS f ON b.facid = f.facid
  GROUP BY b.facid
  LIMIT 3;
