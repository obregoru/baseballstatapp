require 'test_helper'

class LeagueTest< ActiveSupport::TestCase
  
  should have_many(:teams)
  should have_many(:photos)
  should validate_presence_of(:league_name)
  
  should_not allow_mass_assignment_of(:created_at)
  should_not allow_mass_assignment_of(:updated_at)
  
  test 'leagues count ' do
    assert_equal 2, League.count
  end
  
  
  test 'league must have a league name' do
    league = League.new
    refute league.save, 'Saved a league without a name'
  end
  
  test 'league saves with a name' do
    league=League.new
    league.league_name='Milwaukee Brewers'
    assert league.save, 'Saved the league with a name'
  end
  
  test 'update League' do
    league=leagues(:al)
    league.league_name = 'International League'
    assert league.save, 'Update the league name to International League'
  end
  
  test 'Destroy league record 1' do
    league=leagues(:al)
    assert league.destroy, 'Delete the league record with id of 1'
    assert !League.exists?(league.id), 'Check if league still exists'   
    assert_equal 1, League.count, 'Verify new league count'
  end
  
end