# Challenge 1

select au_id, sales_royalty 
from (select ta.title_id, ta.au_id, advance + sum(t.price * s.qty * t.royalty / 100 * ta.royaltyper / 100) as sales_royalty 
from titleauthor as ta
left join titles as t
on ta.title_id = t.title_id
left join sales as s
on t.title_id = s.title_id
group by ta.au_id, ta.title_id) subquery
order by sales_royalty desc
limit 3;

# Challenge 2

create temporary table temp_1
select  ta.title_id, au_id, advance + (t.price * s.qty * t.royalty / 100 * ta.royaltyper / 100) as sales_royalty
from titleauthor ta
left join titles t
on t.title_id = ta.title_id
left join sales s
on  s.title_id = t.title_id;

create temporary table temp_2
select title_id, au_id, sum(sales_royalty) as sales_royalty
from temp_1
group by title_id, au_id;

create temporary table temp_3
select au_id, advance + sum(sales_royalty) as sales_royalty
from temp_2 t2
left join titles t
on t.title_id = t2.title_id
group by au_id, t2.title_id
order by sales_royalty
limit 3;

# Challenge 3 

create table most_profitable_authors
select au_id, sales_royalty 
from (select ta.title_id, ta.au_id, advance + sum(t.price * s.qty * t.royalty / 100 * ta.royaltyper / 100) as sales_royalty 
from titleauthor as ta
left join titles as t
on ta.title_id = t.title_id
left join sales as s
on t.title_id = s.title_id
group by ta.au_id, ta.title_id) subquery
order by sales_royalty desc
limit 3;

