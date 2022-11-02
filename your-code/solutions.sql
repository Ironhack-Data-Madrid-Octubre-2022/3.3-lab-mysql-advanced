-- Challenge 1
-- Step 1
create temporary table publications.royalties_sales_author
select t.title_id, authors.au_id as 'author id', (t.price * s.qty * t.royalty / 100 * a.royaltyper / 100) as sales_royalty
from authors
inner join titleauthor as a
on authors.au_id = a.au_id
left join titles as t
on a.title_id = t.title_id
left join sales as s
on a.title_id = s.title_id
order by t.title_id;

-- Step 2
create temporary table publications.total_royalties
select roy_sa.title_id, `author id`, sum(sales_royalty) as total_roy
from publications.royalties_sales_author as roy_sa
group by `author id`, title_id
order by title_id;

-- Step 3
create temporary table publications.total_profits
select `author id`, sum(t.advance + tr.total_roy) as total_profit
from publications.total_royalties as tr
left join titles as t
on tr.title_id = t.title_id
group by `author id`
order by total_profit desc limit 3;

-- Challenge 2
-- Step 1:
select t.title_id, authors.au_id as 'author id', (t.price * s.qty * t.royalty / 100 * a.royaltyper / 100) as sales_royalty
from authors
inner join titleauthor as a
on authors.au_id = a.au_id
left join titles as t
on a.title_id = t.title_id
left join sales as s
on a.title_id = s.title_id
order by t.title_id;

-- Step 2:
select authors.au_id, s.title_id,
	SUM(t.price * s.qty * t.royalty / 100 * a.royaltyper / 100) as sales_royalty
from authors
left join titleauthor as a
on authors.au_id = a.au_id
left join titles as t
on a.title_id = t.title_id
inner join sales as s
on a.title_id = s.title_id
group by authors.au_id, s.title_id;

-- Step 3:
select authors.au_id,
    SUM(t.advance + (t.price * s.qty * t.royalty / 100 * t.royaltyper / 100)) as total_profits
from authors
left join titleauthor as a
on authors.au_id = a.au_id
left join titles as t
on a.title_id = t.title_id
inner join sales as s
on a.title_id = s.title_id
group by authors.au_id
order by total_profits desc
limit 3;

-- Challenge 3
create table most_profiting_authors
select `author id`, total_profit
from publications.total_profits as tp
group by `author id`
order by total_profit desc;
