require 'test_helper'
require 'rails/performance_test_help'

class BrowsingTest < ActionDispatch::PerformanceTest
  # Refer to the documentation for all available options
  # self.profile_options = { :runs => 5, :metrics => [:wall_time, :memory]
  #                          :output => 'tmp/performance', :formats => [:flat] }

  def test_homepage
    get '/'
  end
  
  def test_leagues
    get '/leagues'
  end
  
  def test_teams
    get '/teams'
  end
  
  def test_players
    get '/players'
  end
  
  def test_batting_stats
    get '/batting_stats'
  end
end
