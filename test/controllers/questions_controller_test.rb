require 'test_helper'

class QuestionsDeleteControllerTest < ActionDispatch::IntegrationTest
  test "delete a text input question" do
    route = "/questions/text_input/#{input_text_questions(:one).id}"
    delete route, headers: get_test_creds()

    assert_equal 204, status
  end

  test "delete a textarea question" do
    route = "/questions/textarea/#{textarea_questions(:one).id}"
    delete route, headers: get_test_creds()

    assert_equal 204, status
  end

  test "delete a number input question" do
    route = "/questions/number_input/#{input_number_questions(:one).id}"
    delete route, headers: get_test_creds()

    assert_equal 204, status
  end

  test "delete a select question" do
    route = "/questions/select/#{option_questions(:one).id}"
    delete route, headers: get_test_creds()

    assert_equal 204, status
  end

  test "delete a radio question" do
    route = "/questions/radio/#{option_questions(:two).id}"
    delete route, headers: get_test_creds()

    assert_equal 204, status
  end

  test "delete a checkbox question" do
    route = "/questions/checkbox/#{option_questions(:three).id}"
    delete route, headers: get_test_creds()

    assert_equal 204, status
  end

  test "fail to define a question to delete" do
    route = "/questions/WHAT_KIND_OF_QUESTION/1"
    delete route, headers: get_test_creds()

    assert_equal 400, status
  end

  test "fail to find a question to delete" do
    route = "/questions/text_input/9999"
    delete route, headers: get_test_creds()

    assert_equal 404, status
  end
end
