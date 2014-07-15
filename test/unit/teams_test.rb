require 'test_helper'

class TeamTest < ActiveSupport::TestCase
  should belong_to(:league)
  should have_many(:players)  
  should have_many(:photos)
  should have_many(:batting_stats)
  
  should validate_presence_of(:team_name)
  should validate_presence_of(:league_id)
  
  should_not allow_mass_assignment_of(:created_at)
  should_not allow_mass_assignment_of(:updated_at)
  
  
  test 'Team must have a team name' do
    team=Team.new
    assert !team.save, 'Saving the team without a team name'
  end
  
  test 'Team saves with a team name and league id' do
    team=Team.new
    team.league_id=1
    team.team_name='Dodgers'
    assert team.save, 'Save the team with a team name'
  end
  
  
  test 'Update Teams' do
    team=teams(:CincinnatiReds)
    team.team_name = 'Reds'
    assert team.save, 'Update team name to Reds'
  end
  
  test 'Destroy Team' do
    team=teams(:CincinnatiReds)
    assert team.destroy, 'Destroy team CincinnatiReds (team 2)'
    assert !Team.exists?(team.id), 'Check if team 2 still exists'
    assert_equal 1, Team.count, 'Verify team count'
  end
  
 
end