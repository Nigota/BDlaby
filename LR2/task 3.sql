--  Выбрать объекты, пользование которых бесплатно для членов клуба.

use cd;

select facility from facilities where membercost = 0;
