require 'test_helper'
require_relative '../../lib/BaseballStats.rb'
include BaseballStats

class CalculateStatsTest< ActionDispatch::IntegrationTest
  fixtures :players
  
test 'calculate battering average for player' do
  player=Player.includes(:batting_stats).where(:last_name=>"Bailey").first
  puts player.batting_stats.first.hits.to_i # 8
  hits=player.batting_stats.first.hits.to_i # 8
  assert_equal(8,hits,'Verifying hits')
  at_bats=player.batting_stats.first.at_bats #70
  assert_equal(70,at_bats,'Verifying at bats')
  puts battingAverage(hits, at_bats)
  assert_equal(0.114,battingAverage(hits, at_bats), 'Battting average should be .114')
  
end

end
