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
  
  
  test 'team must have a team name' do
    team=Team.new
    refute team.save, 'saved the team'
  end
  
  test 'team saves with a team name and league id' do
    team=Team.new
    team.league_id=1
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
  
  test 'update notes' do
    year=2012
    team_id=2
    team_slugging_percentage=BattingStat.new.get_sum_team_batting_stats(team_id, year)
    assert team_slugging_percentage
    if !(team_slugging_percentage.nil?)
      team=Team.find(team_id)
      team.notes= 'Team slugging percentage ' + team_slugging_percentage.to_s
      refute team.save
    end
  end
end