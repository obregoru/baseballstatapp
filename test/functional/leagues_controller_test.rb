require 'test_helper'
class LeaguesControllerTest < ActionController::TestCase
  
  def setup
    assert  @league = League.new, 'Setup'
    @league=leagues(:nl)
    
  end
  
  def teardown
    @league = nil
  end 
  
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:leagues), 'assigned @league'
  end
  
  test "index should render correct layout" do
    get :index
    assert_template :index
    assert_template layout: "layouts/application"
  end
  
  test 'should show league' do
    get :show, id: @league.id
    assert_response :success
  end
  
  test 'should create League' do
    assert_difference('League.count') do
      post :create, league: {league_name: 'Other League'}
    end
    assert_redirected_to league_path(assigns(:league)), 'Redirected to league_path'
    assert_equal 'League was successfully created.', flash[:notice]
  end
  
  test "should update league" do
    put :update, :id=> leagues(:al), :league=>{:league_name => 'American League Updated'}
    assert_equal "American League Updated", assigns(:league).league_name
  end

  test "should destroy league" do 
    assert_difference('League.count', -1) do
      delete :destroy, id: @league.id
    end
    assert_redirected_to leagues_path
  end
  
  test 'set a custom header' do 
    @request.env["CUSTOM_HEADER"] = "bar"
    assert_difference('League.count') do
      post :create, league: {league_name: 'Another League'}
    end
    assert_redirected_to league_path(assigns(:league)), 'Redirected to league_path'
    assert_equal 'League was successfully created.', flash[:notice]
    assert_equal @request.env["CUSTOM_HEADER"] = "bar", "bar"
  end

  test "should route to league" do
    assert_routing '/leagues/1', {controller: "leagues", action: "show", id: "1"}
  end
  
  
end
