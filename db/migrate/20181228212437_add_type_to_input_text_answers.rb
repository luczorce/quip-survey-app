class AddTypeToInputTextAnswers < ActiveRecord::Migration[5.2]
  def up
    add_column :input_text_answers, :answer_type, :string, default: "text_input"
  end

  def down
    remove_column :input_text_answers, :answer_type
  end
end
