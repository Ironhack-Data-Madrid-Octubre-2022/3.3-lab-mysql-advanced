-- CHALLENGE 1.1
create temporary table if not exists STEPUNO
select t.title_id as Title_ID, au.au_id as Author_ID,
t.price * s.qty * t.royalty / 100 * (ta.royaltyper / 100) as Total_Royalties
from authors as au
inner join titleauthor as ta
on au.au_id = ta.au_id
inner join titles as t
on ta.title_id = t.title_id 
inner join sales as s
on t.title_id = s.title_id;

-- CHALLENGE 1.2
create temporary table if not exists STEPDOS
select Title_ID, Author_ID, sum(Total_Royalties) as Royalities from STEPUNO
group by Author_ID, Title_ID
order by Title_ID desc;

-- CHALLENG3 1.3
select Author_ID, sum(t.advance + Royalities) as Profits
from STEPDOS

inner join titles as t 
on t.title_id = STEPDOS.Title_ID 
group by STEPDOS.Author_ID
order by Profits  
desc limit 3;


-- CHALLENGE 2

select t.title_id as Title_ID, au.au_id as Author_ID,
t.price * s.qty * t.royalty / 100 * (ta.royaltyper / 100) as Total_Royalties
from authors as au
inner join titleauthor as ta
on au.au_id = ta.au_id
inner join titles as t
on ta.title_id = t.title_id 
inner join sales as s
on t.title_id = s.title_id;


select s1.Title_ID, s1.Author_ID, sum(Total_Royalties) as Royalities 
from 
(select t.title_id as Title_ID, au.au_id as Author_ID,
t.price * s.qty * t.royalty / 100 * (ta.royaltyper / 100) as Total_Royalties
from authors as au
inner join titleauthor as ta
on au.au_id = ta.au_id
inner join titles as t
on ta.title_id = t.title_id 
inner join sales as s
on t.title_id = s.title_id) as s1
group by s1.Author_ID, s1.Title_ID
order by s1.Title_ID desc;


select s2.Author_ID, sum(t.advance + s2.Royalities) as Profits
from
(select s1.Title_ID, s1.Author_ID, sum(Total_Royalties) as Royalities 
from 
(select t.title_id as Title_ID, au.au_id as Author_ID,
t.price * s.qty * t.royalty / 100 * (ta.royaltyper / 100) as Total_Royalties
from authors as au
inner join titleauthor as ta
on au.au_id = ta.au_id
inner join titles as t
on ta.title_id = t.title_id 
inner join sales as s
on t.title_id = s.title_id) as s1
group by s1.Author_ID, s1.Title_ID
order by s1.Title_ID desc) as s2

inner join titles as t 
on s2.title_id = t.Title_ID 
group by s2.Author_ID
order by Profits desc  
limit 3;

-- CHALLENGE 3 

CREATE TABLE IF NOT EXISTS most_profiting_authors

select t.title_id as Title_ID, au.au_id as Author_ID,
t.price * s.qty * t.royalty / 100 * (ta.royaltyper / 100) as Total_Royalties
from authors as au
inner join titleauthor as ta
on au.au_id = ta.au_id
inner join titles as t
on ta.title_id = t.title_id 
inner join sales as s
on t.title_id = s.title_id;


select s1.Title_ID, s1.Author_ID, sum(Total_Royalties) as Royalities 
from 
(select t.title_id as Title_ID, au.au_id as Author_ID,
t.price * s.qty * t.royalty / 100 * (ta.royaltyper / 100) as Total_Royalties
from authors as au
inner join titleauthor as ta
on au.au_id = ta.au_id
inner join titles as t
on ta.title_id = t.title_id 
inner join sales as s
on t.title_id = s.title_id) as s1
group by s1.Author_ID, s1.Title_ID
order by s1.Title_ID desc;


select s2.Author_ID, sum(t.advance + s2.Royalities) as Profits
from
(select s1.Title_ID, s1.Author_ID, sum(Total_Royalties) as Royalities 
from 
(select t.title_id as Title_ID, au.au_id as Author_ID,
t.price * s.qty * t.royalty / 100 * (ta.royaltyper / 100) as Total_Royalties
from authors as au
inner join titleauthor as ta
on au.au_id = ta.au_id
inner join titles as t
on ta.title_id = t.title_id 
inner join sales as s
on t.title_id = s.title_id) as s1
group by s1.Author_ID, s1.Title_ID
order by s1.Title_ID desc) as s2

inner join titles as t 
on s2.title_id = t.Title_ID 
group by s2.Author_ID
order by Profits desc  
limit 3;

