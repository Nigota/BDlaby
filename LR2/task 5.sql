-- Выбрать объекты, которые платны для членов клуба, но стоимость 
-- использование не превышает 1/50 от стоимость месячного обслуживания 
-- (monthlymaintenance).

use cd;

select facility from facilities where membercost != 0 and membercost < 1 / 50 * monthlymaintenance;
