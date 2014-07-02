FactoryGirl.define do 
  factory :batting_stat do |b|
    b.player_id {2 + rand(200)}
    b.at_bats {1 + rand(500)}
    b.hits {1 + rand(200)}
    b.doubles {1 + rand(100)}
    b.triples {1 + rand(50)}
    b.home_runs {1 + rand(400)}
    b.batting_year {1990 + rand(24)}
    b.league_id  {1 + rand(2)}
 #   b.batting_average { b.hits / b.at_bats}
 #   b.slugging_percentage {((b.hits - b.doubles - b.triples - b.home_runs) + (2 * b.doubles) + (3 * b.triples) + (4 * b.home_runs)) / b.at_bats}

  end
  
end