/*Рассчитайте количество зарегистрированных объектов в теннисном клубе,
стоимость аренды гостя в котором не менее 10.*/

USE cd;

SELECT COUNT(facid) as 'Количество зарегистрированных объектов' 
  FROM facilities 
  WHERE guestcost >= 10;