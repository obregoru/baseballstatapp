require 'test_helper'

class SiteUsageTest < ActionDispatch::IntegrationTest

  # test unauthenticated user and authenticated user

  fixtures :users
  

  
  def sign_in_user
    #DRY - code this once
    #not all tests use authentication 
    #need to ensure actions are only by authenticated users
    
    visit('/users/sign_in')
    fill_in('user[email]',:with=>users(:Ruben).email)
    fill_in('user[password]',:with=>'rubyonrails')
    click_on('Sign in')
  
  
  end
  
  #test unauthenticated user flow first ----------------------
  should 'visit home page' do
    visit('/')
  end
  
  test 'visit league page' do
    visit('/')
    click_link('Leagues')
    assert page.has_content?('Listing Leagues')
  end
  
  test 'visit team page' do
    visit('/')
    click_link('Teams')
    assert page.has_content?('Listing Teams')
  end
  test 'visit players page' do
    visit('/')
    click_link('Players')
    assert page.has_content?('Listing Players')
  end
  
  test 'visit batting stats page' do
    visit('/')
    click_link('Batting Stats')
    assert page.has_content?('Listing Batting Stats')
  end
  
  test 'visit player awards page' do
    visit('/')
    click_link('Player Awards')
    assert page.has_content?('Listing Player Awards')
  end
  
  
  test 'Sign in, create a league, create a team, create a player' do
    
    sign_in_user
    
    assert_difference('League.count', 1) do
      visit('/leagues')
      click_link('New League')
      assert page.has_content?('New League')
      fill_in('League name', :with => 'Rails League')
      click_on('Create League')
      assert page.has_content?('League was successfully created.')
    end 
      assert_difference('Team.count', 1) do
        visit('/teams')
        click_link('New Team')
        assert page.has_content?('New Team')
        select('Rails League', :from =>'team[league_id]')
        fill_in('Team name', :with => 'OOPland Railers')
        click_on('Create Team')
        assert page.has_content?('Team was successfully created.')
      end
      
      assert_difference('Player.count', 1) do
        visit('/players')
        click_link('New Player')
        assert page.has_content?('New Player')
        select('OOPland Railers', :from =>'player[team_id]')
        fill_in('First name', :with => 'Ruby')
        fill_in('Last name', :with => 'Rails')
        click_on('Create Player')
        assert page.has_content?('Player was successfully created.')
      end   
      assert_difference('BattingStat.count', 1) do
        visit('/batting_stats')
        click_link('New Batting stat')
        assert page.has_content?('New Batting Stat')
        select('Ruby Rails', :from =>'batting_stat[player_id]')
        select('Rails League', :from =>'batting_stat[league_id]')
        select('OOPland Railers', :from =>'batting_stat[team_id]')
        fill_in('Batting year', :with => '2014')
        fill_in('At bats', :with => 100)
        fill_in('Hits', :with=>80)
        fill_in('Doubles', :with=>70)
        fill_in('Triples', :with=>60)
        fill_in('Home runs', :with=>50)
        fill_in('Runs batted', :with=>40)
        fill_in('Batting average',  :with=>BaseballStats.battingAverage(80, 100))
        fill_in('Slugging percentage', :with =>BaseballStats.sluggingPercentage(80, 70, 60, 50, 100))
        click_on('Create Batting stat')
        assert page.has_content?('Batting stat was successfully created.')
      end   
      
    click_link("Sign out")
  end
  
  # authenticated user tests

  test 'Sign in, create league' do
    sign_in_user
    assert_difference('League.count', 1) do
      visit('/leagues')
      click_link('New League')
      assert page.has_content?('New League')
      fill_in('League name', :with => 'Rails League')
      click_on('Create League')
    end
    click_link("Sign out")
  end
  
  test 'create team' do
      sign_in_user
      assert_difference('Team.count', 1) do
        visit('/teams')
        click_link('New Team')
        assert page.has_content?('New Team')
        select('American League', :from =>'team[league_id]')
        fill_in('Team name', :with => 'OOPland Railers')
        click_on('Create Team')
      end
      click_link("Sign out")
  end
    
  test 'create player' do
      sign_in_user
      assert_difference('Player.count', 1) do
        visit('/players')
        click_link('New Player')
        assert page.has_content?('New Player')
        select('New York Yankees', :from =>'player[team_id]')
        fill_in('First name', :with => 'Ruby')
        fill_in('Last name', :with => 'Rails')
        click_on('Create Player')
      end   
      click_link("Sign out")
  end 
  
    test 'create batting stats' do
      sign_in_user
      assert_difference('BattingStat.count', 1) do
        visit('/batting_stats')
        click_link('New Batting stat')
        assert page.has_content?('New Batting Stat')
        select('Bobby Abreu', :from =>'batting_stat[player_id]')
        select('American League', :from =>'batting_stat[league_id]')
        select('New York Yankees', :from =>'batting_stat[team_id]')
        fill_in('Batting year', :with => '2014')
        fill_in('At bats', :with => 100)
        fill_in('Hits', :with=>80)
        fill_in('Doubles', :with=>70)
        fill_in('Triples', :with=>60)
        fill_in('Home runs', :with=>50)
        fill_in('Runs batted', :with=>40)
        fill_in('Batting average',  :with=>BaseballStats.battingAverage(80, 100))
        fill_in('Slugging percentage', :with =>BaseballStats.sluggingPercentage(80, 70, 60, 50, 100))
        click_on('Create Batting stat')
      end   
      click_link("Sign out")
    end     
    
    test 'create player award' do
     sign_in_user
      assert_difference('PlayerAward.count', 1) do
        visit('/player_awards')
        click_link('New Player award')
        assert page.has_content?('New Player Award')
        select('American League', :from =>'player_award[league_id]')
        fill_in('Award year', :with => '2014')
        fill_in('Award name', :with => 'Ruby Batting Award')
        select('Bobby Abreu',:from=>'player_award[player_id]')
        click_on('Create Player award')
      end   
      click_link("Sign out")
    end 
    
    test 'test create league photo ' do
     sign_in_user
      assert_difference('Photo.count',1) do
        visit('/leagues/1')
        click_link('Add photo')
        assert page.has_content?('New Photo')
        fill_in('Photo name', :with=>'American League - new logo')
        fill_in('File name', :with=> 'ALlogo3.png')
        click_on('Create Photo')
      end
      click_link("Sign out")
    end 
    
    
    test 'create team photo' do
     sign_in_user
      assert_difference('Photo.count',1) do
        visit('/teams/1')
        click_link('Add photo')
        assert page.has_content?('New Photo')
        fill_in('Photo name', :with=>'New York Yankees - 2014 team photo')
        fill_in('File name', :with=> 'NYY2014team.png')
        click_on('Create Photo')
      end
      click_link("Sign out")
    end
    
    test 'create player photo' do
      sign_in_user
      assert_difference('Photo.count',1) do
        visit('/players/2')
        click_link('Add photo')
        assert page.has_content?('New Photo')
        fill_in('Photo name', :with=>'Bobby Abreu - 2014')
        fill_in('File name', :with=> 'NYY2014BAbreu.png')
        click_on('Create Photo')
      end
      click_link("Sign out")
    end
  
    test 'create all player award' do
      sign_in_user
      visit('/create_awards')
      assert page.has_content?('Awards created')
      click_link("Sign out")
    end 

end
