select t.title_id, ta.au_id, (t.price * s.qty * t.royalty / 100 * ta.royaltyper / 100 )as sales_royalty

from titles as t

left join titleauthor as ta
on t.title_id=ta.title_id


left join sales as s
on  ta.title_id=s.title_id;

---
select t.title_id, ta.au_id, sum(t.price * s.qty * t.royalty / 100 * ta.royaltyper / 100 )as sales_royalty

from titles as t

left join titleauthor as ta
on t.title_id=ta.title_id

left join sales as s
on ta.title_id=s.title_id

group by t.title_id, ta.au_id

--
select authors.au_id,
    SUM(t.advance + (t.price * s.qty * t.royalty / 100 * a.royaltyper / 100)) as total_profits
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

---
Create temporary table forstep2
select t.title_id, ta.au_id, (t.price * s.qty * t.royalty / 100 * ta.royaltyper / 100 )as sales_royalty

from titles as t

left join titleauthor as ta
on t.title_id=ta.title_id


left join sales as s
on  ta.title_id=s.title_id;
---
