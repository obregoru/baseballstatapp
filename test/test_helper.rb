ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'shoulda'
require 'database_cleaner'
require 'capybara/rails'
require 'mocha/setup'
Mocha::Configuration.allow(:stubbing_non_existent_method)

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.(yml|csv) for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  fixtures :all
  include FactoryGirl::Syntax::Methods
  DatabaseCleaner.strategy = :deletion
  # Add more helper methods to be used by all tests here...
  
  
 
end

class ActionController::TestCase
  def teardown
    DatabaseCleaner.clean      
   
  end
end
class ActionDispatch::IntegrationTest
  include Capybara::DSL
end