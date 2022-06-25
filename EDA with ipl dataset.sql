SELECT * FROM ipl.match;
SELECT * FROM ipl.deliveries;

-- Name all the teams
select distinct(team1) as teams from ipl.match;

-- find season winner for each season
select season,winner from ipl.match
group by season
order by season desc;

-- find venue of 10 most recently played matches

select date,venue from ipl.match
group by date
order by date desc
limit 10;

-- case (4,6,single,0)

select batsman,bowler,
case 
    when total_runs=6 then 'Six'
    when total_runs=4 then 'Four'
    when total_runs=1 then 'Single'
    when total_runs =0 then 'duck'
else
    'No Runs'
end as 'Runs in Words' from ipl.deliveries; 


-- Data aggregation
-- Teams wins by total runs and total wickets in each seasons
select season,winner,sum(win_by_runs),sum(win_by_wickets)
from ipl.match
group by season,winner
order by 2 desc;


-- how many extra total runs made by 'Sunrisers hyderabad' 
select batting_team,sum(total_runs)
from ipl.deliveries
where batting_team ='Sunrisers Hyderabad' ;

-- in how many seasons  Delhi deardevils were became winners
select season,winner
from ipl.match
where winner='Delhi Daredevils' 
group by winner;
 
 
-- How many extra runs have been conceded by bowlers 

select distinct bowler,sum(extra_runs)
from ipl.deliveries
group by bowler
having sum(extra_runs)>0;

-- On an average,teams won by how many runs in ipl

select winner,round(avg(win_by_runs),0) as avg_winning_runs
from ipl.match 
group by winner
having round(avg(win_by_runs),0)>0;


-- How many extra runs werer conceded by SK Warne in ipl

select bowler,sum(extra_runs) 
from ipl.deliveries
where bowler='SK Warne'
group by bowler;

-- How many 4 and 6 has been hit by mumbai indians

select m.winner,d.total_runs,count(d.total_runs)
from ipl.deliveries d
inner join ipl.match m 
on m.id=d.match_id
where d.total_runs in(4,6)
and m.winner="Mumbai Indians"
group by m.winner,d.total_runs;

-- How many balls did TS Mills bowl to batsman DA Warner

select batsman,bowler,count(ball)
from ipl.deliveries
where bowler='TS Mills' and batsman='DA Warner'
group by batsman,bowler;

-- How many matches were played in month of April

select count(*)as total_match_april from ipl.match
where month(date)='4';

 -- How many matches were played in month of march and june
 
 select count(*) as match_march_june
from ipl.match
where month(date) in('3','6');

-- show the details when player of the match name starts from "K"

select * from ipl.match 
where player_of_match like "K%";

-- show the details when player of the match name starts from "S" and end by"a"
select * from ipl.match
where player_of_match like "S%" and player_of_match like "%a";

-- Create a score card for players

select batting_team,batsman,sum(batsman_runs)
from ipl.deliveries
group by batting_team,batsman
order by 3 desc;

-- Top 10 players with maximum boundries

select distinct batsman,count(total_runs)
from ipl.deliveries
where total_runs in (4,6)
group by batsman
order by 2 desc
limit 10;

-- Top 20 bowlers who conceded highest extra runs

select bowler,sum(extra_runs) as highest_extra_runs 
from ipl.deliveries
group by bowler
order by 2 desc
limit 20;