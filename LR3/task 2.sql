-- Выберите теннисные корты, забронированные пользователями на 19 сентября 2012 года

USE cd;

SELECT DISTINCT facility 
FROM facilities f
    JOIN bookings b ON b.facid = f.facid
WHERE DATE(starttime) = '2012.09.19' AND facility like 'Tennis Court%';
