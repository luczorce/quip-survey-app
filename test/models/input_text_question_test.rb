require 'test_helper'

class InputTextQuestionTest < ActiveSupport::TestCase
  test "wont save if the question is missing" do
    question = InputTextQuestion.new
    question.survey = Survey.first

    assert_not question.save
  end

  test "wont save if the question is not unique to the survey" do
    question_first = InputTextQuestion.new
    question_first.survey = Survey.first
    question_first.question = "First Question?"
    question_first.save

    question_second = InputTextQuestion.new
    question_second.survey = Survey.first
    question_second.question = "First Question?"

    assert_not question_second.save
  end

  test "will save even if the question is repeated, outside its own survey" do
    question_first = InputTextQuestion.new
    question_first.survey = Survey.first
    question_first.question = "First Question?"
    question_first.save

    question_second = InputTextQuestion.new
    question_second.survey = Survey.last
    question_second.question = "First Question?"

    assert question_second.save
  end

  test "will be deleted when the survey it belongs to is deleted" do
    question = InputTextQuestion.new
    question.survey = Survey.last
    question.question = "First Question?"
    question.save

    id = question.id

    Survey.last.destroy
    assert_not InputTextQuestion.all.include?(question)
  end
end
