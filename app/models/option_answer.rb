class OptionAnswer < ApplicationRecord
  belongs_to :option_question

  validates :quip_id, presence: true, uniqueness: { scope: :option_question }
  validates :answer_type, 
    presence: true, 
    inclusion: { in: ["select", "radio", "checkbox"], message: "%{value} is not a valid type" }

  validate :answer_length, :type_matches_question

  private

  def answer_length
    if answer.nil?
      errors.add(:answer, "must be included (even if empty)")
    elsif answer_type.include?("radio") or answer_type.include?("select")
      errors.add(:answer, "must be only one answer here") unless answer.length <= 1
    end
  end

  def type_matches_question
    question_type = OptionQuestion.find(option_question_id).question_type
    errors.add(:answer_type, "does not match the question type") unless answer_type == question_type
  end
end
