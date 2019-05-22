class RankedQuestion < ApplicationRecord
  belongs_to :survey
  has_many :ranked_answers, :dependent => :destroy

  validates :question, presence: true, uniqueness: { scope: :survey }
  validate :options_are_not_empty_and_unique

  private

  # TODO can we DRY this up?
  # https://stackoverflow.com/a/37640265
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
