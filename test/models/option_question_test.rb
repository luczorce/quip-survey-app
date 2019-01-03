require 'test_helper'

class OptionQuestionTest < ActiveSupport::TestCase
  test "the question will save when its type is select" do
    question = OptionQuestion.new
    question.survey = Survey.first
    question.question = "First select question?"
    question.options = ["one", "two"]
    question.question_type = "select"
    
    assert question.save
  end

  test "the question will save when its type is radio" do
    question = OptionQuestion.new
    question.survey = Survey.first
    question.question = "First radio question?"
    question.options = ["one", "two"]
    question.question_type = "radio"
    
    assert question.save
  end

  test "the question will save when its type is checkbox" do
    question = OptionQuestion.new
    question.survey = Survey.first
    question.question = "First checkbox question?"
    question.options = ["one", "two"]
    question.question_type = "checkbox"
    
    assert question.save
  end

  test "the question will not save when its type is anything but (select, radio, checkbox)" do
    question = OptionQuestion.new
    question.survey = Survey.first
    question.question = "First funky question?"
    question.options = ["one", "two"]
    question.question_type = "funky option"
    
    assert_not question.save
  end

  test "the question will not save when its not unique to the survey" do
    question = OptionQuestion.new
    question.survey = Survey.first
    question.question = "First option question?"
    question.options = ["one", "two"]
    question.question_type = "checkbox"
    
    question.save

    another = OptionQuestion.new
    another.survey = Survey.first
    another.question = "First option question?"
    another.options = ["one", "two"]
    another.question_type = "checkbox"
    
    assert_not another.save
  end

  # test "the question will not save when its not unique to the survey, amongst other types of questions" do
  #   TODO this doesn't actually get validated correctly
  # end

  test "the question will save when it is unique to the survey" do
    question = OptionQuestion.new
    question.survey = Survey.first
    question.question = "First option question?"
    question.options = ["one", "two"]
    question.question_type = "checkbox"
    
    question.save

    another = OptionQuestion.new
    another.survey = Survey.last
    another.question = "First option question?"
    another.options = ["one", "two"]
    another.question_type = "checkbox"
    
    assert another.save
  end

  # test "the question will save when it is unique to the survey, amongst other types of questions" do
  #   TODO this doesn't actually get validated correctly
  # end

  test "the question will not save when it has no options" do
    question = OptionQuestion.new
    question.survey = Survey.first
    question.question = "First option question?"
    # question.options = ["one", "two"]
    question.question_type = "checkbox"
    
    assert_not question.save
  end

  test "will be deleted when the survey it belongs to is deleted" do
    question = OptionQuestion.new
    question.survey = Survey.last
    question.question = "First Question?"
    question.options = ["one", "two"]
    question.question_type = "checkbox"
    question.save

    id = question.id

    Survey.last.destroy
    assert_not OptionQuestion.all.include?(question)
  end
end
