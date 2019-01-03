class CreateOptionQuestions < ActiveRecord::Migration[5.2]
  def change
    create_table :option_questions do |t|
      t.string :question
      t.references :survey, foreign_key: true
      t.string :options, array: true
      t.integer :order
      t.string :question_type

      t.timestamps
    end
  end
end
