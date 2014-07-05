FactoryGirl.define do 
  factory :batting_stat do |b|
    b.player_id {2 + rand(200)}
    b.at_bats {1 + rand(500)}
    b.hits {1 + rand(200)}
    b.doubles {1 + rand(100)}
    b.triples {1 + rand(50)}
    b.runs_batted 500
    b.home_runs {1 + rand(400)}
    b.batting_year {1990 + rand(24)}
    b.league_id  {1 + rand(2)}
    b.team_id 1
    b.batting_average 0.211
    b.slugging_percentage 0.20
  end
  
end