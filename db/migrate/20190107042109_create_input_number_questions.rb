class CreateInputNumberQuestions < ActiveRecord::Migration[5.2]
  def change
    create_table :input_number_questions do |t|
      t.string :question
      t.integer :min
      t.integer :max
      t.integer :order
      t.string :question_type, default: "number_input"
      t.references :survey, foreign_key: true

      t.timestamps
    end
  end
end
