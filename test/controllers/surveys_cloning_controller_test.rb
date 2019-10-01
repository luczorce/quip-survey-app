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
    new_survey = Survey.where(name: "My Second Survey").first
    new_questions = Array.new

    original_questions.concat(InputNumberQuestion.where(survey_id: surveys(:one).id))
    original_questions.concat(InputTextQuestion.where(survey_id: surveys(:one).id))
    original_questions.concat(TextareaQuestion.where(survey_id: surveys(:one).id))
    original_questions.concat(OptionQuestion.where(survey_id: surveys(:one).id))
    original_questions.concat(SurveyHeader.where(survey_id: surveys(:one).id))
    original_questions.concat(RankedQuestion.where(survey_id: surveys(:one).id))

    new_questions.concat(InputNumberQuestion.where(survey_id: new_survey.id))
    new_questions.concat(InputTextQuestion.where(survey_id: new_survey.id))
    new_questions.concat(TextareaQuestion.where(survey_id: new_survey.id))
    new_questions.concat(OptionQuestion.where(survey_id: new_survey.id))
    new_questions.concat(SurveyHeader.where(survey_id: new_survey.id))
    new_questions.concat(RankedQuestion.where(survey_id: new_survey.id))

    assert_equal original_questions.length, new_questions.length
  end

  test "cloning a survey will NOT copy any answers" do
    route = survey_clone_route(surveys(:one).id)
    body = { name: "My Second Survey" }
    post route, headers: get_test_creds(), params: body

    assert_equal 201, status
    new_survey = Survey.where(name: "My Second Survey").first
    new_answers = Array.new

    new_answers.concat(InputNumberAnswer.where(input_number_question_id: InputNumberQuestion.where(survey_id: new_survey.id)))
    new_answers.concat(InputTextAnswer.where(input_text_question_id: InputTextQuestion.where(survey_id: new_survey.id)))
    new_answers.concat(TextareaAnswer.where(textarea_question_id: TextareaQuestion.where(survey_id: new_survey.id)))
    new_answers.concat(OptionAnswer.where(option_question_id: OptionQuestion.where(survey_id: new_survey.id)))
    new_answers.concat(RankedAnswer.where(ranked_question_id: RankedQuestion.where(survey_id: new_survey.id)))

    assert_equal 0, new_answers.length
  end
end
