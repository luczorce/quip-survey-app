class OptionAnswer < ApplicationRecord
  belongs_to :option_question

  validates :quip_id, presence: true, uniqueness: { scope: :option_question }
  validates :answer_type, 
    presence: true, 
    inclusion: { in: ["select", "radio", "checkbox"], message: "%{value} is not a valid type" }

  validate :answer_length, :type_matches_question, :option_matches_question_options 
  # TODO add a validation that the answer matches the options from the question

  private

  def answer_length
    if answer.nil?
      errors.add(:answer, "must be included (even if empty)")
    elsif answer_type.include?("radio") or answer_type.include?("select")
      errors.add(:answer, "must be only one answer here") unless answer.length <= 1
    end
  end

  def option_matches_question_options
    if !answer.nil? and !answer.empty?
      question = OptionQuestion.find(option_question_id)

      if !question.options.include? answer[0] and ["select", "radio"].include? answer_type
        errors.add(:answer, "must be one of the available options")
      elsif answer_type === "checkbox"
        has_error = false

        answer.each do |a|
          if !question.options.include? a 
            has_error = true
          end
        end

        errors.add(:answer, "must be any of the available options") unless !has_error
      end
    end
  end

  def type_matches_question
    question_type = OptionQuestion.find(option_question_id).question_type
    errors.add(:answer_type, "does not match the question type") unless answer_type == question_type
  end
end
