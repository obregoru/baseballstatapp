require 'test_helper'
class PlayerMailerControlerTest <ActiveSupport::TestCase
  fixtures :users
  def setup 
    @user=users(:Ruben)
  end
  
test 'should notify player of award (mocks)' do
  
  player=players(:HomerBailey)
  award=player_awards(:GoldenBall)
  pMailer=PlayerMailer.send :new
  PlayerMailer.expects(:notify_award).with(:player,:award).returns(pMailer)
  assert_equal pMailer, PlayerMailer.notify_award(:player,:award), 'Checking triple crown mock'
  
end

test 'should notify player of an awards (stubs)' do
  player=players(:HomerBailey)
  award=  player_awards(:GoldenBall)
  PlayerMailer.stubs(:notify_award).returns(true)
  assert_equal true, PlayerMailer.notify_award(:player,:award), 'Checking triple crown mock'
  
end

test 'should notify do ' do
  player=players(:HomerBailey)
  award=player_awards(:GoldenBall)
  PlayerMailer.notify_award(player,award)
end


end