class CreateTextareaQuestions < ActiveRecord::Migration[5.2]
  def change
    create_table :textarea_questions do |t|
      t.string :question
      t.integer :order
      t.string :question_type, default: "textarea"
      t.references :survey, foreign_key: true

      t.timestamps
    end
  end
end
