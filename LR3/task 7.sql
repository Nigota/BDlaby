-- Выберите список всех членов, включая человека, который их рекомендовал (если таковой имеется), 
-- без использования каких-либо объединений. 
-- Исключите в списке дубликаты, упорядочите лист по ФИО (==   имя + фамилия).

USE cd;

SELECT DISTINCT CONCAT(m1.surname, " ", m1.firstname) as Member
  FROM members m1, members m2
  WHERE (m1.recommendedby = m2.memid OR m1.recommendedby IS NULL)
        and m1.surname NOT LIKE "GUEST"
  ORDER BY Member;
