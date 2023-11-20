/*
Добавьте еще одно spa с такими же характеристиками 
как в задании 1, сгенерировав новое ID.
*/

USE cd;

INSERT facilities(facid, facility, membercost, guestcost, initialoutlay, monthlymaintenance)
  SELECT 12, facility, membercost, guestcost, initialoutlay, monthlymaintenance 
  FROM facilities 
  WHERE facility LIKE 'spa';
