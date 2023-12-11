/*
Напишите функцию, которая будет рассчитывать увеличение/уменьшение
стоимость аренды объекта на последующие месяцы  для изменения
( увеличения или уменьшения) срока окупаемость на заданную долю
(в процентах) на основании расчета окупаемости за уже оплаченные периоды.
Сохраните расчет в виде csv или sql файла (например, используя временные таблицы). 
*/

/*
g - guest_cost
m - member_cost
x - cnt_guest
y - cnt_member
income = g * x + m * y - доход за месяц, g, x, m, y - нам известны
income = g' * new_x + m' * new_y - доход за новый срок,
new_x, new_y - количетсво посещений гостей и участников за новый период, по старым данным.
(новый срок высчитываем по формуле w * days, w - доля в процентах, days - дней в месяце)
Цена аренды для гостей и для участником можно связать соотношением m/g = k, 
k - нам извесно (по старым данным), для простоты условимся, что это соотношение
будет сохраняться и при новых ценах

Тогда m'=kg', income = g' * new_x + k * g' * new_y => g' = income / (new_x + k * new_y)
=> находим m'
*/

USE cd;

-- задаем долю на которую изменяем срок окупаемости (в процентах)

SET @start = CAST('2012-07-01' AS DATETIME);
SET @end = CAST('2012-07-31-23:59:59' AS DATETIME);

DELIMITER //

-- получаем количество гостей за период
DROP FUNCTION IF EXISTS get_guestcnt_inperiod //
CREATE FUNCTION get_guestcnt_inperiod(facid INT, starttime TIMESTAMP, endtime TIMESTAMP)
  RETURNS INT
  READS SQL DATA
  NOT DETERMINISTIC
  BEGIN
    DECLARE guestcnt INT;

    SELECT COUNT(b.memid) INTO guestcnt
      FROM bookings AS b
      WHERE b.memid = 0 AND b.facid = facid AND
      b.starttime BETWEEN starttime AND endtime;

    RETURN guestcnt;
  END //

-- получаем количество участников за период
DROP FUNCTION IF EXISTS get_memcnt_inperiod //
CREATE FUNCTION get_memcnt_inperiod(facid INT, starttime TIMESTAMP, endtime TIMESTAMP)
  RETURNS INT
  READS SQL DATA
  NOT DETERMINISTIC
  BEGIN
    DECLARE memcnt INT;

    SELECT COUNT(b.memid) INTO memcnt
      FROM bookings AS b
      WHERE b.memid != 0 AND b.facid = facid AND
      b.starttime BETWEEN starttime AND endtime;

    RETURN memcnt;
  END //

-- получаем стоимость аренды для участников
DROP FUNCTION IF EXISTS get_membercost //
CREATE FUNCTION get_membercost(facid INT)
  RETURNS DECIMAL(10, 0)
  READS SQL DATA
  NOT DETERMINISTIC
  BEGIN
    DECLARE memcost DECIMAL(10, 0);

    SELECT f.membercost INTO memcost
      FROM  facilities AS f
      WHERE f.facid = facid;

    RETURN memcost;
  END //

-- получаем стоимость аренды для гостей
DROP FUNCTION IF EXISTS get_guestcost //
CREATE FUNCTION get_guestcost(facid INT)
  RETURNS DECIMAL(10, 0)
  READS SQL DATA
  NOT DETERMINISTIC
  BEGIN
    DECLARE guestcost DECIMAL(10, 0);

    SELECT f.guestcost INTO guestcost
      FROM  facilities AS f
      WHERE f.facid = facid;

    RETURN guestcost;
  END //

