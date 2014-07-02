require 'test_helper'

class SiteUsageTest < ActionDispatch::IntegrationTest
  #initial tests
  should 'visit home page' do
    visit('/')
  end
  
  test 'visit league page' do
    visit('/')
    click_link('Leagues')
    assert page.has_content?('Listing leagues')
  end
  
  test 'visit team page' do
    visit('/')
    click_link('Teams')
    assert page.has_content?('Listing teams')
  end
  test 'visit players page' do
    visit('/')
    click_link('Players')
    assert page.has_content?('Listing players')
  end
  
  test 'visit batting stats page' do
    visit('/')
    click_link('Batting Stats')
    assert page.has_content?('Listing batting_stats')
  end
  
  test 'visit player awards page' do
    visit('/')
    click_link('Player Awards')
    assert page.has_content?('Listing player_awards')
  end
  #create league
  
  test 'create league' do
    assert_difference('League.count', 1) do
      visit('/leagues')
      click_link('New League')
      assert page.has_content?('New league')
      fill_in('League name', :with => 'Rails League')
      click_on('Create League')
    end
  end
    test 'create team' do
      assert_difference('Team.count', 1) do
        visit('/teams')
        click_link('New Team')
        assert page.has_content?('New team')
        select('American League', :from =>'team[league_id]')
        fill_in('Team name', :with => 'OOPland Railers')
        click_on('Create Team')
      end
    end
    test 'create player' do
      assert_difference('Player.count', 1) do
        visit('/players')
        click_link('New Player')
        assert page.has_content?('New player')
        select('New York Yankees', :from =>'player[team_id]')
        fill_in('First name', :with => 'Ruby')
        fill_in('Last name', :with => 'Rails')
        click_on('Create Player')
      end   
    end 
    test 'create batting stats' do
      assert_difference('BattingStat.count', 1) do
        visit('/batting_stats')
        click_link('New Batting stat')
        assert page.has_content?('New batting_stat')
        select('Bobby Abreu', :from =>'batting_stat[player_id]')
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
    end     
    test 'create player award' do
      assert_difference('PlayerAward.count', 1) do
        visit('/player_awards')
        click_link('New Player award')
        assert page.has_content?('New player_award')
        select('American League', :from =>'player_award[league_id]')
        fill_in('Award year', :with => '2014')
        fill_in('Award name', :with => 'Ruby Batting Award')
        select('Bobby Abreu',:from=>'player_award[player_id]')
        click_on('Create Player award')
      end   
    end 
    
    test 'test create league photo ' do
      assert_difference('Photo.count',1) do
        visit('/leagues/1')
        click_link('Add photo')
        assert page.has_content?('New photo')
        fill_in('Photo name', :with=>'American League - new logo')
        fill_in('File name', :with=> 'ALlogo3.png')
        click_on('Create Photo')
      end
    end 
    
    
    test 'create team photo' do
      assert_difference('Photo.count',1) do
        visit('/teams/1')
        click_link('Add photo')
        assert page.has_content?('New photo')
        fill_in('Photo name', :with=>'New York Yankees - 2014 team photo')
        fill_in('File name', :with=> 'NYY2014team.png')
        click_on('Create Photo')
      end
    end
    
    test 'create player photo' do
      assert_difference('Photo.count',1) do
        visit('/players/2')
        click_link('Add photo')
        assert page.has_content?('New photo')
        fill_in('Photo name', :with=>'Bobby Abreu - 2014')
        fill_in('File name', :with=> 'NYY2014BAbreu.png')
        click_on('Create Photo')
      end
    end

end
