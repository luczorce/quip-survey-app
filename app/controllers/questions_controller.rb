class QuestionsController < ApplicationController
  def index
    # questions = Array.new
    # questions << InputTextQuestion.where(...)
    # questions.order(:order)

    questions = InputTextQuestion.where(survey_id: params[:survey_id]).order(:order)
    render json: questions, status: :ok
  end

  def create
    question = nil

    if (params[:type] == "text_input")
      question = InputTextQuestion.new

      question.question = question_params[:question]
      question.order = question_params[:order]
      question.survey_id = params[:survey_id]

      question.save!
    end

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

    if (params[:type] == "text_input")
      question = InputTextQuestion.find(params[:id])
      question.update!(question_params)
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

    if (params[:type] == "text_input")
      question = InputTextQuestion.find(params[:id])
      question.destroy
    end

    if question
      head :no_content
    else 
      render json: {error: missing_question_type("delete")}, status: :bad_request
    end
  end

  private

  def question_params
    if (params[:type] == "text_input")
      params.permit(:question, :order)
    end
  end

  def missing_question_type(action= "create") 
    "Could not determine which question to #{action}"
  end
end
