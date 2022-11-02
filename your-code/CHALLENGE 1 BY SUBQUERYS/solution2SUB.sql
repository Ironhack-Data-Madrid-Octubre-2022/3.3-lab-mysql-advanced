SELECT JULS.title_id, JULS.au_id, SUM(sales_royalty) AS thesales FROM
(SELECT titleauthor.title_id, titleauthor.au_id, (titles.price * sales.qty * titles.royalty / 100) * (titleauthor.royaltyper / 100) AS sales_royalty
FROM authors 
INNER JOIN titleauthor ON titleauthor.au_id = authors.au_id
LEFT JOIN sales ON sales.title_id =titleauthor.title_id
LEFT JOIN titles ON titleauthor.title_id=titles.title_id) AS JULS
GROUP BY JULS.au_id, JULS.title_id
