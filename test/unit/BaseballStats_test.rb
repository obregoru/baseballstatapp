require 'test_helper'
#must have relative for lib
require_relative '../../lib/BaseballStats.rb'
include BaseballStats
class BaseballStats_test < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "Getting batting average" do
    assert_equal 0.2,battingAverage(1, 5), 'Batting stats were correct'
  end
  
  test "prevent batting average divide by zero" do
    assert_nil battingAverage(1,0), 'Divide by zero'
  end 
  
  test "Calc slugging percentage" do
    #todo assert equal
    assert sluggingPercentage(10, 3,2,1, 20), 'Calculated slugging percentage'
    
  end
  
  test "prevent slugging percentage divide by zero" do
    assert_nil sluggingPercentage(10, 3,2,1, 0), 'Divide by zero'
  end  
  
  
  
end