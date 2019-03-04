require 'test_helper'

class QuestionsOptionsTest < ActionDispatch::IntegrationTest
  test "options ideal" do
    route = "/surveys/#{surveys(:one).id}/questions"
    params = {
      question_type: "radio",
      order: 1,
      question: "test question",
      options: "option 1~~~option 2~~~option 3"
    }

    post route, params: params, headers: get_test_creds()
    helpers = response.parsed_body["options"]

    assert_equal 201, status
    assert_equal 3, helpers.size
    assert_equal 'option 1', helpers[0]
    assert_equal 'option 2', helpers[1]
    assert_equal 'option 3', helpers[2]
  end

  test "option empty failure" do
    route = "/surveys/#{surveys(:one).id}/questions"
    params = {
      question_type: "radio",
      order: 1,
      question: "test question"
    }

    post route, params: params, headers: get_test_creds()
    helpers = response.parsed_body["options"]

    assert_equal 400, status
  end

  test "options not unique fail" do
    route = "/surveys/#{surveys(:one).id}/questions"
    params = {
      question_type: "radio",
      order: 1,
      question: "test question",
      options: "option 1~~~option 2~~~option 1"
    }

    post route, params: params, headers: get_test_creds()
    helpers = response.parsed_body["options"]

    assert_equal 400, status
  end
end

class QuestionsOptionHelpersTest < ActionDispatch::IntegrationTest
  test "option helpers 1" do
    route = "/surveys/#{surveys(:one).id}/questions"
    params = {
      question_type: "radio",
      order: 1,
      question: "test question",
      options: "option 1~~~option 2~~~option 3",
      option_helpers: "option 1~~~~~~option 3"
    }

    post route, params: params, headers: get_test_creds()
    helpers = response.parsed_body["option_helpers"]

    assert_equal 201, status
    assert_equal 3, helpers.size
    assert_equal 'option 1', helpers[0]
    assert_equal '', helpers[1]
    assert_equal 'option 3', helpers[2]
  end

  test "option helpers 2" do
    route = "/surveys/#{surveys(:one).id}/questions"
    params = {
      question_type: "radio",
      order: 1,
      question: "test question",
      options: "option 1~~~option 2~~~option 3",
      option_helpers: "option 1~~~option 2~~~"
    }

    post route, params: params, headers: get_test_creds()
    helpers = response.parsed_body["option_helpers"]

    assert_equal 201, status
    assert_equal 3, helpers.size
    assert_equal 'option 1', helpers[0]
    assert_equal 'option 2', helpers[1]
    assert_equal '', helpers[2]
  end

  test "option helpers 3" do
    route = "/surveys/#{surveys(:one).id}/questions"
    params = {
      question_type: "radio",
      order: 1,
      question: "test question",
      options: "option 1~~~option 2~~~option 3~~~option 4",
      option_helpers: "option 1~~~option 2~~~~~~"
    }

    post route, params: params, headers: get_test_creds()
    helpers = response.parsed_body["option_helpers"]

    assert_equal 201, status
    assert_equal 4, helpers.size
    assert_equal 'option 1', helpers[0]
    assert_equal 'option 2', helpers[1]
    assert_equal '', helpers[2]
    assert_equal '', helpers[3]
  end

  test "option helpers 4" do
    route = "/surveys/#{surveys(:one).id}/questions"
    params = {
      question_type: "radio",
      order: 1,
      question: "test question",
      options: "option 1~~~option 2~~~option 3",
      option_helpers: "~~~option 2~~~option 3"
    }

    post route, params: params, headers: get_test_creds()
    helpers = response.parsed_body["option_helpers"]

    assert_equal 201, status
    assert_equal 3, helpers.size
    assert_equal '', helpers[0]
    assert_equal 'option 2', helpers[1]
    assert_equal 'option 3', helpers[2]
  end
end
