class RankedAnswer < ApplicationRecord
  belongs_to :ranked_question

  validates :quip_id, presence: true, uniqueness: { scope: :ranked_question }
  validate :answer_length, :option_matches_question_options 

  private

  def answer_length
    if answer.nil?
      errors.add(:answer, "must be included")
    end
  end

  def option_matches_question_options
    if !answer.nil? and !answer.empty?
      question = RankedQuestion.find(ranked_question_id)
      has_error = false

      answer.each do |a|
        if !question.options.include? a 
          has_error = true
        end
      end

      if answer.count != question.options.count
        has_error = true
      end

      errors.add(:answer, "must only container the available options from the question") unless !has_error
    end
  end
end
