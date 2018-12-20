require 'test_helper'

class SurveyTest < ActiveSupport::TestCase
  test "surveys fail to save if they do not have a name" do
    survey = Survey.new

    assert_not survey.save
  end

  test "surveys fail to save if they do not have a unique name" do
    survey = Survey.new
    survey.name = "My First Survey"

    assert_not survey.save
  end

  test "surveys save when they have a unique name" do
    survey = Survey.new
    survey.name = "A Completely New Survey"

    assert survey.save
  end
end
