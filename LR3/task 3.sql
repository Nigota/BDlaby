-- Выберите членов клуба, которые рекомендовали других членов для вступления

USE cd;

SELECT m1.surname, m1.firstname
FROM members m1
    JOIN members m2
WHERE m1.recommendedby = m2.memid;