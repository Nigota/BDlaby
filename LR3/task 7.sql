-- Выберите список всех членов, включая человека, который их рекомендовал (если таковой имеется), 
-- без использования каких-либо объединений. 
-- Исключите в списке дубликаты, упорядочите лист по ФИО (==   имя + фамилия).

USE cd;

SELECT CONCAT(m1.surname, ' ', m1.firstname) as 'Член клуба',
       CONCAT(m2.surname, ' ', m2.firstname) as 'Кем был рекомендован'
  FROM members m1
    JOIN members m2 
      ON m1.recommendedby = m2.memid
  ORDER BY m1.firstname;
