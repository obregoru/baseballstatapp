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
    assert_equal 1, BattingStat.count
  end
  
  
  
  
end
