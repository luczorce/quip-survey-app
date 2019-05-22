require 'test_helper'

class RankedAnswerTest < ActiveSupport::TestCase
  test "answer will not save if has a foreign option in its answer" do
    answer = RankedAnswer.new
    answer.answer = [ "peanut butter", "chocolate", "gummies", "cake", "WATER" ]
    answer.quip_id = "quipDocumentId"
    answer.ranked_question = ranked_questions(:one)

    assert_not answer.save
  end

  test "answer will not save if is missing an option from the question" do
    answer = RankedAnswer.new
    answer.answer = [ "peanut butter", "chocolate", "gummies" ]
    answer.quip_id = "quipDocumentId"
    answer.ranked_question = ranked_questions(:one)

    assert_not answer.save
  end

  test "answer will not save if no answer is provided" do
    answer = RankedAnswer.new
    # answer.answer = [ "peanut butter", "chocolate", "gummies", "cake", "WATER" ]
    answer.quip_id = "quipDocumentId"
    answer.ranked_question = ranked_questions(:one)

    assert_not answer.save
  end

  test "answer will not save if no quip id is provided" do
    answer = RankedAnswer.new
    answer.answer = [ "peanut butter", "chocolate", "gummies", "cake" ]
    # answer.quip_id = "quipDocumentId"
    answer.ranked_question = ranked_questions(:one)

    assert_not answer.save
  end

  test "answer will save with all provided options used" do
    answer = RankedAnswer.new
    answer.answer = [ "peanut butter", "chocolate", "gummies", "cake" ]
    answer.quip_id = "quipDocumentId"
    answer.ranked_question = ranked_questions(:one)

    assert answer.save
  end
end
