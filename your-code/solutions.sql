
GHALLENGE 1
select titles.title_id as 'TITLE_ID', a.au_id as 'AUTHOR_ID', 
(titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100) AS 'SALES_ROYALTY'
from authors as a

left join titleauthor
on a.au_id=titleauthor.au_id

left join titles 
on titleauthor.title_id=titles.title_id

left join sales
on titles.title_id=sales.title_id

where qty is not null;

------

select TITLE_ID, AUTHOR_ID, sum(SALES_ROYALTY) as "TOTAL"
from
(select titles.title_id as 'TITLE_ID', a.au_id as 'AUTHOR_ID', 
(titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100)AS 'SALES_ROYALTY'
from authors as a

left join titleauthor
on a.au_id=titleauthor.au_id

left join titles 
on titleauthor.title_id=titles.title_id

left join sales

on titles.title_id=sales.title_id

where qty is not null) SUB

group by TITLE_ID, AUTHOR_ID

----

select  AUTHOR_ID, sum(advance +SALES_ROYALTY) as prueba 
from
(select a.au_id as 'AUTHOR_ID', advance,
(titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100) AS 'SALES_ROYALTY'

from authors as a

left join titleauthor
on a.au_id=titleauthor.au_id

left join titles 
on titleauthor.title_id=titles.title_id

left join sales
on titles.title_id=sales.title_id
where qty is not null
group by AUTHOR_ID, titles.title_id
order by AUTHOR_ID DESC)AS SUB

group by AUTHOR_ID
order by prueba desc
limit 3;




CHALLENGE 2



create temporary table tempo1
select titles.title_id as 'TITLE_ID', a.au_id as 'AUTHOR_ID', 
(titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100) AS 'SALES_ROYALTY'
from authors as a

left join titleauthor
on a.au_id=titleauthor.au_id

left join titles 
on titleauthor.title_id=titles.title_id

left join sales
on titles.title_id=sales.title_id

where qty is not null;

----

create temporary table tempo2
select TITLE_ID, AUTHOR_ID, sum(SALES_ROYALTY) as "TOTAL"
from tempo1
group by TITLE_ID, AUTHOR_ID;

---
create temporary table tempo2_2
select  AUTHOR_ID, sum(advance +SALES_ROYALTY) as prueba 
from

(select a.au_id as 'AUTHOR_ID', advance,
(titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100) AS 'SALES_ROYALTY'

from authors as a

left join titleauthor
on a.au_id=titleauthor.au_id

left join titles 
on titleauthor.title_id=titles.title_id

left join sales
on titles.title_id=sales.title_id
where qty is not null
group by AUTHOR_ID, titles.title_id
order by AUTHOR_ID DESC)AS SUB

group by AUTHOR_ID
order by prueba desc;


select * from tempo2_2
limit 3;

CHALLENGE3

create table most_profiting_authors
select  AUTHOR_ID, sum(advance +SALES_ROYALTY) as prueba 
from
(select a.au_id as 'AUTHOR_ID', advance,
(titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100) AS 'SALES_ROYALTY'

from authors as a

left join titleauthor
on a.au_id=titleauthor.au_id

left join titles 
on titleauthor.title_id=titles.title_id

left join sales
on titles.title_id=sales.title_id
where qty is not null
group by AUTHOR_ID, titles.title_id
order by AUTHOR_ID DESC)AS SUB

group by AUTHOR_ID
order by prueba desc
limit 3;

