-- Выбрать объекты с ID равным 1 и 5.
USE cd;

SELECT facility FROM facilities WHERE facid IN (1, 5);
