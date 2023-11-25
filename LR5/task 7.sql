/*Найдите общее количество участников (члены + гости), совершивших хотя бы одно бронирование.*/

USE cd;

SELECT COUNT(DISTINCT book.memid) as mem_count
  FROM bookings AS book;

SELECT DISTINCT CONCAT(m.surname, " ", m.firstname) AS People
  FROM members AS m
    LEFT JOIN bookings AS b ON b.memid = m.memid