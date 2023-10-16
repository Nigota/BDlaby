-- Выбрать информацию о наименовании и стоимости его
-- использования для членов клуба (membercost) для всех 
-- зарегистрированных в базе объектах (facilities) клуба.

use cd;

select facility, membercost from facilities;
