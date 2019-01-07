require 'test_helper'
# we can reference the fixtures with the test_helper
# use it like option_questions(:one) or option_answers(:one)

class OptionAnswerTest < ActiveSupport::TestCase
  test "answer will save if its a select type" do
    answer = OptionAnswer.new
    answer.answer = ["option 1"]
    answer.answer_type = "select"
    answer.quip_id = "quipDocumentId"
    answer.option_question = option_questions(:one)

    assert answer.save
  end

  test "answer will save if its a radio type" do
    answer = OptionAnswer.new
    answer.answer = ["option 1"]
    answer.answer_type = "radio"
    answer.quip_id = "quipDocumentId"
    answer.option_question = option_questions(:two)

    assert answer.save
  end

  test "answer will save if its a checkbox type" do
    answer = OptionAnswer.new
    answer.answer = ["option 1"]
    answer.answer_type = "checkbox"
    answer.quip_id = "quipDocumentId"
    answer.option_question = option_questions(:three)

    assert answer.save
  end

  test "answer will not save if its type is not one of (select, radio, checkbox)" do
    answer = OptionAnswer.new
    answer.answer = ["option 1"]
    answer.answer_type = "the_next_best_action"
    answer.quip_id = "quipDocumentId"
    answer.option_question = option_questions(:two)

    assert_not answer.save
  end

  test "answer will not save if its type does not match that of its question" do
    answer = OptionAnswer.new
    answer.answer = ["option 1"]
    answer.answer_type = "checkbox"
    answer.quip_id = "quipDocumentId"
    answer.option_question = option_questions(:one) # this one is a select

    assert_not answer.save
  end

  test "answer will not save if the quip_id is missing" do
    answer = OptionAnswer.new
    answer.answer = ["option 1"]
    answer.answer_type = "checkbox"
    # answer.quip_id = ""
    answer.option_question = option_questions(:three)

    assert_not answer.save
  end

  test "answer will not save if the quip_id is present but empty" do
    answer = OptionAnswer.new
    answer.answer = ["option 1"]
    answer.answer_type = "checkbox"
    answer.quip_id = ""
    answer.option_question = option_questions(:three)

    assert_not answer.save
  end

  test "answer will not save if the quip_id is not unique (to queston)" do
    answer = OptionAnswer.new
    answer.answer = ["option 1"]
    answer.answer_type = "checkbox"
    answer.quip_id = "quipDocumentId"
    answer.option_question = option_questions(:three)

    answer.save

    another = OptionAnswer.new
    another.answer = ["option 1"]
    another.answer_type = "checkbox"
    another.quip_id = "quipDocumentId"
    another.option_question = option_questions(:three)

    assert_not another.save
  end

  test "answer will not save if answer missing" do
    answer = OptionAnswer.new
    # answer.answer = ["option 1"]
    answer.answer_type = "select"
    answer.quip_id = "quipDocumentId"
    answer.option_question = option_questions(:one)

    assert_not answer.save
  end

  test "answer will save if answer present but empty" do
    answer = OptionAnswer.new
    answer.answer = []
    answer.answer_type = "select"
    answer.quip_id = "quipDocumentId"
    answer.option_question = option_questions(:one)

    assert answer.save
  end

  test "answer will not allow more than one answer if it of type select" do
    answer = OptionAnswer.new
    answer.answer = ["option 1", "option 2"]
    answer.answer_type = "select"
    answer.quip_id = "quipDocumentId"
    answer.option_question = option_questions(:one)

    assert_not answer.save
  end

  test "answer will not allow more than one answer if it of type radio" do
    answer = OptionAnswer.new
    answer.answer = ["option 1", "option 2"]
    answer.answer_type = "radio"
    answer.quip_id = "quipDocumentId"
    answer.option_question = option_questions(:two)

    assert_not answer.save
  end

  test "answer will allow more than one answer if it of type checkbox" do
    answer = OptionAnswer.new
    answer.answer = ["option 1", "option 2"]
    answer.answer_type = "checkbox"
    answer.quip_id = "quipDocumentId"
    answer.option_question = option_questions(:three)

    assert answer.save
  end

  test "answer will be deleted if the question it belongs to is deleted" do
    answer = OptionAnswer.new
    answer.answer = ["option 1"]
    answer.answer_type = "select"
    answer.quip_id = "quipDocumentId"
    answer.option_question = option_questions(:one)

    option_questions(:one).destroy
    assert_not OptionAnswer.all.include?(answer)
  end

  test "answer will be deleted if the survey it belongs to is deleted" do
    answer = OptionAnswer.new
    answer.answer = ["option 1"]
    answer.answer_type = "select"
    answer.quip_id = "quipDocumentId"
    answer.option_question = option_questions(:one) #belongs to survey one

    surveys(:one).destroy
    assert_not OptionAnswer.all.include?(answer)
  end

  test "answer will not save if its answer does not match the available options from its question (select or radio)" do
    answer = OptionAnswer.new
    answer.answer = ["not an option"]
    answer.answer_type = "select"
    answer.quip_id = "quipDocumentId"
    answer.option_question = option_questions(:one)

    assert_not answer.save
  end

  test "answer will not save if its single answer does not match the available options from its question (checkbox)" do
    answer = OptionAnswer.new
    answer.answer = ["not an option"]
    answer.answer_type = "checkbox"
    answer.quip_id = "quipDocumentId"
    answer.option_question = option_questions(:three)

    assert_not answer.save
  end

  test "answer will not save if any of its answers do not match the available options from its question (checkbox)" do
    answer = OptionAnswer.new
    answer.answer = ["not an option", "option 2"]
    answer.answer_type = "checkbox"
    answer.quip_id = "quipDocumentId"
    answer.option_question = option_questions(:three)

    assert_not answer.save
  end
end
