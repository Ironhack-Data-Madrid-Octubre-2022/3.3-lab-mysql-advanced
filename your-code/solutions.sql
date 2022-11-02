CHALLENGE 1

- Step 1:

SELECT titles.title_id AS "Title_ID", a.au_id AS "Author_ID", 
(titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100) AS "Sales_Royalty"

FROM authors AS a

LEFT JOIN titleauthor 
ON a.au_id=titleauthor.au_id

LEFT JOIN titles
ON titleauthor.title_id=titles.title_id

LEFT JOIN sales 
ON titles.title_id=sales.title_id

WHERE qty IS NOT NULL;

- Step 2

SELECT Title_ID, Author_ID, sum(Sales_Royalty) AS "TOTAL"

FROM

(SELECT titles.title_id AS "Title_ID", a.au_id AS "Author_ID", 
(titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100) AS "Sales_Royalty"

FROM authors AS a

LEFT JOIN titleauthor 
ON a.au_id=titleauthor.au_id

LEFT JOIN titles
ON titleauthor.title_id=titles.title_id

LEFT JOIN sales 
ON titles.title_id=sales.title_id

WHERE qty IS NOT NULL) royalties 

GROUP BY Title_ID, Author_ID;

- Step 3



SELECT au_id, sum(advance + sales_royalty) AS "profit"
FROM

(SELECT a.au_id,
 advance, 
 t.price * s.qty * t.royalty / 100 * ta.royaltyper / 100 AS "sales_royalty"
FROM titles AS t

LEFT JOIN titleauthor AS ta
ON ta.title_id=t.title_id

LEFT JOIN authors AS a
ON a.au_id=ta.au_id

LEFT JOIN sales AS s
ON t.title_id=s.title_id
WHERE t.price IS NOT NULL

GROUP BY a.au_id,t.title_id

ORDER BY a.au_id DESC) AS ADELANTO

GROUP BY au_id

ORDER BY profit DESC

LIMIT 3;


CHALLENGE 2

- Step 1

CREATE TEMPORARY TABLE temp1

SELECT titles.title_id AS "Title_ID", a.au_id AS "Author_ID", 
(titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100) AS "Sales_Royalty"

FROM authors AS a

LEFT JOIN titleauthor 
ON a.au_id=titleauthor.au_id

LEFT JOIN titles
ON titleauthor.title_id=titles.title_id

LEFT JOIN sales 
ON titles.title_id=sales.title_id

WHERE qty IS NOT NULL;

- Step 2

CREATE TEMPORARY TABLE temp2

SELECT Title_ID, Author_ID, sum(Sales_Royalty) AS "TOTAL"

FROM temp1

GROUP BY Title_ID,Author_ID;

- Step 3

CREATE TEMPORARY TABLE ADELANTO
SELECT a.au_id,
 advance, 
 t.price * s.qty * t.royalty / 100 * ta.royaltyper / 100 as "sales_royalty"
FROM titles AS t

LEFT JOIN titleauthor AS ta
ON ta.title_id=t.title_id

LEFT JOIN authors AS a
ON a.au_id=ta.au_id

LEFT JOIN sales AS s
ON t.title_id=s.title_id

WHERE t.price IS NOT NULL

GROUP BY a.au_id,t.title_id

ORDER BY a.au_id DESC;

SELECT au_id, sum(advance + sales_royalty) AS "profit"
FROM ADELANTO

GROUP BY au_id

ORDER BY profit DESC

LIMIT 3;

CHALLENGE 3

CREATE TABLE most_profiting_authors

SELECT au_id, sum(advance + sales_royalty) AS "profit"
FROM

(SELECT a.au_id,
 advance, 
 t.price * s.qty * t.royalty / 100 * ta.royaltyper / 100 AS "sales_royalty"
FROM titles AS t

LEFT JOIN titleauthor AS ta
ON ta.title_id=t.title_id

LEFT JOIN authors AS a
ON a.au_id=ta.au_id

LEFT JOIN sales AS s
ON t.title_id=s.title_id
WHERE t.price IS NOT NULL

GROUP BY a.au_id,t.title_id

ORDER BY a.au_id DESC) AS ADELANTO

GROUP BY au_id

ORDER BY profit DESC

LIMIT 3;






