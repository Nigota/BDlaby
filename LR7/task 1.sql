/*
Создайте функцию, которая рассчитывает стоимость
каждой аренды (для каждой записи таблицы bookings).  
*/

USE cd;

drop function if exists HelloWorld;

DELIMITER //

CREATE FUNCTION HelloWorld() RETURNS VARCHAR(20)
    DETERMINISTIC
BEGIN
    DECLARE result varchar(30);  
 SET result = 'HELLO WORLD';
 
 RETURN (result); 
END//

DELIMITER ;

select HelloWorld();

DELIMITER //

DROP FUNCTION IF EXISTS cost_of;
CREATE FUNCTION cost_of(a INT, b INT) RETURNS INT
  NOT DETERMENISTIC
  BEGIN
    DECLARE income INT;
    SET income = a * b;
    RETURN (income);
  END //