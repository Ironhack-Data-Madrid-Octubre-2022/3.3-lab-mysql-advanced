-- Challenge 1

create temporary table publications.royalties
select t.title_id as "Title ID" , ta.au_id as "Author ID" , (t.price * s.qty * t.royalty / 100 * ta.royaltyper / 100) as Royalty
from titles as t
inner join titleauthor as ta
on t.title_id = ta.title_id
left join sales as s
on t.title_id = s.title_id;

create temporary table title_royaltysum
select `Title ID` , `Author ID`  , sum(Royalty) as tot_roy
from publications.royalties
group by  `Title ID` , `Author ID`
order by `Title ID` ;

select `Author ID`, sum(tr.`Royalty` + t.advance) as sum
from title_royaltysum as tr
left join titles as t
on `Title ID` = t.title_id
group by `Author ID`
order by sum desc limit 3;


-- Challenge 2
select authors.au_id, sales.title_id, titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100 as sales_royalty
from authors
left join titleauthor
on authors.au_id = titleauthor.au_id
left join titles
on titleauthor.title_id = titles.title_id
inner join sales
on titleauthor.title_id = sales.title_id;

select authors.au_id, sales.title_id,
	SUM(titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100) as sales_royalty
from authors
left join titleauthor
on authors.au_id = titleauthor.au_id
left join titles
on titleauthor.title_id = titles.title_id
inner join sales
on titleauthor.title_id = sales.title_id
group by authors.au_id, sales.title_id;

select authors.au_id,
    SUM(titles.advance + (titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100)) as total_profits
from authors
left join titleauthor
on authors.au_id = titleauthor.au_id
left join titles
on titleauthor.title_id = titles.title_id
inner join sales
on titleauthor.title_id = sales.title_id
group by authors.au_id
order by total_profits desc limit 3;



-- Challenge 3
create table if not exists most_profiting_authors
select `Author ID`, sum(tr.`Royalty` + t.advance) as sum
from title_royaltysum as tr
left join titles as t
on `Title ID` = t.title_id
group by `Author ID`
order by sum desc ;