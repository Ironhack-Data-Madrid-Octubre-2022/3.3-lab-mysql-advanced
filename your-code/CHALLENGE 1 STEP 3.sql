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