require 'test_helper'
class PlayerMailerControlerTest <ActiveSupport::TestCase
  fixtures :users
  def setup 
    @user=User.first
  end
  
test 'should notify player of award (mocks)' do
  
  player=Player.find(1)
  award=PlayerAward.find(1) 
  pMailer=PlayerMailer.send :new
  PlayerMailer.expects(:notify_award).with(:player,:award).returns(pMailer)
  assert_equal pMailer, PlayerMailer.notify_award(:player,:award), 'Checking triple crown mock'
  
end

test 'should notify player of an awards (stubs)' do
  player=Player.find(1)
  award=PlayerAward.find(1) 
  PlayerMailer.stubs(:notify_award).returns(true)
  assert_equal true, PlayerMailer.notify_award(:player,:award), 'Checking triple crown mock'
  
end

test 'should notify do ' do
  player=Player.find(1)
  award=PlayerAward.find(1) 
  PlayerMailer.notify_award(player,award)
end


end