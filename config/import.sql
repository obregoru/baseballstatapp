delete from leagues;
delete from teams;
delete from players;
delete from batting_stats;
delete from player_awards;
ALTER SEQUENCE leagues_id_seq RESTART WITH 1;
UPDATE leagues SET id=nextval('leagues_id_seq');

ALTER SEQUENCE players_id_seq RESTART WITH 1;
UPDATE players SET id=nextval('players_id_seq');

drop table players_import;

drop table batting_stats_import;

create table players_import (legacy_id char(20), birthYear char(10), nameFirst char(20), nameLast char(30)) ;

copy players_import from '/Users/Ruben/Downloads/Developer Candidate Exercise/Master-small.csv' Delimiter ',' CSV;

alter table players_import add column player_id smallint;

create table batting_stats_import (player_id char(20), yearID char(10), league char(10), teamID char(20), G char(20), AB char(20), R char(20), H char(20), TWOB char(20), THREEB char(20), HR char(20), RBI char(20), SB char(20), CS char(20));


copy batting_stats_import from '/Users/Ruben/Downloads/Developer Candidate Exercise/Batting-07-12.csv' Delimiter ',' CSV HEADER;
alter table batting_stats_import add column league_id smallint;

delete from batting_stats_import where player_id = 'playerID';
	
insert into players(legacy_id,first_name,last_name,email,created_at,updated_at) select legacy_id, namefirst, namelast , namefirst || namelast || '@baseballstats.com' as email, current_timestamp, current_timestamp from players_import;

update players_import set player_id = players.id from  players where players_import.legacy_id=players.legacy_id;
update batting_stats_import set league = 1 where league = 'NL';
update batting_stats_import set league = 2 where league = 'AL';
insert into teams(league_id, team_name, created_at, updated_at) select distinct cast(league as integer), teamid, current_timestamp, current_timestamp from batting_stats_import;

insert into batting_stats(team_id, player_id, league_id,batting_year,at_bats,hits,doubles,triples, home_runs,runs_batted,created_at,updated_at )  select t.id as team_id, pl.player_id as player_id, t.league_id as league_id, cast(bs.yearID as integer) as batting_year, cast(bs.ab as integer) as at_bats, cast(bs.h as integer) as hits, cast(bs.twob as integer) , cast(bs.threeb as integer) , cast(hr as integer) as home_runs,cast(rbi as integer) as runs_batted, current_timestamp as created_at, current_timestamp as updated_at from batting_stats_import bs inner join players_import pl on bs.player_id = pl.legacy_id inner join teams t on bs.teamid  = t.team_name;

update players
set team_id = stats.team_id
from 
(select player_id, max(batting_year), max(team_id) as team_id from batting_stats group by player_id) as stats where players.id = stats.player_id;

delete from players where team_id is null;

update batting_stats set batting_average=0 where batting_average is null;

update batting_stats set slugging_percentage=0 where slugging_percentage is null;


insert into leagues(league_name, created_at, updated_at) values('National League', current_timestamp , current_timestamp );
insert into leagues(league_name, created_at, updated_at) values('American League', current_timestamp , current_timestamp );
	
