-- Выбрать объекты, пользование которых платно для членов клуба

use cd;

select facility from facilities where membercost != 0;
