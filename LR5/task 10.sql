/*Создайте список общего количества мест, 
забронированных на один объект в месяц в 2012 году. 
Включите выходные строки, 
содержащие итоговые суммы за все месяцы по каждому объекту, 
а также итоговые суммы за все месяцы для всех объектов. 
Выходная таблица должна состоять из идентификатора объекта, 
месяца и слотов, отсортированных по идентификатору и месяцу. 
При вычислении агрегированных значений для всех месяцев
и всех facid возвращайте нулевые значения в столбцах месяца и facid.*/

USE cd; 

WITH income_per_month AS (
  SELECT f.facid, MONTH(b.starttime) AS month,
          SUM(b.slots) as sum_slots
    FROM facilities f
      JOIN bookings b ON f.facid = b.facid
    WHERE YEAR(b.starttime) = 2012
    GROUP BY f.facid, month
    )
SELECT facid, IF(GROUPING(month) = 1, 'Total', month) as month2, SUM(sum_slots) as slots
  FROM income_per_month
  GROUP BY facid, month WITH ROLLUP;

SELECT f.facid,
    IF(GROUPING(MONTH(b.starttime)) = 1, "TOTAL", MONTH(b.starttime)) AS tmp,
    SUM(b.slots) as sum_slots
    FROM facilities f
      JOIN bookings b ON f.facid = b.facid
    WHERE YEAR(b.starttime) = 2012
    GROUP BY f.facid, MONTH(starttime) WITH ROLLUP;
