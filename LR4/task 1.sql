-- Добавить новый объект (‘spa’), стоимость создания (initialoutlay) = 100000, 
-- стоимость обслуживания (monthlymaintenance) = 800, 
-- стоимость аренды гостем = 30, членом клуба = 20.

USE cd;

-- PRIMARY KEY без auto_increment, поэтому приходиться дополнительно создавать новый id
INSERT facilities(facid, facility, membercost, guestcost, initialoutlay, monthlymaintenance)
  SELECT MAX(facid) + 1, "spa", 20, 30, 100000, 800
  FROM facilities;
