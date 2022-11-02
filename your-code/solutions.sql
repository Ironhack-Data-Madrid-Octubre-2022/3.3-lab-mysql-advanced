-- Challenge 1 - Most Profiting Authors
-- Step 1: Calculate the royalties of each sales for each author

create table if not exists tabla
select titleauthor.title_id as Title_ID, titleauthor.au_id as Author_ID,
(titles.price * sales.qty * titles.royalty / 100 * (titleauthor.royaltyper / 100) as Total_Royality
from authors
inner join titleauthor
on authors.au_id = titleauthor.au_id
inner join titles
on titleauthor.title_id = titles.title_id 
inner join sales
on titles.title_id = sales.title_id;


-- Step 2: Aggregate the total royalties for each title for each author

create table if not exists tabla1
select Title_ID, Author_ID, sum(Total_Royality) as Royalities
from tabla
group by Author_ID, Title_ID
order by Title_ID desc;

-- Step 3: Calculate the total profits of each author

create table if not exists tabla2
select Author_ID, sum(titles.advance + Royalities) as Profits
from tabla1
inner join titles
on tabla1.Title_ID = titles.title_id
group by tabla1.Author_ID
order by Profits  desc limit 3;
select * from tabla2;

-- Challenge 2 - Alternative Solution

create temporary table if not exists tabla3
select Author_ID, sum(titles.advance + Royalities) as Profits
from tabla1
inner join titles
on tabla1.Title_ID = titles.title_id
group by tabla1.Author_ID
order by Profits  desc limit 3;
select * from tabla3;

-- Challenge 3

create table if not exists most_profiting_authors
select Author_ID, Profits
from tabla2;

select * from most_profiting_authors;








