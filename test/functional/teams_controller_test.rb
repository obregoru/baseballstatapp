require 'test_helper'

class TeamsControllerTest < ActionController::TestCase
  fixtures :users
  def setup
    assert  @team = Team.new, 'Setup'
    @team=teams(:NewYorkYankees)
    FactoryGirl.reload
    @user=User.first
    
  end
  
  def teardown
    @team = nil
  end 
  
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:teams), 'assigned @teams'
  end
  
  test "index should render correct layout" do
    get :index
    assert_template :index
    assert_template layout: "layouts/application"
  end
  
  test 'should show team' do
    get :show, id: @team.id
    assert_response :success
  end
  
  
  test 'should not create Team - not authenticated' do
     post :create, team: {league_id: 1, team_name: 'Other Team'}
     assert_redirected_to user_session_path, 'Redirected to sign_in'
  end
  
  test 'should create Team' do
    sign_in @user
    assert_difference('Team.count') do
      post :create, team: {league_id: 1, team_name: 'Other Team'}
    end
    assert_redirected_to team_path(assigns(:team)), 'Redirected to team_path'
    assert_equal 'Team was successfully created.', flash[:notice]
    sign_out @user
  end
 
  test 'should not update team - not authenticated' do
    put :update, :id=> teams(:NewYorkYankees), :team=>{:team_name => 'Cin Reds'}
    assert_redirected_to user_session_path, 'Redirect to sign_in path'
  end
  
  test 'should update team' do
    sign_in @user
    put :update, :id=> teams(:NewYorkYankees), :team=>{:team_name => 'Cin Reds'}
    assert_equal "Cin Reds", assigns(:team).team_name
    sign_out @user
  end

  test 'should destroy team' do 
    sign_in @user
    assert_difference('Team.count', -1) do
      delete :destroy, id: @team.id
    end
    assert_redirected_to teams_path
    sign_out @user
  end
  
  test 'should not destroy team - not authenticated' do 
      delete :destroy, id: @team.id
      assert_redirected_to user_session_path, 'Redirected to sign_in path'
  end
  
  test 'set a custom header' do 
    sign_in @user
    @request.env["CUSTOM_HEADER"] = "bar"
    assert_difference('Team.count') do
      post :create, team: {league_id: 1, team_name: 'Another Team',id: 200}
    end
    assert_redirected_to team_path(assigns(:team)), 'Redirected to team_path'
    assert_equal 'Team was successfully created.', flash[:notice]
    assert_equal @request.env["CUSTOM_HEADER"] = "bar", "bar"
    sign_out @user
  end

  test "should route to team" do
    assert_routing '/teams/1', {controller: "teams", action: "show", id: "1"}
  end
  

end
