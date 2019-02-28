class SurveysController < ApplicationController
  def index
    surveys = Survey.select(:id, :name).order(:name)
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

  def get_all_results
    # get details on the survey, questions from the survey, and all the answers separated by quipId
    info = Hash.new

    survey = Survey.find(params[:survey_id])
    info[:survey] = survey
    q_and_a = get_questions_and_answers()
    info[:questions] = q_and_a[:questions]
    info[:answers] = q_and_a[:answers]

    render json: info, status: :ok
  rescue ActiveRecord::RecordNotFound => missing
    render json: missing, status: :not_found
  end

  private

  def get_questions_and_answers
    questions = Array.new
    answers = Array.new

    InputNumberQuestion.includes(:input_number_answers).where(survey_id: params[:survey_id]).each { |q|
      answers.concat(q.input_number_answers)
      questions << q
    }

    InputTextQuestion.includes(:input_text_answers).where(survey_id: params[:survey_id]).each { |q|
      answers.concat(q.input_text_answers)
      questions << q
    }

    TextareaQuestion.includes(:textarea_answers).where(survey_id: params[:survey_id]).each { |q|
      answers.concat(q.textarea_answers)
      questions << q
    }

    OptionQuestion.includes(:option_answers).where(survey_id: params[:survey_id]).each { |q|
      answers.concat(q.option_answers)
      questions << q
    }

    questions.sort_by! do |q|
      q[:order]
    end

    # arrange answers by quip_id
    organised_answers = Hash.new
    answers.each { |answer|
      if !organised_answers.has_key?(answer.quip_id)
        organised_answers[answer.quip_id] = Array.new
      end
      
      organised_answers[answer.quip_id] << answer
    }

    return {:questions => questions, :answers => organised_answers}
  end

  def survey_params
    params.permit(:name)
  end
end
