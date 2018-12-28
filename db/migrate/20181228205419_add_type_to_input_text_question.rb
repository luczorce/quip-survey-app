class AddTypeToInputTextQuestion < ActiveRecord::Migration[5.2]
  def up
    add_column :input_text_questions, :question_type, :string, default: "text_input"
  end

  def down
    remove_column :input_text_questions, :question_type
  end
end
