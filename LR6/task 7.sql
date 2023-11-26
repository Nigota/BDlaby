/*Подсчитайте количество участников, чья фамилия 
начинается на определенную букву, отсортировав по буквам в порядке убывания. */

USE cd;

SELECT COUNT(*) AS 'cnt_of_people',
    LEFT(surname, 1) AS first_letter
  FROM members
  GROUP BY first_letter
  ORDER BY first_letter DESC;