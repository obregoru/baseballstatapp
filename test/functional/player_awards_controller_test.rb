require 'test_helper'

class PlayerAwardsControllerTest<ActionController::TestCase
  fixtures :users
  
  def setup
    assert @player_award=PlayerAward.new, 'setup'
    @player_award = player_awards(:GoldenBall)
    @user = User.first
  end
  
  test 'should get index' do
    get :index
    assert_response :success
    assert_not_nil assigns(:player_awards), 'Assigned @player_awards'
  end
  
  test 'index should render correct layout' do
    get :index
    assert_template :index
    assert_template layout: "layouts/application"
  end
  
  test 'should show player award' do
    get :show, id: @player_award.id
    assert_response :success
  end
  
  test 'should create player award' do
    sign_in @user
    assert_difference('PlayerAward.count') do
      assert post :create, player_award: {league_id: 1, award_year: 1997, award_name: "Golden Bat", player_id: 1}
    end
    assert_redirected_to player_award_path(assigns(:player_award)), 'Redirected to player_awards_path'
  end
  
  
  test 'should create player awards for all years' do
    assert post :create_awards
  
  end
  
  
  
end