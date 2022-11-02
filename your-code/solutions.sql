select authors.au_id, titles.title_id, (titles.price * sales.qty/100 * titleauthor.royaltyper / 100) as total from authors
inner join titleauthor
on authors.au_id = titleauthor.au_id
left join titles
on titleauthor.title_id = titles.title_id
left join sales
on sales.title_id = titles.title_id;



select authors.au_id, titles.title_id, sum(titles.price * sales.qty/100 * titleauthor.royaltyper / 100) as total from authors
inner join titleauthor
on authors.au_id = titleauthor.au_id
left join titles
on titleauthor.title_id = titles.title_id
left join sales
on sales.title_id = titles.title_id
group by titles.title_id, authors.au_id;


select authors.au_id, (sum(titles.price * sales.qty/100 * titleauthor.royaltyper / 100)+titles.advance) as total from authors
inner join titleauthor
on authors.au_id = titleauthor.au_id
left join titles
on titleauthor.title_id = titles.title_id
left join sales
on sales.title_id = titles.title_id
group by titles.title_id, authors.au_id
ORDER BY total DESC
LIMIT 3;


create temporary table pubs.step1
select authors.au_id, titles.title_id, (titles.price * sales.qty/100 * titleauthor.royaltyper / 100) as total from authors
inner join titleauthor
on authors.au_id = titleauthor.au_id
left join titles
on titleauthor.title_id = titles.title_id
left join sales
on sales.title_id = titles.title_id;


create temporary table pubs.step2
select authors.au_id, titles.title_id, sum(titles.price * sales.qty/100 * titleauthor.royaltyper / 100) as total from authors
inner join titleauthor
on authors.au_id = titleauthor.au_id
left join titles
on titleauthor.title_id = titles.title_id
left join sales
on sales.title_id = titles.title_id
group by titles.title_id, authors.au_id;

create temporary table pubs.step3
select authors.au_id, (sum(titles.price * sales.qty/100 * titleauthor.royaltyper / 100)+titles.advance) as total from authors
inner join titleauthor
on authors.au_id = titleauthor.au_id
left join titles
on titleauthor.title_id = titles.title_id
left join sales
on sales.title_id = titles.title_id
group by titles.title_id, authors.au_id
ORDER BY total DESC
LIMIT 3;


create table most_profiting_authors
select authors.au_id, (sum(titles.price * sales.qty/100 * titleauthor.royaltyper / 100)+titles.advance) as total from authors
inner join titleauthor
on authors.au_id = titleauthor.au_id
left join titles
on titleauthor.title_id = titles.title_id
left join sales
on sales.title_id = titles.title_id
group by titles.title_id, authors.au_id
ORDER BY total DESC;
