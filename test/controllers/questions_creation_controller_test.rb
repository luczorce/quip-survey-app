class QuestionsCreateControllerTest < ActionDispatch::IntegrationTest
  test "dont create a question with an ill-defined type" do
    route = question_create_route(surveys(:one).id)
    body = { question: "Question 1", order: 1, question_type: "SDFSDFSDF" }
    post route, headers: get_test_creds(), params: body

    assert_equal 400, status
  end

  test "create a text input question" do
    route = question_create_route(surveys(:one).id)
    body = { question: "Question 1", order: 1, question_type: "text_input" }
    post route, headers: get_test_creds(), params: body

    assert_equal 201, status
  end

  test "dont create a duplicate text input question" do
    route = question_create_route(surveys(:one).id)
    body = { question: "Question 1", order: 1, question_type: "text_input" }
    post route, headers: get_test_creds(), params: body
    post route, headers: get_test_creds(), params: body

    assert_equal 400, status
  end

  test "create a textarea question" do
    route = question_create_route(surveys(:one).id)
    body = { question: "Question 1", order: 1, question_type: "textarea" }
    post route, headers: get_test_creds(), params: body

    assert_equal 201, status
  end

  test "create a number question" do
    route = question_create_route(surveys(:one).id)
    body = { question: "Question 1", order: 1, question_type: "number_input" }
    post route, headers: get_test_creds(), params: body

    assert_equal 201, status
  end

  test "create a number question with a min" do
    route = question_create_route(surveys(:one).id)
    body = { question: "Question 1", order: 1, question_type: "number_input", min: 10 }
    post route, headers: get_test_creds(), params: body

    assert_equal 201, status
  end

  test "create a number question with a max" do
    route = question_create_route(surveys(:one).id)
    body = { question: "Question 1", order: 1, question_type: "number_input", max: 10 }
    post route, headers: get_test_creds(), params: body

    assert_equal 201, status
  end

  test "create a number question with a min and max" do
    route = question_create_route(surveys(:one).id)
    body = { question: "Question 1", order: 1, question_type: "number_input", min: 10, max: 20 }
    post route, headers: get_test_creds(), params: body

    assert_equal 201, status
  end

  test "dont create a number question with a conflicting min and max" do
    route = question_create_route(surveys(:one).id)
    body = { question: "Question 1", order: 1, question_type: "number_input", min: 20, max: 10 }
    post route, headers: get_test_creds(), params: body

    assert_equal 400, status
  end

  test "create a select question" do
    route = question_create_route(surveys(:one).id)
    body = { question: "Question 1", order: 1, question_type: "select", options: "poi~~~sdf" }
    post route, headers: get_test_creds(), params: body

    assert_equal 201, status
  end

  test "dont create a select question without options" do
    route = question_create_route(surveys(:one).id)
    body = { question: "Question 1", order: 1, question_type: "select" }
    post route, headers: get_test_creds(), params: body

    assert_equal 400, status
  end

  test "dont create a select question with options that aren't unique" do
    route = question_create_route(surveys(:one).id)
    body = { question: "Question 1", order: 1, question_type: "select", options: "POI~~~POI" }
    post route, headers: get_test_creds(), params: body

    assert_equal 400, status
  end

  test "create a radio question" do
    route = question_create_route(surveys(:one).id)
    body = { question: "Question 1", order: 1, question_type: "radio", options: "poi~~~sdf" }
    post route, headers: get_test_creds(), params: body

    assert_equal 201, status
  end

  test "dont create a radio question without options" do
    route = question_create_route(surveys(:one).id)
    body = { question: "Question 1", order: 1, question_type: "radio" }
    post route, headers: get_test_creds(), params: body

    assert_equal 400, status
  end

  test "dont create a radio question with options that aren't unique" do
    route = question_create_route(surveys(:one).id)
    body = { question: "Question 1", order: 1, question_type: "radio", options: "POI~~~POI" }
    post route, headers: get_test_creds(), params: body

    assert_equal 400, status
  end

  test "create a checkbox question" do
    route = question_create_route(surveys(:one).id)
    body = { question: "Question 1", order: 1, question_type: "checkbox", options: "poi~~~sdf" }
    post route, headers: get_test_creds(), params: body

    assert_equal 201, status
  end

  test "dont create a checkbox question without options" do
    route = question_create_route(surveys(:one).id)
    body = { question: "Question 1", order: 1, question_type: "checkbox" }
    post route, headers: get_test_creds(), params: body

    assert_equal 400, status
  end

  test "dont create a checkbox question with options that aren't unique" do
    route = question_create_route(surveys(:one).id)
    body = { question: "Question 1", order: 1, question_type: "checkbox", options: "POI~~~POI" }
    post route, headers: get_test_creds(), params: body

    assert_equal 400, status
  end

  test "create a ranked question" do
    route = question_create_route(surveys(:one).id)
    body = { question: "Question 1", order: 1, question_type: "ranked", options: "poi~~~sdf" }
    post route, headers: get_test_creds(), params: body

    assert_equal 201, status
  end

  test "dont create a ranked question without options" do
    route = question_create_route(surveys(:one).id)
    body = { question: "Question 1", order: 1, question_type: "ranked" }
    post route, headers: get_test_creds(), params: body

    assert_equal 400, status
  end

  test "dont create a ranked question with options that aren't unique" do
    route = question_create_route(surveys(:one).id)
    body = { question: "Question 1", order: 1, question_type: "ranked", options: "POI~~~POI" }
    post route, headers: get_test_creds(), params: body

    assert_equal 400, status
  end

  test "create a header" do
    route = question_create_route(surveys(:one).id)
    body = { value: "Header 1", order: 1, question_type: "header" }
    post route, headers: get_test_creds(), params: body

    assert_equal 201, status
  end
end
