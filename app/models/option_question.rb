class OptionQuestion < ApplicationRecord
  belongs_to :survey
  has_many :option_answers, :dependent => :destroy

  validates :question, presence: true, uniqueness: { scope: :survey }
  validates :question_type, 
    presence: true, 
    inclusion: { in: ["select", "radio", "checkbox"], message: "%{value} is not a valid type" }
  
  validate :options_are_not_empty

  private

  def options_are_not_empty
    if options.nil? or options.empty?
      errors.add(:options, "must be provided")
    end
  end
end
