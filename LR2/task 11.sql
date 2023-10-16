-- Объедините имена членов и названия объектов в обдну таблицу 
-- с одним столбцом.

USE cd;

SELECT DISTINCT facilities.facility, members.firstname
FROM bookings
JOIN facilities ON bookings.facid = facilities.facid
JOIN members ON bookings.memid = members.memid
