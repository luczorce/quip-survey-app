class QuestionsController < ApplicationController
  def index
    questions = Array.new

    questions.concat(InputTextQuestion.where(survey_id: params[:survey_id]).order(:order))
    questions.concat(TextareaQuestion.where(survey_id: params[:survey_id]).order(:order))

    questions.sort_by! do |q|
      q[:order]
    end

    render json: questions, status: :ok
  end

  def create
    question = nil

    if (params[:type] == "text_input")
      question = InputTextQuestion.new
    elsif (params[:type] == "textarea")
      question = TextareaQuestion.new
    end

    question.question = question_params[:question]
    question.order = question_params[:order]
    question.survey_id = params[:survey_id]

    question.save!

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

    if params[:type] == "text_input"
      question = InputTextQuestion.find(params[:id])
    elsif params[:type] == "textara"
      question = TextareaQuestion.find(params[:id])
    end
    
    question.update!(question_params) unless question.nil?

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

    if params[:type] == "text_input"
      question = InputTextQuestion.find(params[:id])
    elsif params[:type] == "textarea"
      question = TextareaQuestion.find(params[:id])
    end

    question.destroy unless question.nil?

    if question
      head :no_content
    else 
      render json: {error: missing_question_type("delete")}, status: :bad_request
    end
  end

  private

  def question_params
    if ["text_input", "textarea"].include? params[:type]
      params.permit(:question, :order)
    end
  end

  def missing_question_type(action= "create") 
    "Could not determine which question to #{action}"
  end
end
