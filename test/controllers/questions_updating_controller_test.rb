class QuestionsUpdateControllerTest < ActionDispatch::IntegrationTest
  test "dont update a question with an ill-defined type" do
    route = question_update_route(input_text_questions(:one).id)
    body = { question: "Question 1", question_type: "SDFSDFSDF" }
    put route, headers: get_test_creds(), params: body

    assert_equal 400, status
  end

  test "update a text input question" do
    route = question_update_route(input_text_questions(:one).id)
    body = { question: "Question 1", question_type: "text_input" }
    put route, headers: get_test_creds(), params: body

    assert_equal 200, status
  end

  # TODO uh oh fix this!
  # test "dont update a text input question to be a duplicate" do
  #   route = question_update_route(input_text_questions(:one).id)
  #   body = { question: "Another question?", question_type: "text_input" }
  #   put route, headers: get_test_creds(), params: body
  #   InputTextQuestion.all.each { |q| puts q.question }

  #   assert_equal 400, status
  # end

  test "update a number input question" do
    route = question_update_route(input_number_questions(:one).id)
    body = { question: "Question 1", question_type: "number_input" }
    put route, headers: get_test_creds(), params: body

    assert_equal 200, status
  end

  test "update a number input question min" do
    route = question_update_route(input_number_questions(:two).id)
    body = { min: 6, question_type: "number_input" }
    put route, headers: get_test_creds(), params: body

    assert_equal 200, status
  end

  test "update a number input question max" do
    route = question_update_route(input_number_questions(:three).id)
    body = { max: 110, question_type: "number_input" }
    put route, headers: get_test_creds(), params: body

    assert_equal 200, status
  end

  test "update a textarea question" do
    route = question_update_route(textarea_questions(:one).id)
    body = { question: "Question 1", question_type: "textarea" }
    put route, headers: get_test_creds(), params: body

    assert_equal 200, status
  end

  test "update a select question" do
    route = question_update_route(option_questions(:one).id)
    body = { question: "Question 1", question_type: "select" }
    put route, headers: get_test_creds(), params: body

    assert_equal 200, status
  end

  test "update a select options" do
    route = question_update_route(option_questions(:one).id)
    body = { options: "option 1~~~option 2", question_type: "select" }
    put route, headers: get_test_creds(), params: body

    assert_equal 200, status
  end

  test "update a radio question" do
    route = question_update_route(option_questions(:two).id)
    body = { question: "Question 1", question_type: "radio" }
    put route, headers: get_test_creds(), params: body

    assert_equal 200, status
  end

  test "update a radio options" do
    route = question_update_route(option_questions(:two).id)
    body = { options: "option 1~~~option 2", question_type: "radio" }
    put route, headers: get_test_creds(), params: body

    assert_equal 200, status
  end

  test "update a checkbox question" do
    route = question_update_route(option_questions(:three).id)
    body = { question: "Question 1", question_type: "checkbox" }
    put route, headers: get_test_creds(), params: body

    assert_equal 200, status
  end

  test "update a checkbox options" do
    route = question_update_route(option_questions(:three).id)
    body = { options: "option 1~~~option 2", question_type: "checkbox" }
    put route, headers: get_test_creds(), params: body

    assert_equal 200, status
  end

  test "update a ranked question" do
    route = question_update_route(ranked_questions(:one).id)
    body = { question: "Question 1", question_type: "ranked" }
    put route, headers: get_test_creds(), params: body

    assert_equal 200, status
  end

  test "update a ranked options" do
    route = question_update_route(ranked_questions(:one).id)
    body = { options: "option 1~~~option 2", question_type: "ranked" }
    put route, headers: get_test_creds(), params: body

    assert_equal 200, status
  end

  test "update a header" do
    route = question_update_route(survey_headers(:one).id)
    body = { value: "Header 1", question_type: "header" }
    put route, headers: get_test_creds(), params: body

    assert_equal 200, status
  end
end
