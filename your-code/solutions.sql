Challenge 1 


Step1

SELECT t.title_id as Title_ID,a.au_id as Author_ID, 
t.price * s.qty * t.royalty / 100 * ta.royaltyper / 100 AS sales_royalty
FROM titles t
LEFT JOIN titleauthor ta
on ta.title_id=t.title_id
LEFT JOIN authors a
on a.au_id=ta.au_id
LEFT JOIN sales s
on t.title_id=s.title_id
where t.price is not null;


Step2

SELECT t.title_id as Title_ID,a.au_id Author_ID, 
sum(t.price * s.qty * t.royalty / 100 * ta.royaltyper / 100) AS sales_royalty
FROM titles t
LEFT JOIN titleauthor ta
on ta.title_id=t.title_id
LEFT JOIN authors a
on a.au_id=ta.au_id
LEFT JOIN sales s
on t.title_id=s.title_id
where t.price is not null
group by a.au_id, t.title_id;


Step3

SELECT a.au_id Author_ID, 
advance+sum(t.price * s.qty * t.royalty / 100 * ta.royaltyper / 100) AS Profit
FROM titles t
LEFT JOIN titleauthor ta
on ta.title_id=t.title_id
LEFT JOIN authors a
on a.au_id=ta.au_id
LEFT JOIN sales s
on t.title_id=s.title_id
where t.price is not null
group by a.au_id, t.title_id;






ALTERNATIVE
Challenge 2

Step1 

CREATE TEMPORATY TABLE CHAL1 
SELECT t.title_id,a.au_id, 
t.price * s.qty * t.royalty / 100 * ta.royaltyper / 100 AS sales_royalty
FROM titles t
LEFT JOIN titleauthor ta
on ta.title_id=t.title_id
LEFT JOIN authors a
on a.au_id=ta.au_id
LEFT JOIN sales s
on t.title_id=s.title_id
where t.price is not null;


Step2

create temporary table chal2
SELECT title_id,au_id, 
sum(sales_royalty) as agr_royalty
from chal1
group by title_id,au_id;

Step3

select au_id, sum(advance+agr_royalty) as profit from chal2
LEFT JOIN titles t
ON chal2.title_id=t.title_id
group by au_id
order by profit desc
limit 3;

Challenge 2

from sqlalchemy import create_engine
import pandas as pd

str_conn='mysql+pymysql://root:root@localhost:3306/publication'

cursor=create_engine(str_conn)



query='''
CREATE TEMPORARY TABLE CHAL1
SELECT t.title_id,a.au_id, 
t.price * s.qty * t.royalty / 100 * ta.royaltyper / 100 AS sales_royalty
FROM titles t
LEFT JOIN titleauthor ta
on ta.title_id=t.title_id
LEFT JOIN authors a
on a.au_id=ta.au_id
LEFT JOIN sales s
on t.title_id=s.title_id
where t.price is not null;

'''

cursor.execute(query)



query='''
create temporary table chal2
SELECT title_id,au_id, 
sum(sales_royalty) as agr_royalty
from chal1
group by title_id,au_id;

'''

cursor.execute(query)


query='''
select au_id, advance+agr_royalty from chal2
LEFT JOIN titles t
ON chal2.title_id=t.title_id


'''

df1=pd.read_sql(query,cursor)