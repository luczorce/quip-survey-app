class Survey < ApplicationRecord
  has_many :input_text_questions, :dependent => :destroy
  has_many :textarea_questions, :dependent => :destroy
  has_many :option_questions, :dependent => :destroy
  has_many :input_number_questions, :dependent => :destroy
  has_many :ranked_questions, :dependent => :destroy
  has_many :survey_headers, :dependent => :destroy

  validates :name, presence: true, uniqueness: true
end
