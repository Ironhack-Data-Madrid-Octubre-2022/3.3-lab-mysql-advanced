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

