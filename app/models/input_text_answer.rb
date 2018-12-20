class InputTextAnswer < ApplicationRecord
  belongs_to :input_text_question

  validates :quip_id, presence: true, uniqueness: {scope: :input_text_question}
end
