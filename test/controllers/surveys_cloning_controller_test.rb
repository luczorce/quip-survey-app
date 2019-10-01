require 'test_helper'

class SurveysCloningControllerTest < ActionDispatch::IntegrationTest
  test "cloning a survey with the same name will fail" do
    route = survey_clone_route(surveys(:one).id)
    body = { name: "My First Survey" }
    post route, headers: get_test_creds(), params: body

    assert_equal 400, status
  end

  test "cloning a survey with a duplicated name will fail" do
    route = survey_clone_route(surveys(:one).id)
    body = { name: "My Best Survey" }
    post route, headers: get_test_creds(), params: body

    assert_equal 400, status
  end

  test "cloning a survey with a unique name will pass" do
    route = survey_clone_route(surveys(:one).id)
    body = { name: "My Second Survey" }
    post route, headers: get_test_creds(), params: body

    assert_equal 201, status
  end

  test "cloning a survey will also copy all the original questions" do
    route = survey_clone_route(surveys(:one).id)
    body = { name: "My Second Survey" }
    post route, headers: get_test_creds(), params: body

    assert_equal 201, status

    original_questions = Array.new
    new_questions = Array.new

    original_questions << InputNumberQuestion.where(survey_id: surveys(:one).id)
    original_questions << InputTextQuestion.where(survey_id: surveys(:one).id)
    original_questions << TextareaQuestion.where(survey_id: surveys(:one).id)
    original_questions << OptionQuestion.where(survey_id: surveys(:one).id)
    original_questions << SurveyHeader.where(survey_id: surveys(:one).id)
    original_questions << RankedQuestion.where(survey_id: surveys(:one).id)

    new_questions << InputNumberQuestion.where(name: "My Second Survey")
    new_questions << InputTextQuestion.where(name: "My Second Survey")
    new_questions << TextareaQuestion.where(name: "My Second Survey")
    new_questions << OptionQuestion.where(name: "My Second Survey")
    new_questions << SurveyHeader.where(name: "My Second Survey")
    new_questions << RankedQuestion.where(name: "My Second Survey")

    assert_equal original_questions.length, new_questions.length
  end
end
