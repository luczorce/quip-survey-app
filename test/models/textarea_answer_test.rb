require 'test_helper'

class TextareaAnswerTest < ActiveSupport::TestCase
  test "will not save if the quip_id is missing" do
    answer = TextareaAnswer.new
    answer.textarea_question = TextareaQuestion.first

    assert_not answer.save
  end

  test "will not save if the quip_id is not unique" do
    answer = TextareaAnswer.new
    answer.textarea_question = TextareaQuestion.first
    answer.quip_id = "quipDocumentId"
    answer.save

    another = TextareaAnswer.new
    another.textarea_question = TextareaQuestion.first
    another.quip_id = "quipDocumentId"

    assert_not another.save
  end

  test "will save if the quip_id is not unique but with a different question" do
    answer = TextareaAnswer.new
    answer.textarea_question = TextareaQuestion.first
    answer.quip_id = "quipDocumentId"
    answer.save

    another = TextareaAnswer.new
    another.textarea_question = TextareaQuestion.last
    another.quip_id = "quipDocumentId"

    assert another.save
  end

  test "will save when the quip_id is provided" do
    answer = TextareaAnswer.new
    answer.textarea_question = TextareaQuestion.first
    answer.quip_id = "quipDocumentId"

    assert answer.save
  end

  test "will be deleted when the question it belongs to is destroyed" do
    answer = TextareaAnswer.new
    answer.textarea_question = TextareaQuestion.first
    answer.quip_id = "quipDocumentId"

    answer.save

    TextareaQuestion.first.destroy
    assert_not TextareaAnswer.all.include?(answer)
  end

  test "will be deleted when the survey (that the question it belongs to) is destroyed" do
    answer = TextareaAnswer.new
    answer.textarea_question = TextareaQuestion.first
    answer.quip_id = "quipDocumentId"

    answer.save

    TextareaQuestion.first.survey.destroy
    assert_not TextareaAnswer.all.include?(answer)
  end
end
