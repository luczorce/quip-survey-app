class QuestionsCreateControllerTest < ActionDispatch::IntegrationTest
  def create_route
    "/surveys/#{surveys(:one).id}/questions"
  end

  test "dont create a question with an ill-defined type" do
    body = { question: "Question 1", order: 1, question_type: "SDFSDFSDF" }
    post create_route, headers: get_test_creds(), params: body

    assert_equal 400, status
  end

  test "create a text input question" do
    body = { question: "Question 1", order: 1, question_type: "text_input" }
    post create_route, headers: get_test_creds(), params: body

    assert_equal 201, status
  end

  test "dont create a duplicate text input question" do
    body = { question: "Question 1", order: 1, question_type: "text_input" }
    post create_route, headers: get_test_creds(), params: body
    post create_route, headers: get_test_creds(), params: body

    assert_equal 400, status
  end

  test "create a textarea question" do
    body = { question: "Question 1", order: 1, question_type: "textarea" }
    post create_route, headers: get_test_creds(), params: body

    assert_equal 201, status
  end

  test "create a number question" do
    body = { question: "Question 1", order: 1, question_type: "number_input" }
    post create_route, headers: get_test_creds(), params: body

    assert_equal 201, status
  end

  test "create a number question with a min" do
    body = { question: "Question 1", order: 1, question_type: "number_input", min: 10 }
    post create_route, headers: get_test_creds(), params: body

    assert_equal 201, status
  end

  test "create a number question with a max" do
    body = { question: "Question 1", order: 1, question_type: "number_input", max: 10 }
    post create_route, headers: get_test_creds(), params: body

    assert_equal 201, status
  end

  test "create a number question with a min and max" do
    body = { question: "Question 1", order: 1, question_type: "number_input", min: 10, max: 20 }
    post create_route, headers: get_test_creds(), params: body

    assert_equal 201, status
  end

  test "dont create a number question with a conflicting min and max" do
    body = { question: "Question 1", order: 1, question_type: "number_input", min: 20, max: 10 }
    post create_route, headers: get_test_creds(), params: body

    assert_equal 400, status
  end

  test "create a select question" do
    body = { question: "Question 1", order: 1, question_type: "select", options: "poi~~~sdf" }
    post create_route, headers: get_test_creds(), params: body

    assert_equal 201, status
  end

  test "dont create a select question without options" do
    body = { question: "Question 1", order: 1, question_type: "select" }
    post create_route, headers: get_test_creds(), params: body

    assert_equal 400, status
  end

  test "dont create a select question with options that aren't unique" do
    body = { question: "Question 1", order: 1, question_type: "select", options: "POI~~~POI" }
    post create_route, headers: get_test_creds(), params: body

    assert_equal 400, status
  end

  test "create a radio question" do
    body = { question: "Question 1", order: 1, question_type: "radio", options: "poi~~~sdf" }
    post create_route, headers: get_test_creds(), params: body

    assert_equal 201, status
  end

  test "dont create a radio question without options" do
    body = { question: "Question 1", order: 1, question_type: "radio" }
    post create_route, headers: get_test_creds(), params: body

    assert_equal 400, status
  end

  test "dont create a radio question with options that aren't unique" do
    body = { question: "Question 1", order: 1, question_type: "radio", options: "POI~~~POI" }
    post create_route, headers: get_test_creds(), params: body

    assert_equal 400, status
  end

  test "create a checkbox question" do
    body = { question: "Question 1", order: 1, question_type: "checkbox", options: "poi~~~sdf" }
    post create_route, headers: get_test_creds(), params: body

    assert_equal 201, status
  end

  test "dont create a checkbox question without options" do
    body = { question: "Question 1", order: 1, question_type: "checkbox" }
    post create_route, headers: get_test_creds(), params: body

    assert_equal 400, status
  end

  test "dont create a checkbox question with options that aren't unique" do
    body = { question: "Question 1", order: 1, question_type: "checkbox", options: "POI~~~POI" }
    post create_route, headers: get_test_creds(), params: body

    assert_equal 400, status
  end

  test "create a ranked question" do
    body = { question: "Question 1", order: 1, question_type: "ranked", options: "poi~~~sdf" }
    post create_route, headers: get_test_creds(), params: body

    assert_equal 201, status
  end

  test "dont create a ranked question without options" do
    body = { question: "Question 1", order: 1, question_type: "ranked" }
    post create_route, headers: get_test_creds(), params: body

    assert_equal 400, status
  end

  test "dont create a ranked question with options that aren't unique" do
    body = { question: "Question 1", order: 1, question_type: "ranked", options: "POI~~~POI" }
    post create_route, headers: get_test_creds(), params: body

    assert_equal 400, status
  end

  test "create a header" do
    body = { value: "Header 1", order: 1, question_type: "header" }
    post create_route, headers: get_test_creds(), params: body

    assert_equal 201, status
  end
end
