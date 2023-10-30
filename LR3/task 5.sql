-- Выберите ФИО (== имя + фамилия) всех, кто покупал корты 1 и 2.

USE cd;

SELECT DISTINCT CONCAT(firstname, ' ', surname) AS 'Members'
FROM members m
    JOIN bookings b ON b.memid = m.memid
    JOIN facilities f ON b.facid = f.facid 
WHERE b.facid IN (0, 1);