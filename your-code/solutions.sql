-- Challenge 1
-- Step 1

select a.au_id, t.title_id, (t.price * s.qty * (t.royalty / 100) * (ta.royaltyper / 100)) as sales_royalty
from authors as a
inner join titleauthor as ta
on a.au_id = ta.au_id
inner join titles as t
on ta.title_id = t.title_id
inner join sales as s
on t.title_id = s.title_id;

-- Step 2

select au_id, title_id, sum(sales_royalty) as sales_royalty
from
(select a.au_id, t.title_id, (t.price * s.qty * (t.royalty / 100) * (ta.royaltyper / 100)) as sales_royalty
from authors as a
inner join titleauthor as ta
on a.au_id = ta.au_id
inner join titles as t
on ta.title_id = t.title_id
inner join sales as s
on t.title_id = s.title_id) query1
group by au_id, title_id;

-- Step 3

select au_id, sales_royalty + advance/count(title_id) as profit
from
(select au_id, title_id, sum(sales_royalty) as sales_royalty, advance
from
(select a.au_id, t.title_id, (t.price * s.qty * (t.royalty / 100) * (ta.royaltyper / 100)) as sales_royalty, advance
from authors as a
inner join titleauthor as ta
on a.au_id = ta.au_id
inner join titles as t
on ta.title_id = t.title_id
inner join sales as s
on t.title_id = s.title_id) query1
group by au_id, title_id) query2
group by au_id
order by profit desc
limit 3;

-- Challenge 2

create temporary table temp1
select a.au_id, t.title_id, (t.price * s.qty * (t.royalty / 100) * (ta.royaltyper / 100)) as sales_royalty, advance
from authors as a
inner join titleauthor as ta
on a.au_id = ta.au_id
inner join titles as t
on ta.title_id = t.title_id
inner join sales as s
on t.title_id = s.title_id;

create temporary table temp2
select au_id, title_id, sum(sales_royalty) as sales_royalty, advance
from
(select a.au_id, t.title_id, (t.price * s.qty * (t.royalty / 100) * (ta.royaltyper / 100)) as sales_royalty, advance
from authors as a
inner join titleauthor as ta
on a.au_id = ta.au_id
inner join titles as t
on ta.title_id = t.title_id
inner join sales as s
on t.title_id = s.title_id) query1
group by au_id, title_id;

create temporary table temp2
select au_id, sales_royalty + advance/count(title_id) as profit
from
(select au_id, title_id, sum(sales_royalty) as sales_royalty, advance
from
(select a.au_id, t.title_id, (t.price * s.qty * (t.royalty / 100) * (ta.royaltyper / 100)) as sales_royalty, advance
from authors as a
inner join titleauthor as ta
on a.au_id = ta.au_id
inner join titles as t
on ta.title_id = t.title_id
inner join sales as s
on t.title_id = s.title_id) query1
group by au_id, title_id) query2
group by au_id
order by profit desc
limit 3;

-- Challenge 3

create table most_profiting_authors
select * from temp3