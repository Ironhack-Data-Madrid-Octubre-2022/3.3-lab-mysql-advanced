CREATE TABLE most_profiting_authors
SELECT au_id, SUM(thesales + titles.advance) AS SUMA FROM FORSTEP33
LEFT JOIN titles ON FORSTEP33.title_id=titles.title_id
GROUP BY au_id
ORDER BY SUMA DESC
LIMIT 3