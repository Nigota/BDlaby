/*
Создайте функцию, которая рассчитывает стоимость
каждой аренды (для каждой записи таблицы bookings).  
*/

USE cd;

DELIMITER //

DROP FUNCTION IF EXISTS cost_of //
CREATE FUNCTION cost_of(memid INT, facid INT, slots INT) RETURNS INT
  READS SQL DATA
  NOT DETERMINISTIC
  BEGIN
    DECLARE income INT;
    SET income = (SELECT IF(memid = 0, guestcost, membercost) * slots
                   FROM facilities
                   WHERE facid = facilities.facid);
    RETURN income;
  END //

DELIMITER ;

SELECT cost_of(memid, facid, slots)
  FROM bookings;