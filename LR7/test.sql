/*
1. Создайте таблицу payments со структурой (payid INT PK, FK on booking.bookid; payment  DECIMAL. 
2. Добавьте в таблицу bookings поле payed, смысл которого оплачена или не оплачена аренда. 
3. Создайте триггеры, которые запрещают удаление записей, если они уже оплачены;
4. После отметки оплаты, заносят в таблицу  payments запись с соответствующим
значением PK и суммой оплаты,  для вычисления которой используется функция созданная в Task-7-1.
При отмене оплаты - удаляет соответствующую запись в таблице payments.    
5. Напишите скрипт, который отмечает, что все аренды июля 2012 года оплачены.
Посчитайте (написав соответствующий скрипт) оплату на июль 2012 года двумя способами: 
используя данные таблицы payments
используя только функцию из Task-7-1 и данные таблицы bookings.
		Сравните результаты расчета.
*/

USE cd;

DELIMITER //

-- Триггер на изменение статуса оплаты
DROP TRIGGER IF EXISTS not_delete_if_false //

DROP TRIGGER IF EXISTS on_pay_status //
CREATE TRIGGER on_pay_status
  AFTER UPDATE ON bookings FOR EACH ROW
  BEGIN
    CASE
      WHEN NEW.payed = OLD.payed THEN BEGIN END;
      WHEN NEW.payed = 1
        THEN INSERT INTO payments(bookid, payment) VALUES
              (NEW.bookid, cost_of(NEW.memid, NEW.facid, NEW.slots));
      ELSE DELETE FROM payments WHERE payments.bookid = NEW.bookid;
    END CASE;
  END //

-- Триггер на добавление новой записи в букинг, если оно сразу оплачено
DROP TRIGGER IF EXISTS on_insert //
CREATE TRIGGER on_insert
  AFTER INSERT ON bookings FOR EACH ROW
  BEGIN
    CASE
      WHEN NEW.payed = 1
        THEN INSERT INTO payments(bookid, payment) VALUES
              (NEW.bookid, cost_of(NEW.memid, NEW.facid, NEW.slots));
      ELSE BEGIN END;
    END CASE;
  END //

DELIMITER ;


-- Подсчет суммы
SELECT SUM(payment) FROM payments;
SELECT SUM(cost_of(memid, facid, slots))
  FROM bookings
  WHERE DATE(starttime) < '2012-08-01' AND DATE(starttime) >= '2012-07-01';