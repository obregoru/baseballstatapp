require 'test_helper'

class UserControllerTest < ActionController::TestCase
  include Devise::TestHelpers
  
  # no controller created for devise
  fixtures :users
  
  setup do
    @user = users(:Ruben)
  end

  test 'login as a user' do
    #login_as(:Ruben)
    sign_in @user

  end
  
  test 'logout' do
    
    sign_out @user
 
  end
  

 
end