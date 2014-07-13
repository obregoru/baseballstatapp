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
    team=Team.find(2)
    team.team_name = 'Reds'
    assert team.save, 'Update team name to Reds'
  end
  
  test 'Destroy Team' do
    team=Team.find(2)
    assert team.destroy, 'Destroy team 2'
    assert !Team.exists?(2), 'Check if team 2 still exists'
    assert_equal 1, Team.count, 'Verify team count'
  end
  
  test 'update notes with team slugging percenatge' do
    year=2012
    team_id=2
    team_slugging_percentage=BattingStat.new.get_sum_team_batting_stats(team_id, year)
    assert team_slugging_percentage, 'Got the slugging percentage'
    if !(team_slugging_percentage.nil?)
      team=Team.find(team_id)
      team.notes= 'Team slugging percentage ' + team_slugging_percentage.to_s
      assert team.save,  'Save the team record with the updated notes field'
    end
  end
end