require 'test_helper'

class AnswersCreateControllerTest < ActionDispatch::IntegrationTest
  test "don't create an answer when answer_type is ill-defined" do
    route = answer_create_route(input_text_questions(:one).id)
    body = { answer: "my smrt answer", quip_id: "quipDocId0", answer_type: "SDFSDFSDF" }
    post route, headers: get_test_creds(), params: body

    assert_equal 400, status
  end

  test "create a text input answer" do
    route = answer_create_route(input_text_questions(:one).id)
    body = { answer: "my smrt answer", quip_id: "quipDocId0", answer_type: "text_input" }
    post route, headers: get_test_creds(), params: body

    assert_equal 201, status
  end

  test "create a textarea answer" do
    route = answer_create_route(textarea_questions(:one).id)
    body = { answer: "my smrt answer", quip_id: "quipDocId0", answer_type: "textarea" }
    post route, headers: get_test_creds(), params: body

    assert_equal 201, status
  end

  test "create a number input answer" do
    route = answer_create_route(input_number_questions(:four).id)
    body = { answer: 2, quip_id: "quipDocId0", answer_type: "number_input" }
    post route, headers: get_test_creds(), params: body

    assert_equal 201, status
  end

  test "don't create a number input answer that's outside the min/max bounds" do
    route = answer_create_route(input_number_questions(:one).id)
    body = { answer: 12, quip_id: "quipDocId0", answer_type: "number_input" }
    post route, headers: get_test_creds(), params: body

    assert_equal 400, status
  end

  test "don't create a number input answer that's lower than the min" do
    route = answer_create_route(input_number_questions(:two).id)
    body = { answer: 1, quip_id: "quipDocId0", answer_type: "number_input" }
    post route, headers: get_test_creds(), params: body

    assert_equal 400, status
  end

  test "don't create a number input answer that's greater than the max" do
    route = answer_create_route(input_number_questions(:three).id)
    body = { answer: 110, quip_id: "quipDocId0", answer_type: "number_input" }
    post route, headers: get_test_creds(), params: body

    assert_equal 400, status
  end

  test "create a select answer" do
    route = answer_create_route(option_questions(:one).id)
    body = { answer: "option 1", quip_id: "quipDocId0", answer_type: "select" }
    post route, headers: get_test_creds(), params: body

    assert_equal 201, status
  end

  test "don't create a select answer if no answer is provided" do
    route = answer_create_route(option_questions(:one).id)
    body = { quip_id: "quipDocId0", answer_type: "select" }
    post route, headers: get_test_creds(), params: body

    assert_equal 400, status
  end

  test "don't create a select answer if the provided answer isn't in the question option list" do
    route = answer_create_route(option_questions(:one).id)
    body = { answer: "option NOPE", quip_id: "quipDocId0", answer_type: "select" }
    post route, headers: get_test_creds(), params: body

    assert_equal 400, status
  end

  test "don't create a select answer if there is more than one provided answer" do
    route = answer_create_route(option_questions(:one).id)
    body = { answer: "option 1~~~option 2", quip_id: "quipDocId0", answer_type: "select" }
    post route, headers: get_test_creds(), params: body

    assert_equal 400, status
  end

  test "create a radio answer" do
    route = answer_create_route(option_questions(:two).id)
    body = { answer: "option 1", quip_id: "quipDocId0", answer_type: "radio" }
    post route, headers: get_test_creds(), params: body

    assert_equal 201, status
  end

  test "don't create a radio answer if no answer is provided" do
    route = answer_create_route(option_questions(:two).id)
    body = { quip_id: "quipDocId0", answer_type: "radio" }
    post route, headers: get_test_creds(), params: body

    assert_equal 400, status
  end

  test "don't create a radio answer if the provided answer isn't in the question option list" do
    route = answer_create_route(option_questions(:two).id)
    body = { answer: "option NOPE", quip_id: "quipDocId0", answer_type: "radio" }
    post route, headers: get_test_creds(), params: body

    assert_equal 400, status
  end

  test "don't create a radio answer if there is more than one provided answer" do
    route = answer_create_route(option_questions(:two).id)
    body = { answer: "option 1~~~option 2", quip_id: "quipDocId0", answer_type: "radio" }
    post route, headers: get_test_creds(), params: body

    assert_equal 400, status
  end

  test "create a checkbox answer" do
    route = answer_create_route(option_questions(:three).id)
    body = { answer: "option 1", quip_id: "quipDocId0", answer_type: "checkbox" }
    post route, headers: get_test_creds(), params: body

    assert_equal 201, status
  end

  test "don't create a checkbox answer if no answer is provided" do
    route = answer_create_route(option_questions(:three).id)
    body = { quip_id: "quipDocId0", answer_type: "checkbox" }
    post route, headers: get_test_creds(), params: body

    assert_equal 400, status
  end

  test "don't create a checkbox answer if the provided answer isn't in the question option list" do
    route = answer_create_route(option_questions(:three).id)
    body = { answer: "option NOPE", quip_id: "quipDocId0", answer_type: "checkbox" }
    post route, headers: get_test_creds(), params: body

    assert_equal 400, status
  end

  test "create a ranked answer" do
    route = answer_create_route(ranked_questions(:one).id)
    body = { quip_id: "quipDocId0", answer_type: "ranked" }
    body[:answer] = "peanut butter~~~chocolate~~~gummies~~~cake"
    post route, headers: get_test_creds(), params: body

    assert_equal 201, status
  end

  test "don't create a ranked answer if no answer is provided" do
    route = answer_create_route(ranked_questions(:one).id)
    body = { quip_id: "quipDocId0", answer_type: "ranked" }
    post route, headers: get_test_creds(), params: body

    assert_equal 400, status
  end

  test "don't create a ranked answer if the provided answer contains a foreign option" do
    route = answer_create_route(ranked_questions(:one).id)
    body = { quip_id: "quipDocId0", answer_type: "ranked" }
    body[:answer] = "peanut butter~~~chocolate~~~gummies~~~cake~~~WATER"
    post route, headers: get_test_creds(), params: body

    assert_equal 400, status
  end

  test "don't create a ranked answer if the provided answer is missing an option" do
    route = answer_create_route(ranked_questions(:one).id)
    body = { quip_id: "quipDocId0", answer_type: "ranked" }
    body[:answer] = "peanut butter~~~chocolate~~~gummies"
    post route, headers: get_test_creds(), params: body

    assert_equal 400, status
  end
end
