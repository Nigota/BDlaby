-- Выбрать информацию о наименовании и стоимости его
-- использования для членов клуба (membercost) для всех 
-- зарегистрированных в базе объектах (facilities) клуба.

USE cd;

SELECT facility, membercost FROM facilities;
