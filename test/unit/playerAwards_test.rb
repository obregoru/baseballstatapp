require 'test_helper'

class PlayerAwardTest< ActiveSupport::TestCase
  
  
should belong_to :league
should belong_to :player

should validate_presence_of(:league_id)
should validate_presence_of(:player_id)

should_not allow_mass_assignment_of(:created_at)
should_not allow_mass_assignment_of(:updated_at)  

test "create an instance of PlayerAward" do
  player_award=PlayerAward.new
  assert_instance_of PlayerAward, player_award, 'Must be an instance of Player_Award'
end


test "should not save PlayerAward without an award name"  do
   player_award=PlayerAward.new(:award_year=>1996)
   assert !player_award.save, 'Save PlayerAward without an award name'
end
  
test "should not save PlayerAward without an award year"  do
   player_award=PlayerAward.new(:award_name=>'Golden Ball')
   assert !player_award.save, 'Save PlayerAward without an award year'
end
  
test "should save PlayerAward with required fields"  do
   player_award=PlayerAward.new
   player_award.league_id=1
   player_award.player_id=1
   player_award.award_year=1997
   player_award.award_name='Golden Ball'
   assert player_award.save!, 'Save PlawerAward with all required fields'
   
end 

test "should not save PlayerAward with a non-numeric award year"  do
   player_award=PlayerAward.new
   player_award.award_year="abcd"
   player_award.award_name='Golden Ball'
   assert !player_award.save, 'Save PlayerAward with a non-numeric year'
   
end 

test 'upadate PlayerAward' do
  player_award=player_awards(:GoldenBall)
  player_award.award_name='Updated Award'
  player_award.award_year=1999
  assert player_award.save!, 'Update PlayerAward award name and award year'
end

test 'destroy PlayerAward' do
  player_award=player_awards(:GoldenBall) 
  assert player_award.destroy, 'Destroy PlayerAward with id of 1'
  assert !PlayerAward.exists?(player_award.id), 'Check if Player Award 1 still exists'
  assert_equal 0, PlayerAward.count , 'Verify PlayerAward count'
end


  
end
