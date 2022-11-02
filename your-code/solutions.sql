--CHALLENGE 1:
    --STEP 1:

select sales.title_id as 'TITLE ID', titleauthor.au_id as 'AUTHOR ID',
titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100 as sales_royalty
from titleauthor

left join sales
on titleauthor.title_id=sales.title_id

left join titles
on  titleauthor.title_id=titles.title_id
where qty is not null

    --STEP 2:

select sales.title_id as 'TITLE ID', titleauthor.au_id as 'AUTHOR ID',
(sum(titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100)) as sales_royalty
from titleauthor

left join sales
on titleauthor.title_id=sales.title_id

left join titles
on  titleauthor.title_id=titles.title_id
where qty is not null
group by titleauthor.au_id,titleauthor.title_id	

    --STEP 3:

select  titleauthor.au_id as 'AUTHOR ID',
advance + sum(titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100) as sales_royalty
from titleauthor

left join sales
on titleauthor.title_id=sales.title_id
left join titles
on titleauthor.title_id=titles.title_id

where qty is not null
GROUP BY titleauthor.au_id,titles.title_id
order by advance + sum(titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100) desc limit 3;


--segunda forma de hacerlo con subquery:
SELECT Author_ID, Sales_Royalty
FROM
(SELECT titles.title_id AS "Title_ID", a.au_id AS "Author_ID",
(advance + sum(titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100)) AS "Sales_Royalty"
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

 
--CHALLENGE 2:

create temporary table temporal1
select sales.title_id as 'TITLE_ID', titleauthor.au_id as 'AUTHOR_ID',
(titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100) as "sales_royalty"
from titleauthor

left join sales
on titleauthor.title_id=sales.title_id

left join titles
on  titleauthor.title_id=titles.title_id
where qty is not null;

----
create temporary table temporal2
select TITLE_ID, AUTHOR_ID,
sum(sales_royalty) as "total"
from temporal1

group by TITLE_ID,AUTHOR_ID;
----
create temporary table temporal32
select  'AUTHOR_ID',
advance + sum(total) as 'totales'
from temporal2

left join titles
on titles.title_id=temporal2.title_id


GROUP BY 'AUTHOR_ID',temporal2.title_id
order by 'totales' 
limit 3;

  
--CHALLENGE 3:

create  table most_profiting_authors
select  'AUTHOR_ID',
advance + sum(total) as 'totales'
from temporal2

left join titles
on titles.title_id=temporal2.title_id


GROUP BY 'AUTHOR_ID',temporal2.title_id
order by 'totales' 
limit 3;








