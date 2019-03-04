class OptionQuestion < ApplicationRecord
  belongs_to :survey
  has_many :option_answers, :dependent => :destroy

  validates :question, presence: true, uniqueness: { scope: :survey }
  validates :question_type, 
    presence: true, 
    inclusion: { in: ["select", "radio", "checkbox"], message: "%{value} is not a valid type" }
  
  validate :options_are_not_empty_and_unique

  private

  def options_are_not_empty_and_unique
    if options.nil? or options.empty?
      errors.add(:options, "must be provided")
    elsif !options.uniq!.nil?
      # https://ruby-doc.org/core-2.2.0/Array.html#method-i-uniq-21
      # #uniq! returns nil if no duplicates are found
      errors.add(:options, "must be unique")
    end
  end
end
