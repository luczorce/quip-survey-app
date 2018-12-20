class SurveysController < ApplicationController
  def index
    surveys = Survey.all
    render json: surveys, status: :ok
  end

  def create
    survey = Survey.create!(survey_params)
    render json: survey, status: :created
  end

  def show
    todo = survey.find(params[:id])
    render json: todo, status: :ok
  end

  def update
    survey = survey.find(params[:id])
    survey.update(survey_params)
    head :no_content
  end

  def destroy
    survey = survey.find(params[:id])
    survey.destroy
    head :no_content
  end

  private 

  def survey_params
    params.permit(:name)
  end
end
