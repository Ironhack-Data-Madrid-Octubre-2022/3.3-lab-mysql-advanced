#CHALLENGE 1: STEP 1

select t.title_id,ta.au_id,(t.price * s.qty * t.royalty / 100 * ta.royaltyper/100) as total_royalty
from titles as t
left join titleauthor as ta
on t.title_id=ta.title_id
left join sales as s
on ta.title_id=s.title_id;

#CHALLENGE 1: STEP 2

select ta.au_id,t.title_id,sum(t.price * s.qty * t.royalty / 100 * ta.royaltyper/100) as total_royalty
from titleauthor as ta
left join titles as t
on ta.title_id=t.title_id
left join sales as s
on ta.title_id=s.title_id
group by ta.au_id, t.title_id;

#CHALLENGE 1: STEP 3

select ta.au_id,sum((t.price * s.qty * t.royalty / 100 * ta.royaltyper/100)+t.advance) as total_profit
from titleauthor as ta
left join titles as t
on ta.title_id=t.title_id
left join sales as s
on ta.title_id=s.title_id
group by ta.au_id
order by total_profit desc limit 3;


#CHALLENGE 2: STEP 1

create temporary table step1
select t.title_id,ta.au_id,(t.price * s.qty * t.royalty / 100 * ta.royaltyper/100) as sales_royalty
from titles as t
left join titleauthor as ta
on t.title_id=ta.title_id
left join sales as s
on ta.title_id=s.title_id;

#CHALLENGE 2: STEP 2

create temporary table step2
select step1.au_id,step1.title_id,sum(step1.sales_royalty) as total_royalty
from step1
group by step1.au_id, step1.title_id;

#CHALLENGE 2: STEP 3

create temporary table step3
select step2.au_id,sum(step2.total_royalty+t.advance) as total_profit
from step2
left join titles as t
on step2.title_id=t.title_id
group by step2.au_id
order by total_profit desc limit 3;


#CHALLENGE 3: STEP 1

create table most_profiting_authors
select ta.au_id,sum((t.price * s.qty * t.royalty / 100 * ta.royaltyper/100)+t.advance) as total_profit
from titleauthor as ta
left join titles as t
on ta.title_id=t.title_id
left join sales as s
on ta.title_id=s.title_id
group by ta.au_id
order by total_profit desc limit 3;

select * from step3