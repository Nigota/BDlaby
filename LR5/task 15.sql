/*
Составьте список участников (включая гостей) вместе с количеством часов,
которые они забронировали для объекта,  округленным до ближайших десяти часов.
Ранжируйте их по этой округленной цифре, получая в результате имя, фамилию,
округленные часы и звание. Сортировка по званию, фамилии и имени.
*/

USE cd;

SELECT b.memid, m.surname, m.firstname,
       ROUND(SUM(slots) / 2, -1) AS fachours,
       RANK() OVER(ORDER BY ROUND(SUM(slots) / 2, -1)) AS ranking,
       DENSE_RANK() OVER(ORDER BY ROUND(SUM(slots) / 2, -1)) AS dranking
  FROM bookings as b
    LEFT JOIN members AS m ON b.memid = m.memid
  GROUP BY b.memid
  ORDER BY ranking, surname, firstname;
