require 'test_helper'
class PlayersControllerTest< ActionController::TestCase
  
  def setup
    assert @player=Player.new, 'Setup'
    @player=players(:HomerBailey)
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
  
  test 'should create Player' do
    assert_difference('Player.count') do
      post :create, player: {first_name: 'Ruben', last_name: 'Obregon'}
    end
    assert_redirected_to player_path(assigns(:player)), 'Redirected to player'
    assert_equal 'Player was successfully created.', flash[:notice]
  end
  
  test 'should update player' do
    put :update, :id=> players(:HomerBailey), :player=>{:first_name=>'H.'}
    assert_equal 'H.', assigns(:player).first_name
  end

  test 'should destroy player' do
    assert_difference('Player.count', -1) do
      delete :destroy, id: @player.id
    end
    assert_redirected_to players_path
  end

  test 'should route to player' do
    assert_routing '/players/1', {controller: "players", action: "show", id: "1"}
  end
  
  
end