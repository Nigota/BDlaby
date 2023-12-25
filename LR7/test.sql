USE cd;


-- Подсчет суммы
SELECT SUM(payment) FROM payments;
SELECT SUM(cost_of(memid, facid, slots))
  FROM bookings
  WHERE DATE(starttime) < '2012-08-01' AND DATE(starttime) >= '2012-07-01';