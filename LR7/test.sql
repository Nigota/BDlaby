USE cd;


SELECT facility, IF(SUM(p.payment) IS NULL, 0, SUM(p.payment)) AS income
      FROM payments AS p
        JOIN bookings AS b ON b.bookid = p.bookid
        JOIN facilities AS f ON b.facid = f.facid
      WHERE b.starttime <= "2012-07-5-23:59:59"
      GROUP BY facility;

SELECT * FROM facilities;
