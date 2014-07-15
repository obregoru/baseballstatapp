require 'test_helper'
class PlayersControllerTest< ActionController::TestCase
  fixtures :users
  
  def setup
    assert @player=Player.new, 'Setup'
    @player=players(:HomerBailey)
    FactoryGirl.reload
    @user=users(:Ruben)
  end
  
  def teardown
    @player=nil
  end
  
  test 'should get index' do
    get :index
    assert_response :success
    assert_not_nil assigns(:players), 'assigned @players'
  end
  
  test 'index should render correct layout' do
    get :index
    assert_template :index
    assert_template 'layouts/application'
  end
  
  test 'should show player ' do
    get :show, id: @player.id
    assert_response :success
  end
  
  test 'should not create Player - not authenticated' do
    post :create, player: {team_id: 1, first_name: 'Ruben', last_name: 'Obregon'}
    assert_redirected_to user_session_path,'Redirected to sign_in path'
  end
  
  test 'should create Player' do
    sign_in @user
    assert_difference('Player.count') do
      post :create, player: {team_id: 1, first_name: 'Ruben', last_name: 'Obregon'}
    end
    assert_redirected_to player_path(assigns(:player)), 'Redirected to player'
    assert_equal 'Player was successfully created.', flash[:notice]
    sign_out @user
  end
  
 
  test 'should not update Player - not authenticated' do
    put :update, :id=> players(:HomerBailey), :player=>{:first_name=>'H.'}
    assert_redirected_to user_session_path, 'Redirected to sign_in'
  end
  
  
  test 'should update Player' do
    sign_in @user
    put :update, :id=> players(:HomerBailey), :player=>{:first_name=>'H.'}
    assert_equal 'H.', assigns(:player).first_name, 'Verify first_name update'
    sign_out @user
  end

  test 'should destroy player' do
    sign_in @user
    assert_difference('Player.count', -1) do
      delete :destroy, id: @player.id
    end
    assert_redirected_to players_path, 'Redirected to Players path'
    sign_out @user
  end

  test 'should not destroy player - not authenticated' do
    delete :destroy, id: @player.id
    assert_redirected_to user_session_path, 'Redirected to sign_in path'

  end

  test 'should route to player' do
    assert_routing '/players/1', {controller: "players", action: "show", id: "1"}
  end
  
  
end