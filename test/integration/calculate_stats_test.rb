require 'test_helper'
require_relative '../../lib/BaseballStats.rb'
include BaseballStats

class CalculateStatsTest< ActionDispatch::IntegrationTest
  fixtures :players, :batting_stats, :teams
  
test 'calculate battering average for player' do
  player=Player.includes(:batting_stats).where(:last_name=>"Bailey").first
  hits=player.batting_stats.first.hits  # 8
  assert_equal(8,hits,'Verifying hits')
  at_bats=player.batting_stats.first.at_bats #70
  assert_equal(70,at_bats,'Verifying at bats')
  assert_equal(0.114,battingAverage(hits, at_bats), 'Battting average should be .114')
  
end

test 'update notes with team slugging percenatge' do
  year=2012
  team=teams(:CincinnatiReds)#team_id=2
  team_slugging_percentage=BattingStat.new.get_sum_team_batting_stats(team.id, year)
  assert team_slugging_percentage, 'Got the slugging percentage'
  if !(team_slugging_percentage.nil?)
    team.notes= 'Team slugging percentage ' + team_slugging_percentage.to_s
    assert team.save,  'Save the team record'
    team_record=Team.find(team.id)
    assert_equal team_record.notes,'Team slugging percentage ' +  team_slugging_percentage.to_s, 'Comparing team slugging record to expected results'
  end
end

# simply here for mocking and stubbing demo
test 'find Triple Crown winner and create award - mock' do
  battingstat=batting_stats(:TripleCrown)
  BattingStat.expects(:find_triple_crown_player_by_year_and_league).with(2012,1).returns(battingstat)
  triple_crown_winner=  BattingStat.find_triple_crown_player_by_year_and_league(2012,1)
  triple_crown_award = PlayerAward.new
  triple_crown_award.league_id=triple_crown_winner.league_id
  triple_crown_award.player_id=triple_crown_winner.player_id
  triple_crown_award.award_year = triple_crown_winner.batting_year
  triple_crown_award.award_name = 'Triple Crown'
  assert triple_crown_award.save!, 'saving triple crown award'
end

test 'find Triple Crown winner, create award, notify player - mock and stup' do
  battingstat=batting_stats(:TripleCrown)
  
  BattingStat.expects(:find_triple_crown_player_by_year_and_league).with(2012,1).returns(battingstat)
  triple_crown_winner=  BattingStat.find_triple_crown_player_by_year_and_league(2012,1)
  
  assert_equal batting_stats(:TripleCrown), triple_crown_winner, 'Verify returned Triple Crown Winner is correct'
  
  triple_crown_award = PlayerAward.new
  triple_crown_award.league_id=triple_crown_winner.league_id
  triple_crown_award.player_id=triple_crown_winner.player_id
  triple_crown_award.award_year = triple_crown_winner.batting_year
  triple_crown_award.award_name = 'Triple Crown'
  assert triple_crown_award.save, 'Save the Triple Crown Award'
  
  player=Player.find(triple_crown_winner.player_id)
  
  award=PlayerAward.last
  assert_equal triple_crown_award.award_name, award.award_name.to_s,'Verifying new award name'
  assert_equal triple_crown_winner.league_id,award.league_id, 'Verify triple crown winner league id'  
  #stub e-mail notifcation - we don't really want to send an e-mail for this test
  
  PlayerMailer.stubs(:notify_award).returns(true)
  assert PlayerMailer.notify_award(:player,:award), 'Check triple crown award is successful'
end

# just misc mocks and stubs to demonstrate mocking and stubbing

test 'stubbing an instancee method on all instances ' do
   BattingStat.any_instance.stubs(:id).returns(3)
   battingstat = BattingStat.new
   assert_equal 3, battingstat.id
 end
 

 test 'mock for an instance' do
   battingstat=batting_stats(:TripleCrown)
   BattingStat.expects(:find_triple_crown_player_by_year_and_league).with(2012,1).returns(battingstat)
   assert_equal battingstat, BattingStat.find_triple_crown_player_by_year_and_league(2012,1), 'Checking triple crown mock'
 end


end
