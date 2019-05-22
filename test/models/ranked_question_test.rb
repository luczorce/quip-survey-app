require 'test_helper'

class RankedQuestionTest < ActiveSupport::TestCase
  test "the question will not save if its question is empty" do
    question = RankedQuestion.new
    question.survey = Survey.first
    question.question = ""
    question.options = ["test", "another"]

    assert_not question.save
  end

  test "the question will not save if it's a duplicate in the survey" do
    question = RankedQuestion.new
    question.survey = Survey.first
    question.question = "I AM THE QUESTION TO END ALL QUESTIONS"
    question.options = ["test", "another"]

    assert question.save

    question = RankedQuestion.new
    question.survey = Survey.first
    question.question = "I AM THE QUESTION TO END ALL QUESTIONS"
    question.options = ["test", "another"]

    assert_not question.save
  end

  test "the question will not save if has no options" do
    question = RankedQuestion.new
    question.survey = Survey.first
    question.question = "a question"
    # question.options = ["test", "another"]

    assert_not question.save
  end

  test "the question will not save if there is a duplicate in its options" do
    question = RankedQuestion.new
    question.survey = Survey.first
    question.question = "a question"
    question.options = ["test", "test"]

    assert_not question.save
  end

  test "the question will be deleted when the survey it belongs to is deleted" do
    question = RankedQuestion.new
    question.survey = Survey.first
    question.question = "I AM THE QUESTION TO END ALL QUESTIONS"
    question.options = ["test", "another"]

    question.save
    id = question.id

    Survey.first.destroy
    assert_not RankedQuestion.all.include?(question)
  end
end
