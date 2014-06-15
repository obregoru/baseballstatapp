require 'test_helper'

class TeamsControllerTest < ActionController::TestCase

  def setup
    assert  @team = Team.new, 'Setup'
    @team=teams(:NewYorkYankees)
    
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
  
  test 'should create Team' do
    assert_difference('Team.count') do
      post :create, team: {team_name: 'Other Team'}
    end
    assert_redirected_to team_path(assigns(:team)), 'Redirected to team_path'
    assert_equal 'Team was successfully created.', flash[:notice]
  end
  
  test "should update team" do
    put :update, :id=> teams(:NewYorkYankees), :team=>{:team_name => 'Cin Reds'}
    assert_equal "Cin Reds", assigns(:team).team_name
  end

  test "should destroy team" do 
    assert_difference('Team.count', -1) do
      delete :destroy, id: @team.id
    end
    assert_redirected_to teams_path
  end
  
  test 'set a custom header' do 
    @request.env["CUSTOM_HEADER"] = "bar"
    assert_difference('Team.count') do
      post :create, team: {team_name: 'Another Team'}
    end
    assert_redirected_to team_path(assigns(:team)), 'Redirected to team_path'
    assert_equal 'Team was successfully created.', flash[:notice]
    assert_equal @request.env["CUSTOM_HEADER"] = "bar", "bar"
  end

  test "should route to team" do
    assert_routing '/teams/1', {controller: "teams", action: "show", id: "1"}
  end
  
  
end
