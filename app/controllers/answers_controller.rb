class AnswersController < ApplicationController
  def show
    answer = nil

    if is_text_input_question?
      answer = InputTextAnswer.find(params[:id])
    elsif is_number_input_question?
      answer = InputNumberAnswer.find(params[:id])
    elsif is_textarea_question?
      answer = TextareaAnswer.find(params[:id])
    elsif is_option_question?
      answer = OptionAnswer.find(params[:id])
    end

    if answer
      render json: answer, status: :ok
    else
      render json: {error: missing_answer_type("find")}, status: :bad_request
    end
  rescue ActiveRecord::RecordNotFound => missing
    render json: missing, status: :not_found
  end

  def create
    answer = nil

    if is_text_input_question?
      answer = InputTextAnswer.new(answer_params)
      answer.input_text_question_id = params[:question_id]
    elsif is_number_input_question?
      answer = InputNumberAnswer.new(answer_params)
      answer.input_number_question_id = params[:question_id]
    elsif is_textarea_question?
      answer = TextareaAnswer.new(answer_params)
      answer.textarea_question_id = params[:question_id]
    elsif is_option_question?
      option_answer_params = alter_option_answer(answer_params)
      answer = OptionAnswer.new(option_answer_params)
      answer.option_question_id = params[:question_id]
    end

    answer.save! unless answer.nil?

    if answer
      render json: answer, status: :created
    else 
      render json: {error: missing_answer_type}, status: :bad_request
    end
  rescue ActiveRecord::RecordInvalid => invalid
    render json: invalid.record.errors, status: :bad_request
  end

  def update
    answer = nil

    if is_text_input_question?
      answer = InputTextAnswer.find(params[:id])
    elsif is_number_input_question?
      answer = InputNumberAnswer.find(params[:id])
    elsif is_textarea_question?
      answer = TextareaAnswer.find(params[:id])
    elsif is_option_question?
      answer = OptionAnswer.find(params[:id])
    end

    if is_option_question?
      option_answer_params = alter_option_answer(answer_params)
      answer.update!(option_answer_params) unless answer.nil?
    else
      answer.update!(answer_params) unless answer.nil?
    end

    if answer
      render json: answer, status: :ok
    else 
      render json: {error: missing_answer_type("update")}, status: :bad_request
    end
  rescue ActiveRecord::RecordInvalid => invalid
    render json: invalid.record.errors, status: :bad_request
  rescue ActiveRecord::RecordNotFound => missing
    render json: missing, status: :not_found
  rescue ActiveModel::UnknownAttributeError => error
    render json: error, status: :bad_request
  end

  private

  def alter_option_answer(answer_hash) 
    if !answer_hash[:answer].nil? and answer_hash[:answer].kind_of?(String)
      answer_hash[:answer] = answer_hash[:answer].split("~~~")
    end

    return answer_hash
  end

  def answer_params
    params.permit(:answer, :quip_id, :answer_type)
  end

  def is_number_input_question?
    params[:answer_type] == "number_input"
  end

  def is_text_input_question?
    params[:answer_type] == "text_input"
  end

  def is_textarea_question?
    params[:answer_type] == "textarea"
  end

  def is_option_question?
    ["select", "radio", "checkbox"].include? params[:answer_type]
  end

  def missing_answer_type(action= "create") 
    "Could not determine which answer to #{action}"
  end
end
