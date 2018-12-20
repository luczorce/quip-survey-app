require 'test_helper'

class InputTextAnswerTest < ActiveSupport::TestCase
  test "will not save if the quip_id is missing" do
    answer = InputTextAnswer.new
    answer.input_text_question = InputTextQuestion.first

    assert_not answer.save
  end

  test "will save when the quip_id is provided" do
    answer = InputTextAnswer.new
    answer.input_text_question = InputTextQuestion.first
    answer.quip_id = "quipDocumentId"

    assert answer.save
  end
end
