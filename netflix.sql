Select * from [dbo].[netflix_raw]
order by title

-- 1) HANDLING FOREIGN CHARACTER 

-- As we can note that due to the column properties whcih is set to varchar 
-- netfilx title column is not able to read other that english language which 
-- we can see in show_id 
--s5023	Movie	??? ???
--s2639	Movie	??? ?????
--s8775	Movie	??? ?????
--s7102	TV Show	????
--s4915	TV Show	????
--s7109	Movie	???? ????? : ??? ??
--s2640	TV Show	???? ???????
--s8795	Movie	??????
--s6178	TV Show	????????
--s5975	TV Show	??????????????????? 
-- we will perfrom to change the schema defination



Select * from netflix_raw
where show_id = 's5023'

-- s5023	Movie	반드시 잡는다	 Hong-seon Kim	Baek Yoon-sik	South Korea	

-- now foreign character is processed

-- 2) REMOVING DUPLICATES

Select show_id ,count(*)
from netflix_raw
group by show_id
having COUNT(*)>1
-- as we can see no duplicate values is present Show_id so we can now present show_id as primary key


Select title ,count(*)
from netflix_raw
group by title
having COUNT(*)>1
-- yes their is duplicates in title / checking it respect to the table
select * from netflix_raw
where title in(select title from netflix_raw 
group by title
having count(*) >1)

-- as per the result their are duplicates with same title name but in 
--some case title name is same for the type of the show like tv show or movie 
-- we can't count that title as duplicate 
select * from netflix_raw
where concat(title,type) in(select concat(title,type) from netflix_raw 
group by title,type
having count(*) >1)
order by title ,type

with cte as (select * , Row_Number() over(Partition by title,type order by title)as rn
from netflix_raw)
select * from cte
where rn =1

-- we can see we have multiple values in single column so we have to 
-- seprate it with respect to show id in a new take so taht we can analyse
-- first is director as we have multiple director fro one show or movie 
select show_id , trim(value) as director
into netflix_director
from netflix_raw
cross apply string_split(director,',')
select * from netflix_director
order by director

-- we will do the same for cast 
select show_id , trim(value) as [cast]
into netflix_cast
from netflix_raw
cross apply string_split(cast,',')
select * from netflix_cast
order by cast

---- we will do the same for country

select show_id , trim(value) as country
into netflix_country
from netflix_raw
cross apply string_split(country,',')
select * from netflix_country
order by country

--we will do the same for listed_in

select show_id , trim(value) as genre
into netflix_genre
from netflix_raw
cross apply string_split(listed_in,',')
select * from netflix_genre
order by genre


---- Data type conversion 

-- cleaned table
with cte as (select * , 
			Row_Number() over(Partition by title,type order by title)as rn
from netflix_raw)
			select show_id,type,title,cast(date_added as date) as date_added ,
	release_year,rating,duration,description
from cte
where rn =1

-- populating the null values 

--Country 
insert into netflix_country
select show_id, m.country from netflix_raw nr inner join
(Select director,country from netflix_country nc 
	inner join netflix_director nd on nc.show_id =nd.show_id
group by director,country) m on nr.director = m.director
where nr.country is null

select * from netflix_country nc left join netflix_raw nr on nc.show_id = nr.show_id
where nr.director IS NOT NULL
order by nr.director


--- we can also check for  duration as we can also possible populate it 

Select * from netflix_raw 
where duration is null

-- as the ouput we got is the duration have 3 null values 
-- beside the duration column their is rating col 
-- which has wrong value as the rating is given in 74 min / 84 min/66 min
-- so we will copy the value of the rating to duration colum with respect to the same show_id


-- using our cleaned tabe for it 
with cte as (select * , 
			Row_Number() over(Partition by title,type order by title)as rn
from netflix_raw)
			select show_id,type,title,cast(date_added as date) as date_added ,
	release_year,rating,case when duration is null then rating else duration end,description
from cte
where rn =1


-- casting the above cleaned table code to a new table named netflix

with cte as (select * , 
Row_Number() over(Partition by title,type order by show_id)as rn
from netflix_raw)--cte over 
select show_id,type,title,cast(date_added as date) as date_added ,
release_year,rating,case when duration is null then rating else duration end as duration ,description
/*this is for pushing it to a new table */into netflix--new table name
from cte
where rn =1

-- new table 
select * from netflix
order by title
