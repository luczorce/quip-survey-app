require 'test_helper'

class InputNumberAnswerTest < ActiveSupport::TestCase
  test "will not save if the quip_id is missing" do
    answer = InputNumberAnswer.new
    answer.input_number_question = InputNumberQuestion.first

    assert_not answer.save
  end

  test "will not save if the quip_id is not unique" do
    answer = InputNumberAnswer.new
    answer.input_number_question = InputNumberQuestion.first
    answer.quip_id = "quipDocumentId"
    answer.save

    another = InputNumberAnswer.new
    another.input_number_question = InputNumberQuestion.first
    another.quip_id = "quipDocumentId"

    assert_not another.save
  end

  test "will save if the quip_id is not unique but with a different question" do
    answer = InputNumberAnswer.new
    answer.input_number_question = InputNumberQuestion.first
    answer.quip_id = "quipDocumentId"
    answer.save

    another = InputNumberAnswer.new
    another.input_number_question = InputNumberQuestion.last
    another.quip_id = "quipDocumentId"

    assert another.save
  end

  test "will save when the quip_id is provided" do
    answer = InputNumberAnswer.new
    answer.input_number_question = InputNumberQuestion.first
    answer.quip_id = "quipDocumentId"

    assert answer.save
  end

  test "will be deleted when the question it belongs to is destroyed" do
    answer = InputNumberAnswer.new
    answer.input_number_question = InputNumberQuestion.first
    answer.quip_id = "quipDocumentId"

    answer.save

    InputNumberQuestion.first.destroy
    assert_not InputNumberAnswer.all.include?(answer)
  end

  test "will be deleted when the survey (that the question it belongs to) is destroyed" do
    answer = InputNumberAnswer.new
    answer.input_number_question = InputNumberQuestion.first
    answer.quip_id = "quipDocumentId"

    answer.save

    InputNumberQuestion.first.survey.destroy
    assert_not InputNumberAnswer.all.include?(answer)
  end

  test "will not save if its answer is less than the questions min number, when it only has a min" do
    answer = InputNumberAnswer.new
    answer.input_number_question = input_number_questions(:two)
    answer.quip_id = "quipDocumentId"
    answer.answer = 4

    assert_not answer.save
  end

  test "will save if its answer is equal to the questions min number, when it only has a min" do
    answer = InputNumberAnswer.new
    answer.input_number_question = input_number_questions(:two)
    answer.quip_id = "quipDocumentId"
    answer.answer = 5

    assert answer.save
  end

  test "will not save if its answer is less than the questions min number, when it has both min and max" do
    answer = InputNumberAnswer.new
    answer.input_number_question = input_number_questions(:one)
    answer.quip_id = "quipDocumentId"
    answer.answer = 1

    assert_not answer.save
  end

  test "will save if its answer is equal to the questions min number, when it has both min and max" do
    answer = InputNumberAnswer.new
    answer.input_number_question = input_number_questions(:one)
    answer.quip_id = "quipDocumentId"
    answer.answer = 2

    assert answer.save
  end

  test "will not save if its answer is more than the questions max number, when it has only a max" do
    answer = InputNumberAnswer.new
    answer.input_number_question = input_number_questions(:three)
    answer.quip_id = "quipDocumentId"
    answer.answer = 120

    assert_not answer.save
  end

  test "will save if its answer is equal to the questions max number, when it has only a max" do
    answer = InputNumberAnswer.new
    answer.input_number_question = input_number_questions(:three)
    answer.quip_id = "quipDocumentId"
    answer.answer = 100

    assert answer.save
  end

  test "will not save if its answer is more than the questions max number, when it has both min and max" do
    answer = InputNumberAnswer.new
    answer.input_number_question = input_number_questions(:one)
    answer.quip_id = "quipDocumentId"
    answer.answer = 11

    assert_not answer.save
  end

  test "will save if its answer is equal to the questions max number, when it has both min and max" do
    answer = InputNumberAnswer.new
    answer.input_number_question = input_number_questions(:one)
    answer.quip_id = "quipDocumentId"
    answer.answer = 10

    assert answer.save
  end
end
