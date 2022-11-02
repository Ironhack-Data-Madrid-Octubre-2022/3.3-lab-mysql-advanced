CREATE TEMPORARY TABLE FORSTEP33
SELECT title_id, au_id, SUM(sales_royalty) AS thesales FROM FORSTEP22
GROUP BY au_id, title_id