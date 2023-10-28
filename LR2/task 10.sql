-- Выбрать всех членов клуба, зарегистрированных с сентября 2012 
-- года.

USE cd;

SELECT DISTINCT surname FROM cd.members ORDER BY surname LIMIT 10;
