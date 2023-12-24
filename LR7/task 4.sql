/*
Напишите функцию, которая будет рассчитывать увеличение/уменьшение
стоимость аренды объекта на последующие месяцы  для изменения
( увеличения или уменьшения) срока окупаемость на заданную долю
(в процентах) на основании расчета окупаемости за уже оплаченные периоды.
Сохраните расчет в виде csv или sql файла (например, используя временные таблицы). 
*/

USE cd;

DELIMITER //

DROP FUNCTION IF EXISTS increase_income_by //
CREATE FUNCTION increase_income_by(facid INT, fraction FLOAT, cur_time TIMESTAMP)
  RETURNS VARCHAR(50)
  READS SQL DATA
  NOT DETERMINISTIC
  BEGIN
    DECLARE income DECIMAL(10, 2);
    DECLARE maintenance DECIMAL(10, 2);
    DECLARE net_income DECIMAL(10, 2);
    DECLARE cost DECIMAL(10, 2);
    DECLARE beta DECIMAL(10, 2);
    DECLARE result VARCHAR(50);

    -- доход за все время эксплуатации объекта без учета обслуживания
    SELECT SUM(p.payment) INTO income
      FROM payments AS p
        JOIN bookings AS b ON b.bookid = p.bookid
        JOIN facilities AS f ON b.facid = f.facid
      WHERE facid = b.facid AND
        b.starttime <= cur_time
      GROUP BY b.facid;

    IF income IS NULL THEN
      BEGIN
        SELECT CONCAT(f.guestcost, ';', f.membercost) INTO result
        FROM facilities AS f
        WHERE facid = f.facid;
      RETURN result;
      END;
    END IF;


    -- расходы на обслуживание за все время эксплуатации объекта (с точностью до дня)
    SELECT f.monthlymaintenance * (MONTH(cur_time) - MONTH(MIN(b.starttime)) + 1) INTO maintenance
      FROM facilities AS f
        JOIN bookings AS b ON b.facid = f.facid
      WHERE facid = b.facid
      GROUP BY b.facid;

    -- стоимость объекта
    SELECT f.initialoutlay INTO cost
      FROM facilities AS f
      WHERE facid = f.facid;

    -- очень важная переменная
    SET net_income = (income - maintenance);
    IF net_income <= 0 OR cost <= net_income THEN
      BEGIN
        SELECT CONCAT(f.guestcost, ';', f.membercost) INTO result
        FROM facilities AS f
        WHERE facid = f.facid;
      RETURN result;
      END;
    END IF;

    -- расчитываем коээфициент для стоимости аренды
    SET beta = ((1 / fraction) * (cost - income + maintenance)
                / cost * (1 - maintenance / income) + maintenance / income);

    -- расчитываем новые сотимости аренды
    IF beta > 0 THEN
      SELECT CONCAT(f.guestcost * beta, ';', f.membercost * beta) INTO result
        FROM facilities AS f
        WHERE facid = f.facid;
    ELSE
      SELECT CONCAT(f.guestcost / (-1 * beta), ';', f.membercost / (-1 * beta)) INTO result
        FROM facilities AS f
        WHERE facid = f.facid;
    END IF;

    RETURN CONCAT(result);
  END //

DELIMITER ;

SELECT increase_income_by(0, 2, '2012-07-31-23:59:59')
INTO OUTFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/output.csv' 
FIELDS ENCLOSED BY '"' 
TERMINATED BY ';' 
ESCAPED BY '"' 
LINES TERMINATED BY '\r\n';
