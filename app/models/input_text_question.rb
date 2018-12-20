class InputTextQuestion < ApplicationRecord
  belongs_to :survey
  has_many :input_text_answers

  validates :question, presence: true, uniqueness: { scope: :survey }
end
