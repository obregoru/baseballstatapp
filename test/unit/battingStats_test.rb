require 'test_helper'

class BattingStatTest < ActiveSupport::TestCase
  should belong_to(:player)
  should belong_to(:team)
  
  should_not allow_mass_assignment_of(:created_at)
  should_not allow_mass_assignment_of(:updated_at)
  
  should validate_presence_of(:player_id)
  should validate_presence_of(:team_id)
  should validate_presence_of(:league_id)
  
  test "save a battingStat record" do
    battingstat=BattingStat.new
    battingstat.player_id=1
    battingstat.league_id=1
    battingstat.team_id=2
    assert battingstat.save
  end 
  
  test 'update Batting Stats' do
    batstats=BattingStat.find(2)
    batstats.hits = 9
    assert batstats.save!, 'Updated batting stats for player 2'
  end

  test 'destroy batting stats' do
    batstats=BattingStat.find(1)
    assert batstats.destroy, 'Destory batting stat record'
    assert !BattingStat.exists?(1), 'Batting stat does not exist'
    assert_equal 2, BattingStat.count, 'Verify batting stat count is 2'
  end

  
  test 'gets batter with max batting average by year and league' do
    assert_equal 2, BattingStat.new.find_max_batting_avg_by_year_and_league(2012, 1), 'Retrieve the player_id with max batting average'
  
  end
  
  test 'gets batter with most home runs by year and league' do
         assert_equal 2,BattingStat.new.find_max_home_runs_by_year_and_league(2012,1), 'Retrieve player_id with most home runs'
  end
  
  test 'gets batter with most runs battted in' do
    assert_equal 2, BattingStat.new.find_max_runs_batted_by_year_and_league(2012,1), 'Retrive player_id with most runs batted in'
    
  end
  
  test 'gets triple crown winner' do
    assert_equal 2, BattingStat.new.find_triple_crown_player_by_year_and_league(2012,1).player_id, 'Retrieve the triple crown winner\'s record'

  end
  
 test 'get prior year and next year batting stats' do
   assert BattingStat.new.update_batting_average_difference(2012, 2), 'Update batting average difference'
 end 
 
 test 'get players with batting data for year  2012' do
   assert_equal 2,BattingStat.new.find_players_with_batting_data_by_year(2012).count, 'Get the number of players with batting data for a specific year'
 end
 
 test 'get changes in prior year' do
   batting_year = 2012
   players=BattingStat.new.find_players_with_batting_data_by_year(batting_year)
   assert_equal 2, players.count
   players.each do |bs|
      assert BattingStat.new.update_batting_average_difference(batting_year, bs.player_id).to_s, 'Update batting average differnce for each player'
   end 
    
 end

 test 'get team stats for slugging percentage for the  year' do
   team_id = 2
   batting_year = 2012
   battingstats= BattingStat.new.get_sum_team_batting_stats(team_id, batting_year)
   assert_equal 2,battingstats.league_id, 'league_id =2'
   assert_equal 2, battingstats.team_id, 'team_id = 2'
   assert_equal 2012,battingstats.batting_year, 'Summed batting stats - batting year=2012'
   assert_equal '8',battingstats.sum_hits, 'Summed batting stats - hits'
   assert_equal '1',battingstats.sum_doubles, 'Summed batting stats - doubles'
   assert_equal '0',battingstats.sum_triples, 'Summed batting stats - triples'
   assert_equal '0',battingstats.sum_home_runs, 'Summed batting stats - home runs'
   assert_equal '70',battingstats.sum_at_bats, 'Summeed batting stats - at bats'
 end 
end
