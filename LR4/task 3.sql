/*
Добавьте еще одно spa с такими же характеристиками 
как в задании 1, сгенерировав новое ID.
*/

USE cd;

SELECT @maxid := MAX(facid)
  FROM facilities;

INSERT facilities(facid, facility, membercost, guestcost, initialoutlay, monthlymaintenance)
  VALUES (@maxid + 1, "spa", 20, 30, 100000, 800);
