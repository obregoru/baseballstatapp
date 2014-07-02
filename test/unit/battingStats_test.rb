require 'test_helper'

class BattingStatTest < ActiveSupport::TestCase
  should belong_to(:player)
   
  should_not allow_mass_assignment_of(:created_at)
  should_not allow_mass_assignment_of(:updated_at)
  
  test "save a battingStat record" do
    battingstat=BattingStat.new
    assert battingstat.save
  end 
  
  test 'update Batting Stats' do
    batstats=BattingStat.find(2)
    batstats.hits = 9
    assert batstats.save, 'Updated batting stats for player 2'
  end

  test 'destroy batting stats' do
    batstats=BattingStat.find(1)
    assert batstats.destroy
    assert_equal 2, BattingStat.count
  end
  #The player that had the highest batting average AND the most home runs AND the most RBI in their league.
  
  
  test 'gets batter with max batting average by year and league' do
    player_with_highest_batting_avg = BattingStat.new.find_max_batting_avg_by_year_and_league(2012, 1)
    assert tripleCrown=BattingStat.new.find_max_batting_avg_by_year_and_league(2012, 1)
    
  end
  
  test 'gets batter with most home runs by year and league' do

        player_with_most_home_runs = BattingStat.new.find_max_home_runs_by_year_and_league(2012,1)
        assert triplecrown=BattingStat.new.find_max_home_runs_by_year_and_league(2012,1)
  end
  
  test 'gets batter with most runs battted in' do

    player_with_most_runs_batted_in = BattingStat.new.find_max_runs_batted_by_year_and_league(2012,1)
    
    assert triplecrown=BattingStat.new.find_max_runs_batted_by_year_and_league(2012,1)
    
  end
  
  test 'gets triple crown winner' do

    triple_crown_winner = BattingStat.new.find_triple_crown_player_by_year_and_league(2012,1)

    assert triplecrown=BattingStat.new.find_triple_crown_player_by_year_and_league(2012,1)

  end
  
  
end
