require 'test_helper'

class TeamTest < ActiveSupport::TestCase
  should belong_to(:league)
  should have_many(:players)  
  should have_many(:photos)
  should validate_presence_of(:team_name)
  should_not allow_mass_assignment_of(:created_at)
  should_not allow_mass_assignment_of(:updated_at)
  
  test 'team must have a team name' do
    team=Team.new
    refute team.save, 'saved the team'
  end
  
  test 'team saves with a team name' do
    team=Team.new
    team.team_name='Dodgers'
    assert team.save, 'saved the team with a team name'
  end
  
  
  test 'update Teams' do
    team=Team.find(2)
    team.team_name = 'Reds'
    assert team.save, 'Updated team name to Reds'
  end
  
  test 'destroy Team' do
    team=Team.find(2)
    assert team.destroy
    assert_equal 1, Team.count, 'Destroyed team 2'
  end
  
end