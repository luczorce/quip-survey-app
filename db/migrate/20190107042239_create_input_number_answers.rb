class CreateInputNumberAnswers < ActiveRecord::Migration[5.2]
  def change
    create_table :input_number_answers do |t|
      t.integer :answer
      t.string :quip_id
      t.string :answer_type, default: "number_input"
      t.references :input_number_question, foreign_key: true

      t.timestamps
    end
  end
end
