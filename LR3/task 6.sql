/* Выберите список бронирований на 14 сентября 2012 г., чтоимость которых более 30. 
Включите в выходные данные название заведения, имя участника, отформатированное 
как одиночное столбец и стоимость. Упорядочивайте 
по убыванию стоимости и не используйте подзапросы.
Помните, что у гостей разные затраты по сравнению с участниками 
(указанные затраты указаны за получасовой «интервал»), 
а идентификатор гостя всегда имеет идентификатор 0. */

USE cd;

SELECT DISTINCT f.facility, CONCAT(m.surname, ' ', m.firstname) AS 'Members',
                IF(b.memid = 0, f.guestcost, f.membercost) * b.slots AS 'Cost'
  FROM members m
    JOIN bookings b ON b.memid = m.memid
    JOIN facilities f ON b.facid = f.facid
  WHERE DATE(starttime) = '2012.09.14' AND ((b.memid = 0 AND f.guestcost * b.slots > 30) 
                                             OR (b.memid != 0 AND f.membercost * b.slots > 30)
                                           )
  ORDER BY Cost DESC;
