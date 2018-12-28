class TextareaAnswer < ApplicationRecord
  belongs_to :textarea_question

  validates :quip_id, presence: true, uniqueness: {scope: :textarea_question}
end
