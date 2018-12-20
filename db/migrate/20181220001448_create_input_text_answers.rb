class CreateInputTextAnswers < ActiveRecord::Migration[5.2]
  def change
    create_table :input_text_answers do |t|
      t.string :answer
      t.string :quip_id
      t.references :input_text_question, foreign_key: true

      t.timestamps
    end
  end
end
