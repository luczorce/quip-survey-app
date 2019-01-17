class QuestionsController < ApplicationController
  def index
    questions = Array.new

    questions.concat(InputNumberQuestion.where(survey_id: params[:survey_id]))
    questions.concat(InputTextQuestion.where(survey_id: params[:survey_id]))
    questions.concat(TextareaQuestion.where(survey_id: params[:survey_id]))
    questions.concat(OptionQuestion.where(survey_id: params[:survey_id]))
    questions.concat(SurveyHeader.where(survey_id: params[:survey_id]))

    questions.sort_by! do |q|
      q[:order]
    end

    render json: questions, status: :ok
  end

  def create
    question = nil

    if is_header_not_question?
      question = SurveyHeader.new(question_params)
    elsif is_text_input_question?
      question = InputTextQuestion.new(question_params)
    elsif is_number_input_question?
      question = InputNumberQuestion.new(question_params)
    elsif is_textarea_question?
      question = TextareaQuestion.new(question_params)
    elsif is_option_question?
      option_question_params = alter_question_options(question_params)
      question = OptionQuestion.new(option_question_params)
    end

    question.save! unless question.nil?

    if question
      render json: question, status: :created
    else 
      render json: {error: missing_question_type}, status: :bad_request
    end
  rescue ActiveRecord::RecordInvalid => invalid
    render json: invalid.record.errors, status: :bad_request
  end

  def update
    question = nil

    if is_header_not_question?
      question = SurveyHeader.find(params[:id])
    elsif is_text_input_question?
      question = InputTextQuestion.find(params[:id])
    elsif is_number_input_question?
      question = InputNumberQuestion.find(params[:id])
    elsif is_textarea_question?
      question = TextareaQuestion.find(params[:id])
    elsif is_option_question?
      question = OptionQuestion.find(params[:id])
    end

    if is_option_question?
      option_question_params = alter_question_options(question_params)
      question.update!(updates) unless question.nil?
    else
      question.update!(question_params) unless question.nil?
    end

    if question
      render json: question, status: :ok
    else 
      render json: {error: missing_question_type("update")}, status: :bad_request
    end
  rescue ActiveRecord::RecordInvalid => invalid
    render json: invalid.record.errors, status: :bad_request
  rescue ActiveRecord::RecordNotFound => missing
    render json: missing, status: :not_found
  rescue ActiveModel::UnknownAttributeError => error
    render json: error, status: :bad_request
  end

  def destroy
    question = nil

    if is_header_not_question?
      question = SurveyHeader.find(params[:id])
    elsif is_text_input_question?
      question = InputTextQuestion.find(params[:id])
    elsif is_number_input_question?
      question = InputNumberQuestion.find(params[:id])
    elsif is_textarea_question?
      question = TextareaQuestion.find(params[:id])
    elsif is_option_question?
      question = OptionQuestion.find(params[:id])
    end

    question.destroy unless question.nil?

    if question
      head :no_content
    else 
      render json: {error: missing_question_type("delete")}, status: :bad_request
    end
  end

  private

  def alter_question_options(q_params_hash)
    if !q_params_hash[:options].nil? and q_params_hash[:options].kind_of?(String)
      q_params_hash[:options] = q_params_hash[:options].split("~~~")
    end

    return q_params_hash
  end

  def is_header_not_question?
    params[:question_type] == "header"
  end

  def is_number_input_question?
    params[:question_type] == "number_input"
  end

  def is_text_input_question?
    params[:question_type] == "text_input"
  end

  def is_textarea_question?
    params[:question_type] == "textarea"
  end

  def is_option_question?
    ["select", "radio", "checkbox"].include? params[:question_type]
  end

  def missing_question_type(action= "create") 
    "Could not determine which question to #{action}"
  end

  def question_params
    if is_header_not_question?
      return params.permit(:value, :order, :survey_id)
    elsif is_option_question?
      return params.permit(:question, :question_helper, :question_type, :order, :options, :option_helpers, :survey_id)
    elsif is_number_input_question?
      return params.permit(:question, :question_helper, :question_type, :order, :min, :max, :survey_id)
    else
      return params.permit(:question, :question_helper, :question_type, :order, :survey_id)
    end
  end
end
