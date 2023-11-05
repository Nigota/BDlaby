--  Найдите дату последней регистрации члена клуба.

USE cd;

SELECT MAX(joindate) AS 'Последняя регистарция' FROM members;
