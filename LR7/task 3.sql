/*
Напишите процедуру, которая считает окупаемость каждого
объекта клуба на основании оплаты аренд за месяц (т.е. за июль 2012 года). 
*/

USE cd;

DELIMITER //

DROP PROCEDURE IF EXISTS income_of_all //
CREATE PROCEDURE income_of_all(curfacid INT, whichDate DATE)
  READS SQL DATA
  NOT DETERMINISTIC
  BEGIN
    SELECT b.facid, f.facility,
        SUM(p.payment) - f.monthlymaintenance AS income
      FROM payments AS p
        JOIN bookings AS b ON b.bookid = p.bookid
        JOIN facilities AS f ON b.facid = f.facid
      WHERE curfacid = b.facid AND
        DATE_FORMAT(starttime, '%y %m') = DATE_FORMAT(whichDate, '%y %m')
      GROUP BY b.facid;
  END //

CALL income_of_all(4, '2012-07-03');