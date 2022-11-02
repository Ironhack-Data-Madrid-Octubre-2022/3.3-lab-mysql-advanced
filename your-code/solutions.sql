Select titles.title_id, authors.au_id, (titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100) as sales_royalty
from authors
inner join titleauthor 
on authors.au_id = titleauthor.au_id
inner join titles
on titleauthor.title_id = titles.title_id
inner join sales
on titleauthor.title_id = sales.title_id


select title_id, au_id, sum(sales_royalty) as sales_royalty1
from (Select titles.title_id, authors.au_id, (titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100) as sales_royalty
from authors
inner join titleauthor on authors.au_id = titleauthor.au_id
inner join titles on titleauthor.title_id = titles.title_id
inner join sales on titleauthor.title_id = sales.title_id) query2
group by au_id, title_id

select au_id, advance + sales_royalty1 as profit
from (select title_id, au_id, advance, sum(sales_royalty) as sales_royalty1
from (Select titles.title_id, authors.au_id, advance, (titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100) as sales_royalty
from authors
inner join titleauthor on authors.au_id = titleauthor.au_id
inner join titles on titleauthor.title_id = titles.title_id
inner join sales on titleauthor.title_id = sales.title_id) query2
group by au_id, title_id) query3
group by title_id order by profit desc limit 3

create temporary table publications.paso1
Select titles.title_id, authors.au_id, (titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100) as sales_royalty
from authors
inner join titleauthor 
on authors.au_id = titleauthor.au_id
inner join titles
on titleauthor.title_id = titles.title_id
inner join sales
on titleauthor.title_id = sales.title_id

create temporary table publications.paso2
select title_id, au_id, sum(sales_royalty) as sales_royalty1
from (Select titles.title_id, authors.au_id, (titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100) as sales_royalty
from authors
inner join titleauthor on authors.au_id = titleauthor.au_id
inner join titles on titleauthor.title_id = titles.title_id
inner join sales on titleauthor.title_id = sales.title_id) query2
group by au_id, title_id

create temporary table publications.paso3
select au_id, advance + sales_royalty1 as profit
from (select title_id, au_id, advance, sum(sales_royalty) as sales_royalty1
from (Select titles.title_id, authors.au_id, advance, (titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100) as sales_royalty
from authors
inner join titleauthor on authors.au_id = titleauthor.au_id
inner join titles on titleauthor.title_id = titles.title_id
inner join sales on titleauthor.title_id = sales.title_id) query2
group by au_id, title_id) query3
group by title_id order by profit desc limit 3

Create table if not exists most_profiting_authors
select au_id, advance + sales_royalty1 as profit
from (select title_id, au_id, advance, sum(sales_royalty) as sales_royalty1
from (Select titles.title_id, authors.au_id, advance, (titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100) as sales_royalty
from authors
inner join titleauthor on authors.au_id = titleauthor.au_id
inner join titles on titleauthor.title_id = titles.title_id
inner join sales on titleauthor.title_id = sales.title_id) query2
group by au_id, title_id) query3
group by title_id order by profit desc limit 3