class CreateOptionAnswers < ActiveRecord::Migration[5.2]
  def change
    create_table :option_answers do |t|
      t.string :answer, array: true
      t.string :quip_id
      t.string :answer_type
      t.references :option_question, foreign_key: true

      t.timestamps
    end
  end
end
