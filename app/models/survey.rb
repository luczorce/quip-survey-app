class Survey < ApplicationRecord
  has_many :input_text_questions

  validates :name, presence: true, uniqueness: true
end
