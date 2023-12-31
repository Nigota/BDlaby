-- Объедините имена членов и названия объектов в обдну таблицу 
-- с одним столбцом.

USE cd;

SELECT DISTINCT CONCAT(firstname, ' ', surname) as 'Members and Facilities' FROM members WHERE firstname != 'GUEST' OR surname != 'GUEST'
UNION
SELECT DISTINCT facility FROM facilities;