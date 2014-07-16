require 'test_helper'

class PlayerTest<ActiveSupport::TestCase
  fixtures :players
  
  should belong_to(:team)
  should have_many(:batting_stats)
  
  should have_many(:photos)
  should have_many(:player_awards)
  
  should validate_presence_of(:first_name)
  should validate_presence_of(:last_name)
  should validate_presence_of(:team_id)
  
  should_not allow_mass_assignment_of(:created_at)
  should_not allow_mass_assignment_of(:updated_at)
  
  test "player must have first and last name and league id" do
    player=Player.new
    player.first_name='Bo'
    assert !player.save, 'Save without both a first and last name and league_id'
  end
  
  test "save player with team_id, first and last name" do
    player=Player.new
    player.team_id=1
    player.first_name='Bo'
    player.last_name='Jackson'
    assert player.save, 'Save the player'
  end
  
  test "find player by last name" do
    player=Player.find_by_last_name("Bailey")
    assert_equal('Bailey', player.last_name, 'Return a player named "Bailey"')
  end
  
  test 'update player' do
    player=players(:BobbyAbreu)
    player.first_name = 'Bob'
    assert player.save, 'Update Player first name to Bob'
  end
  
  test 'destroy player' do
    player=players(:HomerBailey)
    assert player.destroy, 'Destroy Player'
    assert !Player.exists?(player.id), 'Player destroyed'
    assert_equal 1, Player.count, 'Player count reflects destroy'
  end
  
  test 'player first and last name are returned' do
    player=players(:HomerBailey)
    assert_equal 'Homer Bailey', player=players(:HomerBailey).first_and_last_name, 'Returns first and last name'
  end
  
end