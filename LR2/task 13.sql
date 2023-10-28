-- Выберите имя, фамилию и дату вступления в клуб последних из 
-- всех вступивших.

USE cd;

SELECT surname, firstname, joindate FROM members ORDER BY joindate DESC LIMIT 1
