select a.au_id, t.title_id, (t.price * s.qty * (t.royalty / 100) * (ta.royaltyper / 100)) as sales_royalty
from authors as a
inner join titleauthor as ta
on a.au_id = ta.au_id
inner join titles as t
on ta.title_id = t.title_id
inner join sales as s
on t.title_id = s.title_id;
;