-- считаем доход за период
DROP FUNCTION IF EXISTS income_of //
CREATE FUNCTION income_of(facid INT, starttime TIMESTAMP, endtime TIMESTAMP)
  RETURNS INT
  READS SQL DATA
  NOT DETERMINISTIC
  BEGIN
    DECLARE income INT;

    SELECT SUM(p.payment) - f.monthlymaintenance * (
        MONTH(endtime) - MONTH(starttime) + 1) INTO income
      FROM payments AS p
        JOIN bookings AS b ON b.bookid = p.bookid
        JOIN facilities AS f ON b.facid = f.facid
      WHERE facid = b.facid AND
        b.starttime BETWEEN starttime AND endtime
      GROUP BY b.facid;

    RETURN income;
  END //

-- считаем коэффициент соотношения цены гостей и участников
DROP FUNCTION IF EXISTS get_k //
CREATE FUNCTION IF EXISTS get_k(facid INT, starttime TIMESTAMP, endtime TIMESTAMP)
  RETURNS FLOAT
  READS SQL DATA
  NOT DETERMINISTIC
  BEGIN
    DECLARE guest_cost DECIMAL(10, 0);
    DECLARE mem_cost DECIMAL(10, 0);

    SELECT get_guestcost(facid) INTO guest_cost;
    SELECT get_membercost(facid) INTO mem_cost;

    RETURN mem_cost / guest_cost;
  END//

-- считаем новую цену объекта
DROP FUNCTION IF EXISTS increase_income_by //
CREATE FUNCTION increase_income_by(facid INT, fraction FLOAT, starttime TIMESTAMP, endtime TIMESTAMP)
  RETURNS DECIMAL(10, 0);
  READS SQL DATA
  NOT DETERMINISTIC
  BEGIN
    DECLARE guestcnt_inperiod INT;
    DECLARE memcnt_inperiod INT;
    DECLARE income DECIMAL(10, 0);
    DECLARE new_end TIMESTAMP;
    DECLARE new_guestcnt INT;
    DECLARE new_memcnt INT;
    DECLARE k FLOAT;

    SELECT get_guestcnt_inperiod(facid, starttime, endtime) INTO guestcnt_inperiod;
    SELECT get_memcnt_inperiod(facid, starttime, endtime) INTO memcnt_inperiod;
    SELECT income_of(facid, starttime, endtime) INTO income;
    SELECT DATE_ADD(starttime, INTERVAL
        ROUND(DATEDIFF(endtime, starttime) * fraction) DAY) INTO new_end;
    SELECT get_guestcnt_inperiod(facid, starttime, new_end) INTO new_guestcnt;
    SELECT get_memcnt_inperiod(facid, starttime, new_end) INTO new_memcnt;
    SELECT get_k(facid, starttime, endtime) INTO k;

    RETURN new_end;
  END //

DELIMITER ;

SELECT increase_income_by(4, 0.5, @start, @end);


-- доход от гостей, от участников
SELECT f.facid, f.facility, COUNT(b.memid),
      SUM(
        IF(b.memid = 0, f.guestcost, 0) * b.slots
      ) AS income_guest
  FROM bookings AS b
    JOIN facilities AS f ON b.facid = f.facid
  WHERE b.memid = 0 AND f.facid = 4 AND DATE(starttime) < '2012-08-01' AND DATE(starttime) >= '2012-07-01'
  GROUP BY b.facid;

SELECT f.facid, f.facility, COUNT(b.memid),
      SUM(
        IF(b.memid = 0, 0, f.membercost) * b.slots
      ) AS income_mem
  FROM bookings AS b
    JOIN facilities AS f ON b.facid = f.facid
  WHERE b.memid != 0 AND f.facid = 4 AND DATE(starttime) < '2012-08-01' AND DATE(starttime) >= '2012-07-01'
  GROUP BY b.facid;

SELECT f.facid, f.facility, COUNT(b.memid),
      SUM(
        IF(b.memid = 0, f.guestcost, f.membercost) * b.slots
      ) - f.monthlymaintenance AS income
  FROM bookings AS b
    JOIN facilities AS f ON b.facid = f.facid
  WHERE f.facid = 4 AND DATE(starttime) < '2012-08-01' AND DATE(starttime) >= '2012-07-01'
  GROUP BY b.facid;
