class CreateRankedQuestions < ActiveRecord::Migration[5.2]
  def change
    create_table :ranked_questions do |t|
      t.string :question
      t.string :question_type, default: "ranked"
      t.references :survey, foreign_key: true
      t.integer :order
      t.string :question_helper
      t.string :options, array: true
      t.string :option_helpers, array: true

      t.timestamps
    end
  end
end
