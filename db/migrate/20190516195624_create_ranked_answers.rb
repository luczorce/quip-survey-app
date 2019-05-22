class CreateRankedAnswers < ActiveRecord::Migration[5.2]
  def change
    create_table :ranked_answers do |t|
      t.string :answer, array: true
      t.string :quip_id
      t.string :answer_type, default: "ranked"
      t.references :ranked_question, foreign_key: true

      t.timestamps
    end
  end
end
