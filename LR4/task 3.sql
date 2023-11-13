/*
Добавьте еще одно spa с такими же характеристиками 
как в задании 1, сгенерировав новое ID.
*/

USE cd;

INSERT facilities(facid, facility, membercost, guestcost, initialoutlay, monthlymaintenance)
  SELECT MAX(facid) + 1, "spa", 20, 30, 100000, 800
  FROM facilities;
