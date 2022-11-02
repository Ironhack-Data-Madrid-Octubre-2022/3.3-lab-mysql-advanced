CHALLENGE 1:

SELECT Author_ID, Sales_Royalty
FROM
(SELECT titles.title_id AS 'Title_ID', a.au_id AS 'Author_ID',
(advance + sum(titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100)) AS 'Sales_Royalty'
FROM authors AS a
LEFT JOIN titleauthor
ON a.au_id=titleauthor.au_id
LEFT JOIN titles
ON titleauthor.title_id=titles.title_id
LEFT JOIN sales
ON titles.title_id=sales.title_id
WHERE qty IS NOT NULL
GROUP BY Title_ID, Author_ID) royalties
ORDER BY Sales_Royalty DESC
LIMIT 3;

CHALLENGE 2:

CREATE TEMPORARY TABLE TEMP_1
SELECT  ta.title_id, au_id, advance + (t.price * s.qty * t.royalty / 100 * ta.royaltyper / 100) 'SALES_ROYALTY'
FROM titleauthor ta
LEFT JOIN titles t
ON t.title_id = ta.title_id
LEFT JOIN sales s
ON s.title_id = t.title_id
WHERE qty IS NOT NULL
;
CREATE TEMPORARY TABLE TEMP_2
SELECT title_id, au_id, SUM(SALES_ROYALTY) 'SALES_ROYALTY'
FROM TEMP_1
GROUP BY title_id, au_id
;
CREATE TEMPORARY TABLE TEMP_3
SELECT au_id, advance + SUM(SALES_ROYALTY) 'SALES_ROYALTY'
FROM TEMP_2 t2
LEFT JOIN titles t
ON t.title_id = t2.title_id
GROUP BY au_id, t2.title_id
ORDER BY 'SALES_ROYALTY'
LIMIT 3
;


CHALLENGE 3:

CREATE TABLE most_profiting_authors
SELECT Author_ID, PROFIT
FROM
(SELECT titles.title_id AS 'Title_ID', a.au_id AS 'Author_ID',
(advance + sum(titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100)) AS 'PROFIT'
FROM authors AS a
LEFT JOIN titleauthor
ON a.au_id=titleauthor.au_id
LEFT JOIN titles
ON titleauthor.title_id=titles.title_id
LEFT JOIN sales
ON titles.title_id=sales.title_id
WHERE qty IS NOT NULL
GROUP BY Title_ID, Author_ID) royalties
ORDER BY PROFIT DESC
LIMIT 3;