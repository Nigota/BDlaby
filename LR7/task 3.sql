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
    SELECT b.starttime AS income
      FROM payments AS p
        JOIN bookings AS b ON b.bookid = p.bookid
        JOIN facilities AS f ON b.facid = f.facid
      WHERE curfacid = b.facid AND
        MONTH(starttime) = m AND YEAR(starttime) = y
      GROUP BY b.facid;
  END //

CALL income_of_all(4, MONTH('2012-07-03'), YEAR('2012-07-03'));