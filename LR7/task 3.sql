/*
Напишите процедуру, которая считает окупаемость каждого
объекта клуба на основании оплаты аренд за месяц (т.е. за июль 2012 года). 
*/

USE cd;

DELIMITER //

DROP PROCEDURE IF EXISTS income_of_all //
CREATE PROCEDURE income_of_all(curfacid INT, m INT, y INT)
  READS SQL DATA
  NOT DETERMINISTIC
  BEGIN
    WITH tmp AS(
      SELECT b.starttime AS date, SUM(p.payment) OVER (
      ROWS BETWEEN unbounded preceding and current row) - f.initialoutlay AS income
        FROM payments AS p
          JOIN bookings AS b ON b.bookid = p.bookid
          JOIN facilities AS f ON b.facid = f.facid
        WHERE curfacid = b.facid AND
          MONTH(starttime) = m AND YEAR(starttime) = y
        ORDER BY b.starttime
        )
    SELECT date FROM tmp WHERE income > 0 LIMIT 1;
  END //

CALL income_of_all(4, MONTH('2012-07-03'), YEAR('2012-07-03'));