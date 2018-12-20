class SurveysController < ApplicationController
  def index
    surveys = Survey.all
    render json: surveys, status: :ok
  end

  def create
    survey = Survey.create!(survey_params)
    render json: survey, status: :created
  rescue ActiveRecord::RecordInvalid => invalid
    render json: invalid.record.errors, status: :bad_request
  end

  def show
    survey = Survey.find(params[:id])
    render json: survey, status: :ok
  rescue ActiveRecord::RecordNotFound => missing
    render json: missing, status: :not_found
  end

  def update
    survey = Survey.find(params[:id])
    survey.update!(survey_params)
    
    render json: survey, status: :ok
  rescue ActiveRecord::RecordInvalid => invalid
    render json: invalid.record.errors, status: :bad_request
  rescue ActiveRecord::RecordNotFound => missing
    render json: missing, status: :not_found
  end

  def destroy
    survey = Survey.find(params[:id])
    survey.destroy
    head :no_content
  end

  private

  def survey_params
    params.permit(:name)
  end
end
