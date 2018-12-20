require 'test_helper'

class InputTextAnswerTest < ActiveSupport::TestCase
  test "will not save if the quip_id is missing" do
    answer = InputTextAnswer.new
    answer.input_text_question = InputTextQuestion.first

    assert_not answer.save
  end

  test "will not save if the quip_id is not unique" do
    answer = InputTextAnswer.new
    answer.input_text_question = InputTextQuestion.first
    answer.quip_id = "quipDocumentId"
    answer.save

    another = InputTextAnswer.new
    another.input_text_question = InputTextQuestion.first
    another.quip_id = "quipDocumentId"

    assert_not another.save
  end

  test "will save if the quip_id is not unique but with a different question" do
    answer = InputTextAnswer.new
    answer.input_text_question = InputTextQuestion.first
    answer.quip_id = "quipDocumentId"
    answer.save

    another = InputTextAnswer.new
    another.input_text_question = InputTextQuestion.last
    another.quip_id = "quipDocumentId"

    assert another.save
  end

  test "will save when the quip_id is provided" do
    answer = InputTextAnswer.new
    answer.input_text_question = InputTextQuestion.first
    answer.quip_id = "quipDocumentId"

    assert answer.save
  end
end
