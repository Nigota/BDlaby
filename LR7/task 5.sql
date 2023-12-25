/*
Произведите изменения в стоимости аренды объектов согласно расчету задания Task-7-4,
написав update-скрипт. Напишите скрипт отмечающий оплату всех аренд за август 2012 года.
Рассчитайте окупаемость объектов исходя из оплат за август, используя функцию 
Task-7-3 . Сравните, совпадают ли расчетные данные с теми,
что были Вами получены в задании Task-7-4.    
*/

USE cd;

START TRANSACTION;
  CALL income_of_all(4, MONTH('2012-07-03'), YEAR('2012-07-03'));

  SET @k = 2;
  SET @curtime = '2012-07-31-23:59:59';
  UPDATE facilities
    SET guestcost = guestcost * (SELECT increase_income_by(facid, @k, @curtime)),
    membercost = membercost * (SELECT increase_income_by(facid, @k, @curtime));

  UPDATE bookings
    SET payed = 1
    WHERE DATE(starttime) < '2012-09-01' AND DATE(starttime) >= '2012-08-01';
  
  CALL income_of_all(4, MONTH('2012-08-03'), YEAR('2012-08-03'));
ROLLBACK;
