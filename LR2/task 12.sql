--  Найдите дату последней регистрации члена клуба.

USE cd;

SELECT joindate FROM members ORDER BY joindate DESC LIMIT 1
