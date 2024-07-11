--NETFLIX DATA ANALYSIS

/*1  for each director who has created tv shows and movies both 
count the no of movies and TV shows created by them in separate columns */

Select nd.director,
count(distinct case when n.type = 'Movie' then n.show_id end) as Movies,-- counting of the unique type of content - MOVIE
count(distinct case when n.type = 'TV Show' then n.show_id end) as TV_Shows-- counting of the unique type of content - TV SHOW
from netflix n 
INNER JOIN netflix_director nd
on n.show_id = nd.show_id
group by nd.director
having count(distinct n.type) > 1-- this is where we are sorting the directors who have done min 1 movie and 1 TV show

/*which country has the highest number of comedy movies*/

Select nc.country,count(distinct ng.show_id) as comedy_movies -- Using count(*), which counts all rows satisfying the condition.
--Using COUNT(distinct ng.show_id), which counts distinct show IDs, ensuring no duplicate show IDs are counted
from netflix n 
INNER JOIN netflix_genre ng 
on  n.show_id = ng.show_id INNER JOIN
netflix_country nc on ng.show_id = nc.show_id
where ng.genre = 'Comedies' and n.type= 'Movie'
group by nc.country
order by comedy_movies desc

/*3 for each year (as per date added to Netflix), which director has the maximum number of movies released*/

with cte1 as (
Select nd.director,year(n.date_added) as year_rel_netflix ,
count(n.show_id) as no_of_movies
from netflix n inner join netflix_director nd on n.show_id = nd.show_id
where n.type = 'Movie'
group by nd.director,year(n.date_added)
) , cte2 as(
select *, ROW_NUMBER() over(partition by year_rel_netflix order by no_of_movies desc,director) as rank_director
from cte1 )-- we have used row_number to rank as it gives unique ranking as per year column
select* from cte2 
where rank_director = 1


/*4 What is average duration of movies in each genre*/

Select ng.genre, 
avg(cast(replace(n.duration,'min','') as int)) as avg_duration -- the duration type was of varchar so we hadd to cas it into integer
-- also we had to replace the minute denotation min as avg() works with integers only  
from netflix n inner join									 
netflix_genre ng ON n.show_id = ng.show_id
where n.type = 'Movie'
group by ng.genre
order by avg_duration

/*5  Find the directors who have created both horror and comedy movies.
display director names along with a number of comedy and horror movies directed by them*/

Select nd.director,
count(distinct case when ng.genre = 'Comedies' then n.show_id end) as no_of_comedies, -- separate countings has been performed for comedies and horror movies
count(distinct case when ng.genre = 'Horror Movies' then n.show_id end)  as no_of_Horror
from
netflix n inner join
netflix_genre ng ON n.show_id = ng.show_id inner join netflix_director nd ON ng.show_id = nd.show_id
where n.type = 'Movie' and ng.genre IN ('Comedies','Horror Movies')-- over here we had to select 3 parameters for the filtering 
group by nd.director
having count(distinct ng.genre)>=2-- sorting out the distinct genre done by director. 
-- as >=2 is used for a director who has done both comedy and horror genre movies will have a count of a minimum of 2
