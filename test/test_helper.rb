ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # set our authentication for test cases
  ENV["SECURE_KEY"] = "testing"

  # Add more helper methods to be used by all tests here...
  def get_test_creds
    { Authorization: "Bearer testing" }
  end

  def answer_create_route(question_id)
    "/questions/#{question_id}/answers"
  end

  def question_create_route(survey_id)
    "/surveys/#{survey_id}/questions"
  end

  def question_delete_route(type, id)
    "/questions/#{type}/#{id}"
  end

  def question_update_route(question_id)
    "/questions/#{question_id}"
  end

  def survey_clone_route(survey_id)
    "/surveys/#{survey_id}/clone"
  end

end
