class InputNumberQuestion < ApplicationRecord
  belongs_to :survey
  has_many :input_number_answers, :dependent => :destroy

  validates :question, presence: true, uniqueness: { scope: :survey }
  validate :min_is_lessthan_max

  private

  def min_is_lessthan_max
    if !min.nil? and !max.nil?
      errors.add(:min, "must be less than the max value") unless min < max
    end
  end
end
