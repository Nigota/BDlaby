/*
Напишите процедуру, которая считает окупаемость каждого
объекта клуба на основании оплаты аренд за месяц (т.е. за июль 2012 года). 
*/

USE cd;

DELIMITER //

DROP PROCEDURE IF EXISTS income_of_all //
CREATE PROCEDURE income_of_all()
  READS SQL DATA
  NOT DETERMINISTIC
  BEGIN
    SELECT b.facid, f.facility,
        SUM(
            IF(b.memid = 0, f.guestcost, f.membercost) * b.slots
        ) - f.monthlymaintenance AS income
      FROM bookings AS b
        JOIN facilities AS f ON b.facid = f.facid
      WHERE DATE(starttime) < '2012-08-01' AND DATE(starttime) >= '2012-07-01'
      GROUP BY b.facid
      ORDER BY b.facid;
  END //

DELIMITER ;

CALL income_of_all;