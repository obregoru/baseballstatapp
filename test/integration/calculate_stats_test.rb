require 'test_helper'
require_relative '../../lib/BaseballStats.rb'
include BaseballStats

class CalculateStatsTest< ActionDispatch::IntegrationTest
  fixtures :players, :batting_stats
  
test 'calculate battering average for player using fixtures' do
  player=Player.includes(:batting_stats).where(:last_name=>"Bailey").first

  hits=player.batting_stats.first.hits.to_i # 8
  assert_equal(8,hits,'Verifying hits')
  at_bats=player.batting_stats.first.at_bats #70
  assert_equal(70,at_bats,'Verifying at bats')

  assert_equal(0.114,battingAverage(hits, at_bats), 'Battting average should be .114')
  
end




test 'should create list of players' do
  @players=FactoryGirl.create_list(:player,400)

end

test 'create teams' do
    @teams=FactoryGirl.create_list(:team,20)
  
end

test 'find the triple crown winner via factory' do
  #todo - do something with this factory
  @batting_stats=FactoryGirl.create_list(:batting_stat, 400)
  @batting_stats.each do |b|
    b.batting_average = battingAverage(b.hits, b.at_bats)
    b.slugging_percentage = sluggingPercentage(b.hits, b.doubles, b.triples, b.home_runs, b.at_bats)
  end
  #raise @batting_stats.to_yaml
  
  bat_stats =  @batting_stats.sort!

end



#---
test 'mock instance on an object' do 
  battingstat=BattingStat.new
  battingstat.expects(:save).returns(true)
  assert battingstat.save
end

test "stubbing instance methods " do
    batstats =  [stub(:hits => 1000), stub(:hits =>1500)]
    battingstat = BattingStat.new
    battingstat.stubs(:hits).returns(batstats)
    assert_equal [1000,1500], battingstat.hits.collect {|b| b.hits}
  end
  
test 'stubbing an instancee method on all instances ' do
   BattingStat.any_instance.stubs(:id).returns(3)
   battingstat = BattingStat.new
   assert_equal 3, battingstat.id
 end


test 'mock for an instance' do
  battingstat=BattingStat.find(3)
  BattingStat.expects(:find_triple_crown_player_by_year_and_league).with(2012,1).returns(battingstat)
  assert_equal battingstat, BattingStat.find_triple_crown_player_by_year_and_league(2012,1), 'Checking triple crown mock'
end

test 'find Triple Crown winner' do
  
  battingstat=BattingStat.new
  BattingStat.expects(:find_triple_crown_player_by_year_and_league).with(2012,1).returns(battingstat)
  assert_equal battingstat, BattingStat.find_triple_crown_player_by_year_and_league(2012,1), 'Checking triple crown mock'
end


test 'find Triple Crown winner and create award' do
  
  battingstat=BattingStat.find(3)
  BattingStat.expects(:find_triple_crown_player_by_year_and_league).with(2012,1).returns(battingstat)
  triple_crown_winner=  BattingStat.find_triple_crown_player_by_year_and_league(2012,1)
  triple_crown_award = PlayerAward.new
  triple_crown_award.league_id=triple_crown_winner.league_id
  triple_crown_award.player_id=triple_crown_winner.player_id
  triple_crown_award.award_year = triple_crown_winner.batting_year
  triple_crown_award.award_name = 'Triple Crown'
  assert triple_crown_award.save!, 'saving triple crown award'
end

test 'find a single Triple Crown winner and create award and noftify player' do
  battingstat=BattingStat.find(3)
  BattingStat.expects(:find_triple_crown_player_by_year_and_league).with(2012,1).returns(battingstat)
  triple_crown_winner=  BattingStat.find_triple_crown_player_by_year_and_league(2012,1)
  triple_crown_award = PlayerAward.new
  triple_crown_award.league_id=triple_crown_winner.league_id
  triple_crown_award.player_id=triple_crown_winner.player_id
  triple_crown_award.award_year = triple_crown_winner.batting_year
  triple_crown_award.award_name = 'Triple Crown'
  player=Player.find(triple_crown_winner.player_id)
  award=PlayerAward.find(1) 
  #stub e-mail notifcation - we don't really want to send an e-mail for this test
  PlayerMailer.stubs(:notify_award).returns(true)
  assert PlayerMailer.notify_award(:player,:award), 'Checking triple crown mock'
end




# The player that had the highest batting average AND the most home runs AND the most RBI in their league.

#award 'golden bat' award to highest home run in each league

#award 'Slugger' to highest slugging percentage

#award 'triple crown' to leagues' highest batting average and most home runs and most RBI in their league

end
