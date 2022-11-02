-----------Challenge 1 - Most Profiting Authors--------------------


******Step 1: Calculate the royalties of each sales for each author*******

create temporary table publications.sales_royalties

SELECT a.au_id, t.title_id, t.price*s.qty*t.royalty/100*ta.royaltyper/100 as sales_royalty
FROM authors as a INNER JOIN titleauthor as ta ON ta.au_id = a.au_id
INNER JOIN titles as t ON ta.title_id = t.title_id 
INNER JOIN  SALES s ON ta.title_id = s.title_id



*******Step 2: Aggregate the total royalties for each title for each author******

create temporary table publications.title_royalties

SELECT z.au_id, z.title_id, SUM(z.sales_royalty) as title_royalty
FROM
sales_royalties as z
GROUP BY z.au_id, z.title_id


*********Step 3: Calculate the total profits of each author**************

create temporary table publications.title_profits

SELECT r.*, t.advance, r.title_royalty + t.advance as profits
FROM  title_royalties as r 
LEFT JOIN titles as t ON r.title_id = t.title_id


SELECT au_id,  SUM(profits) as total_profits
FROM title_profits
GROUP BY au_id
ORDER BY total_profits DESC
LIMIT 3


---------Challenge 2 - Alternative Solution------------------------


SELECT tp.au_id,  SUM(tp.profits) as total_profits
FROM (SELECT r.*, t.advance, r.title_royalty + t.advance as profits
FROM  (SELECT z.au_id, z.title_id, SUM(z.sales_royalty) as title_royalty
FROM (SELECT a.au_id, t.title_id, t.price*s.qty*t.royalty/100*ta.royaltyper/100 as sales_royalty
FROM authors as a INNER JOIN titleauthor as ta ON ta.au_id = a.au_id
INNER JOIN titles as t ON ta.title_id = t.title_id 
INNER JOIN  SALES s ON ta.title_id = s.title_id) as z
GROUP BY z.au_id, z.title_id) as r 
LEFT JOIN titles as t ON r.title_id = t.title_id) as tp
GROUP BY tp.au_id
ORDER BY total_profits DESC
LIMIT 3



-----------Challenge 3--------------------

create  table publications.most_profiting_authors

SELECT tp.au_id,  SUM(tp.profits) as total_profits
FROM (SELECT r.*, t.advance, r.title_royalty + t.advance as profits
FROM  (SELECT z.au_id, z.title_id, SUM(z.sales_royalty) as title_royalty
FROM (SELECT a.au_id, t.title_id, t.price*s.qty*t.royalty/100*ta.royaltyper/100 as sales_royalty
FROM authors as a INNER JOIN titleauthor as ta ON ta.au_id = a.au_id
INNER JOIN titles as t ON ta.title_id = t.title_id 
INNER JOIN  SALES s ON ta.title_id = s.title_id) as z
GROUP BY z.au_id, z.title_id) as r 
LEFT JOIN titles as t ON r.title_id = t.title_id) as tp
GROUP BY tp.au_id
ORDER BY total_profits DESC
LIMIT 3