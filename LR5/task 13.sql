/*Создайте монотонно увеличивающийся нумерованный список участников (включая гостей), 
упорядоченный по дате присоединения. 
Помните, что идентификаторы участников не обязательно будут последовательными.
Используйте функцию нумерации row_number.*/

USE cd;

SELECT ROW_NUMBER() OVER (ORDER BY joindate) AS number, memid,
       firstname, surname, joindate
  FROM members
  ORDER BY joindate;