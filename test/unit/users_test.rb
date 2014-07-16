require 'test_helper'

class UserTest < ActiveSupport::TestCase
 
  should validate_presence_of(:email)
  should validate_presence_of(:password)
  
  
  should_not allow_mass_assignment_of(:created_at)
  should_not allow_mass_assignment_of(:updated_at)
  
  
  test 'Should not save user with without an email address' do
    user=User.new
    assert !user.save, 'Save the user'
  end
  
  test 'Should not save user with an invalid e-mail address' do
    user=User.new
    user.email='invalid@invalid'
    assert !user.save, 'Save the user'
  end

  test 'Should not save a user with too small of a password' do
    user=User.new
    user.email = 'ruben@ruben.obregon.com'
    user.password ='1232'
    assert !user.save, 'Saving user with an invalid password'
  end
  
  test 'Should not save a user with a non-matching confirmation password' do
    user=User.new
    user.email = 'ruben@ruben.obregon.com'
    user.password ='1232'
    user.password_confirmation='abcd'
    assert !user.save, 'Saving user with an non-matching confirmation password'
  end 
  
  test 'Should save a user with a valid password' do
    user=User.new
    user.email = 'ruben@ruben.obregon.com'
    user.password ='12345678'
    assert user.save, 'Saving user with a valid password'
  end
  
  test 'Should update user with a valid e-mail address' do
    user = users(:Ruben)
    user.email='validaddress@gmail.com'
    assert user.save, 'Update user with valid address'
  end
  
  test 'Should not update user password with a short password' do
    user = users(:Ruben)
    user.password='12345'
    assert !user.save, 'Update user\'s password with short pwd'
  end
  
  test 'Should update user password with a short password' do
    user = users(:Ruben)
    user.password='12345678'
    assert user.save, 'Update user\'s password'
  end
  
  test 'Should destroy the user' do
    user = users(:Ruben)
    assert user.destroy, 'Destroy user'
    assert !User.exists?(user.id), 'Verify deletion of user account'
    assert_equal 0, User.count, 'Verifying the number of records'
  end


 
end