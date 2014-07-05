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
    assert batstats.destroy
    assert_equal 2, BattingStat.count
  end

  
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
  
 test 'get prior year and next year batting stats' do
   puts 'past year'
   two_rows = BattingStat.new.find_prior_year_and_next_year(2012, 2)
   
   puts 'difference ' + two_rows.to_s
 end 
 
 test 'get players with batting data for year x' do
   puts 'find players with data in range'
   puts BattingStat.new.find_players_with_batting_data_by_year(2012).to_yaml
   
 end
 
 test 'get changes in prior year' do
   puts 'Getting changes piro  xxxxxxxxxxxxxxxxxxxxxxxx'
   batting_year = 2012
    BattingStat.new.find_players_with_batting_data_by_year(batting_year).each do |bs|
      puts 'change since previous year >>>>>>>> ' + bs.player_id.to_s + ' ' + BattingStat.new.find_prior_year_and_next_year(batting_year, bs.player_id).to_s
    end 
     puts 'Getting changes piro end  xxxxxxxxxxxxxxxxxxxxxxxx'
  
 end
end
