class CreateInputTextQuestions < ActiveRecord::Migration[5.2]
  def change
    create_table :input_text_questions do |t|
      t.string :question
      t.integer :order
      t.references :survey, foreign_key: true

      t.timestamps
    end
  end
end
