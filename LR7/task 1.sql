/*
Создайте функцию, которая рассчитывает стоимость
каждой аренды (для каждой записи таблицы bookings).  
*/

USE cd;

DELIMITER //

DROP FUNCTION IF EXISTS cost_of //
CREATE FUNCTION cost_of(cost DECIMAL, slots INT)
RETURNS INT
BEGIN
  DECLARE income INT;

  SET income = cost * slots;
  
  RETURN income;

END; //

DELIMITER ;


SELECT cost_of(
    IF(b.memid = 0, f.guestcost, f.membercost), b.slots
)
  FROM bookings AS b
    JOIN facilities AS f ON f.facid = b.facid;