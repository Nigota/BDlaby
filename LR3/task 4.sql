-- Выберите всех членов клуба и членов, которые их рекомендовали, 
-- отсортировав их по имени и фамилии

USE cd;

SELECT CONCAT(m1.surname, ' ', m1.firstname) as 'Член клуба',
       CONCAT(m2.surname, ' ', m2.firstname) as 'Кем был рекомендован'
  FROM members m1
    LEFT JOIN members m2 
      ON m1.recommendedby = m2.memid
  ORDER BY m1.firstname;
