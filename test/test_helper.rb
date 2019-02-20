ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # set our authentication for test cases
  ENV["SECURE_KEY"] = "testing"

  def get_test_creds
    { Authorization: "Bearer testing" }
  end

  # Add more helper methods to be used by all tests here...
end
