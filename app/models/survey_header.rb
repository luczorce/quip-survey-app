class SurveyHeader < ApplicationRecord
  belongs_to :survey

  validates :value, presence: true
end