update teams set team_name= 'Seattle Seahawks - ' || team_name where team_name = 'SEA';
update teams set team_name = 'Anaheim Angels - ' || team_name where team_name = 'ANA';
update teams set team_name = 'Arizona Diamondbacks - ' || team_name where team_name = 'ARI';
update teams set team_name = 'Atlanta Braves - ' || team_name  where team_name = 'ATL';
update teams set team_name = 'Baltimore Orioles - ' || team_name  where team_name = 'BAL';
update teams set team_name = 'Boston Red Sox - ' || team_name  where team_name = 'BOS';
update teams set team_name = 'California Angels - ' || team_name  where team_name = 'CAL';
update teams set team_name = 'Chicago Cubs - ' || team_name  where team_name = 'CHC';
update teams set team_name = 'Chicago White Sox - ' || team_name  where team_name = 'CHI';
update teams set team_name = 'Chicago White Sox - ' || team_name  where team_name = 'CHA';
update teams set team_name = 'Chicago Cubs - ' || team_name  where team_name = 'CHN';
update teams set team_name = 'Chicago White Sox - (WL) ' || team_name  where team_name = 'CHW';
update teams set team_name = 'Cincinnati Red/Red Stockings - ' || team_name  where team_name = 'CIN';
update teams set team_name = 'Cleveland Indians/Naps/Bronchos/Blues - ' || team_name  where team_name = 'CLE';
update teams set team_name = 'Colorado Rockies - ' || team_name  where team_name = 'COL';
update teams set team_name = 'Detroit Tigers - ' || team_name  where team_name = 'DET';
update teams set team_name = 'Florida Marlins - ' || team_name  where team_name = 'FLA';
update teams set team_name = 'Florida Marlins - ' || team_name  where team_name = 'FLO';
update teams set team_name = 'Houston Astros/Colt .45s - ' || team_name  where team_name = 'HOU';
update teams set team_name = 'Kansas City Royals - ' || team_name  where team_name = 'KCA';
update teams set team_name = 'Los Angeles Angels (of Anaheim) - ' || team_name  where team_name = 'LAA';
update teams set team_name = 'Los Angeles Dodgers - ' || team_name  where team_name = 'LAD';
update teams set team_name = 'Los Angeles Dodgers - ' || team_name  where team_name = 'LAN';
update teams set team_name = 'Miami Marlins - ' || team_name  where team_name = 'MIA';
update teams set team_name = 'Milwaukee Brewers - ' || team_name  where team_name = 'MIL';
update teams set team_name = 'Minnesota Twins - ' || team_name  where team_name = 'MIN';
update teams set team_name = 'Montreal Expos - ' || team_name  where team_name = 'MTL';
update teams set team_name = 'New York Gothams/Giants/Yankees - ' || team_name  where team_name = 'NY';
update teams set team_name = 'New York Giants/Gothams - ' || team_name  where team_name = 'NYG';
update teams set team_name = 'New York Mets - ' || team_name  where team_name = 'NYM';
update teams set team_name = 'New York Yankees - ' || team_name  where team_name = 'NYY';
update teams set team_name = 'New York Yankees - ' || team_name  where team_name = 'NYA';
update teams set team_name = 'New York Mets - ' || team_name  where team_name = 'NYN';
update teams set team_name = 'New York Highlanders - ' || team_name  where team_name = 'NYH';
update teams set team_name = 'Oakland Athletics - ' || team_name  where team_name = 'OAK';
update teams set team_name = 'Philadelphia Athletics - ' || team_name  where team_name = 'PHA';
update teams set team_name = 'Philadelphia Phillies - ' || team_name  where team_name = 'PHI';
update teams set team_name = 'Philadelphia Phillies - ' || team_name  where team_name = 'PHP';
update teams set team_name = 'Philadelphia Blue Jays - ' || team_name  where team_name = 'PHB';
update teams set team_name = 'Pittsburgh Pirates/Alleghenys - ' || team_name  where team_name = 'PIT';
update teams set team_name = 'San Diego Padres - ' || team_name  where team_name = 'SDN';
update teams set team_name = 'Seattle Mariners - ' || team_name  where team_name = 'SEA';
update teams set team_name = 'San Francisco Giants - ' || team_name  where team_name = 'SFN';
update teams set team_name = 'St. Louis Browns - ' || team_name  where team_name = 'STB';
update teams set team_name = 'St. Louis Cardinals/Perfectos/Browns/Brown Stockings - ' || team_name  where team_name = 'STL';
update teams set team_name = 'St. Louis Cardinals - ' || team_name  where team_name = 'STC';
update teams set team_name = 'St. Louis Cardinals - ' || team_name  where team_name = 'SLN';
update teams set team_name = 'Tampa Bay (Devil) Rays - ' || team_name  where team_name = 'TBA';
update teams set team_name = 'Texas Rangers - ' || team_name  where team_name = 'TEX';
update teams set team_name = 'Toronto Blue Jays - ' || team_name  where team_name = 'TOR';
update teams set team_name = 'Washington Nationals - ' || team_name  where team_name = 'WSH';
update teams set team_name = 'Washington Nationals - ' || team_name  where team_name = 'WAS';

