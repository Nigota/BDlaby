/*
1. Текущее количество пациентов=-мужчин  и пациентов-женщин.
2. Лечащиеся пациенты определенного отделения, например, Хирургии.
3. Количество мест (отделение, общее кол-во мест (муж), общее кол-во мест (жен) , свободн.места (муж), свободные места (жен).

*/

USE Hospital;

-- Текущее количество пациентов=-мужчин  и пациентов-женщин
CREATE OR REPLACE VIEW cnt AS
  SELECT IF(gender = 0, 'Мужчин', 'Женщин') AS 'Пол', COUNT(*) AS 'Количество'
    FROM patient
    WHERE endTime IS NULL
    GROUP BY gender;

SELECT * FROM cnt;


-- Лечащиеся пациенты определенного отделения, например, Хирургии
CREATE OR REPLACE VIEW cnt_patient AS
  SELECT p.fullName, r.department
    FROM patient as p
      JOIN room as r ON r.roomID = p.roomID
    WHERE endTime IS NULL
    ORDER BY r.department;

SELECT * FROM cnt_patient;

-- Количество мест (отделение, общее кол-во мест (муж), 
-- общее кол-во мест (жен) , свободн.места (муж), свободные места (жен).
CREATE OR REPLACE VIEW man AS
  SELECT department AS 'Отделение', gender AS 'Пол', 
    SUM(bedCnt) AS 'Общее кол-во мест (по полу)',
    SUM(bedCnt) - SUM(bedOccupiedCnt) AS 'Свободн. мест (по полу)'
  FROM room
  GROUP BY department, gender 
  ORDER BY department;

SELECT * FROM man;