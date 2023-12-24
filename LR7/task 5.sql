/*
Произведите изменения в стоимости аренды объектов согласно расчету задания Task-7-4,
написав update-скрипт. Напишите скрипт отмечающий оплату всех аренд за август 2012 года.
Рассчитайте окупаемость объектов исходя из оплат за август, используя функцию 
Task-7-3 . Сравните, совпадают ли расчетные данные с теми,
что были Вами получены в задании Task-7-4.    
*/

USE cd;

START TRANSACTION;
  SET @k = 2;
  SET @cur_time = '2012-07-31-23:59:59';
  UPDATE facilities
    SET guestcost = CAST(SUBSTRING_INDEX(
        (SELECT increase_income_by(facid, @k, @cur_time)), ';', 1
    ) AS DECIMAL(10, 0)),
    membercost = CAST(SUBSTRING_INDEX(
        (SELECT increase_income_by(facid, @k, @cur_time)), ';', -1
    ) AS DECIMAL(10, 0));
  
  UPDATE bookings
    SET payed = 1
    WHERE DATE(starttime) < '2012-09-01' AND DATE(starttime) >= '2012-08-01';

  
ROLLBACK;
