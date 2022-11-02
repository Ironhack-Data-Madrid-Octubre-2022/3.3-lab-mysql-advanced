-- CHALLENGE 1: Most Profiting Authors

-- Step 1 --

create table if not exists nt1
select sales.title_id,sales.qty,titles.price,titles.advance,titles.royalty,titles.ytd_sales,titleauthor.au_id,authors.au_lname,authors.au_fname, titles.title, titleauthor.royaltyper
from sales
left join titles on sales.title_id = titles.title_id
left join titleauthor on titleauthor.title_id = titles.title_id
left join authors on titleauthor.au_id = authors.au_id;

ALTER TABLE nt1
ADD sales_royalty int(20);


select * from nt1;

SET SQL_SAFE_UPDATES = 0;

update nt1
set sales_royalty = (price*qty*(royalty/100)*(royaltyper/100));

select title_id, au_id, sales_royalty from nt1;

-- Step 2 --

select title_id, au_id, sum(sales_royalty)
from nt1
group by title_id, au_id;

-- Step 3 --

select au_id, sum(sales_royalty + advance) as Profits
from nt1
group by au_id
order by Profits desc limit 3;

-- Challenge 2 - Alternative Solution

create temporary table nt2
select au_id, sum(sales_royalty + advance) as Profits
from nt1
group by au_id
order by Profits desc limit 3;

select * from nt2;


-- Challenge 3 


create table if not exists most_profiting_authors
select au_id, sum(sales_royalty + advance) as Profits
from nt1
group by au_id
order by Profits desc;

select * from most_profiting_authors;
