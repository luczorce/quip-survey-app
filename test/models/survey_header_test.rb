require 'test_helper'

class SurveyHeaderTest < ActiveSupport::TestCase
  test "the header wont save if its value is empty" do
    header = SurveyHeader.new
    
    header.survey = Survey.first
    header.value = ""

    assert_not header.save
  end
end
