create temporary table if not exists Profit_per_book
SELECT ta.au_id as AUTHOR_ID, au.au_lname as LAST_NAME, au.au_fname as FIRST_NAME, ta.title_id,t.price, t.advance,  t.royalty, sum(s.qty),ta.royaltyper, (t.advance+(t.price*t.royalty*0.01*ta.royaltyper*0.01)*sum(s.qty)) as Profit_per_book

from authors as au
left join titleauthor as ta
on au.au_id = ta.au_id
left join titles as t
on ta.title_id = t.title_id
left join sales as s
on t.title_id = s.title_id
GROUP BY AUTHOR_ID, ta.title_id;

create table most_profiting_authors
SELECT AUTHOR_ID, LAST_NAME, FIRST_NAME, sum(Profit_per_book) as total_profit
from profit_per_book
GROUP BY AUTHOR_ID
order by total_profit DESC
limit 3;

drop temporary table Profit_per_book;

