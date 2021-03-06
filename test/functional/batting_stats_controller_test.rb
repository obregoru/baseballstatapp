require 'test_helper'
class BattingStatsControllerTest <ActionController::TestCase

fixtures :users

  def setup
    assert @battingstat=BattingStat.new,'Setup'
    @batting_stat=batting_stats(:BobbyAbreu)
    @user = users(:Ruben)
    @league = leagues(:al)
  end
  
  def teardown
    @batting_stat=nil
  end
  
  test 'should get index' do
    get :index
    assert_response :success
    assert_not_nil assigns(:batting_stats), 'Assigned @batting_stats'
  end
  
  test 'index should render correct layout' do
    get :index
    assert_template :index
    assert_template layout: "layouts/application"
  end
  
  test 'should show batting stats' do
    get :show, id: @batting_stat.id
    assert_response :success
  end
  
# begin batting stats -----------------------------------------------------
  test 'should not create batting_stat - user not authenticated' do
    assert_difference('BattingStat.count',0) do
       post :create, batting_stat: {
        player_id: 2, 
        at_bats:10, 
        hits: 5,
        doubles: 2, 
        triples: 1, 
        home_runs: 5, 
        runs_batted: 8, 
        batting_year: 1999, 
        league_id: 2, 
        team_id: 2, 
        batting_average: 0.123, 
        slugging_percentage: 0.432 
      }
    end
    assert_redirected_to user_session_path, 'Redirected to user sign in'   
  end
  
  
  test 'should create batting_stat' do
    sign_in @user
    assert_difference('BattingStat.count') do
      assert post :create, batting_stat: {
        player_id: 2, 
        at_bats:10, 
        hits: 5,
        doubles: 2, 
        triples: 1, 
        home_runs: 5, 
        runs_batted: 8, 
        batting_year: 1999, 
        league_id: 2, 
        team_id: 2, 
        batting_average: 0.123, 
        slugging_percentage: 0.432 
      }
    end
    assert_redirected_to batting_stat_path(assigns(:batting_stat)), 'Redirected to batting_stats_path'
    assert_equal 'Batting stat was successfully created.',flash[:notice]
    sign_out @user
  end
  
  test 'should not update batting_stat - not authenticated' do
    put :update, :id=>@batting_stat, :batting_stat=>{:hits=>100}
    assert_redirected_to user_session_path, 'Redirected to user sign in'   
  end
  
  test 'should update batting_stat' do
    sign_in @user
    put :update, :id=>@batting_stat, :batting_stat=>{:hits=>100}
    assert_equal 100, assigns(:batting_stat).hits
    sign_out @user
  end
  
  
  test 'should not destroy batting_stat - user not authenticated' do
    assert_difference('BattingStat.count', 0) do
      delete :destroy, id: @batting_stat.id 
    end
    assert_redirected_to user_session_path, 'Redirected to user sign in'   
  end
  
  test 'should destroy batting_stat' do
    sign_in @user
    assert_difference('BattingStat.count', -1) do
      delete :destroy, id: @batting_stat.id
    end
    sign_out @user
  end  
  
  test 'should route to batting stats' do
    assert_routing '/batting_stats/1', {controller: "batting_stats", action: "show", id: "1"}
  end 
  

      
end