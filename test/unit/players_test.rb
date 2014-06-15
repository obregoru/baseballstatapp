require 'test_helper'

class PlayerTest<ActiveSupport::TestCase
  
  should belong_to(:team)
  should have_many(:batting_stats)
  should have_many(:photos)
  should validate_presence_of(:first_name)
  should validate_presence_of(:last_name)
  
  should_not allow_mass_assignment_of(:created_at)
  should_not allow_mass_assignment_of(:updated_at)
  
  test "player must have first and last name" do
    player=Player.new
    player.first_name='Bo'
    refute player.save, 'Cannot save without both a first and last name'
  end
  
  test "save player with first and last name" do
    player=Player.new
    player.first_name='Bo'
    player.last_name='Jackson'
    assert player.save, 'Saved a player with a first and last name'
  end
  
  test "find player by last name" do
    player=Player.find_by_last_name("Bailey")
    assert_equal('Bailey', player.last_name, 'Must return player named "Bailey"')
  end
  
  test 'update player' do
    player=Player.find(2)
    player.first_name = 'Bob'
    assert player.save, 'Updated Player first name to bob'
  end
  
  test 'destroy player' do
    player=Player.find(1)
    assert player.destroy
    assert_equal 1, Player.count
  end
  
  test 'player first and last name are returned' do
    assert player=Player.find(1).first_and_last_name
    
    
  end
  
end