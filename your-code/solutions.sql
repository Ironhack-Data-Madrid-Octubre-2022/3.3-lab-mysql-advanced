-- Challenge 1:
-- step 1:
select authors.au_id, sales.title_id,
	titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100 as sales_royalty
from authors
left join titleauthor
on authors.au_id = titleauthor.au_id
left join titles
on titleauthor.title_id = titles.title_id
inner join sales
on titleauthor.title_id = sales.title_id;

-- step 2:
select authors.au_id, sales.title_id,
	SUM(titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100) as sales_royalty
from authors
left join titleauthor
on authors.au_id = titleauthor.au_id
left join titles
on titleauthor.title_id = titles.title_id
inner join sales
on titleauthor.title_id = sales.title_id
group by authors.au_id, sales.title_id;

-- step 3:
select authors.au_id,
    SUM(titles.advance + (titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100)) as total_profits
from authors
left join titleauthor
on authors.au_id = titleauthor.au_id
left join titles
on titleauthor.title_id = titles.title_id
inner join sales
on titleauthor.title_id = sales.title_id
group by authors.au_id
order by total_profits desc
limit 3;

-- Challenge 2:
-- step 1:
CREATE TEMPORARY TABLE step_1
select authors.au_id, sales.title_id,
	titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100 as sales_royalty
from authors
left join titleauthor
on authors.au_id = titleauthor.au_id
left join titles
on titleauthor.title_id = titles.title_id
inner join sales
on titleauthor.title_id = sales.title_id;

-- step 2:
CREATE TEMPORARY TABLE step_2
select authors.au_id, sales.title_id,
	SUM(titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100) as sales_royalty
from authors
left join titleauthor
on authors.au_id = titleauthor.au_id
left join titles
on titleauthor.title_id = titles.title_id
inner join sales
on titleauthor.title_id = sales.title_id
group by authors.au_id, sales.title_id;

-- step 3:
CREATE TEMPORARY TABLE step_3
select authors.au_id,
    SUM(titles.advance + (titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100)) as total_profits
from authors
left join titleauthor
on authors.au_id = titleauthor.au_id
left join titles
on titleauthor.title_id = titles.title_id
inner join sales
on titleauthor.title_id = sales.title_id
group by authors.au_id
order by total_profits desc
limit 3;

-- Challenge 3:
CREATE TABLE most_profiting_authors
select authors.au_id,
    SUM(titles.advance + (titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100)) as total_profits
from authors
left join titleauthor
on authors.au_id = titleauthor.au_id
left join titles
on titleauthor.title_id = titles.title_id
inner join sales
on titleauthor.title_id = sales.title_id
group by authors.au_id
order by total_profits desc
limit 3;