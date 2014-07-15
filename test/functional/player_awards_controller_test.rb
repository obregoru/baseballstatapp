require 'test_helper'

class PlayerAwardsControllerTest<ActionController::TestCase
  fixtures :users, :player_awards
  
  def setup
    assert @player_award=PlayerAward.new, 'setup'
    @player_award = player_awards(:GoldenBall)
    @user = users(:Ruben)
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
  
  test 'should create all player award' do
    sign_in @user
    assert_difference('PlayerAward.count') do
      assert post :create, player_award: {league_id: 1, award_year: 1997, award_name: "Golden Bat", player_id: 1}
    end
    assert_redirected_to player_award_path(assigns(:player_award)), 'Redirected to player_awards_path'
    sign_out @user
  end
  
  test 'should not create all player awards for all years - not authenticated' do
    assert post :create_awards
    assert_redirected_to user_session_path, 'Redirected to sign_in'
  end

  test 'should not destroy a PlaywerAward - not authenticated' do
    assert delete  :destroy, id: @player_award.id
    assert_redirected_to user_session_path, 'Redirected to sign_in'
  end
  
  test 'should destroy a PlayerAward' do
    sign_in @user
    assert_difference('PlayerAward.count', -1) do
      assert delete :destroy, id: @player_award.id
    end
    sign_out @user
  end
  
  test 'should not update PlayerAward - not authenticated' do
      put :update, :id=>player_awards(:GoldenBall), :player_award=>{:league_id=>1, :award_name=>'Test award', :player_id=>'1', :award_year=>'2012'}
      assert_redirected_to user_session_path, 'Redirected to sign_in path'
  end
  
  test 'should update PlayerAward' do
      sign_in @user
      put :update, :id=>player_awards(:GoldenBall), :player_award=>{:league_id=>1, :award_name=>'Updated award', :player_id=>'1', :award_year=>'2012'}
      assert_equal 'Updated award', assigns(:player_award).award_name, 'Update validated'
      sign_out @user
  end
  
  test 'should not create a PlayerAward - not authenticated' do
    post :create,  player_award: {:league_id=>1, :award_name=>'Test award', :player_id=>'1', :award_year=>'2012'}
    assert_redirected_to user_session_path, 'Redirected to sign_in path'
  end
  
  test 'should create a PlayerAward' do
    sign_in @user
    assert_difference('PlayerAward.count', 1) do 
      post :create,  player_award: {:league_id=>1, :award_name=>'Test award', :player_id=>'1', :award_year=>'2012'}
    end
    assert_redirected_to '/player_awards/2', 'Redirected to PlayerAward path'
    assert_equal 'Player award was successfully created.', flash[:notice]
    sign_out @user 
  end
  

  test 'should create player awards for all years' do
    assert post :create_awards
  end
  
  
  
end