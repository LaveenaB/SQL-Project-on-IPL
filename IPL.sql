use ipl;

select * from deliveries;
desc deliveries;

select * from matches;

desc matches;

#-- explore data 

select * from deliveries;
select * from matches;

#-- shape data
desc deliveries;
desc matches;

select count(*) from deliveries;
select count(*) from matches;

#-- to get the no. of columns

select count(*) from information_schema.columns where table_name='matches';
select count(*) from information_schema.columns where table_name='deliveries';

select * from information_schema.tables;

#-- Question 2 
#-- Find season winner for each season (season winner is the winner of the last match of each season)

select distinct season, any_value(winner), max(date) from matches
group by 1
order by 3 desc;

#-- Question 3
#-- Find venue of 10 most recently played matches

select * from matches;
select * from deliveries;

select venue, any_value(team1), any_value(team2), max(date) from matches
group by 1
order by 4 desc
limit 10;

#-- Question 4
#-- case (4,6, single, 0)

select * from deliveries;

select distinct batsman, bowler, case when total_runs= 6 then 'Six'
							 when total_runs=4 then 'Four'
                             when total_runs=1 then 'Single'
                             when total_runs=0 then 'Duck'
						else 
							'No Run'
						end as 'Run in word'
from deliveries;

#-- Data Aggregation max, min, avg, sum, count
#--  get the no. for max, min, and avg wickets or runs in different years for different matches

select * from matches;
select * from deliveries;

SELECT 
    season,
    ANY_VALUE(team1),
    ANY_VALUE(team2),
    ANY_VALUE(winner),
    MAX(win_by_wickets) AS maximum_wickets
FROM
    matches
GROUP BY season
ORDER BY 1 DESC , 4 DESC;

SELECT 
    season,
    ANY_VALUE(team1),
    ANY_VALUE(team2),
    ANY_VALUE(winner),
    sum(win_by_runs) AS total_runs
FROM
    matches
GROUP BY season
ORDER BY 5 DESC , 1 DESC;


select distinct season, batting_team, bowling_team, batsman, sum(total_runs) as total_runs
from deliveries d
join matches m
on m.id = d.match_id
group by season, batting_team, bowling_team, batsman
order by 5;

#-- Questions 5 
#-- how many extra runs have been conceded in ipl

select * from deliveries;

select season, batting_team, sum(extra_runs) as extra_runs from deliveries d
join matches m
on m.id = d.match_id
group by season, batting_team
order by 3 desc;

select sum(extra_runs) as extraruns from deliveries;

#-- on an average, teams won by how many runs in ipl

select * from matches;

select winner, avg(win_by_runs) as average_runs from matches
group by winner;

#-- Question 
#-- How many extra runs were conceded in ipl by SK Warne

select * from deliveries;

select batsman, bowler, sum(extra_runs) as extra_runs from deliveries
where bowler LIKE 'SK warne'
group by batsman, bowler;
