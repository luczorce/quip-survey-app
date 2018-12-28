class TextareaQuestion < ApplicationRecord
  belongs_to :survey
  has_many :textarea_answers, :dependent => :destroy

  validates :question, presence: true, uniqueness: { scope: :survey }
end
