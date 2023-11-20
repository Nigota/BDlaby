/*Найдите общее количество участников (члены + гости), совершивших хотя бы одно бронирование.*/

USE cd;

SELECT COUNT(DISTINCT book.memid) as mem_count
FROM bookings as book;