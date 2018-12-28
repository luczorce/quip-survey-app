class CreateTextareaAnswers < ActiveRecord::Migration[5.2]
  def change
    create_table :textarea_answers do |t|
      t.text :answer
      t.string :quip_id
      t.string :answer_type, default: "textarea"
      t.references :textarea_question, foreign_key: true

      t.timestamps
    end
  end
end
