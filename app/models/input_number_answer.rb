class InputNumberAnswer < ApplicationRecord
  belongs_to :input_number_question

  validates :quip_id, presence: true, uniqueness: {scope: :input_number_question}
  validate :answer_within_range

  private

  def answer_within_range
    question = InputNumberQuestion.find(input_number_question_id)
    min = question.min
    max = question.max

    if !min.nil? and !answer.nil?
      if answer < min
        errors.add(:answer, "must be greater than #{min}")
      end
    end

    if !max.nil? and !answer.nil?
      if answer > max
        errors.add(:answer, "must be less than #{max}")
      end
    end
  end
end
