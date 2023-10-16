-- Выбрать объекты с ID равным 1 и 5.
use cd;

select facility from facilities where facid IN (1, 5);
