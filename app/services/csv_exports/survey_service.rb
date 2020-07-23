# frozen_string_literals: true

module CsvExports
  # class SurveyService < BaseService
  class SurveyService
    require 'csv'

    def initialize(answers, questions, csv_columns = nil)
      @answers = answers
      @questions = questions
      @csv_columns = csv_columns
    end

    def to_csv
      CSV.generate(headers: true) do |csv|
        csv << column_names
        answers.each { |key, value| csv << make_row(key, value) }
      
      end.encode('cp1252').force_encoding('UTF-8')
    end


    private

    attr_reader :answers, :questions, :csv_columns

    def column_names
      if csv_columns.blank? && answers.present?
        answers.first.class.column_names
      else
        csv_columns
      end
    end

    def make_row(quip_id, answer_row)
      data = []
      data << quip_id
      
      # we need to get the answers in order based on the question order
      # answer_row comes in as an array but it is not ordered to the question order
      # but questions is in order!
      answers = []
      just_what_we_want = []

      questions.each do |question|
        answer_id_key = "#{question.question_type}_question_id"
        
        answer = answer_row.select do |a| 
          if a.has_attribute?(answer_id_key) && a[answer_id_key].eql?(question.id)
            a
          else
            nil
          end
        end
        
        answers << answer.pop unless answer.nil?
      end

      answers.each { |a| just_what_we_want << a.answer }
      data.concat(just_what_we_want)

      data
    end
  end
end