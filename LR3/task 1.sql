-- Выберите лист времке  (timestamp) покупки времени 
-- использования объектов членом клуба 'David Farrell'.

USE cd;

SELECT b.starttime, b.memid FROM bookings b 
    JOIN members m ON b.memid = m.memid
WHERE m.firstname = 'David' and m.surname = 'Farrell';
