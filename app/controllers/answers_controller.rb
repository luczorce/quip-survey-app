class AnswersController < ApplicationController
  def show
    answer = nil

    if (params[:type] == "text_input")
      answer = InputTextAnswer.find(params[:id])
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

    if (params[:type] == "text_input")
      answer = InputTextAnswer.new(answer_params)

      answer.input_text_question_id = params[:question_id];
      answer.save!
    end

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

    if (params[:type] == 'text_input')
      answer = InputTextAnswer.find(params[:id])
      answer.update!(answer_params)
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

  def answer_params
    params.permit(:answer, :quip_id)
  end

  def missing_answer_type(action= "create") 
    "Could not determine which answer to #{action}"
  end
end
