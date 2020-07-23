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

  def clone_survey
    survey = Survey.find(params[:survey_id])

    new_survey = survey.dup
    new_survey.name = survey_params["name"]
    new_survey.save!

    InputNumberQuestion.where(survey_id: params[:survey_id]).each do |q|
      duplicate_question(q, new_survey.id)
    end

    InputTextQuestion.where(survey_id: params[:survey_id]).each do |q|
      duplicate_question(q, new_survey.id)
    end

    TextareaQuestion.where(survey_id: params[:survey_id]).each do |q|
      duplicate_question(q, new_survey.id)
    end

    OptionQuestion.where(survey_id: params[:survey_id]).each do |q|
      duplicate_question(q, new_survey.id)
    end

    SurveyHeader.where(survey_id: params[:survey_id]).each do |q|
      duplicate_question(q, new_survey.id)
    end

    RankedQuestion.where(survey_id: params[:survey_id]).each do |q|
      duplicate_question(q, new_survey.id)
    end


    render json: new_survey, status: :created
  rescue ActiveRecord::RecordInvalid => invalid
    render json: invalid.record.errors, status: :bad_request
  rescue ActiveRecord::RecordNotFound => missing
    render json: missing, status: :not_found
  end

  def download_results
    survey = Survey.find(params[:survey_id])
    q_and_a = get_questions_and_answers()
    questions = q_and_a[:questions]
    answers = q_and_a[:answers]

    respond_to do |format|
      format.csv { process_csv_file(survey, make_answer_csv(survey, questions, answers)) }
    end

  rescue ActiveRecord::RecordInvalid => invalid
    render json: invalid.record.errors, status: :bad_request
  rescue ActiveRecord::RecordNotFound => missing
    render json: missing, status: :not_found
  end

  private

  def duplicate_question(question, survey_id)
    dup_question = question.dup
    dup_question.survey_id = survey_id
    dup_question.save!
  end

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

    RankedQuestion.includes(:ranked_answers).where(survey_id: params[:survey_id]).each { |q|
      answers.concat(q.ranked_answers)
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

  def process_csv_file(survey, csv)
    filename = "Survey Results - #{survey.name} - #{Date.today.to_formatted_s(:db)}.csv"
    
    send_data csv,
              type: 'type/csv; charset=iso-8859-1; header=present',
              disposition: 'attachment',
              filename: filename
  end

  def make_answer_csv(survey, questions, answers)
    headers = []
    headers << 'quid_id'
    
    questions.each do |question|
      headers << question.question
    end

    CsvExports::SurveyService.new(answers, questions, headers).to_csv
  end
end
